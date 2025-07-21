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
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.js"></script>
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
                    <div class="card-body" style="position: relative;">
                    	<div class="alert alert-warning alert-dismissible fade show" role="alert" id="warningDiv" style="z-index: 1;">
						  	원활한 이용을 위해 추가 정보를 입력해주세요.
						  	<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
						</div>
						<button class="btn btn-secondary btn-sm" id="userBtn" style="position: absolute; top:80px; right:0;">유저</button>
                        <form action="/auth/additional-info" method="post" id="signupForm">
                            <sec:csrfInput/>
                            <input type="hidden" name="memUsername" value="${memUsername}"/>

                            <div class="row g-2 mb-3 text-start">
                                <div class="col">
                                    <label for="memLastNm" class="form-label">성 (Last Name)</label>
                                    <input type="text" class="form-control" id="peoLastNm" name="peoLastNm" placeholder="성을 입력해주세요" required>
                                   	<div id="peoLastNmFeedback" class="form-feedback-custom">

                                    </div>
                                </div>
                                <div class="col">
                                    <label for="memFirstNm" class="form-label">이름 (First Name)</label>
                                    <input type="text" class="form-control " id="peoFirstNm" name="peoFirstNm" placeholder="이름을 입력해주세요" required>
                                    <div id="peoFirstNmFeedback" class="form-feedback-custom">
                                    </div>
                                </div>
                            </div>

		                    <div class="mb-3 text-start">
		                        <label class="form-label">성별</label>
		                        <div class="gender-options">
		                            <div class="form-check form-check-inline">
		                                <input class="form-check-input" type="radio" name="peoGender" id="genderMale" value="M" checked>
		                                <label class="form-check-label" for="genderMale">남자 (Male)</label>
		                            </div>
		                            <div class="form-check form-check-inline">
		                                <input class="form-check-input" type="radio" name="peoGender" id="genderFemale" value="F">
		                                <label class="form-check-label" for="genderFemale">여자 (Female)</label>
		                            </div>
		                        </div>
		                    </div>

                            <div class="mb-3 text-start">
                                <label for="memNicknm" class="form-label">닉네임</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="memNicknm" name="memNicknm" placeholder="닉네임을 입력해주세요">
                                    <button class="btn btn-check-custom" type="button" id="nickCheckBtn">중복확인</button>
                                </div>
                                <div id="nicknameFeedback" class="form-feedback-custom">
                                </div>
                            </div>

                            <div class="mb-3 text-start">
                                <label for="peoEmail" class="form-label">이메일 주소</label>
                                <div class="input-group">
                                    <input type="email" class="form-control" id="peoEmail" name="peoEmail" placeholder="이메일을 입력해주세요">
                                    <button class="btn btn-check-custom" type="button" id="emailCheckBtn">중복확인</button>
                                </div>
                                <div id="emailFeedback" class="form-feedback-custom">
                                </div>
                            </div>

                            <div class="mb-4 text-start"> <label for="peoPhone" class="form-label">휴대폰 번호</label>
                                <div class="input-group">
                                    <input type="tel" id="peoPhone" name="peoPhone" class="form-control" placeholder="'-' 없이 숫자만 입력">
                                </div>
                                <div id="phoneFeedback" class="form-feedback-custom"></div>
                            </div>

                            <div class="mb-4 text-start">
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

                            <div class="mb-1 text-start">
                            	<p class="form-label">주소</p>
                            	<div class="d-flex">
									<input type="text" class="form-control" id="memPostCode" name="memZipCode">
									<span class="input-group-append">
										<button type="button" class="btn btn-secondary btn-sm btn-flat" onclick="DaumPostcode()">우편번호 찾기</button>
									</span>
                            	</div>
                            	<div id="memZipCodeFeedback" class="form-feedback-custom">
                                </div>
							</div>
							<div class="mb-1 text-start">
								<p class="form-label">기본 주소</p>
								<input type="text" class="form-control" id="memAddress1" name="memAddress1" placeholder="주소를 입력해주세요">
                            	<div id="memAddressFeedback" class="form-feedback-custom">
                                </div>
							</div>
							<div class="mb-5 text-start">
								<p class="form-label">상세 주소</p>
								<input type="text" class="form-control" id="memAddress2" name="memAddress2" placeholder="상세주소를 입력해주세요">
							</div>

                            <div class="row g-2">
                                <div class="col-md-8 mb-2 mb-md-0">
                                </div>
                                <div class="col-md-4 mb-2 d-flex justify-content-end" >
                                    <button type="submit" class="ea-btn btn-primary" id="signupBtn">가입하기</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<%@ include file="../modules/footerPart.jsp" %>

	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
