<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DD TOWN 오디션 지원</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;700;900&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <%@ include file="../modules/headerPart.jsp" %>

    <style>
        /* Enhanced Support Form Styles */
        body {
            background: linear-gradient(135deg, #f8f9ff 0%, #f0f2ff 100%);
            font-family: 'Noto Sans KR', 'Montserrat', sans-serif;
            margin: 0;
            padding: 0;
        }

        .apply-hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 120px 0 80px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .apply-hero:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
        }

        .apply-hero h2 {
            font-size: clamp(3rem, 6vw, 4.5rem);
            font-weight: 900;
            color: white;
            margin-bottom: 20px;
            text-shadow: 0 4px 20px rgba(0,0,0,0.3);
            position: relative;
            z-index: 1;
        }

        .apply-hero p {
            font-size: 1.3rem;
            color: rgba(255, 255, 255, 0.9);
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.6;
            position: relative;
            z-index: 1;
        }

        .apply-form-section {
            padding: 100px 0;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .apply-form-container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            border-radius: 25px;
            box-shadow: 0 20px 60px rgba(102, 126, 234, 0.15);
            padding: 50px;
            border: 1px solid rgba(102, 126, 234, 0.1);
            position: relative;
            overflow: hidden;
        }

        .apply-form-container:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .apply-form label {
            font-weight: 600;
            margin-bottom: 8px;
            display: block;
            color: #333;
            font-size: 1rem;
        }

        .apply-form input[type="text"],
        .apply-form input[type="email"],
        .apply-form input[type="tel"],
        .apply-form select,
        .apply-form textarea {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid rgba(102, 126, 234, 0.2);
            border-radius: 12px;
            margin-bottom: 25px;
            font-size: 1rem;
            font-family: 'Noto Sans KR', sans-serif;
            transition: all 0.3s ease;
            background: #f8f9ff;
            box-sizing: border-box;
        }

        .apply-form input:focus,
        .apply-form select:focus,
        .apply-form textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            background: white;
        }

        .apply-form textarea {
            min-height: 120px;
            resize: vertical;
            line-height: 1.6;
        }

        .gender-group {
            display: flex;
            gap: 30px;
            margin-bottom: 25px;
            padding: 15px 0;
        }

        .gender-group label {
            font-weight: 500;
            margin-bottom: 0;
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            font-size: 1rem;
        }

        .gender-group input[type="radio"] {
            width: 20px;
            height: 20px;
            margin: 0;
            accent-color: #667eea;
        }

        .birth-group {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
        }

        .birth-group select {
            flex: 1;
            margin-bottom: 0;
        }

        .email-group {
            display: flex;
            gap: 15px;
            align-items: flex-start;
            margin-bottom: 25px;
        }

        .email-group input {
            flex: 1;
            margin-bottom: 0;
        }

        .file-group {
            margin-bottom: 25px;
        }

        .file-group input[type="file"] {
            border: 2px dashed rgba(102, 126, 234, 0.3);
            background: #f8f9ff;
            padding: 20px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .file-group input[type="file"]:hover {
            border-color: #667eea;
            background: rgba(102, 126, 234, 0.05);
        }

        .file-desc {
            font-size: 0.9rem;
            color: #666;
            margin-top: 8px;
            text-align: center;
        }

        .privacy-box {
            background: linear-gradient(135deg, #f8f9ff 0%, #f0f2ff 100%);
            border-radius: 15px;
            padding: 25px;
            font-size: 0.95rem;
            color: #555;
            margin-bottom: 25px;
            max-height: 200px;
            overflow-y: auto;
            border: 1px solid rgba(102, 126, 234, 0.1);
            line-height: 1.6;
        }

        .privacy-check {
            margin-bottom: 40px;
            padding: 20px;
            background: rgba(102, 126, 234, 0.05);
            border-radius: 12px;
            border: 1px solid rgba(102, 126, 234, 0.1);
        }

        .privacy-check label {
            display: flex;
            align-items: center;
            gap: 12px;
            cursor: pointer;
            margin-bottom: 0;
            font-weight: 500;
        }

        .privacy-check input[type="checkbox"] {
            width: 20px;
            height: 20px;
            accent-color: #667eea;
        }

        .btn-group {
            display: flex;
            gap: 20px;
            justify-content: center;
            margin-top: 40px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 15px 30px;
            border-radius: 25px;
            font-weight: 600;
            font-size: 1rem;
            text-decoration: none;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            min-width: 150px;
            justify-content: center;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #495057 100%);
            color: white;
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        /* Audition Info Display */
        .audition-info-display {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 30px;
            text-align: center;
        }

        .audition-info-display #audition-type {
            font-size: 1.4rem;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .audition-info-display #audition-field-display {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        /* Enhanced Footer Styles */
        .site-footer {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
            color: white;
            padding: 80px 0 30px;
            position: relative;
            overflow: hidden;
        }

        .site-footer:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="footerPattern" width="40" height="40" patternUnits="userSpaceOnUse"><circle cx="20" cy="20" r="1" fill="white" opacity="0.05"/></pattern></defs><rect width="100" height="100" fill="url(%23footerPattern)"/></svg>');
            pointer-events: none;
        }

        .footer-container {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 60px;
            margin-bottom: 50px;
            position: relative;
            z-index: 1;
        }

        .footer-logo {
            font-family: 'Montserrat', sans-serif;
            font-size: 3rem;
            font-weight: 900;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 20px;
        }

        .footer-description {
            font-size: 1.1rem;
            line-height: 1.8;
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 30px;
        }

        .footer-contact {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .contact-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 12px 0;
            color: rgba(255, 255, 255, 0.9);
        }

        .contact-item i {
            color: #667eea;
            width: 20px;
        }

        .footer-links h3 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 25px;
            color: white;
        }

        .footer-links ul {
            list-style: none;
            padding: 0;
        }

        .footer-links a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            padding: 8px 0;
            display: block;
            transition: color 0.3s ease;
        }

        .footer-links a:hover {
            color: #667eea;
        }

        .footer-bottom {
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            padding-top: 30px;
            text-align: center;
            color: rgba(255, 255, 255, 0.6);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .apply-form-container {
                padding: 30px 25px;
                margin: 0 10px;
            }

            .gender-group {
                flex-direction: column;
                gap: 15px;
            }

            .birth-group {
                flex-direction: column;
            }

            .email-group {
                flex-direction: column;
            }

            .btn-group {
                flex-direction: column;
            }

            .footer-container {
                grid-template-columns: 1fr;
                gap: 40px;
            }
        }
    </style>
