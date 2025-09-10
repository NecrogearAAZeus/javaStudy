<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>불쾌지수 차트</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-annotation@1.1.0"></script>
  <style>
    body {
      background: linear-gradient(to right, #74ebd5, #9face6);
      min-height: 100vh;
      margin: 0;
      display: flex;
      flex-direction: column;
    }
    .chart-container {
      background-color: rgba(255, 255, 255, 0.6);
      border-radius: 15px;
      padding: 30px;
      margin: 50px auto 20px auto;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
      max-width: 1600px;
    }
    .summary-chart, .monthly-chart {
      max-width: 1600px;
      margin: 20px auto 60px auto;
      background: rgba(255,255,255,0.7);
      padding: 20px;
      border-radius: 10px;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="chart-container">
      <h4 class="text-center mb-4">불쾌지수 변화 차트</h4>
      <canvas id="discomfortChart" width="1500" height="500"></canvas>
    </div>
    <div class="summary-chart">
      <canvas id="summaryBarChart" height="100"></canvas>
    </div>
    <div class="monthly-chart">
      <canvas id="monthlyAvgChart" height="150"></canvas>
    </div>
  </div>

<%
  Connection conn = null;
  PreparedStatement pstmt = null;
  ResultSet rs = null;
  String url = "jdbc:mysql://localhost:3306/memberInfo?useSSL=false&serverTimezone=UTC";
  String dbUser = "root";
  String dbPass = "1234";

  ArrayList<String> dates = new ArrayList<>();
  ArrayList<Double> discomfIndexes = new ArrayList<>();
  Map<String, List<Double>> monthlyMap = new LinkedHashMap<>();

  int veryUnpleasant = 0, unpleasant = 0, slightlyUnpleasant = 0, pleasant = 0;

  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(url, dbUser, dbPass);
    String sql = "SELECT record_date, temperature, humidity FROM weather_data ORDER BY record_date ASC";
    pstmt = conn.prepareStatement(sql);
    rs = pstmt.executeQuery();

    while (rs.next()) {
      String date = rs.getString("record_date");
      double temp = rs.getDouble("temperature");
      double humid = rs.getDouble("humidity");
      double di = 0.81 * temp + 0.01 * humid * (0.99 * temp - 14.3) + 46.3;
      di = Math.round(di * 100.0) / 100.0;

      if (di >= 80) veryUnpleasant++;
      else if (di >= 75) unpleasant++;
      else if (di >= 68) slightlyUnpleasant++;
      else pleasant++;

      dates.add(date);
      discomfIndexes.add(di);

      String month = date.substring(0, 7);
      monthlyMap.computeIfAbsent(month, k -> new ArrayList<>()).add(di);
    }
  } catch (Exception e) {
    out.println("<p class='text-danger'>에러 발생: " + e.getMessage() + "</p>");
  } finally {
    if (rs != null) try { rs.close(); } catch (Exception e) {}
    if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
    if (conn != null) try { conn.close(); } catch (Exception e) {}
  }

  List<String> monthLabels = new ArrayList<>(monthlyMap.keySet());
  List<Double> monthlyAvg = new ArrayList<>();
  for (String month : monthLabels) {
    List<Double> values = monthlyMap.get(month);
    double avg = values.stream().mapToDouble(d -> d).average().orElse(0.0);
    monthlyAvg.add(Math.round(avg * 100.0) / 100.0);
  }
%>

<script>
  const labels = <%= new Gson().toJson(dates) %>;
  const data = <%= new Gson().toJson(discomfIndexes) %>;
  const summaryCounts = {
    "매우 불쾌": <%= veryUnpleasant %>,
    "불쾌": <%= unpleasant %>,
    "조금 불쾌": <%= slightlyUnpleasant %>,
    "쾌적": <%= pleasant %>
  };

  const backgroundColors = data.map(value => {
    if (value >= 80) return 'rgba(255,0,0,0.3)';
    else if (value >= 75) return 'rgba(255,165,0,0.3)';
    else if (value >= 68) return 'rgba(128,128,128,0.3)';
    else return 'rgba(0,0,255,0.2)';
  });

  const ctx = document.getElementById('discomfortChart').getContext('2d');
  new Chart(ctx, {
    type: 'bar',
    data: {
      labels: labels,
      datasets: [{
        label: '불쾌지수',
        data: data,
        backgroundColor: backgroundColors,
        borderColor: 'rgba(0,0,0,0.6)',
        borderWidth: 1
      }]
    },
    options: {
      scales: {
        y: {
          beginAtZero: false,
          suggestedMax: 90
        }
      },
      plugins: {
        legend: {
          labels: {
            generateLabels: function(chart) {
              return [
                { text: '80 이상: 매우 불쾌', fillStyle: 'rgba(255,0,0,0.3)' },
                { text: '75 ~ 79: 불쾌', fillStyle: 'rgba(255,165,0,0.3)' },
                { text: '68 ~ 74: 조금 불쾌', fillStyle: 'rgba(128,128,128,0.3)' },
                { text: '68 미만: 쾌적', fillStyle: 'rgba(0,0,255,0.2)' }
              ];
            }
          }
        },
        tooltip: {
          callbacks: {
            label: function(context) {
              let value = context.raw;
              let message = "";
              if (value >= 80) message = " (매우 불쾌)";
              else if (value >= 75) message = " (불쾌)";
              else if (value >= 68) message = " (조금 불쾌)";
              else message = " (쾌적)";
              return value + message;
            }
          }
        },
        annotation: {
          annotations: {
            line80: {
              type: 'line',
              yMin: 80,
              yMax: 80,
              borderColor: 'red',
              borderWidth: 3,
              label: {
                enabled: true,
                content: '80 기준선',
                position: 'end'
              }
            },
            line68: {
              type: 'line',
              yMin: 68,
              yMax: 68,
              borderColor: 'blue',
              borderWidth: 3,
              label: {
                enabled: true,
                content: '68 기준선',
                position: 'end'
              }
            }
          }
        }
      }
    },
    plugins: [Chart.registry.getPlugin('annotation')]
  });

  const ctx2 = document.getElementById('summaryBarChart').getContext('2d');
  new Chart(ctx2, {
    type: 'bar',
    data: {
      labels: Object.keys(summaryCounts),
      datasets: [{
        label: '날 수',
        data: Object.values(summaryCounts),
        backgroundColor: [
          'rgba(255,0,0,0.5)',
          'rgba(255,165,0,0.5)',
          'rgba(128,128,128,0.5)',
          'rgba(0,0,255,0.4)'
        ]
      }]
    },
    options: {
      plugins: {
        legend: { display: false },
        title: { display: true, text: '불쾌지수 범주별 일수' },
        tooltip: {
          callbacks: {
            label: function(context) {
              return context.label + ': ' + context.raw + '일';
            }
          }
        }
      },
      scales: {
        y: {
          beginAtZero: true,
          stepSize: 1
        }
      }
    }
  });

  const monthLabels = <%= new Gson().toJson(monthLabels) %>;
  const monthlyAvg = <%= new Gson().toJson(monthlyAvg) %>;

  const ctx3 = document.getElementById('monthlyAvgChart').getContext('2d');
  new Chart(ctx3, {
    type: 'line',
    data: {
      labels: monthLabels,
      datasets: [{
        label: '월별 평균 불쾌지수',
        data: monthlyAvg,
        borderColor: 'rgba(75,192,192,1)',
        backgroundColor: 'rgba(75,192,192,0.2)',
        fill: true,
        tension: 0.4
      }]
    },
    options: {
      plugins: {
        title: {
          display: true,
          text: '월별 평균 불쾌지수'
        },
        annotation: {
          annotations: {
            line80: {
              type: 'line',
              yMin: 80,
              yMax: 80,
              borderColor: 'red',
              borderWidth: 3,
              label: {
                enabled: true,
                content: '80 기준선',
                position: 'end'
              }
            },
            line68: {
              type: 'line',
              yMin: 68,
              yMax: 68,
              borderColor: 'blue',
              borderWidth: 3,
              label: {
                enabled: true,
                content: '68 기준선',
                position: 'end'
              }
            }
          }
        }
      },
      scales: {
        y: {
          beginAtZero: false,
          suggestedMax: 90
        }
      }
    },
    plugins: [Chart.registry.getPlugin('annotation')]
  });
</script>
</body>
</html>