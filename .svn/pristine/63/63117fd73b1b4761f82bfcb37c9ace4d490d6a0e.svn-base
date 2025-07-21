<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID 찾기</title>
<%@ include file="../modules/headerPart.jsp" %>
</head>
<body>
	<div class="container d-flex justify-content-center align-items-center min-vh-100 py-4">
        <div class="card shadow-sm" style="max-width: 430px; border-radius: 22px; width: 100%; box-shadow: 0 4px 24px rgba(0,0,0,0.09);">
            <div class="card-body" style="padding: 48px 32px 36px 32px;"> 
                <h2 class="text-center fw-bolder mb-4" id="idTitle" style="font-size: 2.2rem; letter-spacing: -1px;">아이디 찾기</h2> 
                
                <form id="findIdForm">
                	<sec:csrfInput/>
                    <div class="mb-3">
                        <input type="text" id="peoName" name="peoName" class="form-control" 
                               placeholder="이름" autofocus
                               style="border-radius: 10px; background-color: #fafbfc; border: 1.5px solid #e0e0e0; font-size: 1.08rem; padding: 16px 18px;">
                    </div>
                    <div class="mb-3">
                        <input type="email" id="peoEmail" name="peoEmail" class="form-control" 
                               placeholder="이메일 주소"
                               style="border-radius: 10px; background-color: #fafbfc; border: 1.5px solid #e0e0e0; font-size: 1.08rem; padding: 16px 18px;"> 
                    </div>
                    <button type="button" class="btn w-100 text-white fw-bold mb-4" id="findBtn"
                            style="background-color: #a259e6; border-radius: 14px; font-size: 1.22rem; padding: 18px 0; box-shadow: 0 2px 8px rgba(162,89,230,0.07);">아이디 찾기</button> 
                    
                    <div id="findIdResultContainer" class="d-none"></div>
                </form>

                <div class="text-center mt-3"> 
                    <a href="/auth/resetPw" class="mx-1 text-decoration-none" style="color: #888; font-size: 1.04rem;">비밀번호 찾기</a>
                    |
                    <a href="javascript:window.close();" class="mx-1 text-decoration-none" style="color: #888; font-size: 1.04rem;">닫기</a>
                </div>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">
$(function(){
	let findBtn = $("#findBtn");
	
	findBtn.on("click",function(){
		
		let peoName = $("#peoName").val();
		let peoEmail = $("#peoEmail").val();
		let data = {
				peoName : peoName,
				peoEmail : peoEmail
			}
		$.ajax({
			url : "/auth/findId",
			type : "post",
			data : JSON.stringify(data),
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
		        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		    },
		    success : function(result){
		    	if(result.Status == "SUCCESS"){
		    		$("#idTitle").addClass("d-none");
					$("#findIdForm").addClass("h4").html(`회원의 아이디는 <span style="color:green;"> \${result.username}</span> 입니다`)	    		
		    	}else{
		    		$("#findIdResultContainer").removeClass("d-none").css("color","red").html(`회원의 아이디를 찾지 못하였습니다! <br/> 이름과 이메일을 다시한번 검토해주시길바랍니다.`)
		    		$("#peoName").focus()
		    	}
		    },
		    error : function(err,status,thrown){
		    	console.log(err, status, thrown)
		    	sweetAlert("error",err.statusText);
		    }
		});
	})
	
})
</script>
</html>