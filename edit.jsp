<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원 정보 수정</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <script>
    function confirmUpdate() {
      return confirm("정말 수정하시겠습니까?");
    }
  </script>
</head>
<body class="bg-light">
  <div class="container mt-5">
    <div class="card shadow">
      <div class="card-header bg-primary text-white text-center py-4">
        <h4 class="mb-0">회원 정보 수정</h4>
      </div>
      <div class="card-body">
        <form action="update.jsp" method="post" onsubmit="return confirmUpdate();">
          <div class="row g-3">
<%
  String id = request.getParameter("id");
  Connection conn = null;
  PreparedStatement pstmt = null;
  ResultSet rs = null;

  String url = "jdbc:mysql://localhost:3306/memberInfo?useSSL=false&serverTimezone=UTC";
  String dbUser = "root";
  String dbPass = "1234";

  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(url, dbUser, dbPass);
    String sql = "SELECT * FROM userInfo WHERE id = ?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, id);
    rs = pstmt.executeQuery();

    if (rs.next()) {
%>
            <input type="hidden" name="id" value="<%= id %>">
            <div class="col-md-6">
              <label class="form-label">이름</label>
              <input type="text" class="form-control" name="name" value="<%= rs.getString("name") %>">
            </div>
            <div class="col-md-6">
              <label class="form-label">이메일</label>
              <input type="email" class="form-control" name="email" value="<%= rs.getString("email") %>">
            </div>
            <div class="col-md-6">
              <label class="form-label">비밀번호</label>
              <input type="password" class="form-control" name="password" value="<%= rs.getString("password") %>">
            </div>
            <div class="col-md-6">
              <label class="form-label">나이</label>
              <input type="number" class="form-control" name="age" value="<%= rs.getString("age") %>">
            </div>
            <div class="col-md-6">
              <label class="form-label">생년월일</label>
              <input type="date" class="form-control" name="dob" value="<%= rs.getString("dob") %>">
            </div>
            <div class="col-md-6">
              <label class="form-label">예약 시간</label>
              <input type="time" class="form-control" name="appt" value="<%= rs.getString("appt") %>">
            </div>
            <div class="col-md-6">
              <label class="form-label">좋아하는 색상</label>
              <input type="color" class="form-control form-control-color" name="color" value="<%= rs.getString("color") %>">
            </div>
            <div class="col-md-6">
              <label class="form-label">도시</label>
              <select class="form-select" name="city">
                <option value="서울" <%= rs.getString("city").equals("서울") ? "selected" : "" %>>서울</option>
                <option value="부산" <%= rs.getString("city").equals("부산") ? "selected" : "" %>>부산</option>
                <option value="대구" <%= rs.getString("city").equals("대구") ? "selected" : "" %>>대구</option>
              </select>
            </div>
            <div class="col-md-12">
              <label class="form-label d-block">성별</label>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="gender" value="male" <%= rs.getString("gender").equals("male") ? "checked" : "" %>>
                <label class="form-check-label">남성</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="gender" value="female" <%= rs.getString("gender").equals("female") ? "checked" : "" %>>
                <label class="form-check-label">여성</label>
              </div>
            </div>
            <div class="col-md-12">
              <label class="form-label d-block">관심사</label>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" name="interest" value="coding" id="chk1" <%= rs.getString("interest").contains("coding") ? "checked" : "" %>>
                <label class="form-check-label" for="chk1">코딩</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" name="interest" value="music" id="chk2" <%= rs.getString("interest").contains("music") ? "checked" : "" %>>
                <label class="form-check-label" for="chk2">음악</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" name="interest" value="sports" id="chk3" <%= rs.getString("interest").contains("sports") ? "checked" : "" %>>
                <label class="form-check-label" for="chk3">스포츠</label>
              </div>
            </div>
            <div class="col-md-12">
              <label class="form-label">자기소개</label>
              <textarea class="form-control" name="message" rows="4"><%= rs.getString("message") %></textarea>
            </div>
<%
    }
  } catch (Exception e) {
%>
          <div class="alert alert-danger">에러 발생: <%= e.getMessage() %></div>
<%
  } finally {
    if (rs != null) try { rs.close(); } catch (Exception e) {}
    if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
    if (conn != null) try { conn.close(); } catch (Exception e) {}
  }
%>
          </div>
          <div class="mt-4 text-center">
            <button type="submit" class="btn btn-success me-2">수정 완료</button>
            <a href="memberlist.jsp" class="btn btn-secondary">목록으로</a>
          </div>
        </form>
      </div>
    </div>
  </div>
</body>
</html>
