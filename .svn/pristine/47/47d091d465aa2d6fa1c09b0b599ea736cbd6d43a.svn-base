<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DD TOWN - 기업소개</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;700;900&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <%-- CSS 파일 경로를 ${pageContext.request.contextPath}/resources 로 시작하도록 수정 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components/navigation.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components/buttons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/about.css">
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
        .about-hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 120px 0 80px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .about-hero:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="white" opacity="0.1"/><circle cx="75" cy="75" r="1" fill="white" opacity="0.1"/><circle cx="50" cy="10" r="0.5" fill="white" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            opacity: 0.3;
        }
        
        .about-hero h2 {
            font-size: clamp(3rem, 6vw, 4.5rem);
            font-weight: 900;
            color: white;
            margin-bottom: 20px;
            text-shadow: 0 4px 20px rgba(0,0,0,0.3);
            position: relative;
            z-index: 1;
        }
        
        .about-hero p {
            font-size: 1.3rem;
            color: rgba(255, 255, 255, 0.9);
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.6;
            position: relative;
            z-index: 1;
        }
        
        .about-vision {
            padding: 100px 0;
            background: linear-gradient(45deg, #f8f9ff 0%, #f0f2ff 100%);
            position: relative;
        }
        
        .vision-content {
            text-align: center;
            max-width: 900px;
            margin: 0 auto;
        }
        
        .vision-content h3 {
            font-size: 3rem;
            font-weight: 800;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 30px;
        }
        
        .vision-text {
            font-size: 2rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 30px;
            font-style: italic;
        }
        
        .vision-description {
            font-size: 1.2rem;
            color: #666;
            line-height: 1.8;
            text-align: left;
        }
        
        .about-history {
            padding: 100px 0;
            background: #fff;
        }
        
        .about-history h3 {
            font-size: 2.5rem;
            font-weight: 800;
            text-align: center;
            margin-bottom: 60px;
            color: #333;
        }
        
        .timeline {
            position: relative;
            max-width: 900px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .timeline:before {
            content: '';
            position: absolute;
            left: 50%;
            top: 0;
            bottom: 0;
            width: 4px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            transform: translateX(-50%);
        }
        
        .timeline-item {
            position: relative;
            margin-bottom: 50px;
            display: flex;
            align-items: stretch; /* 자식 요소들이 높이를 채우도록 */
        }
        
        .timeline-side {
            width: 50%; /* 왼쪽 또는 오른쪽 절반 */
            padding: 0 20px; /* content와 year 사이 간격 조정 */
            display: flex; /* 내부 content 정렬을 위해 flex 추가 */
            align-items: center; /* content를 세로 중앙 정렬 */
        }
        
        .left-side {
            justify-content: flex-end; /* content를 오른쪽으로 밀어내기 */
        }
        
        .right-side {
            justify-content: flex-start; /* content를 왼쪽으로 밀어내기 */
        }

        .timeline-year-wrapper {
            position: absolute; /* year를 중앙선에 고정 */
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%); /* 정확히 중앙 */
            z-index: 3; /* content 위에 오도록 */
            display: flex; /* year를 중앙 정렬하기 위해 flex 추가 */
            align-items: center;
            justify-content: center;
            min-height: 100%; /* year wrapper가 timeline-item 높이를 커버하도록 */
            padding: 0 10px; /* year 박스 주변 여백 */
        }
        
        .year {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 25px;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1.2rem;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
            white-space: nowrap; /* 연도가 줄바꿈되지 않도록 */
            text-align: center;
        }
        
        .content {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            width: 100%; /* timeline-side 안에서 꽉 채우기 */
            border: 1px solid rgba(102, 126, 234, 0.1);
            transition: all 0.3s ease;
            position: relative;
            z-index: 1; /* year wrapper보다 아래에 */
        }
        
        /* 연결 선을 위한 원형 마크 */
        .timeline-item::after {
            content: '';
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            width: 16px;
            height: 16px;
            border-radius: 50%;
            background: #fff;
            border: 4px solid #764ba2;
            z-index: 2; /* year wrapper와 content 사이에 위치 */
        }
        
        .content:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }
        
        .content h4 {
            font-size: 1.4rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
        }
        
        .content p {
            color: #666;
            line-height: 1.6;
        }
        
        .about-values {
            padding: 100px 0;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .about-values h3 {
            font-size: 2.5rem;
            font-weight: 800;
            text-align: center;
            margin-bottom: 60px;
            color: white;
        }
        
        .values-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 40px;
            max-width: 1600px;
            margin: 0 auto;
        }
        
        .value-item {
            text-align: center;
            padding: 40px 30px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
        }
        
        .value-item:hover {
            transform: translateY(-10px);
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
        }
        
        .value-item i {
            font-size: 3rem;
            margin-bottom: 20px;
            color: #fff;
        }
        
        .value-item h4 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 15px;
            color: white;
        }
        
        .value-item p {
            color: rgba(255, 255, 255, 0.9);
            line-height: 1.6;
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .timeline:before {
                left: 30px; /* 모바일에서 중앙선 위치 조정 */
            }
            
            .timeline-item {
                flex-direction: column; /* 모바일에서는 세로로 정렬 */
                align-items: flex-start;
            }
            
            .timeline-year-wrapper {
                position: static; /* 모바일에서는 정적 위치로 변경 */
                transform: none;
                margin-bottom: 20px;
                align-self: flex-start; /* year wrapper 자체를 왼쪽으로 정렬 */
                margin-left: 10px; /* 중앙선과 조금 떨어지게 */
                min-height: unset; /* 높이 제한 해제 */
                padding: 0;
            }

            .year { /* year 박스만 */
                margin-left: 20px; /* 세로선 기준으로 연도를 조금 띄움 */
            }
            
            .timeline-side {
                width: 100%; /* 모바일에서 전체 너비 사용 */
                padding: 0; /* 패딩 제거 */
            }

            .left-side .content,
            .right-side .content { /* content 박스 */
                width: calc(100% - 60px); /* 모바일에서 너비 조정 (왼쪽 선 패딩 고려) */
                margin-left: 60px; /* 왼쪽 선에 맞춰 들여쓰기 */
            }
            
            .timeline-item::after { /* 모바일 타임라인 마크 위치 조정 */
                left: 30px;
                top: 20px; /* 연도 박스 상단에 가깝게 */
                transform: translateX(-50%);
            }
            
            .values-grid {
                grid-template-columns: 1fr;
                gap: 30px;
            }
        }
        
        /* Enhanced dropdown styles */
        .has-submenu { position: relative; }
        .has-submenu:hover .submenu { display: block; }
        .submenu { display: none; position: absolute; top: 100%; left: 0; background: white; min-width: 200px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); border-radius: 4px; padding: 8px 0; z-index: 1000; }
        .submenu li { padding: 0; }
        .submenu a { display: block; padding: 8px 16px; color: #333; text-decoration: none; transition: background-color 0.2s; }
        .submenu a:hover { background-color: #f5f5f5; }
        .footer-links .has-submenu .submenu { position: static; box-shadow: none; padding-left: 16px; margin-top: 8px; }
        .footer-links .has-submenu .submenu a { color: #fff; opacity: 0.8; }
        .footer-links .has-submenu .submenu a:hover { opacity: 1; background: none; }
    </style>
</head>
<body>
    <%@ include file="./modules/header.jsp" %>

    <main>
        <section class="about-hero">
            <div class="container">
                <h2>기업소개</h2>
                <p>DD TOWN은 K-Culture의 미래를 만들어가는 혁신적인 엔터테인먼트 기업입니다.</p>
            </div>
        </section>

        <section class="about-vision">
            <div class="container">
                <div class="vision-content">
                    <h3>Our Vision</h3>
                    <p class="vision-text">"Dynamic Dreams, Together Our World Nurtures"</p>
                    <p class="vision-description">
                        DD TOWN은 아티스트의 꿈을 실현하고, 글로벌 문화를 선도하는 혁신적인 엔터테인먼트 기업입니다.
                        우리는 창의성과 열정을 바탕으로 아티스트와 팬 모두에게 최고의 경험을 선사하며,
                        K-Culture의 새로운 역사를 만들어가고 있습니다.
                    </p>
                </div>
            </div>
        </section>

        <section class="about-history">
            <div class="container">
                <h3>History</h3>
                <div class="timeline">
                    <div class="timeline-item">
                        <div class="timeline-side left-side">
                            <div class="content">
                                <h4>DD TOWN 설립</h4>
                                <p>대전광역시 중구 계룡로 846에 본사 설립, 엔터테인먼트 산업의 새로운 도전 시작</p>
                            </div>
                        </div>
                        <div class="timeline-year-wrapper">
                            <div class="year">2021</div>
                        </div>
                        <div class="timeline-side right-side"></div>
                    </div>

                    <div class="timeline-item">
                        <div class="timeline-side left-side"></div>
                        <div class="timeline-year-wrapper">
                            <div class="year">2022</div>
                        </div>
                        <div class="timeline-side right-side">
                            <div class="content">
                                <h4>첫 아티스트 데뷔</h4>
                                <p>첫 번째 아티스트 그룹 'DREAM' 데뷔, K-POP 씬에 새로운 바람을 일으키다</p>
                            </div>
                        </div>
                    </div>

                    <div class="timeline-item">
                        <div class="timeline-side left-side">
                            <div class="content">
                                <h4>글로벌 진출</h4>
                                <p>일본, 동남아시아 시장 진출, 해외 팬베이스 확장 및 글로벌 네트워크 구축</p>
                            </div>
                        </div>
                        <div class="timeline-year-wrapper">
                            <div class="year">2023</div>
                        </div>
                        <div class="timeline-side right-side"></div>
                    </div>

                    <div class="timeline-item">
                        <div class="timeline-side left-side"></div>
                        <div class="timeline-year-wrapper">
                            <div class="year">2024</div>
                        </div>
                        <div class="timeline-side right-side">
                            <div class="content">
                                <h4>신규 사업 확장</h4>
                                <p>콘텐츠 제작 스튜디오 설립, 다양한 미디어 플랫폼과의 협업 강화</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="about-values">
            <div class="container" style="max-width: 1600px;">
                <h3>Core Values</h3>
                <div class="values-grid">
                    <div class="value-item">
                        <i class="fas fa-lightbulb"></i>
                        <h4>창의성</h4>
                        <p>혁신적인 아이디어와 창의적인 콘텐츠로 새로운 가치를 창출합니다.</p>
                    </div>
                    <div class="value-item">
                        <i class="fas fa-heart"></i>
                        <h4>열정</h4>
                        <p>아티스트와 팬을 위한 진정성 있는 열정으로 최고의 결과를 만들어냅니다.</p>
                    </div>
                    <div class="value-item">
                        <i class="fas fa-handshake"></i>
                        <h4>협력</h4>
                        <p>함께 성장하고 발전하는 협력 문화를 통해 시너지를 창출합니다.</p>
                    </div>
                    <div class="value-item">
                        <i class="fas fa-globe-asia"></i>
                        <h4>글로벌</h4>
                        <p>세계를 향한 도전정신으로 K-Culture의 가치를 높여갑니다.</p>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <%@ include file="./modules/footer.jsp" %>

    <script src="${pageContext.request.contextPath}/resources/js/common/main.js"></script>
</body>
</html>