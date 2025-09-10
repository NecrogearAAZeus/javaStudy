<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Chart.js 기초 예제</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
    body {
      background: linear-gradient(to right, #1e3c72, #2a5298);
      min-height: 100vh;
    }
    .container {
      max-width: 1200px;
      margin: 0 auto;
    }
    .header-box {
      margin: 60px auto 30px auto;
      padding: 30px;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      text-align: center;
      border-radius: 15px;
      box-shadow: 0 4px 20px rgba(0,0,0,0.3);
      width: 100%;
    }
    .header-box h2 {
      font-size: 2.8rem;
      font-weight: bold;
      color: #fff;
      margin: 0;
    }
    .grid-container {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      grid-template-rows: repeat(3, 1fr);
      gap: 20px;
      padding: 20px 0 60px 0;
      width: 100%;
    }
    .chart-box {
      background: rgba(255, 255, 255, 0.75);
      border-radius: 15px;
      padding: 20px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.2);
      display: flex;
      flex-direction: column;
      justify-content: center;
    }
    canvas {
      width: 100% !important;
      height: auto !important;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="header-box">
      <h2>Chart.js 9종 예제</h2>
    </div>
    <div class="grid-container">
      <div class="chart-box">
        <h6 class="text-center">막대 차트</h6>
        <canvas id="barChart"></canvas>
      </div>
      <div class="chart-box">
        <h6 class="text-center">선 차트</h6>
        <canvas id="lineChart"></canvas>
      </div>
      <div class="chart-box">
        <h6 class="text-center">파이 차트</h6>
        <canvas id="pieChart"></canvas>
      </div>
      <div class="chart-box">
        <h6 class="text-center">도넛 차트</h6>
        <canvas id="doughnutChart"></canvas>
      </div>
      <div class="chart-box">
        <h6 class="text-center">레이더 차트</h6>
        <canvas id="radarChart"></canvas>
      </div>
      <div class="chart-box">
        <h6 class="text-center">극지 차트</h6>
        <canvas id="polarChart"></canvas>
      </div>
      <div class="chart-box">
        <h6 class="text-center">버블 차트</h6>
        <canvas id="bubbleChart"></canvas>
      </div>
      <div class="chart-box">
        <h6 class="text-center">스캐터 차트</h6>
        <canvas id="scatterChart"></canvas>
      </div>
      <div class="chart-box">
        <h6 class="text-center">혼합 차트</h6>
        <canvas id="mixedChart"></canvas>
      </div>
    </div>
  </div>

  <script>
    const sampleLabels = ['A', 'B', 'C', 'D', 'E'];
    const sampleData = [12, 19, 3, 5, 2];

    new Chart(document.getElementById('barChart'), {
      type: 'bar',
      data: {
        labels: sampleLabels,
        datasets: [{ label: '데이터', data: sampleData, backgroundColor: 'rgba(75, 192, 192, 0.6)' }]
      }
    });

    new Chart(document.getElementById('lineChart'), {
      type: 'line',
      data: {
        labels: sampleLabels,
        datasets: [{ label: '데이터', data: sampleData, borderColor: 'rgba(255, 99, 132, 1)', fill: false }]
      }
    });

    new Chart(document.getElementById('pieChart'), {
      type: 'pie',
      data: {
        labels: sampleLabels,
        datasets: [{ label: '데이터', data: sampleData, backgroundColor: ['red', 'blue', 'green', 'yellow', 'orange'] }]
      }
    });

    new Chart(document.getElementById('doughnutChart'), {
      type: 'doughnut',
      data: {
        labels: sampleLabels,
        datasets: [{ label: '데이터', data: sampleData, backgroundColor: ['red', 'blue', 'green', 'yellow', 'purple'] }]
      }
    });

    new Chart(document.getElementById('radarChart'), {
      type: 'radar',
      data: {
        labels: sampleLabels,
        datasets: [{ label: '데이터', data: sampleData, backgroundColor: 'rgba(54, 162, 235, 0.2)', borderColor: 'blue' }]
      }
    });

    new Chart(document.getElementById('polarChart'), {
      type: 'polarArea',
      data: {
        labels: sampleLabels,
        datasets: [{ label: '데이터', data: sampleData, backgroundColor: ['red', 'green', 'blue', 'orange', 'purple'] }]
      }
    });

    new Chart(document.getElementById('bubbleChart'), {
      type: 'bubble',
      data: {
        datasets: [{
          label: 'Bubble Dataset',
          data: [ {x: 10, y: 20, r: 10}, {x: 15, y: 10, r: 15}, {x: 25, y: 12, r: 8} ],
          backgroundColor: 'rgba(255, 99, 132, 0.5)'
        }]
      }
    });

    new Chart(document.getElementById('scatterChart'), {
      type: 'scatter',
      data: {
        datasets: [{
          label: 'Scatter Dataset',
          data: [ {x: -10, y: 0}, {x: 0, y: 10}, {x: 10, y: 5} ],
          backgroundColor: 'rgba(153, 102, 255, 0.7)'
        }]
      }
    });

    new Chart(document.getElementById('mixedChart'), {
      data: {
        labels: sampleLabels,
        datasets: [
          { type: 'bar', label: 'Bar', data: sampleData, backgroundColor: 'rgba(255, 206, 86, 0.6)' },
          { type: 'line', label: 'Line', data: sampleData, borderColor: 'rgba(54, 162, 235, 1)', fill: false }
        ]
      }
    });
  </script>
</body>
</html>