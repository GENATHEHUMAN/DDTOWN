<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원가입</title>
<%@ include file="../modules/headerPart.jsp" %>
<style>
    body {
        background-color: #f6f7fa; /* join.css body bg */
        font-family: 'Pretendard', 'Noto Sans KR', Arial, sans-serif; /* join.css font */
    }
    .card { /* 기존 .card [cite: 1] 에 스타일 적용 */
        background-color: #fff; /* join.css container bg */
        border-radius: 18px !important; /* join.css border-radius, !important로 부트스트랩 .rounded-3 우선 */
        box-shadow: 0 4px 24px rgba(80, 60, 120, 0.08) !important; /* join.css shadow, !important로 부트스트랩 .shadow-sm 우선*/
        border: none !important; /* join.css 스타일, !important로 부트스트랩 .border-0 우선 */
    }
    .ddtown-title { /* DDTOWN 타이틀 커스텀 */
        color: #3d246c; 
        font-weight: 800; 
    }
    .form-label {
        color: #3d246c; /* join.css label color */
        font-weight: 600; /* join.css label font-weight */
        font-size: 1.01rem; /* join.css label font-size */
        margin-bottom: 6px; /* join.css label margin */
    }
    .form-control, .form-select {
        background-color: #faf9fd; /* join.css input bg */
        border: 1.5px solid #e0e0e0; /* join.css input border */
        border-radius: 8px; /* join.css input border-radius */
        padding: 11px 12px; /* join.css input padding */
        font-size: 1rem; /* join.css input font-size */
    }
    .form-control:focus, .form-select:focus {
        border-color: #a259e6; /* join.css & login.css input focus border */
        box-shadow: 0 0 0 0.25rem rgba(162, 89, 230, 0.25); /* Primary color shade for focus */
        background-color: #fff; /* login.css focus behavior */
    }

    /* Primary Button 스타일 (가입하기 버튼 등) */
    .btn-primary {
        background-color: #a259e6; /* join.css .join-btn, login.css .login-btn */
        border-color: #a259e6;
        color: #fff;
        font-weight: 700; /* login.css .login-btn font-weight */
    }
    .btn-primary:hover {
        background-color: #7c3aed; /* join.css .join-btn:hover, login.css .login-btn:hover */
        border-color: #7c3aed;
        color: #fff;
    }

    /* 중복확인 버튼 스타일 (join.css .btn-check 기반) */
    .btn-check-custom {
        background: #a259e6;
        color: #fff;
        border: none;
        border-radius: 8px;
        padding: 0 13px;
        font-size: 0.80rem;
        font-weight: 600;
        cursor: pointer;
        transition: background 0.2s;
        height: calc(1.5em + (11px * 2) + (1.5px * 2) ); /* form-control 패딩과 보더에 맞춰 높이 계산 */
        line-height: 1.5; 
    }
    .btn-check-custom:hover {
        background: #7c3aed;
    }
    .input-group .form-control { /* input-group내 form-control 높이 자동조절 */
        height: auto; 
    }

    /* 피드백 메시지 스타일 */
    .form-feedback-custom {
        font-size: 0.93rem; /* join.css .form-msg */
        margin-top: 4px;
        min-height: 18px;
        display: block; 
    }
    .form-feedback-custom.text-success-custom { /* 성공 메시지용 커스텀 클래스 */
        color: #4caf50 !important; /* join.css .form-msg.success */
        font-weight: 600;
    }
    .form-feedback-custom.text-danger-custom { /* 에러 메시지용 커스텀 클래스 */
        color: #e53935 !important; /* join.css .form-msg.error */
        font-weight: 600;
    }
    /* 서버에서 내려오는 .invalid-feedback 에도 동일한 에러 색상 적용 */
    .form-control.is-invalid ~ .invalid-feedback,
    .form-control.is-invalid ~ .form-feedback-custom {
        color: #e53935 !important;
    }
    /* 약관 동의 박스 내부 링크 */
    #agreeBox .form-check-label a {
        color: #a259e6; /* join.css .terms-link */
        text-decoration: underline;
    }
    /* 하단 로그인 링크 */
    .login-link-custom a {
        color: #a259e6; /* join.css .login-link a */
        font-weight: 600; /* join.css .login-link a */
    }
    .login-link-custom a:hover {
        color: #7c3aed;
    }
