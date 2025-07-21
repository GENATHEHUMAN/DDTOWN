<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<header class="emp-header">
	<div class="emp-logo">
		<%-- 관리자 포털 메인 링크 수정 --%>
		<a href="${pageContext.request.contextPath}/admin/main">DDTOWN 관리자 포털</a>
	</div>
	<div class="emp-user-info">
		<%-- 로그인한 관리자 정보 (동적으로 표시) --%>
		<%-- 예시: 세션에서 관리자 정보를 가져온다고 가정 (loginAdmin 객체) --%>
		<sec:authentication property="principal.username" var="username"/>
		<sec:authentication property="principal.employeeVO" var="empVO"/>
		<c:set value="${empVO.userTypeCode }" var="utc"/>
		<span><i class="fas fa-user-circle"></i> <c:out value="${utc eq 'UTC004' ? '관리자' : '직원'  }" default="관리자"/> ${empVO.peoName} <small>${empVO.empDepartNm} ${empVO.empPositionNm}</small> (<c:out value="${username}" default="admin_user"/>)</span>
		<%-- 로그아웃 링크 수정 (Spring Security 사용 시 /logout 경로 등) --%>
		<form action="/logout" method="post">
			<sec:csrfInput/>
			<button type="submit" class="btn emp-logout-btn"><i class="fas fa-sign-out-alt"></i> 로그아웃</button>
		</form>
		<a href="${pageContext.request.contextPath}/admin/logout" class="emp-logout-btn" id="adminLogoutBtn"></a>
	</div>
</header>