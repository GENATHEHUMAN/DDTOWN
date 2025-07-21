<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>404 - 페이지를 찾을 수 없습니다</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif; /* 선호하는 폰트로 변경 가능 */
        }
        .error-container {
            text-align: center;
            padding: 3rem;
            background-color: #ffffff;
            border-radius: 0.5rem;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
        }
        .error-code {
            font-size: 6rem;
            font-weight: bold;
            color: #dc3545; /* 부트스트랩 danger 색상 */
        }
        .error-message {
            font-size: 1.5rem;
            color: #6c757d; /* 부트스트랩 secondary 색상 */
            margin-top: 0;
            margin-bottom: 1.5rem;
        }
        .error-description {
            font-size: 1rem;
            color: #212529; /* 부트스트랩 dark 색상 */
            margin-bottom: 2rem;
        }
        .btn-home, .btn-back {
            margin: 0.5rem;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-code">${statusCode}</div>
        <p class="error-message">
            <c:choose>
                <c:when test="${not empty message}">
                    ${message}
                </c:when>
                <c:otherwise>
                    페이지를 찾을 수 없습니다.
                </c:otherwise>
            </c:choose>
        </p>
        <p class="error-description">
            요청하신 페이지의 주소가 잘못 입력되었거나,
            <br>페이지 주소가 변경 혹은 삭제되어 요청하신 페이지를 찾을 수 없습니다.
            <br>입력하신 주소가 정확한지 다시 한번 확인해 주시기 바랍니다.
        </p>
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-lg btn-home">홈으로 돌아가기</a>
        <a href="javascript:history.back()" class="btn btn-outline-secondary btn-lg btn-back">이전 페이지로</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>