<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
오디션 목록 페이지

<!--1. 글목록 불러오기(list) -->
	<div class="card-body">
		<table class="table table-bordered">
			<tbody>
				<c:choose>
					<c:when test="${empty auditionList }">
						<tr>
							<td colspan="5">조회하신 게시글이 존재하지 않습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${auditionList }" var="audition">
							<tr>
								<td>상태코드 ${audition.audiStatCode }</td>
								<td>제목 ${audition.audiTitle }</td>
								<td>모집 분야 ${audition.audiTypeCode}</td>
								<td>시작 ${audition.audiStartDate }</td>
								<td>종료 ${audition.audiEndDate }</td>
								<td>
									<a href="/corporate/audition/detail.do?audiNo=
									${audition.audiNo }">상세보기
									</a>
								</td>
								
								
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
	
</body>
<script type="text/javascript">
$(function(){
	let detailBtn = $("#detailBtn");  //상세보기 버튼 Element
	
	detailBtn.on("click", function(){
		location.href = "/corporate/audition/detail.do";	//상세 페이지 이동
	});
})
</script>
</html>
