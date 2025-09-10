<%@ page contentType="text/html; charset=UTF-8" language="java" %> <%@ page
import="java.io.*, java.util.*, java.sql.*" %> <%@ page
import="com.oreilly.servlet.MultipartRequest" %> <%@ page
import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>폼 제출 결과</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
  </head>
  <body class="bg-light">
    <div class="container mt-5">
      <div class="card">
        <div class="card-header bg-primary text-white">
          <h4>제출 결과</h4>
        </div>
        <div class="card-body">
          <% String savePath = application.getRealPath("/upload"); int sizeLimit
          = 10 * 1024 * 1024; // 10MB MultipartRequest multi = new
          MultipartRequest(request, savePath, sizeLimit, "UTF-8", new
          DefaultFileRenamePolicy()); String name = multi.getParameter("name");
          String email = multi.getParameter("email"); String password =
          multi.getParameter("password"); String age =
          multi.getParameter("age"); String dob = multi.getParameter("dob");
          String appt = multi.getParameter("appt"); String color =
          multi.getParameter("color"); String city = multi.getParameter("city");
          String gender = multi.getParameter("gender"); String message =
          multi.getParameter("message"); String userId =
          multi.getParameter("user_id"); String resume =
          multi.getFilesystemName("resume"); String[] interests =
          multi.getParameterValues("interest"); String interestStr = ""; if
          (interests != null) { interestStr = String.join(",", interests); } //
          DB 연결 Connection conn = null; PreparedStatement pstmt = null; String
          url =
          "jdbc:mysql://localhost:3306/memberInfo?useSSL=false&serverTimezone=UTC";
          String dbUser = "root"; String dbPass = "1234"; try {
          Class.forName("com.mysql.cj.jdbc.Driver"); conn =
          DriverManager.getConnection(url, dbUser, dbPass); String sql = "INSERT
          INTO userInfo (name, email, password, age, dob, appt, color, city,
          gender, interest, message, user_id, resume) VALUES (?, ?, ?, ?, ?, ?,
          ?, ?, ?, ?, ?, ?, ?)"; pstmt = conn.prepareStatement(sql);
          pstmt.setString(1, name); pstmt.setString(2, email);
          pstmt.setString(3, password); pstmt.setString(4, age);
          pstmt.setString(5, dob); pstmt.setString(6, appt); pstmt.setString(7,
          color); pstmt.setString(8, city); pstmt.setString(9, gender);
          pstmt.setString(10, interestStr); pstmt.setString(11, message);
          pstmt.setString(12, userId); pstmt.setString(13, resume); int result =
          pstmt.executeUpdate(); if (result > 0) {
          response.sendRedirect("memberlistchangeingNameForStudy.jsp"); } else {
          out.println("
          <div class="alert alert-danger">
            저장 실패: 알 수 없는 오류가 발생했습니다.
          </div>
          "); } } catch (Exception e) { out.println("
          <div class="alert alert-danger">
            에러 발생: " + e.getMessage() + "
          </div>
          "); } finally { if (pstmt != null) try { pstmt.close(); } catch
          (Exception e) {} if (conn != null) try { conn.close(); } catch
          (Exception e) {} } %>
        </div>
      </div>
    </div>
  </body>
</html>
