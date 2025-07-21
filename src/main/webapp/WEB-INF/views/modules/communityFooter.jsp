<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
/* Community Footer Styles */
.community-footer {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #667eea 100%);
    color: white;
    padding: 10px 0 10px;
    position: relative;
    overflow: hidden;
    margin-top: 50px;
}

.community-footer::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="communityPattern" width="30" height="30" patternUnits="userSpaceOnUse"><circle cx="15" cy="15" r="1" fill="white" opacity="0.1"/><circle cx="5" cy="5" r="0.5" fill="white" opacity="0.05"/><circle cx="25" cy="25" r="0.5" fill="white" opacity="0.05"/></pattern></defs><rect width="100" height="100" fill="url(%23communityPattern)"/></svg>');
    pointer-events: none;
}

.footer-container {
    max-width: 100%;
    margin: 0 auto;
    padding: 0 20px;
    position: relative;
    z-index: 2;
}

.footer-content {
    display: flex;
    gap: 50px;
    justify-content: space-between;
    align-items: center;
    padding: 0 30px;
}

/* 브랜드 섹션 */
.footer-brand {
    text-align: center;
    width: 30%
}

.footer-logo {
	display: flex;
	align-items: center;
	gap: 20px;
	margin-bottom: 0;
	
	
}

.logo-text {
    font-family: 'Montserrat', sans-serif;
    font-size: 2.5rem;
    font-weight: 900;
    background: linear-gradient(45deg, #ffffff 0%, #f8f9ff 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    display: block;
    text-shadow: 0 4px 20px rgba(255, 255, 255, 0.3);
    letter-spacing: -1px;
}

.logo-subtitle {

    font-family: 'Montserrat', sans-serif;
    font-size: 1.2rem;
    font-weight: 600;
    color: rgba(255, 255, 255, 0.8);
    display: block;
    letter-spacing: 2px;
}

.footer-tagline {
    font-family: 'Noto Sans KR', sans-serif;
    font-size: 1.1rem;
    color: rgba(255, 255, 255, 0.9);
    margin-bottom: 30px;
    line-height: 1.6;
    font-weight: 400;
}

.social-links {
    display: flex;
    justify-content: center;
    gap: 20px;
}

.social-link {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 50px;
    height: 50px;
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(10px);
    border-radius: 50%;
    color: white;
    text-decoration: none;
    font-size: 1.3rem;
    transition: all 0.3s ease;
    border: 1px solid rgba(255, 255, 255, 0.2);
}

.social-link:hover {
    background: rgba(255, 255, 255, 0.2);
    transform: translateY(-3px) scale(1.1);
    box-shadow: 0 8px 25px rgba(255, 255, 255, 0.2);
}

/* 링크 섹션 */
.footer-links {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 30px;
}

.link-group {
    background: rgba(255, 255, 255, 0.05);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    padding: 25px 20px;
    border: 1px solid rgba(255, 255, 255, 0.1);
    transition: all 0.3s ease;
}

.link-group:hover {
    background: rgba(255, 255, 255, 0.1);
    transform: translateY(-2px);
}

.link-title {
    font-family: 'Montserrat', sans-serif;
    font-size: 1.1rem;
    font-weight: 600;
    color: white;
    margin-bottom: 15px;
    display: flex;
    align-items: center;
    gap: 8px;
}

.link-title i {
    color: rgba(255, 255, 255, 0.8);
    font-size: 1rem;
}

.link-list {
    list-style: none;
    padding: 0;
    margin: 0;
}

.link-list li {
    margin-bottom: 8px;
}

.link-list a {
    font-family: 'Noto Sans KR', sans-serif;
    color: rgba(255, 255, 255, 0.8);
    text-decoration: none;
    font-size: 0.95rem;
    font-weight: 400;
    transition: all 0.3s ease;
    display: block;
    padding: 5px 0;
    position: relative;
}

.link-list a:hover {
    color: white;
    transform: translateX(5px);
}

.link-list a::before {
    content: '→';
    position: absolute;
    left: -15px;
    opacity: 0;
    transition: opacity 0.3s ease;
}

.link-list a:hover::before {
    opacity: 1;
}

/* 연락처 섹션 */
.footer-contact {
    display: flex;
    gap: 20px;
    width: 100%;
    height: 50px;
    margin-top: 0;
}

.contact-card {
	width: 100%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 15px;
    background: rgba(255, 255, 255, 0.08);
    backdrop-filter: blur(10px);
    border-radius: 12px;
    border: 1px solid rgba(255, 255, 255, 0.1);
    transition: all 0.3s ease;
    cursor: pointer;
}

.contact-card:hover {
    background: rgba(255, 255, 255, 0.12);
    transform: translateY(-2px);
}

.contact-info {
	margin-left: 20px;
    display: flex;
    flex-direction: column;
    gap: 3px;
}

.contact-label {
    font-family: 'Montserrat', sans-serif;
    font-size: 0.85rem;
    font-weight: 600;
    color: rgba(255, 255, 255, 0.7);
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.contact-value {
    font-family: 'Noto Sans KR', sans-serif;
    font-size: 0.95rem;
    color: white;
    font-weight: 400;
}

/* 하단 섹션 */
.footer-bottom {
    border-top: 1px solid rgba(255, 255, 255, 0.15);
    padding-top: 5px;
    margin-top: 10px;
}

.footer-bottom-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 20px;
}

.footer-links-bottom {
    display: flex;
    gap: 25px;
    flex-wrap: wrap;
    padding-left: 20px;
}

.footer-links-bottom a {
    font-family: 'Noto Sans KR', sans-serif;
    color: rgba(255, 255, 255, 0.7);
    text-decoration: none;
    font-size: 0.9rem;
    font-weight: 400;
    transition: color 0.3s ease;
}

.footer-links-bottom a:hover {
    color: white;
}

.copyright {
    text-align: right;
}

.copyright p {
    font-family: 'Montserrat', sans-serif;
    color: rgba(255, 255, 255, 0.6);
    font-size: 0.85rem;
    margin: 0;
    line-height: 1.4;
    padding-right: 20px;
}

.fun-text {
    font-family: 'Noto Sans KR', sans-serif !important;
    font-size: 0.8rem !important;
    color: rgba(255, 255, 255, 0.5) !important;
    margin-top: 5px !important;
}

/* 배경 장식 */
.footer-decoration {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    pointer-events: none;
    z-index: 1;
}

.decoration-circle {
    position: absolute;
    border-radius: 50%;
    background: rgba(255, 255, 255, 0.03);
    animation: float 6s ease-in-out infinite;
}

.circle-1 {
    width: 200px;
    height: 200px;
    top: 20%;
    right: 10%;
    animation-delay: 0s;
}

.circle-2 {
    width: 150px;
    height: 150px;
    bottom: 30%;
    left: 5%;
    animation-delay: 2s;
}

.circle-3 {
    width: 100px;
    height: 100px;
    top: 60%;
    right: 30%;
    animation-delay: 4s;
}

@keyframes float {
    0%, 100% {
        transform: translateY(0px) rotate(0deg);
    }
    50% {
        transform: translateY(-20px) rotate(180deg);
    }
}

/* 반응형 디자인 */
@media (max-width: 768px) {
    .community-footer {
        padding: 40px 0 15px;
    }
    
    .footer-content {
        gap: 30px;
        text-align: center;
    }
    
    .footer-links {
        grid-template-columns: 1fr;
        gap: 20px;
    }
    
    .footer-bottom-content {
        flex-direction: column;
        text-align: center;
    }
    
    .copyright {
        text-align: center;
    }
    
    .logo-text {
        font-size: 2rem;
    }
    
    .social-links {
        gap: 15px;
    }
    
    .social-link {
        width: 45px;
        height: 45px;
        font-size: 1.1rem;
    }
}

@media (max-width: 480px) {
    .footer-links-bottom {
        flex-direction: column;
        gap: 10px;
        text-align: center;
    }
    
    .contact-card {
        padding: 15px;
    }
    
    .link-group {
        padding: 20px 15px;
    }
}
</style>

<footer class="community-footer">
    <div class="footer-container">
        <!-- 메인 푸터 콘텐츠 -->
        <div class="footer-content">
            <!-- 브랜드 섹션 -->
            <div class="footer-brand" style="margin-top: auto;">
                <div class="footer-logo">
                	<div>
	                    <span class="logo-text">DDTOWN</span>
                	</div>
                	<div>
	                    <span class="logo-subtitle">SQUARE</span>
                	</div>
                </div>
            </div>
	        <!-- 연락처 정보 -->
	        <div class="footer-contact">
	            <div class="contact-card">
	                <div class="contact-info">
	                    <span class="contact-value">주소 : 대전광역시 중구 계룡로 846, 3층 305호</span>
	                </div>
	            </div>
	            <div class="contact-card">
	                <div class="contact-info">
	                    <span class="contact-value">전화 : 042-222-8202</span>
	                </div>
	            </div>
	            <div class="contact-card">
	                <div class="contact-info">
	                    <span class="contact-value">이메일 : ddtown305@gmail.com</span>
	                </div>
	            </div>
	        </div>
        </div>


        <!-- 하단 정보 -->
        <div class="footer-bottom">
            <div class="footer-bottom-content">
                <div class="footer-links-bottom">
                    <a href="${pageContext.request.contextPath}/corporate/about">회사소개</a>
                    <a href="${pageContext.request.contextPath}/policy/privacy">개인정보처리방침</a>
                    <a href="${pageContext.request.contextPath}/policy/terms">이용약관</a>
                    <a href="${pageContext.request.contextPath}/support/contact">고객센터</a>
                </div>
                <div class="copyright">
                    <p>&copy; 2025 DDTOWN Entertainment. All Rights Reserved.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- 배경 장식 요소 -->
    <div class="footer-decoration">
        <div class="decoration-circle circle-1"></div>
        <div class="decoration-circle circle-2"></div>
        <div class="decoration-circle circle-3"></div>
    </div>
</footer>