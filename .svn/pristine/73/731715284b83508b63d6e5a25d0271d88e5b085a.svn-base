<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>DDTOWN 굿즈샵 - 공지사항</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/goods.css">
</head>
<body class="notice-list-page-body">
	<header class="site-header">
		<div class="logo">
			<a href="${pageContext.request.contextPath}/goods/main">DDTOWN SQUARE</a>
		</div>
		<nav class="utility-nav">
			<%--
                백엔드(서버)에서는 'isUserLoggedIn_server'와 같은 세션 속성을 설정해야 합니다.
                예시: session.setAttribute("isUserLoggedIn_server", true);
            --%>
			<c:choose>
				<c:when test="${sessionScope.isUserLoggedIn_server == true}">
					<ul id="loggedInNav">
						<li><a href="#" class="icon-btn" title="알림">🔔</a></li>
						<li><a href="${pageContext.request.contextPath}/mypage.html"
							class="icon-btn" title="마이페이지">👤</a></li>
						<li><a href="#" class="icon-btn" title="고객센터">👩‍💻</a></li>
						<li><a href="${pageContext.request.contextPath}/logout"
							id="logoutBtn" class="auth-link">로그아웃</a></li>
						<%-- 실제 로그아웃 처리 URL로 변경 --%>
					</ul>
				</c:when>
				<c:otherwise>
					<ul id="loggedOutNav">
						<li><a href="${pageContext.request.contextPath}/login.html"
							class="auth-link">로그인</a></li>
						<li><a href="${pageContext.request.contextPath}/signup.html"
							class="signup-link">회원가입</a></li>
					</ul>
				</c:otherwise>
			</c:choose>
		</nav>
	</header>

	<nav class="main-navigation">
		<ul>
			<li><a href="${pageContext.request.contextPath}/goods/main.jsp">굿즈샵</a></li>
			<li><a href="#">선호도 조사</a>
				<ul class="submenu">
					<li><a
						href="${pageContext.request.contextPath}/goods/preference_vote.html">인기
							투표</a></li>
					<%-- 경로 확인 필요 --%>
				</ul></li>
			<li><a href="#">콘서트</a></li>
		</ul>
	</nav>

	<div class="notice-list-container">
		<header class="notice-list-header">
			<h1>공지사항</h1>
			<div class="notice-search">
				<form action="/goodsnotice/search" method="post">
				<sec:csrfInput/>
					<input type="text" name="title" value="${notice.goodsNotiTitle }" /> 
					<input type="submit" value="검색"/>
				</form>
			</div>
		</header>

		<div class="notice-list">
			<table border="1">
				<tr>
					<th align="center" width="320">제목</th>
					<th align="center" width="180">작성일</th>
				</tr>
				<c:choose>
					<c:when test="${empty noticeList }">
						<tr>
							<td colspan="4">조회하실 게시글이 존재하지 않습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${noticeList }" var="notice">
							<tr>
								<td align="left">
								<a href="${notice.goodsNotiNo }">${notice.goodsNotiTitle } </a></td>
								<td align="center"><fmt:formatDate value="${notice.goodsRegDate }" pattern="yyyy-MM-dd" /></td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
		</div>

		<%-- 페이징 처리 예시 --%>
		<%-- 백엔드에서 currentPage, totalPages, startPage, endPage 등의 페이징 정보를 전달해야 합니다. --%>
		<%-- 예시: request.setAttribute("currentPage", 1); --%>
		<%--       request.setAttribute("totalPages", 10); --%>
		<%--       request.setAttribute("startPage", 1); --%>
		<%--       request.setAttribute("endPage", 5); --%>
		<div class="pagination">
			<c:if test="${currentPage > 1}">
				<a href="?page=${currentPage - 1}&query=${param.query}"
					class="btn-page prev">&lt;</a>
			</c:if>
			<c:if test="${currentPage == 1 || empty currentPage}">
				<%-- currentPage가 없거나 1이면 비활성화 --%>
				<button class="btn-page prev" disabled>&lt;</button>
			</c:if>

			<c:forEach var="i" begin="${startPage}" end="${endPage}">
				<a href="?page=${i}&query=${param.query}"
					class="btn-page ${i == currentPage ? 'active' : ''}">${i}</a>
			</c:forEach>

			<c:if test="${currentPage < totalPages}">
				<a href="?page=${currentPage + 1}&query=${param.query}"
					class="btn-page next">&gt;</a>
			</c:if>
			<c:if
				test="${currentPage == totalPages || empty totalPages || totalPages == 0}">
				<%-- currentPage가 마지막 페이지거나 totalPages가 없거나 0이면 비활성화 --%>
				<button class="btn-page next" disabled>&gt;</button>
			</c:if>
		</div>
	</div>

	<script>

    </script>
</body>
</html>