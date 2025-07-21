<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>폼 템플릿 만들기</title>
<%@ include file="../../modules/headerPart.jsp" %>
<script src="${pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script>
</head>
<body>
<form action="" method="post">
	<sec:csrfInput/>
	<select name="formNo" id="formNo">
		<c:forEach items="${formList }" var="formVO" varStatus="vs">
			<option value="${formVO.formNo }" <c:if test="${vs.first }">selected</c:if> >${formVO.formNm }</option>
		</c:forEach>
	</select>
	<textarea rows="10" cols="10" name="formContent" id="formContent"></textarea>
	<input type="submit" value="양식 수정"/>
	<%@ include file="../../modules/footerPart.jsp" %>
</form>
</body>
<script type="text/javascript">
$(function(){
	CKEDITOR.replace("formContent");

	let formNoEl = $("#formNo");

	$("#formNo").on("change",function(){
		let formNo = $(this).val()
		formDetail(formNo);
	})

	formDetail(formNoEl.val());

	function formDetail(formNo){
		let data = {
				formNo : formNo
		};
		$.ajax({
			url : "/api/edms/form",
			type : "post",
			beforeSend : function(xhr) {
		        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		    },
		    contentType : "application/json; charset=utf-8",
		    data : JSON.stringify(data),
		    success : function(res){
		    	if(CKEDITOR.instances.formContent){
			    	CKEDITOR.instances.formContent.setData(res.formContent)
		    	}
		    },
		    error : function(err){
		    	console.err(err);
		    }

		});
	}
})
</script>
</html>