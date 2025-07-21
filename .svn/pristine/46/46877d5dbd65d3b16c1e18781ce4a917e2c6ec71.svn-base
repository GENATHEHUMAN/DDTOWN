<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.fmt"  prefix="fmt"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="form-container">
        <h1>콘서트 일정 수정 (번호: ${concertVO.concertNo})</h1>

        <c:if test="${not empty errorMessage}">
            <div class="message error">${errorMessage}</div>
        </c:if>

        <form method="post" action="<c:url value="/concert/schedule/edit/${concertVO.concertNo}"/>">
            <div class="form-group">
                <label for="concertNm">콘서트명:</label>
                <input type="text" id="concertNm" name="concertNm" value="${concertVO.concertNm}" required>
            </div>

            <div class="form-group">
                <label for="artGroupNo">아티스트 그룹 번호:</label>
                <input type="number" id="artGroupNo" name="artGroupNo" value="${concertVO.artGroupNo}" required>
            </div>

            <div class="form-group">
                <label for="concertHallNo">공연장 번호:</label>
                <input type="number" id="concertHallNo" name="concertHallNo" value="${concertVO.concertHallNo}" required>
            </div>

            <div class="form-group">
                <label for="concertCatCode">콘서트 카테고리 코드:</label>
                <input type="text" id="concertCatCode" name="concertCatCode" value="${concertVO.concertCatCode}" required>
            </div>

            <div class="form-group">
                <label for="concertReservationStatCode">예매 상태 코드:</label>
                <input type="text" id="concertReservationStatCode" name="concertReservationStatCode" value="${concertVO.concertReservationStatCode}" required>
            </div>

            <div class="form-group">
                <label for="concertStatCode">콘서트 상태 코드:</label>
                <input type="text" id="concertStatCode" name="concertStatCode" value="${concertVO.concertStatCode}" required>
            </div>

            <div class="form-group">
                <label for="concertImg">콘서트 이미지 URL:</label>
                <input type="text" id="concertImg" name="concertImg" value="${concertVO.concertImg}">
            </div>

            <div class="form-group">
                <label>온라인 콘서트 여부:</label>
                <input type="radio" id="onlineY_edit" name="concertOnlineYn" value="Y" ${concertVO.concertOnlineYn == 'Y' ? 'checked' : ''}> <label for="onlineY_edit">Yes</label>
                <input type="radio" id="onlineN_edit" name="concertOnlineYn" value="N" ${concertVO.concertOnlineYn == 'N' ? 'checked' : ''}> <label for="onlineN_edit">No</label>
            </div>

            <div class="form-group">
                <label for="concertDate">공연일:</label>
                <input type="date" id="concertDate" name="concertDate" value="<fmt:formatDate value='${concertVO.concertDate}' pattern='yyyy-MM-dd'/>" required>
            </div>

            <div class="form-group">
                <label for="concertAddress">콘서트 주소:</label>
                <input type="text" id="concertAddress" name="concertAddress" value="${concertVO.concertAddress}" required>
            </div>

            <div class="form-group">
                <label for="concertStartDate">(예매/이벤트)시작일시:</label>
                <input type="datetime-local" id="concertStartDate" name="concertStartDate" value="<fmt:formatDate value='${concertVO.concertStartDate}' pattern="yyyy-MM-dd'T'HH:mm"/>" required>
            </div>

            <div class="form-group">
                <label for="concertEndDate">(예매/이벤트)종료일시:</label>
                <input type="datetime-local" id="concertEndDate" name="concertEndDate" value="<fmt:formatDate value='${concertVO.concertEndDate}' pattern="yyyy-MM-dd'T'HH:mm"/>" required>
            </div>

            <div class="form-group">
                <label for="concertRunningTime">진행 시간(분):</label>
                <input type="number" id="concertRunningTime" name="concertRunningTime" value="${concertVO.concertRunningTime}" required>
            </div>

            <div class="form-group">
                <label for="concertGuide">콘서트 안내사항:</label>
                <textarea id="concertGuide" name="concertGuide" required><c:out value="${concertVO.concertGuide}"/></textarea>
            </div>

            <div class="form-actions">
                <a href="<c:url value='/concert/schedule'/>">목록으로</a>
                <input type="submit" value="수정">
            </div>
        </form>
    </div>
</body>
</html>