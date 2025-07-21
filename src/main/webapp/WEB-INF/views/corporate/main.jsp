<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DD TOWN - Welcome to the World of Dreams!</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;700;900&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <%-- CSS 파일 경로: 웹 애플리케이션 루트를 기준으로 'css' 폴더를 가정합니다. --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components/navigation.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components/buttons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Enhanced Modern Styles */
        .has-submenu {
            position: relative;
        }
        .has-submenu:hover .submenu {
            display: block;
            animation: fadeInUp 0.3s ease;
        }
        .submenu {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            min-width: 220px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
            border-radius: 12px;
            padding: 12px 0;
            z-index: 1000;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        .submenu li {
            padding: 0;
        }
        .submenu a {
            display: block;
            padding: 12px 20px;
            color: #333;
            text-decoration: none;
            transition: all 0.3s ease;
            font-weight: 500;
        }
        .submenu a:hover {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            transform: translateX(5px);
        }
        
        /* Enhanced Hero Section */
        .hero-section {
            position: relative;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        
        .hero-content {
            text-align: center;
            z-index: 2;
            max-width: 800px;
            padding: 0 20px;
        }
        
        .hero-title {
            font-size: clamp(3rem, 8vw, 6rem);
            font-weight: 900;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 1rem;
            text-shadow: 0 4px 20px rgba(102, 126, 234, 0.3);
            animation: titleGlow 3s ease-in-out infinite alternate;
        }
        
        .hero-phrase {
            font-size: clamp(1.2rem, 3vw, 1.8rem);
            font-weight: 600;
            color: #fff;
            margin-bottom: 1rem;
            text-shadow: 0 2px 10px rgba(0,0,0,0.5);
            letter-spacing: 1px;
        }
        
        .hero-subphrase {
            font-size: clamp(1rem, 2.5vw, 1.3rem);
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 2.5rem;
            text-shadow: 0 2px 10px rgba(0,0,0,0.3);
            line-height: 1.6;
        }
        
        .btn-hero {
            display: inline-block;
            padding: 18px 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.4s ease;
            box-shadow: 0 8px 30px rgba(102, 126, 234, 0.4);
            border: 2px solid transparent;
            position: relative;
            overflow: hidden;
        }
        
        .btn-hero:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }
        
        .btn-hero:hover:before {
            left: 100%;
        }
        
        .btn-hero:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(102, 126, 234, 0.6);
            border-color: rgba(255, 255, 255, 0.3);
        }
        
        /* Enhanced Business Section */
        .business-areas {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 40px;
            margin-top: 60px;
        }
        
        .business-area-item {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px 30px;
            text-align: center;
            transition: all 0.4s ease;
            border: 1px solid rgba(255, 255, 255, 0.1);
            position: relative;
            overflow: hidden;
        }
        
        .business-area-item:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
            opacity: 0;
            transition: opacity 0.4s ease;
        }
        
        .business-area-item:hover:before {
            opacity: 1;
        }
        
        .business-area-item:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            border-color: rgba(102, 126, 234, 0.3);
        }
        
        .business-area-item img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 15px;
            margin-bottom: 25px;
            transition: transform 0.4s ease;
        }
        
        .business-area-item:hover img {
            transform: scale(1.05);
        }
        
        .business-area-item h4 {
            font-size: 1.5rem;
            font-weight: 700;
            color: #fff;
            margin-bottom: 15px;
            position: relative;
            z-index: 1;
        }
        
        .business-area-item p {
            color: rgba(255, 255, 255, 0.8);
            line-height: 1.6;
            position: relative;
            z-index: 1;
        }
        
        /* Enhanced About Teaser Section */
        .content-section {
            padding: 100px 0;
        }
        
        .section-title-on-bg {
            font-size: clamp(2.5rem, 5vw, 4rem);
            font-weight: 800;
            color: #fff;
            text-align: center;
            margin-bottom: 30px;
            text-shadow: 0 4px 20px rgba(0,0,0,0.5);
        }
        
        .content-on-bg-container p {
            font-size: 1.2rem;
            color: rgba(255, 255, 255, 0.9);
            text-align: center;
            max-width: 800px;
            margin: 0 auto;
            line-height: 1.8;
            text-shadow: 0 2px 10px rgba(0,0,0,0.3);
        }
        
        /* New Style for Business Section Background */
        .business-section-bg {
            background: url('${pageContext.request.contextPath}/resources/assets/images/business-bg.jpg') no-repeat center center / cover;
            position: relative;
            z-index: 1; /* 다른 요소 위에 오도록 보장 */
        }
        /* 선택 사항: 텍스트 가독성을 높이기 위한 오버레이 추가 */
        .business-section-bg::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6); /* 어두운 오버레이 */
            z-index: -1; /* 콘텐츠 뒤에 배치 */
        }

        /* Enhanced Footer */
        .footer-links .has-submenu {
            position: relative;
        }
        .footer-links .submenu {
            position: static;
            box-shadow: none;
            padding-left: 20px;
            margin-top: 12px;
            background: transparent;
            backdrop-filter: none;
            border: none;
        }
        .footer-links .submenu a {
            color: rgba(255, 255, 255, 0.7);
            padding: 8px 0;
            font-weight: 400;
        }
        .footer-links .submenu a:hover {
            color: #667eea;
            background: none;
            transform: none;
        }
        
        /* Animations */
        @keyframes titleGlow {
            0% { text-shadow: 0 4px 20px rgba(102, 126, 234, 0.3); }
            100% { text-shadow: 0 4px 30px rgba(102, 126, 234, 0.6), 0 0 40px rgba(118, 75, 162, 0.4); }
        }
        
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .business-areas {
                grid-template-columns: 1fr;
                gap: 30px;
            }
            
            .business-area-item {
                padding: 30px 20px;
            }
            
            .hero-content {
                padding: 0 15px;
            }
        }
    </style>
