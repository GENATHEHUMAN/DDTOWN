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
        /* 드롭다운 메뉴 스타일 (다른 JSP와 공통으로 사용될 수 있으므로, 별도 common.css 등으로 옮기는 것을 권장합니다) */
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
    <%-- 헤더 부분 --%>
    <%-- 실제 프로젝트에서는 <jsp:include page="/WEB-INF/views/common/header.jsp" /> 와 같이 공통 헤더를 포함하는 것이 좋습니다. --%>
    <header class="site-header">
        <div class="header-container container">
            <div class="logo">
                <%-- 메인 페이지 링크 (예: /corporate/main 또는 해당 컨트롤러 경로) --%>
                <h1><a href="${pageContext.request.contextPath}/corporate/main">DD TOWN</a></h1>
            </div>
            <nav class="main-nav">
                <button class="nav-toggle" aria-label="메뉴 열기/닫기">
                    <span class="hamburger"></span>
                </button>
                <ul>
                    <li class="has-submenu">
                        <a href="#">기업 정보</a>
                        <ul class="submenu">
                            <%-- 각 메뉴는 해당 기능을 처리하는 컨트롤러 경로 또는 JSP 파일 경로로 수정되어야 합니다. --%>
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
            </nav>
        </div>
    </header>

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
                    <p class="vision-text">Dynamic Dreams, Together Our World Nurtures</p>
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
                <%-- 이 부분은 실제로는 컨트롤러에서 List<HistoryVO> 같은 데이터를 받아와 <c:forEach>로 반복 처리할 수 있습니다. --%>
                <%-- 예시: <c:forEach var="historyItem" items="${historyList}"> ... </c:forEach> --%>
                <div class="timeline">
                    <div class="timeline-item">
                        <div class="year">2021</div>
                        <div class="content">
                            <h4>DD TOWN 설립</h4>
                            <p>대전광역시 중구 계룡로 846에 본사 설립</p>
                        </div>
                    </div>
                    <div class="timeline-item">
                        <div class="year">2022</div>
                        <div class="content">
                            <h4>첫 아티스트 데뷔</h4>
                            <p>첫 번째 아티스트 그룹 'DREAM' 데뷔</p>
                        </div>
                    </div>
                    <div class="timeline-item">
                        <div class="year">2023</div>
                        <div class="content">
                            <h4>글로벌 진출</h4>
                            <p>일본, 동남아시아 시장 진출</p>
                        </div>
                    </div>
                    <div class="timeline-item">
                        <div class="year">2024</div>
                        <div class="content">
                            <h4>신규 사업 확장</h4>
                            <p>콘텐츠 제작 스튜디오 설립</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="about-values">
            <div class="container">
                <h3>Core Values</h3>
                 <%-- 이 부분도 컨트롤러에서 List<ValueVO> 같은 데이터를 받아와 <c:forEach>로 반복 처리할 수 있습니다. --%>
                 <%-- 예시: <c:forEach var="coreValue" items="${coreValuesList}"> ... </c:forEach> --%>
                <div class="values-grid">
                    <div class="value-item">
                        <i class="fas fa-star"></i>
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
                        <i class="fas fa-globe"></i>
                        <h4>글로벌</h4>
                        <p>세계를 향한 도전정신으로 K-Culture의 가치를 높여갑니다.</p>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <%-- 푸터 부분 --%>
    <%-- 실제 프로젝트에서는 <jsp:include page="/WEB-INF/views/common/footer.jsp" /> 와 같이 공통 푸터를 포함하는 것이 좋습니다. --%>
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

    <%-- JS 파일 경로를 ${pageContext.request.contextPath}/resources 로 시작하도록 수정 --%>
    <script src="${pageContext.request.contextPath}/resources/js/common/main.js"></script>
</body>
</html>
