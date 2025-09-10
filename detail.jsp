<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원 상세 정보</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .card-header-gradient {
      background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
      height: 80px;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .card-header-gradient h4 {
      font-size: 1.75rem;
      color: white;
      margin: 0;
    }
  </style>
</head>
<body class="bg-light">
  <div class="container mt-5">
    <div class="card shadow">
      <div class="card-header card-header-gradient">
        <h4 class="mb-0">회원 상세 정보</h4>
      </div>
      <div class="card-body">
        <div class="row">
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
      String[] labels = {"이름", "이메일", "비밀번호", "나이", "생년월일", "예약시간", "좋아하는 색상", "도시", "성별", "관심사", "자기소개", "사용자 ID", "이력서 파일", "등록일"};
      String[] fields = {rs.getString("name"), rs.getString("email"), rs.getString("password"), rs.getString("age"), rs.getString("dob"), rs.getString("appt"), rs.getString("color"), rs.getString("city"), rs.getString("gender"), rs.getString("interest"), rs.getString("message"), rs.getString("user_id"), rs.getString("resume"), rs.getTimestamp("created_at").toString()};

      for (int i = 0; i < labels.length; i++) {
        if (labels[i].equals("이력서 파일")) {
%>
          <div class="col-md-6 mb-3">
            <label class="form-label fw-bold"><%= labels[i] %></label><br>
            <a href="upload/<%= fields[i] %>" download class="btn btn-outline-primary btn-sm"><%= fields[i] %> 다운로드</a>
          </div>
<%
        } else {
%>
          <div class="col-md-6 mb-3">
            <label class="form-label fw-bold"><%= labels[i] %></label>
            <div class="form-control bg-light"><%= fields[i] %></div>
          </div>
<%
        }
      }
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
          <a href="memberlist.jsp" class="btn btn-secondary me-2">목록으로</a>
          <a href="edit.jsp?id=<%= id %>" class="btn btn-warning me-2">수정</a>
          <a href="delete.jsp?id=<%= id %>" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
        </div>
      </div>
    </div>
  </div>
</body>
</html>