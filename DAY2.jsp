<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>123123123</title>
    <!-- Bootstrap CSS -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
  </head>
  <body class="bg-light">
    <div class="container mt-5">
      <h1 class="mb-4">부트스트랩 시험용 폼</h1>
      <form>
        <!-- Username -->
        <div class="mb-3">
          <label for="username" class="form-label">아이디</label>
          <input
            type="text"
            class="form-control"
            id="username"
            name="username"
            placeholder="아이디를 입력하세요"
          />
        </div>

        <!-- Password -->
        <div class="mb-3">
          <label for="password" class="form-label">비밀번호</label>
          <input
            type="password"
            class="form-control"
            id="password"
            name="password"
            placeholder="비밀번호를 입력하세요"
          />
        </div>

        <!-- Checkbox -->
        <div class="mb-3">
          <label class="form-label d-block">취미</label>
          <div class="form-check">
            <input
              class="form-check-input"
              type="checkbox"
              id="hobby-music"
              name="hobby"
              value="music"
            />
            <label class="form-check-label" for="hobby-music">음악</label>
          </div>
          <div class="form-check">
            <input
              class="form-check-input"
              type="checkbox"
              id="hobby-reading"
              name="hobby"
              value="reading"
            />
            <label class="form-check-label" for="hobby-reading">독서</label>
          </div>
        </div>

        <!-- Radio -->
        <div class="mb-3">
          <label class="form-label d-block">성별</label>
          <div class="form-check">
            <input
              class="form-check-input"
              type="radio"
              id="gender-male"
              name="gender"
              value="male"
            />
            <label class="form-check-label" for="gender-male">남성</label>
          </div>
          <div class="form-check">
            <input
              class="form-check-input"
              type="radio"
              id="gender-female"
              name="gender"
              value="female"
            />
            <label class="form-check-label" for="gender-female">여성</label>
          </div>
        </div>

        <!-- Submit Button -->
        <button type="submit" class="btn btn-primary">제출</button>
      </form>
    </div>

    <!-- Bootstrap JS (with Popper) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
