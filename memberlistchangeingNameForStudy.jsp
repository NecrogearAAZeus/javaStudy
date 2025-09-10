<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원 리스트</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .card-header-gradient {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      height: 100px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 1rem;
    }
    .card-header-gradient h4 {
      font-size: 2rem;
      color: white;
      margin: 0;
    }
  </style>
</head>
<body class="bg-light">
  <div class="container mt-5">
    <div class="card shadow">
      <div class="card-header card-header-gradient">
        <h4 class="mb-0">회원 정보 리스트</h4>
        <a href="BootComponentForChangeName.jsp" class="btn btn-light">회원정보 입력</a>
      </div>
      <div class="card-body">
        <table class="table table-hover table-bordered text-center">
          <thead class="table-secondary">
            <tr>
              <th>#</th>
              <th>이름</th>
              <th>이메일</th>
              <th>성별</th>
              <th>나이</th>
              <th>도시</th>
              <th>등록일</th>
            </tr>
          </thead>
          <tbody>
<%
  Connection conn = null;
  PreparedStatement pstmt = null;
  ResultSet rs = null;
  String url = "jdbc:mysql://localhost:3306/memberInfo?useSSL=false&serverTimezone=UTC";
  String dbUser = "root";
  String dbPass = "1234";

  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(url, dbUser, dbPass);
    String sql = "SELECT id, name, email, gender, age, city, created_at FROM userInfo ORDER BY created_at DESC";
    pstmt = conn.prepareStatement(sql);
    rs = pstmt.executeQuery();
    while (rs.next()) {
%>
           <tr onclick="location.href='detailChangeNameForStudy.jsp?id=<%= rs.getInt("id") %>'" style="cursor:pointer;">
              <td><%= rs.getInt("id") %></td>
              <td><%= rs.getString("name") %></td>
              <td><%= rs.getString("email") %></td>
              <td><%= rs.getString("gender") %></td>
              <td><%= rs.getString("age") %></td>
              <td><%= rs.getString("city") %></td>
              <td><%= rs.getTimestamp("created_at") %></td>
            </tr>
<%
    }
  } catch (Exception e) {
%>
            <tr><td colspan="7">에러 발생: <%= e.getMessage() %></td></tr>
<%
  } finally {
    if (rs != null) try { rs.close(); } catch (Exception e) {}
    if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
    if (conn != null) try { conn.close(); } catch (Exception e) {}
  }
%>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</body>
</html>