<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
지원 폼

	<main>
	    <section class="apply-hero">
	        <div class="container">
	            <h2>온라인 지원</h2>
	            <p>DD TOWN의 새로운 스타가 될 기회! 아래 지원서를 작성해주세요.</p>
	        </div>
	    </section>

        <section class="apply-form-section">
            <div class="apply-form-container">
                <form class="apply-form" method="post" enctype="multipart/form-data">
                    <label>오디션 종류 / 모집분야</label>
                    <div style="display: flex; gap: 1em; margin-bottom: var(--spacing-md);">
                        <input type="text" id="audition-type" name="audition_type" value="2025 DD TOWN 글로벌 오디션" readonly style="flex:1;">
                        <input type="text" id="audition-field" name="audition_field" value="보컬" readonly style="flex:1;">
                    </div>

                    <label for="name">이름</label>
                    <input type="text" id="name" name="name" placeholder="이름을 입력하세요." required>

                    <label>성별</label>
                    <div class="gender-group">
                        <label><input type="radio" id="genderM" name="gender" value="남자" required> 남자</label>
                        <label><input type="radio" id="genderF" name="gender" value="여자"> 여자</label>
                    </div>

                    <label>생년월일</label>
                    <div class="birth-group">
                        <select name="birth_year" required>
                            <option value="">년</option>
                            <!-- 1980~2015 예시 -->
                            <option value="2005">2005</option>
                            <option value="2006">2006</option>
                            <option value="2007">2007</option>
                            <option value="2008">2008</option>
                            <option value="2009">2009</option>
                            <option value="2010">2010</option>
                            <option value="2011">2011</option>
                            <option value="2012">2012</option>
                            <option value="2013">2013</option>
                            <option value="2014">2014</option>
                            <option value="2015">2015</option>
                        </select>
                        <select name="birth_month" required>
                            <option value="">월</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                        </select>
                        <select name="birth_day" required>
                            <option value="">일</option>
                            <!-- 1~31 -->
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                            <option value="13">13</option>
                            <option value="14">14</option>
                            <option value="15">15</option>
                            <option value="16">16</option>
                            <option value="17">17</option>
                            <option value="18">18</option>
                            <option value="19">19</option>
                            <option value="20">20</option>
                            <option value="21">21</option>
                            <option value="22">22</option>
                            <option value="23">23</option>
                            <option value="24">24</option>
                            <option value="25">25</option>
                            <option value="26">26</option>
                            <option value="27">27</option>
                            <option value="28">28</option>
                            <option value="29">29</option>
                            <option value="30">30</option>
                            <option value="31">31</option>
                        </select>
                    </div>

                    <label for="email">이메일</label>
                    <div class="email-group">
                        <input type="email" id="email" name="email" placeholder="이메일을 입력하세요." required>
                        <button type="button" class="btn btn-secondary" id="emailCheckBtn">중복체크</button>
                    </div>

                    <label for="phone">휴대폰 번호</label>
                    <input type="tel" id="phone" name="phone" placeholder="휴대폰 번호를 입력하세요. (예: 010-1234-5678)" required>

                    <label for="file">사진/동영상 첨부</label>
                    <div class="file-group">
                        <input type="file" id="file" name="file" accept=".jpg,.jpeg,.png,.gif,.mp4,.mov,.wmv,.avi" required>
                        <div class="file-desc">최대 용량 100MB. JPG, PNG, GIF, MP4, MOV, WMV, AVI 등 지원</div>
                    </div>

                    <label for="intro">자기소개서</label>
                    <textarea id="intro" name="intro" placeholder="자기소개 및 지원 동기를 입력하세요." required></textarea>

                    <label>개인정보 수집·이용 동의</label>
                    <div class="privacy-box" readonly>
                        <strong>㈜디디타운엔터테인먼트(이하 '회사')는 오디션 지원과 관련하여 아래와 같이 개인정보를 수집·이용합니다.</strong><br><br>
                        1. 수집하는 개인정보 항목<br>
                        - 필수항목: 성명, 생년월일(또는 성별), 성별, 연락처(이메일 주소, 휴대전화번호), 지원분야, 사진, 영상 등<br>
                        2. 이용목적: 오디션 지원자 관리 및 심사, 합격자 안내 등<br>
                        3. 보유 및 이용기간: 지원일로부터 1년간 보관 후 파기<br>
                        4. 동의 거부 시 지원이 제한될 수 있습니다.<br>
                    </div>
                    <div class="privacy-check">
                        <label><input type="checkbox" name="privacy_agree" required> 위 개인정보 수집 및 이용에 동의합니다.</label>
                    </div>

                    <div class="btn-group">
                        <button type="submit" class="btn btn-primary" id="signupBtn" >지원하기</button>
                        <button type="reset" class="btn btn-secondary"
                        	onclick="javascript:location.href='/corporate/audition/detail.do'">취소하기</button>
                    </div>
                </form>
            </div>
        </section>
    </main>
</body>
<script type="text/javascript">
$(function(){
	let emailCheckBtn = $("#emailCheckBtn");	// 이메일중복확인 Element
	let emailCheckFlag = false;					
	
	let signupBtn = $("#signupBtn");			//등록하기 Element
	
	//이메일 중복확인버튼 이벤트
	emailCheckBtn.on("click", function(){
		let email = $("#email").val();	//입력한 이메일 값
		
		if(email == null || email == ""){
			sweetAlert("error", "이메일을 입력해주세요!");
			return false;
		}
		let data ={
				email : email
		};
		
		$.ajax({
			url: "/corporate/audition/emailCheck.do",
			type : "post",
			data : JSON.stringify(data),
			contentType : "application/json; charset=utf-8",
			success: function(res){
				let err = $(".errors")[0];
				if(res == "NOTEXIST"){	//이메일 사용가능
					sweetAlert("success", "사용 가능한 이메일입니다!");
					$(err).html("사용 가능한 이메일 입니다!").css("color", "green");
					emailCheckFlag =true;
				}else{
					sweetAlert("error", "이미 사용중인 이메일입니다!");
					$(err).html("이미 사용중인 이메일 입니다!").css("color", "red");
					emailCheckFlag = false;
				}
			}
		})
	});
})
</script>
</html>