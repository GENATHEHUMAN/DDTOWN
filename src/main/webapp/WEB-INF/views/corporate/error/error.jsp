<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>오류 발생</title>
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
        .error-icon { /* 아이콘 사용 시 (예: Font Awesome) */
            font-size: 5rem;
            color: #6c757d; /* 부트스트랩 secondary 색상 */
            margin-bottom: 1rem;
        }
        .error-code-generic {
            font-size: 2rem; /* 404/500보다는 작게 */
            font-weight: bold;
            color: #dc3545; /* 부트스트랩 danger 색상 또는 다른 일반적인 에러 색상 */
            margin-bottom: 0.5rem;
        }
        .error-message {
            font-size: 1.25rem;
            color: #6c757d;
            margin-top: 0;
            margin-bottom: 1.5rem;
        }
        .error-description {
            font-size: 1rem;
            color: #212529;
            margin-bottom: 2rem;
        }
        .btn-home, .btn-back {
            margin: 0.5rem;
        }
    </style>
</head>
<body>
    <div class="error-container">
        필요하다면 여기에 일반적인 에러 아이콘을 넣을 수 있습니다.
             예: <i class="fas fa-exclamation-triangle error-icon"></i> (Font Awesome 사용 시)
        

        <div class="error-code-generic">
            오류 코드:
            <c:choose>
                <c:when test="${not empty statusCode}">
                    ${statusCode}
                </c:when>
                <c:otherwise>
                    알 수 없음
                </c:otherwise>
            </c:choose>
        </div>
        <p class="error-message">
            <c:choose>
                <c:when test="${not empty message}">
                    ${message}
                </c:when>
                <c:otherwise>
                    예기치 않은 오류가 발생했습니다.
                </c:otherwise>
            </c:choose>
        </p>
        <p class="error-description">
            서비스 이용에 불편을 드려 죄송합니다.
            <br>문제가 지속되거나 다른 문의사항이 있으시면 관리자에게 연락주시기 바랍니다.
        </p>
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-lg btn-home">홈으로 돌아가기</a>
        <a href="javascript:history.back()" class="btn btn-outline-secondary btn-lg btn-back">이전 페이지로</a>

        <%-- 개발 환경에서만 상세 에러 메시지를 보여주고 싶을 때 (선택 사항, 500.jsp와 유사) --%>
 
        <c:if test="${pageContext.request.serverName == 'localhost' || pageContext.request.serverName == '127.0.0.1'}">
            <c:if test="${not empty requestScope['jakarta.servlet.error.exception']}">
                <div class="error-details w-100" style="margin-top: 2rem; padding: 1rem; background-color: #f1f1f1; border-radius: 0.25rem; text-align: left; font-size: 0.9rem;">
                    <strong>Error Details (for developers):</strong><br>
                    ${requestScope['jakarta.servlet.error.exception']}<br>
                </div>
            </c:if>
        </c:if>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>