</head>
<body>
    <%@ include file="./modules/header.jsp" %>

    <main>
        <div class="dynamic-background-wrapper interactive-gradient-bg">
            <video class="background-video" autoplay muted loop playsinline>
                <%-- 비디오 파일 경로: 웹 애플리케이션 루트를 기준으로 'assets/videos' 폴더를 가정합니다. --%>
                <source src="${pageContext.request.contextPath}/resources/assets/videos/background.mp4" type="video/mp4">
            </video>
            <div class="mouse-aura"></div>
            <section class="hero-section section-on-dynamic-bg">
                <div class="hero-content">
                    <h2 class="hero-title">DDTOWN</h2>
                    <p class="hero-phrase"><strong>D</strong>ynamic <strong>D</strong>reams, <strong>T</strong>ogether <strong>O</strong>ur <strong>W</strong>orld <strong>N</strong>urtures.</p>
                    <p class="hero-subphrase">역동적인 꿈들이 모여, 함께 세상을 키워나가는 디디타운입니다.</p>
                    <a href="${pageContext.request.contextPath}/corporate/about" class="btn btn-hero">
                        <i class="fas fa-rocket"></i> DD TOWN 더 알아보기
                    </a>
                </div>
            </section>
            
            <section id="about-teaser-section" class="content-section section-on-dynamic-bg">
                <div class="container content-on-bg-container">
                    <h3 class="section-title-on-bg">새로운 엔터테인먼트의 중심</h3>
                    <p>DD TOWN은 창의성과 열정을 바탕으로 아티스트와 팬 모두에게 최고의 경험을 선사합니다. 우리는 혁신적인 콘텐츠와 글로벌 네트워크를 통해 K-Culture의 미래를 만들어갑니다.</p>
                </div>
            </section>
        </div>

        <section id="business-section" class="content-section business-section-bg text-light">
            <div class="container">
                <h2 class="section-title text-center" style="color: #fff; font-size: 3rem; font-weight: 800; margin-bottom: 20px;">Our Business</h2>
                <p class="section-subtitle text-center" style="color: rgba(255,255,255,0.8); font-size: 1.2rem; margin-bottom: 60px;">DD TOWN은 다음과 같은 핵심 사업을 통해 엔터테인먼트 산업을 선도합니다.</p>
                <div class="business-areas">
                    <div class="business-area-item">
                        <img src="${pageContext.request.contextPath}/resources/assets/images/artist-management.jpg" alt="아티스트 매니지먼트">
                        <h4><i class="fas fa-star"></i> 아티스트 매니지먼트</h4>
                        <p>아티스트의 성장과 활동을 체계적으로 지원하며, 잠재력을 최대한 발휘할 수 있도록 돕습니다.</p>
                    </div>
                    <div class="business-area-item">
                        <img src="${pageContext.request.contextPath}/resources/assets/images/contents-producing.jpg" alt="콘텐츠 제작">
                        <h4><i class="fas fa-video"></i> 콘텐츠 제작</h4>
                        <p>음악, 영상, 공연 등 다양한 형태의 콘텐츠를 기획하고 제작하여 팬들에게 다채로운 즐거움을 제공합니다.</p>
                    </div>
                    <div class="business-area-item">
                        <img src="${pageContext.request.contextPath}/resources/assets/images/events.png" alt="공연 및 이벤트">
                        <h4><i class="fas fa-music"></i> 공연 및 이벤트</h4>
                        <p>국내외 팬들과 직접 만나는 감동적인 공연과 특별한 이벤트를 기획하여 잊지 못할 경험을 선사합니다.</p>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <%@ include file="./modules/footer.jsp" %>

    <%-- JS 파일 경로: 웹 애플리케이션 루트를 기준으로 'js' 폴더를 가정합니다. --%>
    <script src="${pageContext.request.contextPath}/resources/js/common/main.js"></script>
</body>
</html>