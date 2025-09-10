<%@ page contentType="text/html; charset=UTF-8" language="java" %> <%@ page
import="java.sql.*" %> <% String id = request.getParameter("id"); Connection
conn = null; PreparedStatement pstmt = null; String url =
"jdbc:mysql://localhost:3306/memberInfo?useSSL=false&serverTimezone=UTC"; String
dbUser = "root"; String dbPass = "1234"; try {
Class.forName("com.mysql.cj.jdbc.Driver"); conn =
DriverManager.getConnection(url, dbUser, dbPass); String sql = "DELETE FROM
userInfo WHERE id = ?"; pstmt = conn.prepareStatement(sql); pstmt.setString(1,
id); int result = pstmt.executeUpdate(); if (result > 0) {
response.sendRedirect("memberlistchangeingNameForStudy.jsp"); } else { %>
<div class="alert alert-danger">삭제에 실패했습니다.</div>
<% } } catch (Exception e) { %>
<div class="alert alert-danger">에러 발생: <%= e.getMessage() %></div>
<% } finally { if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
if (conn != null) try { conn.close(); } catch (Exception e) {} } %>
