<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
상세보기

	<div class="card-body">
		<table class="table table-bordered">
			<tbody>
				<tr>
					<td>상태코드 ${audition.audiStatCode }</td>
					<td>등록일시 ${audition.audiRegDate }</td>
					<td>제목 ${audition.audiTitle }</td>
					<td>모집 분야 ${audition.audiTypeCode}</td>
					<td>시작 ${audition.audiStartDate }</td>
					<td>종료 ${audition.audiEndDate }</td>
					<td>내용 ${audition.audiContent }</td>
					<td>첨부파일 ${audition.fileGroupNo }</td>
				</tr>
			</tbody>
		</table>
		<button type="button" id="listBtn">목록</button>
		<button type="button" id="supportBtn"><a href="/corporate/audition/support.do?audiNo=${audition.audiNo }">지원하기</a></button>
	</div>
</body>
<script type="text/javascript">
$(function(){
	let listBtn = $("#listBtn");  //목록 버튼 Element
	let supportBtn = $("#supportBtn");  //지원하기 버튼 Element
	
	listBtn.on("click", function(){
		location.href = "/corporate/audition/list";	//상세 페이지 이동
		
	
	});
	
	supportBtn.on("click", function(){
		location.href = "/corporate/audition/supportForm.do";	//상세 페이지 이동
	
	});
})
</script>
</html>