<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>500 - 서버 내부 오류</title>
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
            color: #ffc107; /* 부트스트랩 warning 색상 또는 다른 적절한 색상 */
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
        /* 개발 모드에서만 에러 상세 정보 표시 (선택 사항) */
        .error-details {
            margin-top: 2rem;
            padding: 1rem;
            background-color: #f1f1f1;
            border-radius: 0.25rem;
            text-align: left;
            font-size: 0.9rem;
            max-height: 200px;
            /* overflow-y: auto; */
            word-break: break-all;
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
                    서버 내부 오류가 발생했습니다.
                </c:otherwise>
            </c:choose>
        </p>
        <p class="error-description">
            서비스 이용에 불편을 드려 죄송합니다.
            <br>문제가 지속될 경우 관리자에게 문의해주세요.
            <br>잠시 후 다시 시도해 주시면 정상적으로 처리될 수 있습니다.
        </p>

        <%-- 개발 환경에서만 상세 에러 메시지를 보여주고 싶을 때 (선택 사항) --%>
        
        <c:if test="${pageContext.request.serverName == 'localhost' || pageContext.request.serverName == '127.0.0.1'}">
            <c:if test="${not empty requestScope['jakarta.servlet.error.exception']}">
                <div class="error-details w-100">
                    <strong>Error Details (for developers):</strong><br>
                    ${requestScope['jakarta.servlet.error.exception']}<br>
                    <c:forEach var="trace" items="${requestScope['jakarta.servlet.error.exception'].stackTrace}">
                        &nbsp;&nbsp;&nbsp;&nbsp;at ${trace}<br>
                    </c:forEach>
                </div>
            </c:if>
        </c:if>

        <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-lg btn-home">홈으로 돌아가기</a>
        <a href="javascript:history.back()" class="btn btn-outline-secondary btn-lg btn-back">이전 페이지로</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>