</head>
<body>
    <%@ include file="./../corporate/modules/header.jsp" %>

    <main>
        <section class="apply-hero">
            <div class="container">
                <h2>온라인 지원</h2>
                <p>DD TOWN의 새로운 스타가 될 기회! 아래 지원서를 작성해주세요.</p>
            </div>
        </section>

        <section class="apply-form-section">
            <div class="apply-form-container">
                <div class="audition-info-display">
                    <div id="audition-type">${audition.audiTitle}</div>
                    <div>모집분야:
                        <span id="audition-field-display">
                            <c:choose>
                                <c:when test="${audition.audiTypeCode eq 'ADTC001'}">보컬</c:when>
                                <c:when test="${audition.audiTypeCode eq 'ADTC002'}">댄스</c:when>
                                <c:when test="${audition.audiTypeCode eq 'ADTC003'}">연기</c:when>
                            </c:choose>
                        </span>
                    </div>
                </div>

                <form class="apply-form" action="/corporate/audition/signup.do" method="post" id="signupForm" enctype="multipart/form-data">
                    <sec:csrfInput/>
                    <input type="hidden" id="audiNo" name="audiNo" value="${audition.audiNo}">
                    <input type="hidden" id="audiTypeCode" name="audiTypeCode" value="${audition.audiTypeCode}">
                    <input type="hidden" id="applicantBirth" name="applicantBirth" value="">

                    <button type="button" id="randomBtn" style="margin-left: 90%; background-color: #2c3e50; color:#ecf0f1;" >입력</button>
                    <label for="applicantNm">이름</label>
                    <input type="text" id="applicantNm" name="applicantNm" placeholder="이름을 입력하세요." required>

                    <label>성별</label>
                    <div class="gender-group">
                        <label><input type="radio" id="genderM" name="applicantGender" value="M" required> 남자</label>
                        <label><input type="radio" id="genderF" name="applicantGender" value="F"> 여자</label>
                    </div>

                    <label>생년월일</label>
                    <div class="birth-group">
                        <select name="birthYear" id="birthYear" required>
                            <option value="">년</option>
                            <c:set var="currentYear" value="<%= java.time.Year.now().getValue() %>" />
                            <c:forEach var="i" begin="0" end="100">
                                <c:set var="year" value="${currentYear - i}" />
                                <option value="${year}">${year}</option>
                            </c:forEach>
                        </select>
                        <select name="birthMonth" id="birthMonth" required>
                            <option value="">월</option>
                            <c:forEach var="month" begin="1" end="12">
                                <option value="${month}">${month}</option>
                            </c:forEach>
                        </select>
                        <select name="birthDay" id="birthDay" required>
                            <option value="">일</option>
                            <c:forEach var="day" begin="1" end="31">
                                <option value="${day}">${day}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <label for="applicantEmail">이메일</label>
                    <div class="email-group">
                        <input type="email" id="applicantEmail" name="applicantEmail" placeholder="이메일을 입력하세요." required>
                    </div>

                    <label for="applicantPhone">휴대폰 번호</label>
                    <input type="tel" id="applicantPhone" name="applicantPhone" maxlength="11" placeholder="휴대폰 번호를 입력하세요. (예: 01012345678)" required>

                    <label for="audiMemFiles">사진/동영상 첨부</label>
                    <div class="file-group">
                        <input type="file" id="audiMemFiles" name="audiMemFiles" accept=".jpg,.jpeg,.png,.gif,.mp4,.mov,.wmv,.avi" multiple required>
                        <div class="file-desc">최대 용량 100MB. JPG, PNG, GIF, MP4, MOV, WMV, AVI 등 지원</div>
                    </div>

                    <label for="appCoverLetter">자기소개서</label>
                    <textarea id="appCoverLetter" name="appCoverLetter" placeholder="자기소개 및 지원 동기를 입력하세요." required></textarea>

                    <label>개인정보 수집·이용 동의</label>
                    <div class="privacy-box">
                        <strong>㈜디디타운엔터테인먼트(이하 '회사')는 오디션 지원과 관련하여 아래와 같이 개인정보를 수집·이용합니다.</strong><br><br>
                        1. 수집하는 개인정보 항목<br>
                        - 필수항목: 성명, 생년월일(또는 성별), 성별, 연락처(이메일 주소, 휴대전화번호), 지원분야, 사진, 영상 등<br>
                        2. 이용목적: 오디션 지원자 관리 및 심사, 합격자 안내 등<br>
                        3. 보유 및 이용기간: 지원일로부터 1년간 보관 후 파기<br>
                        4. 동의 거부 시 지원이 제한될 수 있습니다.<br>
                    </div>
                    <div class="privacy-check">
                        <label><input type="checkbox" id="applicantAgree" name="applicantAgree" value="Y" required> 위 개인정보 수집 및 이용에 동의합니다.</label>
                    </div>

                    <div class="btn-group">
                        <button type="button" class="btn btn-primary" id="signupBtn">지원하기</button>
                        <button type="button" class="btn btn-secondary" onclick="history.back()">취소하기</button>
                    </div>
                </form>
            </div>
        </section>
    </main>

    <footer class="site-footer">
        <div class="container">
            <div class="footer-container">
                <div class="footer-info">
                    <div class="footer-logo">DD TOWN</div>
                    <p class="footer-description">
                        DD TOWN은 창의성과 열정을 바탕으로 아티스트와 팬 모두에게 최고의 경험을 선사합니다.
                        우리는 혁신적인 콘텐츠와 글로벌 네트워크를 통해 K-Culture의 미래를 만들어갑니다.
                    </p>
                    <div class="footer-contact">
                        <div class="contact-item">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>대전광역시 중구 계룡로 846</span>
                        </div>
                        <div class="contact-item">
                            <i class="fas fa-phone"></i>
                            <span>042-123-4567</span>
                        </div>
                        <div class="contact-item">
                            <i class="fas fa-envelope"></i>
                            <span>contact@ddtown.com</span>
                        </div>
                    </div>
                </div>
                <div class="footer-links">
                    <h3>바로가기</h3>
                    <ul>
                        <li class="has-submenu">
                            <a href="#">기업 정보</a>
                            <ul class="submenu">
                                <li><a href="${pageContext.request.contextPath}/corporate/finance">재무정보</a></li>
                                <li><a href="${pageContext.request.contextPath}/corporate/about">기업소개</a></li>
                                <li><a href="${pageContext.request.contextPath}/corporate/notice/list">기업 공지</a></li>
                                <li><a href="${pageContext.request.contextPath}/corporate/location">기업 위치</a></li>
                            </ul>
                        </li>
                        <li><a href="${pageContext.request.contextPath}/corporate/audition/schedule">오디션</a></li>
                        <li><a href="${pageContext.request.contextPath}/corporate/artist/profile">아티스트 프로필</a></li>
                        <li><a href="${pageContext.request.contextPath}/community/artist/main">아티스트 커뮤니티</a></li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 DD TOWN Entertainment. All Rights Reserved.</p>
            </div>
        </div>
    </footer>

    <script src="${pageContext.request.contextPath}/resources/js/common/main.js"></script>
    <script type="text/javascript">
        $(function(){
            let emailCheckFlag = false;
            let signupBtn = $("#signupBtn");		//지원하기 버튼
            let signupForm = $("#signupForm");		//지원하기 form
            let randomBtn = $("#randomBtn");        //랜덤값 넣는 이벤튼 버튼

            signupBtn.on("click", function(){
                let audiNo = $("#audiNo").val();
                let applicantNm = $("#applicantNm").val();
                let applicantPhone = $("#applicantPhone").val();
                let appCoverLetter = $("#appCoverLetter").val();
                let applicantEmail = $("#applicantEmail").val();
                let agreeFlag = false;
                let audiMemFiles = $("#audiMemFiles").val();
                let audiTypeCode = $("#audiTypeCode").val();
                
                let genderCheck = $("input[name='applicantGender']:checked").val();

                let birthYear = $("#birthYear");
                let birthMonth = $("#birthMonth");
                let birthDay = $("#birthDay");

                let year = birthYear.val();
                let month = birthMonth.val();
                let day = birthDay.val();
                let applicantBirth = "";
                
                const codeMap = {
                        "ADTC001": "VOCAL",
                        "ADTC002": "DANCE",
                        "ADTC003": "ACT",
                        // 필요한 다른 코드들도 여기에 추가
                    };
                
                audiTypeCode = codeMap[audiTypeCode] || audiTypeCode;
                
                $("#audiTypeCode").val(audiTypeCode);
                //유효성 검사
                if(applicantNm == null || applicantNm.trim() == ""){
                	Swal.fire("오류", "이름을 입력해주세요!", "error");
                    return false;
                }
                if (!genderCheck) {
                	Swal.fire("오류", "성별을 선택해주세요!", "error");
                    return false;
                }

                if(year && month && day){
                    applicantBirth = "" + year + month + day;
                    $("#applicantBirth").val(applicantBirth);
                } else {
                	Swal.fire("오류", "생년월일을 모두 선택해주세요!", "error");
                    return false;
                }

                if (applicantEmail == null || applicantEmail.trim() === "") {
                	Swal.fire("오류", "이메일을 입력해주세요!", "error");
                    return false;
                }

                if(applicantPhone == null || applicantPhone.trim() == ""){
                	Swal.fire("오류", "전화번호를 입력해주세요!", "error");
                    return false;
                }

                const phoneRegex = /^\d{1,11}$/;
                if (!phoneRegex.test(applicantPhone)) {
                	Swal.fire("오류", "전화번호 형식이 올바르지 않습니다. (예: 01012345678)", "error");
                    return false;
                }

                if(appCoverLetter == null || appCoverLetter.trim() == ""){
                	Swal.fire("오류", "자기소개를 입력해주세요!", "error");
                    return false;
                }

                let audiMemFilesInput = $("#audiMemFiles")[0];
                if (audiMemFilesInput.files.length === 0) {
                	Swal.fire("오류", "파일을 첨부해주세요!", "error");
                    return false;
                }

                let applicantAgree = $("#applicantAgree:checked").val();
                if(applicantAgree == "Y"){
                    agreeFlag = true;
                }

                if(agreeFlag){
                    signupForm.submit();	//등록
                } else {
                	Swal.fire("오류", "개인정보 동의를 체크해주세요!", "error");
                }
            });

            //랜덤값 넣는 버튼 이벤트
            $("#randomBtn").on("click", function(){
            	RandomData();
            });

             const emailList = [
            	 	"ddtown305@gmail.com"
					  /* "user1234@gmail.com", "randomid5678@naver.com", "testaccount99@kakao.com", "alphauser11@gmail.com", "betatester22@naver.com",
					  "cyberdev33@kakao.com", "digitking44@gmail.com", "echoprime55@naver.com", "fusionnet66@kakao.com", "galaxystar77@gmail.com",
					  "horizontech88@naver.com", "infinitylab99@kakao.com", "junglebeat00@gmail.com", "kilobyte12@naver.com", "lunarbase34@kakao.com",
					  "magicspell56@gmail.com", "novaforce78@naver.com", "oceandeep90@kakao.com", "pixelart01@gmail.com", "quantumleap23@naver.com",
					  "robofriend45@kakao.com", "solarwind67@gmail.com", "terracore89@naver.com", "ultrawave02@kakao.com", "vortexspin13@gmail.com",
					  "wildcard24@naver.com", "xenogame35@kakao.com", "yachtclub46@gmail.com", "zetafield57@naver.com", "aquaflow68@kakao.com",
					  "blazefire79@gmail.com", "crystalgem80@naver.com", "dreamland91@kakao.com", "eagleeye03@gmail.com", "fluidmotion14@naver.com",
					  "grandview25@kakao.com", "happyday36@gmail.com", "ironwill47@naver.com", "jollyfish58@kakao.com", "keensight69@gmail.com",
					  "lightbeam70@naver.com", "mistyrain81@kakao.com", "nightowl92@gmail.com", "opensky04@naver.com", "peacesign15@kakao.com",
					  "quietmind26@gmail.com", "risingsun37@naver.com", "silvermoon48@kakao.com", "truenorth59@gmail.com", "uniquesoul60@naver.com" */
					];

           	function RandomData(){
            	//이름
           		const firstNames = ["김", "이", "박", "최", "정", "강", "조", "윤", "장", "임"];
           		const middleNames =  ["민", "지", "현", "준", "영", "성", "수", "예", "아", "도"];
           		const lastNames = ["준", "아", "서", "우", "은", "찬", "윤", "림", "진", "하"];
           		let randomName = firstNames[Math.floor(Math.random() * firstNames.length)] +
           						 middleNames[Math.floor(Math.random() * middleNames.length)] +
           						 lastNames[Math.floor(Math.random() * lastNames.length)];
           		$("#applicantNm").val(randomName);

           		//성별
           		const genders = ["M", "F"];
				const randomGender = genders[Math.floor(Math.random() * genders.length)];
           		$(`input[name="applicantGender"][value="\${randomGender}"]`).prop('checked', true);

           		//생년월일
           		const currentYear = new Date().getFullYear();
                const randomYear = Math.floor(Math.random() * 20) + (currentYear - 30); // 30년 전부터 10년 전까지 (예시)
                const randomMonth = Math.floor(Math.random() * 12) + 1;
                const randomDay = Math.floor(Math.random() * 28) + 1;

                $("#birthYear").val(randomYear).trigger('change'); // trigger('change')는 jQuery UI 같은 특정 라이브러리에서 필요할 수 있지만, 여기서는 보통 불필요
                $("#birthMonth").val(randomMonth).trigger('change');
                $("#birthDay").val(randomDay).trigger('change');

                const formattedMonth = String(randomMonth).padStart(2, '0');
                const formattedDay = String(randomDay).padStart(2, '0');
                $("#applicantBirth").val(`${randomYear}-${formattedMonth}-${formattedDay}`);

                //이메일
                const randomEmailIndex = Math.floor(Math.random() * emailList.length);
                $("#applicantEmail").val(emailList[randomEmailIndex]);

                //휴대폰
                const randomPhoneMiddle = String(Math.floor(Math.random() * 9000) + 1000); // 4자리 숫자
                const randomPhoneLast = String(Math.floor(Math.random() * 9000) + 1000);   // 4자리 숫자
                $("#applicantPhone").val(`010\${randomPhoneMiddle}\${randomPhoneLast}`);
                //자기소개서
                const coverLetters = [
                	"어릴 적부터 DDTOWN의 무대를 보며 꿈을 키워왔습니다. DDTOWN이 추구하는 혁신적인 음악과 퍼포먼스에 깊이 공감하며, 저의 잠재력과 열정으로 DDTOWN의 새로운 비전을 함께 만들어가고 싶습니다. 저는 꾸준한 연습과 노력을 통해 어떤 어려움도 극복할 준비가 되어 있습니다. DDTOWN의 일원이 되어 최고의 시너지를 만들어낼 것을 약속드립니다.",
                    "저는 음악/춤/연기에 대한 깊은 사랑과 끊임없는 탐구 정신을 가지고 있습니다. DDTOWN의 아티스트로서 대중에게 긍정적인 영향을 주고, 저만의 색깔을 담은 작품으로 새로운 트렌드를 이끌어가고 싶습니다. 항상 배우고 발전하는 자세로, DDTOWN의 명성을 더욱 빛낼 수 있도록 최선을 다하겠습니다. 저의 열정과 가능성을 보여드릴 기회를 주십시오.",
                    "수많은 오디션 속에서도 DDTOWN은 저에게 특별한 의미로 다가왔습니다. 단순히 스타가 되는 것을 넘어, 진정한 아티스트로서 성장할 수 있는 곳이라는 확신을 얻었기 때문입니다. 저는 DDTOWN이 제시하는 방향성에 저의 재능과 노력을 더해, 팬들에게 오래도록 기억될 감동적인 무대를 선사하고 싶습니다. 저의 뜨거운 열정과 간절함을 이곳에 바칩니다.",
                    "무대 위에서 저의 모든 것을 보여줄 준비가 되어 있습니다. DDTOWN은 제가 가진 재능을 꽃피울 수 있는 최적의 환경이라고 생각합니다. 저는 단순히 주어진 것을 수행하는 것을 넘어, 스스로 고민하고 창작하며 DDTOWN의 명성에 기여할 수 있는 아티스트가 되겠습니다. 저의 가능성을 믿고 지지해주신다면, 후회 없는 선택이었음을 증명해 보이겠습니다."
                ];
                const randomCoverLetter = coverLetters[Math.floor(Math.random() * coverLetters.length)];
                $("#appCoverLetter").val(randomCoverLetter);
                //개인정보동의
                $("#applicantAgree").prop('checked', true);
           	}
        });
    </script>
</body>
</html>