</style>
</head>
<body class="d-flex align-items-center justify-content-center min-vh-100 py-4 py-md-5 ${bodyText }">

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-10 col-lg-8 col-xl-7">
                <div class="card p-4 p-lg-5">
                    <div class="card-body">
                        <div class="text-center mb-4">
                            <a href="${pageContext.request.contextPath}/" class="h1 text-decoration-none ddtown-title"><b>DDTOWN</b></a>
                        </div>
                        <p class="text-center mb-4 lead">회원가입</p>

                        <form action="/auth/signup.do" method="post" id="signupForm">
                            <sec:csrfInput/>

                            <div class="mb-3 text-start">
                                <label for="username" class="form-label">아이디</label>
                                <div class="input-group">
                                    <input type="text" class="form-control <c:if test='${not empty errors.username}'>is-invalid</c:if>" id="username" name="username" value="${member.username }" placeholder="아이디를 입력해주세요" required>
                                    <button class="btn btn-check-custom" type="button" id="usernameCheckBtn">중복확인</button>
                                </div>
                                <div id="usernameFeedback" class="form-feedback-custom <c:if test='${not empty errors.username}'>text-danger-custom</c:if>">
    	                            <c:if test="${not empty errors.username}">
                                        ${errors.username}
	                                </c:if>
                                </div>
                            </div>

                            <div class="mb-3 text-start">
                                <label for="password" class="form-label">비밀번호</label>
                                <input type="password" class="form-control <c:if test='${not empty errors.password}'>is-invalid</c:if>" id="password" name="password" placeholder="비밀번호를 입력해주세요" required>
                                <div id="passwordCaps" class="d-none form-text text-danger small">
			                    	Caps Lock이 켜져 있습니다.
			                    </div>
                                <div id="passwordFeedback" class="form-feedback-custom <c:if test='${not empty errors.memPw}'>text-danger-custom</c:if>">
	                                <c:if test="${not empty errors.memPw}">
                                        ${errors.memPw}
	                                </c:if>
                                </div>
                            </div>

                            <div class="mb-3 text-start">
                                <label for="passwordConfirm" class="form-label">비밀번호 확인</label>
                                <input type="password" id="passwordConfirm" name="passwordConfirm" class="form-control" placeholder="비밀번호를 한번 더 입력해주세요" required>
                                <div id="passwordConfirmCaps" class="d-none form-text text-danger small">
			                    	Caps Lock이 켜져 있습니다.
			                    </div>
                                <div class="form-feedback-custom" id="passwordConfirmError"></div>
                            </div>

                            <div class="row g-2 mb-3 text-start">
                                <div class="col">
                                    <label for="memLastNm" class="form-label">성 (Last Name)</label>
                                    <input type="text" class="form-control <c:if test='${not empty errors.peoLastNm}'>is-invalid</c:if>" id="peoLastNm" name="peoLastNm" value="${member.peoLastNm}" placeholder="성을 입력해주세요" required>
                                   	<div id="peoLastNmFeedback" class="form-feedback-custom <c:if test='${not empty errors.peoLastNm}'>text-danger-custom</c:if>">
	                                     <c:if test="${not empty errors.peoLastNm}">
                                            ${errors.peoLastNm}
    	                                </c:if>
                                    </div>
                                </div>
                                <div class="col">
                                    <label for="memFirstNm" class="form-label">이름 (First Name)</label>
                                    <input type="text" class="form-control <c:if test='${not empty errors.peoFirstNm}'>is-invalid</c:if>" id="peoFirstNm" name="peoFirstNm" value="${member.peoFirstNm}" placeholder="이름을 입력해주세요" required>
                                    <div id="peoFirstNmFeedback" class="form-feedback-custom <c:if test='${not empty errors.peoFirstNm}'>text-danger-custom</c:if>">
                                    	<c:if test="${not empty errors.peoFirstNm}">
                                            ${errors.peoFirstNm}
                                    	</c:if>
                                    </div>
                                </div>
                            </div>

		                    <div class="mb-3 text-start">
		                    	<input type="hidden" name="peoGender" id="peoGender">
		                        <label class="form-label">성별</label>
		                        <div class="gender-options">
		                            <div class="form-check form-check-inline">
		                                <input class="form-check-input" type="radio" name="gender" id="genderMale" value="male" checked>
		                                <label class="form-check-label" for="genderMale">남자 (Male)</label>
		                            </div>
		                            <div class="form-check form-check-inline">
		                                <input class="form-check-input" type="radio" name="gender" id="genderFemale" value="female">
		                                <label class="form-check-label" for="genderFemale">여자 (Female)</label>
		                            </div>
		                        </div>
		                    </div>
		                    
                            <div class="mb-3 text-start">
                                <label for="memNicknm" class="form-label">닉네임</label>
                                <div class="input-group">
                                    <input type="text" class="form-control <c:if test='${not empty errors.memNicknm}'>is-invalid</c:if>" id="memNicknm" name="memNicknm" value="${member.memNicknm}" placeholder="닉네임을 입력해주세요">
                                    <button class="btn btn-check-custom" type="button" id="nickCheckBtn">중복확인</button>
                                </div>
                                <div id="nicknameFeedback" class="form-feedback-custom <c:if test='${not empty errors.memNicknm}'>text-danger-custom</c:if>">
    	                            <c:if test="${not empty errors.memNicknm}">
                                        ${errors.memNicknm}
	                                </c:if>
                                </div>
                            </div>

                            <div class="mb-3 text-start">
                                <label for="peoEmail" class="form-label">이메일 주소</label>
                                <div class="input-group">
                                    <input type="email" class="form-control <c:if test='${not empty errors.peoEmail}'>is-invalid</c:if>" id="peoEmail" name="peoEmail" value="${member.peoEmail }" placeholder="이메일을 입력해주세요">
                                    <button class="btn btn-check-custom" type="button" id="emailCheckBtn">중복확인</button>
                                </div>
                                <div id="emailFeedback" class="form-feedback-custom <c:if test='${not empty errors.peoEmail}'>text-danger-custom</c:if>">
	                                <c:if test="${not empty errors.peoEmail}">
                                        ${errors.peoEmail}
	                                </c:if>
                                </div>
                            </div>

                            <div class="mb-4 text-start"> <label for="peoPhone" class="form-label">휴대폰 번호</label>
                                <div class="input-group">
                                    <input type="tel" id="peoPhone" name="peoPhone" class="form-control" placeholder="'-' 없이 숫자만 입력">
                                </div>
                                <div id="phoneFeedback" class="form-feedback-custom"></div>
                            </div>

                            <div class="mb-3 text-start">
                            	<input type="hidden" name="memBirth" id="memBirth"/>
                                <label for="birthYear" class="form-label">생년월일</label>
                                <div class="row g-1">
                                    <div class="col">
                                        <select id="birthYear" name="birthYear" class="form-select w-100" title="년도 선택">
                                            <option value="">년</option>
                                        </select>
                                    </div>
                                    <div class="col">
                                        <select id="birthMonth" name="birthMonth" class="form-select w-100" title="월 선택">
                                            <option value="">월</option>
                                        </select>
                                    </div>
                                    <div class="col">
                                        <select id="birthDay" name="birthDay" class="form-select w-100" title="일 선택">
                                            <option value="">일</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="card p-3 text-start mb-4 rounded-3 border" id="agreeBox">
                                <div class="form-check border-bottom pb-2 mb-2">
                                    <input class="form-check-input" type="checkbox" id="agreeAll" name="agreeAll">
                                    <label class="form-check-label fw-bold" for="agreeAll">
                                        전체 약관에 동의합니다.
                                    </label>
                                </div>
                                <div class="form-check mb-1">
                                    <input class="form-check-input" type="checkbox" id="memAgree" name="memAgree" value="Y" required>
                                    <label class="form-check-label small" for="memAgree">
                                        (필수) 이용약관 동의
                                    </label>
                                    <a href="#" class="ms-1 text-decoration-none small" target="_blank" title="개인정보방침 보기">[개인정보방침 보기]</a>
                                </div>
                                <div class="form-check mb-1">
                                    <input class="form-check-input" type="checkbox" id="agreeTermsPrivacy" name="agreeTerms" value="Y" required>
                                    <label class="form-check-label small" for="agreeTermsPrivacy">
                                        (필수) 개인정보 수집 및 이용 동의
                                    </label>
                                    <a href="#" class="ms-1 text-decoration-none small" target="_blank" title="개인정보 수집 및 이용 동의 보기">[보기]</a>
                                </div>
                            </div>


                            <div class="row g-2">
                                <div class="col-md-8 mb-2 mb-md-0">
                                    <div class="d-grid">
                                        <button type="button" class="btn btn-primary btn-lg" id="signupBtn">가입하기</button>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="d-grid">
                                        <button type="button" class="btn btn-secondary btn-lg" onclick="location.href='${pageContext.request.contextPath}/'">뒤로가기</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                        
                      
                        <div class="text-center mt-4 small login-link-custom">
                            이미 회원이신가요? <a href="/login" class="text-decoration-none fw-bold">로그인</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<%@ include file="../modules/footerPart.jsp" %>
	
