<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DD TOWN - 기업 위치</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;700;900&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components/navigation.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components/buttons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/location.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Enhanced Location Page Styles */
        .location-hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 120px 0 80px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .location-hero:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
/*             background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="locationPattern" width="20" height="20" patternUnits="userSpaceOnUse"><circle cx="10" cy="10" r="1" fill="white" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23locationPattern)"/></svg>'); */
        }
        
        .location-hero h2 {
            font-size: clamp(3rem, 6vw, 4.5rem);
            font-weight: 900;
            color: white;
            margin-bottom: 20px;
            text-shadow: 0 4px 20px rgba(0,0,0,0.3);
            position: relative;
            z-index: 1;
        }
        
        .location-hero p {
            font-size: 1.3rem;
            color: rgba(255, 255, 255, 0.9);
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.6;
            position: relative;
            z-index: 1;
        }
        
        .location-info {
            padding: 100px 0;
            background: linear-gradient(45deg, #f8f9ff 0%, #f0f2ff 100%);
        }
        
        .location-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 60px;
            align-items: start;
        }
        
        .map-container {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
            border: 1px solid rgba(102, 126, 234, 0.1);
            transition: all 0.3s ease;
        }
        
        .map-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 25px 60px rgba(0,0,0,0.15);
        }
        
        #staticMap {
            width: 100% !important;
            height: 400px !important;
            border-radius: 15px;
            overflow: hidden;
        }
        
        .location-details {
            display: flex;
            flex-direction: column;
            gap: 40px;
        }
        
        .address-info, .transportation-info, .contact-info {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            border: 1px solid rgba(102, 126, 234, 0.1);
            transition: all 0.3s ease;
        }
        
        .address-info:hover, .transportation-info:hover, .contact-info:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.12);
        }
        
        .address-info h3, .transportation-info h3, .contact-info h3 {
            font-size: 1.5rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .address-info h3:before {
            content: '\f3c5';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            color: #667eea;
            font-size: 1.2rem;
        }
        
        .transportation-info h3:before {
            content: '\f207';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            color: #667eea;
            font-size: 1.2rem;
        }
        
        .contact-info h3:before {
            content: '\f095';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            color: #667eea;
            font-size: 1.2rem;
        }
        
        .address-info p {
            font-size: 1.1rem;
            color: #666;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .address-info i {
            color: #667eea;
            font-size: 1.2rem;
        }
        
        .transport-item {
            margin-bottom: 30px;
            padding: 25px;
            background: linear-gradient(45deg, #f8f9ff 0%, #f0f2ff 100%);
            border-radius: 15px;
            border-left: 4px solid #667eea;
        }
        
        .transport-item:last-child {
            margin-bottom: 0;
        }
        
        .transport-item h4 {
            font-size: 1.2rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .transport-item i {
            color: #667eea;
            font-size: 1.1rem;
        }
        
        .transport-item p {
            color: #666;
            margin-bottom: 15px;
            line-height: 1.6;
        }
        
        .transport-item ul {
            list-style: none;
            padding: 0;
        }
        
        .transport-item li {
            padding: 8px 0;
            color: #666;
            border-bottom: 1px solid rgba(102, 126, 234, 0.1);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .transport-item li:before {
            content: '\f105';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            color: #667eea;
            font-size: 0.9rem;
        }
        
        .transport-item li:last-child {
            border-bottom: none;
        }
        
        .contact-info p {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 15px;
            font-size: 1.1rem;
            color: #666;
            padding: 15px;
            background: linear-gradient(45deg, #f8f9ff 0%, #f0f2ff 100%);
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        
        .contact-info p:hover {
            background: linear-gradient(45deg, #667eea 0%, #764ba2 100%);
            color: white;
            transform: translateX(5px);
        }
        
        .contact-info p:hover i {
            color: white;
        }
        
        .contact-info i {
            color: #667eea;
            font-size: 1.2rem;
            width: 20px;
            text-align: center;
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .location-grid {
                grid-template-columns: 1fr;
                gap: 40px;
            }
            
            #staticMap {
                height: 300px !important;
            }
            
            .address-info, .transportation-info, .contact-info {
                padding: 25px;
            }
            
            .transport-item {
                padding: 20px;
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
        <section class="location-hero">
            <div class="container">
                <h2>기업위치</h2>
                <p>DD TOWN의 본사 위치와 오시는 길을 안내해드립니다.</p>
            </div>
        </section>

        <section class="location-info">
            <div class="container">
                <div class="location-grid">
                    <div class="map-container">
                        <div id="staticMap" style="width:100%;height:400px;"></div> 
                    </div>
                    <div class="location-details">
                        <div class="address-info">
                            <h3>주소</h3>
                            <p><i class="fas fa-map-marker-alt"></i> <c:out value="${locationInfo.address != null ? locationInfo.address : '대전광역시 중구 계룡로 846, 3층 305호 DDTOWN'}"/></p>
                        </div>
                        <div class="transportation-info">
                            <h3>대중교통 이용안내</h3>
                            <div class="transport-item">
                                <h4><i class="fas fa-subway"></i> 지하철</h4>
                                <p><c:out value="${locationInfo.subwayInfo != null ? locationInfo.subwayInfo : '1호선 중앙로역 3번 출구에서 도보 5분'}"/></p>
                            </div>
                            <div class="transport-item">
                                <h4><i class="fas fa-bus"></i> 버스</h4>
                                <p><c:out value="${locationInfo.busStopInfo != null ? locationInfo.busStopInfo : '중앙로역 정류장 하차'}"/></p>
                                <ul>
                                    <c:if test="${empty locationInfo.busRoutes}">
                                        <li>간선버스: 101, 102, 103</li>
                                        <li>지선버스: 201, 202</li>
                                        <li>마을버스: 301</li>
                                    </c:if>
                                    <c:forEach var="busRoute" items="${locationInfo.busRoutes}">
                                        <li><c:out value="${busRoute.type}"/>: <c:out value="${busRoute.numbers}"/></li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <!-- 카카오 지도 API : 정적 지도 -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2816d38a347f8c7797d3f6453ce307b9"></script>
    <script>
        var marker = {
            position: new kakao.maps.LatLng(36.32508187471473, 127.40889586430282), 
            text: 'DD TOWN'
        };

        var staticMapContainer  = document.getElementById('staticMap'),
            staticMapOption = { 
                center: new kakao.maps.LatLng(36.32508187471473, 127.40889586430282),
                level: 3,
                marker: marker
            };

        var staticMap = new kakao.maps.StaticMap(staticMapContainer, staticMapOption);
    </script>

    <%@ include file="./modules/footer.jsp" %>

    <script src="${pageContext.request.contextPath}/resources/js/common/main.js"></script>
</body>
</html>