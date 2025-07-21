<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
<%@ include file="../modules/headerPart.jsp" %>
<style>
    /* 필요한 경우 여기에 추가적인 커스텀 스타일을 정의할 수 있습니다. */
    /* 예시: login.css의 input focus 스타일을 headerPart.jsp의 Bootstrap 테마가 완전히 커버하지 못할 경우 대비 */
    .form-control:focus {
        border-color: #a259e6 !important;
        box-shadow: 0 0 0 0.25rem rgba(162, 89, 230, 0.25) !important;
        background-color: #fff !important;
    }
    .form-control {
        background-color: #fafbfc; /* 기본 배경색 */
        border: 1.5px solid #e0e0e0; /* 기본 테두리 */
    }
</style>
</head>
<body>
    <div class="container d-flex justify-content-center align-items-center min-vh-100 py-4">
        <div class="card shadow-sm" style="max-width: 430px; border-radius: 22px; width: 100%; box-shadow: 0 4px 24px rgba(0,0,0,0.09);">
            <div class="card-body" style="padding: 48px 32px 36px 32px;">
                <h2 class="text-center fw-bolder mb-3" id="pwTitle" style="font-size: 2.2rem; letter-spacing: -1px;">비밀번호 찾기</h2>
                

                <form id="resetPwForm">
                    <sec:csrfInput/>
                    <div class="mb-3">
                        <input type="text" id="peoName" name="peoName" class="form-control"
                               placeholder="이름" required autofocus
                               style="border-radius: 10px; font-size: 1.08rem; padding: 16px 18px;">
                    </div>
                    <div class="mb-3">
                        <input type="text" id="username" name="username" class="form-control"
                               placeholder="아이디" required
                               style="border-radius: 10px; font-size: 1.08rem; padding: 16px 18px;">
                    </div>
                    <div class="mb-3">
                        <input type="email" id="peoEmail" name="peoEmail" class="form-control"
                               placeholder="이메일 주소" required
                               style="border-radius: 10px; font-size: 1.08rem; padding: 16px 18px;">
                    </div>
                    <button type="button" class="btn w-100 text-white fw-bold mb-4" id="resetPwBtn"
                            style="background-color: #a259e6; border-radius: 14px; font-size: 1.22rem; padding: 18px 0; box-shadow: 0 2px 8px rgba(162,89,230,0.07);">임시 비밀번호 발급</button>

                    <div id="resetPwResult" class="d-none mb-3 text-center" style="background:#f6f7fa;border-radius:10px;padding:18px 16px 12px 16px;">
                    </div>

                </form>
                <div id="resetPwInfo" class="d-none"
                     style="background:#f6f7fa; border-radius:10px; padding:16px 14px 10px 14px; margin-top:18px; font-size:0.98rem; color:#666;">
                    입력하신 이메일 주소 <span id="targetEmail" style="color:#a259e6;font-weight:600;"></span>(으)로 임시 비밀번호를 발송했습니다.<br>
                    이메일을 확인해 주세요. 만약 메일이 오지 않았다면 스팸 메일함도 확인해주시기 바랍니다.<br>
                    임시 비밀번호로 로그인 후, 반드시 새로운 비밀번호로 변경해 주세요.
                </div>

                <div class="text-center mt-4 pt-2">
                    <a href="javascript:window.close()" class="mx-2 text-decoration-none" style="color: #888; font-size: 1.04rem;">닫기</a>
                </div>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">
$(function(){
	let resetPwBtn = $("#resetPwBtn");
	
	resetPwBtn.on("click",function(){
		
		let peoName = $("#peoName").val();
		let username = $("#username").val();
		let peoEmail = $("#peoEmail").val();
		
		if(peoName == null || peoName.trim() == ""){
			sweetAlert("error","이름을 입력해주세요");
			$("#peoName").focus();
			return false;
		}
		if(username == null || username.trim() == ""){
			sweetAlert("error","아이디을 입력해주세요");
			$("#username").focus();
			return false;
		}
		if(peoEmail == null || peoEmail.trim() == ""){
			sweetAlert("error","이메일을 입력해주세요");
			$("#peoEmail").focus();
			return false;
		}
		
		let data = {
				peoName : peoName,
				username : username,
				peoEmail : peoEmail
			}
		$.ajax({
			url : "/auth/resetPw",
			type : "post",
			data : JSON.stringify(data),
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
		        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		    },
		    success : function(result){
		    	if(result.Status == "SUCCESS"){
		    		$("#resetPwForm").addClass("d-none");
		    		$("#targetEmail").text(peoEmail);
					$("#resetPwInfo").removeClass("d-none");	
		    	}else{
		    		$("#resetPwResult").removeClass("d-none").css("color","red").html(`회원의 정보를 찾지 못하였습니다! <br/> 입력하신 정보를 다시한번 검토해주시길바랍니다.`)
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