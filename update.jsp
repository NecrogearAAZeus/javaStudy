<%@ page contentType="text/html; charset=UTF-8" language="java" %> <%@ page
import="java.sql.*" %> <% request.setCharacterEncoding("UTF-8"); String id =
request.getParameter("id"); String name = request.getParameter("name"); String
email = request.getParameter("email"); String password =
request.getParameter("password"); String age = request.getParameter("age");
String dob = request.getParameter("dob"); String appt =
request.getParameter("appt"); String color = request.getParameter("color");
String city = request.getParameter("city"); String gender =
request.getParameter("gender"); String[] interests =
request.getParameterValues("interest"); String message =
request.getParameter("message"); String interestStr = ""; if (interests != null)
{ for (int i = 0; i < interests.length; i++) { interestStr += interests[i]; if
(i != interests.length - 1) interestStr += ","; } } Connection conn = null;
PreparedStatement pstmt = null; String url =
"jdbc:mysql://localhost:3306/memberInfo?useSSL=false&serverTimezone=UTC"; String
dbUser = "root"; String dbPass = "1234"; try {
Class.forName("com.mysql.cj.jdbc.Driver"); conn =
DriverManager.getConnection(url, dbUser, dbPass); String sql = "UPDATE userInfo
SET name=?, email=?, password=?, age=?, dob=?, appt=?, color=?, city=?,
gender=?, interest=?, message=? WHERE id=?"; pstmt = conn.prepareStatement(sql);
pstmt.setString(1, name); pstmt.setString(2, email); pstmt.setString(3,
password); pstmt.setString(4, age); pstmt.setString(5, dob); pstmt.setString(6,
appt); pstmt.setString(7, color); pstmt.setString(8, city); pstmt.setString(9,
gender); pstmt.setString(10, interestStr); pstmt.setString(11, message);
pstmt.setString(12, id); int result = pstmt.executeUpdate(); if (result > 0) {
response.sendRedirect("memberlistchangeingNameForStudy.jsp"); } else { %>
<div class="alert alert-danger">수정 실패: 알 수 없는 오류가 발생했습니다.</div>
<% } } catch (Exception e) { %>
<div class="alert alert-danger">에러 발생: <%= e.getMessage() %></div>
<% } finally { if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
if (conn != null) try { conn.close(); } catch (Exception e) {} } %>
