<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.fmt"  prefix="fmt"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
        table { border-collapse: collapse; width: 90%; margin: 20px auto; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .action-links a, .action-links button { margin-right: 5px; text-decoration: none; padding: 5px; }
        .message { padding: 10px; margin-bottom: 15px; border-radius: 4px; }
        .success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
</style>
</head>
<body>
	<h1>콘서트 일정 관리</h1>

    <c:if test="${not empty successMessage}">
        <div class="message success">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="message error">${errorMessage}</div>
    </c:if>

    <div style="margin: 20px;">
        <a href="<c:url value='/concert/schedule/new'/>">새 일정 등록</a>
    </div>

    <form action="<c:url value='/concert/schedule'/>" method="get" style="margin: 20px;">
        <input type="text" name="searchKeyword" placeholder="콘서트명 검색" value="${searchKeyword}">
        <input type="submit" value="검색">
    </form>

    <table>
        <thead>
            <tr>
                <th>번호</th>
                <th>콘서트명</th>
                <th>아티스트그룹번호</th>
                <th>공연장번호</th>
                <th>공연일</th>
                <th>(예매)시작일시</th>
                <th>(예매)종료일시</th>
                <th>온라인</th>
                <th>상태</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty concertList}">
                    <c:forEach var="concert" items="${concertList}">
                        <tr>
                            <td>${concert.concertNo}</td>
                            <td>
                                <a href="<c:url value='/concert/schedule/view/${concert.concertNo}'/>">
                                    <c:out value="${concert.concertNm}"/>
                                </a>
                            </td>
                            <td><c:out value="${concert.artGroupNo}"/></td>
                            <td><c:out value="${concert.concertHallNo}"/></td>
                            <td><fmt:formatDate value="${concert.concertDate}" pattern="yyyy-MM-dd"/></td>
                            <td><fmt:formatDate value="${concert.concertStartDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td><fmt:formatDate value="${concert.concertEndDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td>${concert.concertOnlineYn}</td>
                            <td>${concert.concertStatCode}</td>
                            <td class="action-links">
                                <a href="<c:url value='/concert/schedule/edit/${concert.concertNo}'/>">수정</a>
                                <form action="<c:url value='concert/schedule/delete/${concert.concertNo}'/>" method="post" style="display:inline;">
                                    <button type="submit" onclick="return confirm('정말로 이 일정을 삭제하시겠습니까?');">삭제</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="10">등록된 콘서트 일정이 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
	
	
</body>
</html>