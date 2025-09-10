<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>JSP 부트스트랩 폼</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .form-title {
      background: linear-gradient(to right, #4facfe, #00f2fe);
      padding: 20px;
      color: white;
      text-align: center;
      border-radius: 8px;
      font-size: 1.8rem;
      font-weight: 600;
      margin-bottom: 30px;
      box-shadow: 0 3px 8px rgba(0,0,0,0.2);
    }
    .form-container {
      max-width: 900px;
      margin: 50px auto;
      padding: 40px;
      background: #fff;
      border-radius: 12px;
      box-shadow: 0 0 12px rgba(0,0,0,0.08);
    }
  </style>
</head>
<body class="bg-light">
  <div class="container">
    <div class="form-container">
      <h3 class="form-title">
        <i class="bi bi-person-fill"></i> 회원 정보 입력
      </h3>
      <!-- <form class="needs-validation" novalidate action="submitForm.jsp" method="post" enctype="multipart/form-data">
        <div class="row g-3">
          <div class="col-md-6">
            <label for="name" class="form-label">이름</label>
            <input type="text" class="form-control" id="name" name="name" required>
            <div class="invalid-feedback">이름은 필수 항목입니다.</div>
          </div> -->

          <form class = "needs-validation" novalidate action="submitFormForChangeName.jsp" method="post" enctype="multipart/form-data">
            <div class="row g-3">
              <div class="col-md-6">
                <label for="name" class="form-label">이름</label>
                <input type="text" class="form-control" id="name" name="name" required>
                <div class ="invalid-feedback">이름을 입력하세요.</div>
              </div>
            </div>
          </div>
          <div class="col-md-6">
            <label for="email" class="form-label">이메일</label>
            <input type="email" class="form-control" id="email" name="email" required>
            <div class="invalid-feedback">이메일을 입력하세요.</div>
          </div>
          <div class="col-md-6">
            <label for="password" class="form-label">비밀번호</label>
            <input type="password" class="form-control" id="password" name="password" required>
            <div class="invalid-feedback">비밀번호를 입력하세요.</div>
          </div>
          <div class="col-md-6">
            <label for="age" class="form-label">나이</label>
            <input type="number" class="form-control" id="age" name="age">
          </div>
          <div class="col-md-6">
            <label for="dob" class="form-label">생년월일</label>
            <input type="date" class="form-control" id="dob" name="dob">
          </div>
          <div class="col-md-6">
            <label for="appt" class="form-label">예약 시간</label>
            <input type="time" class="form-control" id="appt" name="appt">
          </div>
          <div class="col-md-6">
            <label for="color" class="form-label">좋아하는 색상</label>
            <input type="color" class="form-control form-control-color" id="color" name="color">
          </div>
          <div class="col-md-6">
            <select class="form-select" id="city" name="city">
                <option value="">선택하세요</option>
                <option value="seoul">서울</option>
                <option value="busan">부산</option>
                <option value="daegu">대구</option>
            </select>
          </div>
          <div class="col-md-12">
            <label class="form-label d-block">관심사</label>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="checkbox" name="interest" value="coding" id="chk1">
              <label class="form-check-label" for="chk1">코딩</label>
            </div>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="checkbox" name="interest" value="music" id="chk2">
              <label class="form-check-label" for="chk2">음악</label>
            </div>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="checkbox" name="interest" value="sports" id="chk3">
              <label class="form-check-label" for="chk3">스포츠</label>
            </div>
          </div>
          <div class="col-md-12">
            <label class="form-label d-block">성별</label>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="gender" value="male" id="male">
              <label class="form-check-label" for="male">남성</label>
            </div>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="gender" value="female" id="female">
              <label class="form-check-label" for="female">여성</label>
            </div>
          </div>
          <div class="col-md-12">
            <label for="resume" class="form-label">이력서 첨부</label>
            <input type="file" class="form-control" id="resume" name="resume">
          </div>
          <div class="col-md-12">
            <label for="volume" class="form-label">볼륨 조절</label>
            <input type="range" class="form-range" id="volume" name="volume" min="0" max="100">
          </div>
          <div class="col-md-12">
            <label for="message" class="form-label">자기소개</label>
            <textarea class="form-control" id="message" name="message" rows="4"></textarea>
          </div>
          <input type="hidden" name="user_id" value="12345">
          <div class="col-md-12 text-center mt-4">
            <button type="submit" class="btn btn-primary me-2">제출</button>
            <button type="reset" class="btn btn-secondary">초기화</button>
          </div>
        </div>
      </form>
    </div>
  </div>
  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    (() => {
      'use strict'
      const forms = document.querySelectorAll('.needs-validation')
      Array.from(forms).forEach(form => {
        form.addEventListener('submit', event => {
          if (!form.checkValidity()) {
            event.preventDefault()
            event.stopPropagation()
          }
          form.classList.add('was-validated')
        }, false)
      })
    })()
  </script>
</body>
</html>