<script type="text/javascript">
$(function(){

	let hideWarning = setTimeout(()=>{
		$("#warningDiv").css("visibility","hidden");
		clearTimeout(hideWarning)
	},3500);

	// 닉네임 중복확인 이벤트 영역
	let nickCheckBtn = $("#nickCheckBtn");		// 닉네임 중복확인 버튼 Element
	let nickCheckFlag = false;				// 중복확인 flag(true:중복체크 완료, false: 중복체크 미완료)

	// 이메일 중복확인 이벤트 영역
	let emailCheckBtn = $("#emailCheckBtn");		// 이메일 중복확인 버튼 Element
	let emailCheckFlag = false;				// 중복확인 flag(true:중복체크 완료, false: 중복체크 미완료)

	// 가입하기 영역
	let signupForm = $("#signupForm");		// 가입하기 Form Element

	$("#memNicknm").on("change",function(){
		nickCheckFlag = false;
	})
	$("#peoEmail").on("change",function(){
		emailCheckFlag = false;
	})

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
					nicknameFeedback.html("사용가능한 아이디입니다!").removeClass("text-danger-custom").addClass("text-success-custom");
					nickCheckFlag = true;
				}else{					// 중복된 닉네임 사용 불가능
					sweetAlert("error","이미 사용 중인 닉네임 입니다.")
					nicknameFeedback.html("이미 사용 중인 닉네임 입니다.").removeClass("text-success-custom").addClass("text-danger-custom");
					nickCheckFlag = false;
				}
			}

		});
	});
	// 이메일 중복확인 버튼 이벤트
	emailCheckBtn.on("click",function(){
		let emailInput = $("#peoEmail");
		let email = $("#peoEmail").val();	// 입력한 아이디 값

		if (!signupForm.validate().element(emailInput)) {
	        emailCheckFlag = false;
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
		year = isNaN(year) ? 1995 : year;
		month = isNaN(month) ? 07 : month;
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
	createDay();
	// 입력시 - 지우기
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


	// 밸리데이션 적용하기

	$.validator.addMethod("customEmail",function(value,element){
		return this.optional(element) || /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/i.test(value);
	},"이메일 양식에 맞게 작성해주세요");

	signupForm.validate({
		rules: {                    // 유효성 검사 규칙
            memNicknm: {
            	required :true,
            	maxlength : 30
            },
            peoGender: {
            	required :true
            },
            peoLastNm : {
            	required : true,
            	maxlength : 100
            },
            peoFirstNm : {
            	required : true,
            	maxlength : 100
            },
            peoEmail: {                // 이메일 필드
                required: true,     // 필수 입력
                customEmail : true,
                maxlength : 50
            },
            memBirth : {
            	required : true
            },
            peoPhone: {             // 연락처 필드
                required: true,     // 필수 입력
                maxlength: 13
            },
            memZipCode : {
            	required : true
            },
            memAddress1 :{
            	required : true,
            	maxlength : 30
            },
            memAddress2 : {
            	maxlength : 30
            }
        },
        messages: {                 // 오류값 발생시 출력할 메시지 수동 지정
            memNicknm : {
            	required : '필수 입력 항목입니다.',
            	maxlength : '최대 {0} 글자의 닉네임을 입력해주세요.'
            },
            memBirth : {
            	required : "필수 입력 항목입니다."
            },
            peoEmail: {
                required: '필수 입력 항목입니다.',
                email: '올바른 이메일 형식으로 입력하세요.',
                maxlength : '{0} 미만의 이메일 주소를 입력해주세요'
            },
            peoPhone: {
                required: '필수 입력 항목입니다.',
                maxlength : '휴대폰 번호는 -없이 10~11자리 입니다'
            },
            peoLastNm: {
                required: '필수 입력 항목입니다.',
                maxlength : '{0} 자리 미만의 성을 입력해주세요'
            },
            peoFirstNm: {
                required: '필수 입력 항목입니다.',
                maxlength : '{0} 자리 미만의 이름을 입력해주세요'
            },
            memZipCode : {
            	required : "우편번호 찾기를 통해 주소를 입력해주세요."
            },
            memAddress1 :{
            	required : "필수 입력 항목입니다.",
            	maxlength : "{0} 자리 미만의 주소를 입력해주세요."
            },
            memAddress2 : {
            	maxlength : "{0} 자리 미만의 주소를 입력해주세요."
            }
        },
        errorElement: "span", // 오류 메시지를 div 태그로 감쌉니다.
        errorPlacement: function(error, element) {
            // 각 필드의 name 속성을 확인하여 적절한 위치에 오류 메시지를 표시합니다.
            if (element.attr("name") == "peoPhone") {
            	$("#phoneFeedback").empty().append(error);
            } else if (element.attr("name") == "peoLastNm") {
            	$("#peoLastNmFeedback").empty().append(error);
            } else if (element.attr("name") == "peoFirstNm") {
            	$("#peoFirstNmFeedback").empty().append(error);
            } else if (element.attr("name") == "memNicknm") {
            	$("#nicknameFeedback").empty().append(error);
            } else if (element.attr("name") == "peoEmail") {
            	$("#emailFeedback").empty().append(error);
            } else if (element.attr("name") == "memZipCode") {
            	$("#memZipCodeFeedback").empty().append(error);
            } else if (element.attr("name") == "memAddress1") {
            	$("#memAddressFeedback").empty().append(error);
            } else {
                // 다른 필드들은 기본 위치에 오류 메시지를 표시하거나,
                // 필요에 따라 추가적인 errorPlacement 로직을 구현합니다.
                error.insertAfter(element);
            }
            // 사용자 정의 스타일 적용
            if (error.text() !== "") {
                error.addClass('form-feedback-custom text-danger-custom');
            }
        },
        highlight: function(element, errorClass, validClass) {
            // 유효하지 않은 필드에 대한 스타일링 (옵션)
            $(element).addClass("is-invalid").removeClass("is-valid");
        },
        unhighlight: function(element, errorClass, validClass) {
            // 유효한 필드에 대한 스타일링 (옵션)
            $(element).removeClass("is-invalid").addClass("is-valid");
            if ($(element).attr("name") == "peoLastNm") {
            	$("#peoLastNmFeedback").empty();
            } else if ($(element).attr("name") == "peoFirstNm") {
            	$("#peoFirstNmFeedback").empty();
            } else if ($(element).attr("name") == "memNicknm") {
            	$("#nicknameFeedback").empty();
            } else if ($(element).attr("name") == "peoEmail") {
            	$("#emailFeedback").empty();
            } else if ($(element).attr("name") == "peoPhone") {
                $("#phoneFeedback").empty().removeClass("text-danger-custom text-success-custom");
            }
        },
        submitHandler: function(form){

        	let year = birthYear.val();
    		let month = birthMonth.val();
    		let day = birthDay.val();

    		if(year && month && day){
    			$("#memBirth").val(year+"/"+month+"/"+day);
    		}else{
    			sweetAlert("error","생년월일을 모두 선택해주세요!");
    			return false;
    		}

            if(!nickCheckFlag){
            	sweetAlert("error", "닉네임 중복확인을 해주세요.");
                $("#nicknameFeedback").html("닉네임 중복확인을 완료해주세요.").addClass("text-danger-custom").removeClass("text-success-custom");
                return false;
            }
            if(!emailCheckFlag){
            	sweetAlert("error", "이메일 중복확인을 해주세요.");
                $("#emailFeedback").html("이메일 중복확인을 완료해주세요.").addClass("text-danger-custom").removeClass("text-success-custom");
                return false;
            }

        	if(nickCheckFlag && emailCheckFlag){
        		form.submit();
        	}
        }
    });


	// 데이터 만들기
	$("#userBtn").on("click",function(){
		userData = {
			peoLastNm : selectLastNm(),
			peoFirstNm : selectFirstNm(),
			peoGender : Math.random() > 0.5 ? 'M' : "F",
			memNicknm : randomNickname(),
			peoEmail : selectEmail(),
			peoPhone : selectPhone(),
			birthYear : "1995",
			birthMonth : "12",
			birthDay : "14",
			memZipCode : "34908",
			memAddress1 : "대전 중구 계룡로 846",
			memAddress2 : "3층",
		}
		let {peoLastNm,peoFirstNm,peoGender,memNicknm
			,peoEmail,peoPhone,birthYear,birthMonth,birthDay,memZipCode
			,memAddress1,memAddress2} = userData
		$("#peoLastNm").val(peoLastNm);
		$("#peoFirstNm").val(peoFirstNm);
		if(peoGender == 'M'){
			$("#genderFemale").attr("checked",false);
			$("#genderMale").attr("checked",true);
		}else{
			$("#genderMale").attr("checked",false);
			$("#genderFemale").attr("checked",true);
		}
		$("#memNicknm").val(memNicknm);
		$("#peoEmail").val(peoEmail);
		$("#peoPhone").val(peoPhone);
		$("#birthYear").val(birthYear);
		$("#birthMonth").val(birthMonth);
		$("#birthDay").val(birthDay);
		$("#memPostCode").val(memZipCode);
		$("#memAddress1").val(memAddress1);
		$("#memAddress2").val(memAddress2);
	})

	function selectLastNm(){
		const lastList = ["김","이","박","최","강","나","윤"]
		let random = Math.floor(Math.random() * lastList.length);
		return lastList[random];
	}
	function selectFirstNm(){
		const firstList = [
			  "예하", "도현", "유나", "지율", "하준", "서윤", "민재", "은서", "주원", "소미",
			  "건우", "나율", "시우", "아린", "재윤", "채원", "현우", "보민", "우진", "다은",
			  "준서", "가희", "성민", "유진", "동혁", "지아", "은찬", "소율", "지훈", "채은",
			  "재민", "서아", "태양", "예은", "규민", "하영", "선우", "윤서", "도윤", "수현",
			  "승준", "지유", "영훈", "예지", "우주", "민아", "찬우", "아영", "은우", "수민"
			]
		let random = Math.floor(Math.random() * firstList.length);
		return firstList[random];
	}

	function randomNickname() {
	    const adjective = [
	        "행복한", "슬픈", "게으른", "슬기로운", "수줍은",
	        "그리운", "섹시한", "배고픈", "배부른", "부자", "재벌", "웃고있는", "깨발랄한"
	    ];
	    const name = "기린";
	    const number = Math.floor(Math.random() * 300) + 1; // 1부터 99까지의 난수 생성

	    // 배열을 섞는 함수 (Java의 Collections.shuffle과 동일한 기능)
	    function shuffleArray(array) {
	        for (let i = array.length - 1; i > 0; i--) {
	            const j = Math.floor(Math.random() * (i + 1));
	            [array[i], array[j]] = [array[j], array[i]]; // 배열 요소 교환
	        }
	        return array;
	    }

	    const shuffledAdjective = shuffleArray([...adjective]); // 원본 배열을 복사하여 섞음
	    const adj = shuffledAdjective[0]; // 섞인 배열에서 첫 번째 형용사 선택

	    return adj + name + number;
	}

	function selectEmail(){
		const emailList = [
			  "user1234@gmail.com", "randomid5678@naver.com", "testaccount99@kakao.com", "alphauser11@gmail.com", "betatester22@naver.com",
			  "cyberdev33@kakao.com", "digitking44@gmail.com", "echoprime55@naver.com", "fusionnet66@kakao.com", "galaxystar77@gmail.com",
			  "horizontech88@naver.com", "infinitylab99@kakao.com", "junglebeat00@gmail.com", "kilobyte12@naver.com", "lunarbase34@kakao.com",
			  "magicspell56@gmail.com", "novaforce78@naver.com", "oceandeep90@kakao.com", "pixelart01@gmail.com", "quantumleap23@naver.com",
			  "robofriend45@kakao.com", "solarwind67@gmail.com", "terracore89@naver.com", "ultrawave02@kakao.com", "vortexspin13@gmail.com",
			  "wildcard24@naver.com", "xenogame35@kakao.com", "yachtclub46@gmail.com", "zetafield57@naver.com", "aquaflow68@kakao.com",
			  "blazefire79@gmail.com", "crystalgem80@naver.com", "dreamland91@kakao.com", "eagleeye03@gmail.com", "fluidmotion14@naver.com",
			  "grandview25@kakao.com", "happyday36@gmail.com", "ironwill47@naver.com", "jollyfish58@kakao.com", "keensight69@gmail.com",
			  "lightbeam70@naver.com", "mistyrain81@kakao.com", "nightowl92@gmail.com", "opensky04@naver.com", "peacesign15@kakao.com",
			  "quietmind26@gmail.com", "risingsun37@naver.com", "silvermoon48@kakao.com", "truenorth59@gmail.com", "uniquesoul60@naver.com"
			]
		let random = Math.floor(Math.random() * emailList.length);
		return emailList[random];
	}
	function selectPhone(){
		const phoneList = [
			  "010-2345-6789", "010-8765-4321", "010-1122-3344", "010-9988-7766", "010-5555-1234",
			  "010-0011-2233", "010-7890-1234", "010-4321-0987", "010-6789-0123", "010-3456-7890",
			  "010-1010-2020", "010-3030-4040", "010-5050-6060", "010-7070-8080", "010-9090-0000",
			  "010-1230-4567", "010-8761-5432", "010-2211-4433", "010-7788-6655", "010-1234-5670",
			  "010-0001-1122", "010-7891-2345", "010-4320-1987", "010-6780-9123", "010-3450-6789",
			  "010-2340-5678", "010-8760-5432", "010-1120-3344", "010-9980-7766", "010-5550-1234",
			  "010-0010-2233", "010-7890-1230", "010-4321-0980", "010-6789-0120", "010-3456-7890",
			  "010-1010-2020", "010-3030-4040", "010-5050-6060", "010-7070-8080", "010-9090-0000",
			  "010-1234-5678", "010-8765-4321", "010-1122-3344", "010-9988-7766", "010-5555-1234",
			  "010-0011-2233", "010-7890-1234", "010-4321-0987", "010-6789-0123", "010-3456-7890"
			]
		let random = Math.floor(Math.random() * phoneList.length);
		return phoneList[random];
	}

});

// 카카오 주소 API(주소 찾기)
function DaumPostcode() {
	new daum.Postcode({
		oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수

			//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
			    addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
			    addr = data.jibunAddress;
			}

			// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
			if(data.userSelectedType === 'R'){
			    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
			    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
			        extraAddr += data.bname;
			    }
			    // 건물명이 있고, 공동주택일 경우 추가한다.
			    if(data.buildingName !== '' && data.apartment === 'Y'){
			        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			    }
			}

			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById('memPostCode').value = data.zonecode;
			document.getElementById("memAddress1").value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("memAddress2").focus();
		}
	}).open();
 }
</script>
</html>