</body>
<script type="text/javascript">
$(function(){
	
	// 아이디 중복확인 이벤트 영역
	let usernameCheckBtn = $("#usernameCheckBtn");		// 아이디 중복확인 버튼 Element
	let idCheckFlag = false;				// 중복확인 flag(true:중복체크 완료, false: 중복체크 미완료)
	
	// 닉네임 중복확인 이벤트 영역
	let nickCheckBtn = $("#nickCheckBtn");		// 닉네임 중복확인 버튼 Element
	let nickCheckFlag = false;				// 중복확인 flag(true:중복체크 완료, false: 중복체크 미완료)
	
	// 이메일 중복확인 이벤트 영역
	let emailCheckBtn = $("#emailCheckBtn");		// 이메일 중복확인 버튼 Element
	let emailCheckFlag = false;				// 중복확인 flag(true:중복체크 완료, false: 중복체크 미완료)
	
	// 비밀번호 확인 이벤트
	let password = $("#password")
	let passwordConfirm = $("#passwordConfirm");
	let passwordCheckFlag = false;
	// 가입하기 영역
	let signupBtn = $("#signupBtn"); 		// 가입하기 버튼 Element
	let signupForm = $("#signupForm");		// 가입하기 Form Element
	
	// 약관 동의 관련
	let agreeBox = $("#agreeBox");
	let agreeAll = $("#agreeAll");
	let memAgree = $("#memAgree"); // 약관동의체크박스
	let agreeTermsPrivacy = $("#agreeTermsPrivacy"); //개인정보 수신 동의체크박스
	let agreeTermsMarketing = $("#agreeTermsMarketing"); // 마켓팅 수신 동의 체크박스
	
	
	// 아이디 중복확인 버튼 이벤트
	usernameCheckBtn.on("click",function(){
		let username = $("#username").val();	// 입력한 아이디 값
		
		if(username == null || username.trim() == "") { // 아이디 입력이 비어있다면
			sweetAlert("error","아이디를 입력해주세요!");
			return false;
		}
		
		let data = {
			username : username
		};
		
		$.ajax({
			url : "/auth/idCheck",
			type : "post",
			data : JSON.stringify(data),
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
		        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		    },
			success : function(res){
				let usernameFeedback = $("#usernameFeedback");	// error 클래스를 가지고있는 element 중 id요소에 해당하는 Element
				if(res == "NOTEXIST"){	// 아이디 사용가능
					sweetAlert("success","사용가능한 아이디입니다.");
					usernameFeedback.html("사용가능한 아이디입니다!").removeClass("text-danger-custom").addClass("text-success-custom");
					idCheckFlag = true;
				}else{					// 중복된 아이디 사용 불가능
					sweetAlert("error","이미 사용 중인 아이디 입니다.");
					usernameFeedback.html("이미 사용 중인 아이디 입니다.").removeClass("text-success-custom").addClass("text-danger-custom");
					idCheckFlag = false;
				}
			}
			
		});
	});
	
	// 닉네임 중복확인 버튼 이벤트
	nickCheckBtn.on("click",function(){
		let nick = $("#memNicknm").val();	// 입력한 아이디 값
		
		if(nick == null || nick.trim() == "") { // 아이디 입력이 비어있다면
			sweetAlert("error","닉네임을 입력해주세요!");
			return false;
		}
		
		let data = {
				memNicknm : nick
		};
		
		$.ajax({
			url : "/auth/nickCheck",
			type : "post",
			data : JSON.stringify(data),
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
		        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		    },
			success : function(res){
				let nicknameFeedback = $("#nicknameFeedback");	// error 클래스를 가지고있는 element 중 id요소에 해당하는 Element
				if(res == "NOTEXIST"){	// 닉네임 사용가능
					sweetAlert("success","사용가능한 닉네임입니다.");
					nicknameFeedback.html("사용가능한 아이디입니다!").css("color","green");
					nickCheckFlag = true;
				}else{					// 중복된 닉네임 사용 불가능
					sweetAlert("error","이미 사용 중인 닉네임 입니다.").removeClass("text-danger-custom").addClass("text-success-custom");
					nicknameFeedback.html("이미 사용 중인 닉네임 입니다.").removeClass("text-success-custom").addClass("text-danger-custom");
					nickCheckFlag = false;
				}
			}
			
		});
	});
	// 이메일 중복확인 버튼 이벤트
	emailCheckBtn.on("click",function(){
		let email = $("#peoEmail").val();	// 입력한 아이디 값
		
		if(email == null || email.trim() == "") { // 아이디 입력이 비어있다면
			sweetAlert("error","이메일를 입력해주세요!");
			return false;
		}
		
		let data = {
				peoEmail : email
		};
		
		$.ajax({
			url : "/auth/emailCheck",
			type : "post",
			data : JSON.stringify(data),
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
		        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		    },
			success : function(res){
				let emailFeedback = $("#emailFeedback");	// error 클래스를 가지고있는 element 중 id요소에 해당하는 Element
				if(res == "NOTEXIST"){	// 아이디 사용가능
					sweetAlert("success","사용가능한 이메일입니다.");
					emailFeedback.html("사용가능한 이메일입니다!").removeClass("text-danger-custom").addClass("text-success-custom");
					emailCheckFlag = true;
				}else{					// 중복된 아이디 사용 불가능
					sweetAlert("error","이미 사용 중인 이메일 입니다.");
					emailFeedback.html("이미 사용 중인 이메일 입니다.").removeClass("text-success-custom").addClass("text-danger-custom");
					emailCheckFlag = false;
				}
			}
			
		});
	});
	
	let capsLockToggle = false;
		
	$(document).on("keydown",function(e){
		if(e.keyCode == 20){
			capsLockToggle = !capsLockToggle;
		}
		
		if(capsLockToggle && password.is(":focus")){
			$("#passwordCaps").removeClass("d-none");
		}else{
			$("#passwordCaps").addClass("d-none");
		}
		
		if(capsLockToggle && passwordConfirm.is(":focus")){
			$("#passwordConfirmCaps").removeClass("d-none");
		}else{
			$("#passwordConfirmCaps").addClass("d-none");
		}
	})
	
	const pwRegEx = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]).{8,16}$/;
	password.on("blur",function(){
		$("#passwordCaps").addClass("d-none");
		let pwVal = password.val();
		if(!pwRegEx.test(pwVal)){
			$("#passwordFeedback").html("8~16자 영문, 숫자, 특수문자 조합이어야 합니다.").removeClass("text-success-custom").addClass("text-danger-custom");
			passwordCheckFlag = false;
			return false;
		}else{
			passwordCheckFlag = true;
			$("#passwordFeedback").html("").removeClass("text-danger-custom text-success-custom");			
		}
		
	}).on("keyup",pwcheck).on("focus",function(){
		if(capsLockToggle){
			$("#passwordCaps").removeClass("d-none");
		}
	})
	passwordConfirm.on("keyup",pwcheck).on("blur",function(){
		$("#passwordConfirmCaps").addClass("d-none");
	}).on("focus",function(){
		if(capsLockToggle){
			$("#passwordConfirmCaps").removeClass("d-none");
		}
	})
	
	
	// 약관 동의 파트
	agreeAll.on("click",function(){
			$("input[type='checkbox']",agreeBox).prop("checked",$(this).prop("checked"));
	});
	
	// 약관 전체체크 개별 트리거
	$("input[type='checkbox']",agreeBox).on("click",function(){
		let length = $("input[type='checkbox']:not(#agreeAll):checked",agreeBox).length
		if(length < 2){
			agreeAll.prop("checked",false);
		}else{
			agreeAll.prop("checked",true);
		}
		
	})
	
	// 생년월일 동적 생성
	let birthYear = $("#birthYear");
	let birthMonth = $("#birthMonth");
	let birthDay = $("#birthDay");
	
	let date = new Date();
	let year = date.getFullYear();
	for(let i = year - 14 ; i >= 1950; i--){
		birthYear.append(new Option(i,i));
	}
	for(let i = 1; i<=12; i++){
		birthMonth.append(new Option(String(i).padStart(2,'0'),String(i).padStart(2,'0')));
	}
	function createDay(){
		let year = parseInt(birthYear.val());
		let month = parseInt(birthMonth.val());
		
		birthDay.empty()
		birthDay.append(new Option("일",""))
		
		if(year != "" && month != ""){
			let day = new Date(year, month, 0).getDate();
			for(let i = 1; i<=day; i++){
				birthDay.append(new Option(String(i).padStart(2,'0'),String(i).padStart(2,'0')))
			}
		}		
		
	}
	birthYear.on("change",createDay);
	birthMonth.on("change",createDay);
	
	$("#peoPhone").on("focus",function(){
		let val = $(this).val();
		val = val.replaceAll("-","");
		$(this).val(val)
	})
	
	// 휴대폰번호 - 자동완성
	$("#peoPhone").on("blur",function(){
		let val = $(this).val();
		let newVal = val;
		if(val.length == 11){
			newVal = val.substring(0,3) + "-" + val.substring(3,7) + "-" + val.substring(7)
		}else if(val.length == 10){
			newVal = val.substring(0,3) + "-" + val.substring(3,6) + "-" + val.substring(6)			
		}
		$(this).val(newVal);
	})
	
	
	// 가입하기 버튼
	signupBtn.on("click",function(){
		let username = $("#username").val();		// 아이디 값
		let password = $("#password").val(); 		// 비밀번호 값
		let peoFirstNm = $("#peoFirstNm").val();	// 성 값
		let peoLastNm = $("#peoLastNm").val();	// 이름 값
		let memNicknm = $("#memNicknm").val();	// 이름 값
		let peoEmail = $("#peoEmail").val();	// 이름 값
		let peoPhone = $("#peoPhone").val();	// 이름 값
		let agreeFlag = false;				// 개인정보 동의 방침 flag(true:동의, false: 비동의)
		let memBirth = $("#memBirth");
		let peoGender = $("#peoGender");
		let genderCheck = $("input[name='gender']:checked");
		
		let year = birthYear.val();
		let month = birthMonth.val();
		let day = birthDay.val();
		
		if(year && month && day){
			memBirth.val(year+"/"+month+"/"+day);			
		}else{
			sweetAlert("error","생년월일을 모두 선택해주세요!");
			return false;
		}
		
		if(genderCheck.val() == "male"){
			peoGender.val("M");
		}else{
			peoGender.val("F");
		}
			
		// 아이디, 비밀번호, 이름 기본 유효성 검사
		if(username == null || username.trim() == ""){
			sweetAlert("error","아이디를 입력해주세요!");
			return false;
		}
		if(password == null || password.trim() == ""){
			sweetAlert("error","비밀번호를 입력해주세요!");
			return false;
		}
		if(peoFirstNm == null || peoFirstNm.trim() == ""){
			sweetAlert("error","이름을 입력해주세요!");
			return false;
		}
		if(peoLastNm == null || peoLastNm.trim() == ""){
			sweetAlert("error","성을 입력해주세요!");
			return false;
		}
		if(memNicknm == null || memNicknm.trim() == ""){
			sweetAlert("error","닉네임을 입력해주세요!");
			return false;
		}
		if(peoEmail == null || peoEmail.trim() == ""){
			sweetAlert("error","이메일을 입력해주세요!");
			return false;
		}
		if(peoPhone == null || peoPhone.trim() == ""){
			sweetAlert("error","전화번호를 입력해주세요!");
			return false;
		}
		if(peoPhone.length < 12 || peoPhone.length >= 14){
			sweetAlert("error","전화번호는 10~11자리입니다!");
			return false;			
		}
		let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
		if(!emailPattern.test(peoEmail)){
			sweetAlert("error","올바른 이메일 형식이 아닙니다!");
			return false;			
		}
		
		if(passwordConfirm.val() !== password){
			sweetAlert("error", "비밀번호가 일치하지 않습니다.");
            passwordConfirm.focus();
            return false;
		}
		
		let memAgree = $("#memAgree:checked").val();
		let agreeTermsPrivacy = $("#agreeTermsPrivacy:checked").val();
		if(memAgree == "Y" && agreeTermsPrivacy == "Y"){	// 개인정보 동의 체크 함
			agreeFlag = true;			
		}
		// 개인정보 처리방침을 동의했습니까?
		// 아이디 중복체크를 이행하고 오셨습니까?
		// 오셨다구요? 그럼 가입하기를 진행하겠습니다.
		// 예? 안했다구요? 그럼 하기를 할 수 없습니다.
		if(agreeFlag){
			if(idCheckFlag && nickCheckFlag && emailCheckFlag && passwordCheckFlag){	// 중복체크 완료
				signupForm.submit();
			}else{				// 중복체크 미완료
				sweetAlert("error","올바른 정보를 입력해주세요!");
			}
		}else{
			sweetAlert("error","개인정보 동의를 체크해주세요!");
		}
	});
	
	//비밀번호 일치 확인
	function pwcheck(){
		let pw = $("#password").val();
		let pwconfirm = $("#passwordConfirm").val();
		let error = $("#passwordConfirmError");
		
		if(pwconfirm === "") {
			passwordCheckFlag = false;
			error.html("").removeClass("text-success-custom text-danger-custom");
            return;
       	}
		
		if(pw != pwconfirm){
			passwordCheckFlag = false;
			error.html("입력하신 비밀번호와 일치하지 않습니다!").removeClass("text-success-custom").addClass("text-danger-custom");
		}else{
			error.html("입력하신 비밀번호와 일치합니다").removeClass("text-danger-custom").addClass("text-success-custom");
			if(!pwRegEx.test(pw)){
				passwordCheckFlag = false; 
			}else{
				passwordCheckFlag = true;
			}
		}
	}
	
});

</script>
</html>

