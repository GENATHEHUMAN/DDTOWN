<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>DDTOWN SQUARE</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/pages/mainservice_home.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/pages/mainservice_common.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/pages/artist_community.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/pages/artist_community_main.css" />
<link
  rel="stylesheet"
  href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
  
<style type="text/css">
.main-header {
    background: rgba(230, 179, 255, 0.08); /* 연보라 느낌의 투명한 배경 */
    backdrop-filter: blur(20px); /* 블러 강도 증가 */
    border-bottom: 1px solid rgba(255, 255, 255, 0.15); /* 테두리 연하게 */
    box-shadow: 0 4px 25px rgba(0, 0, 0, 0.4); /* 그림자 진하게 */
    position: sticky;
    top: 0;
    z-index: 1000;
    height: 150px;
    border-radius: 0 0 25px 25px; /* 모서리 더 둥글게 */
    transition: all 0.3s ease;
}
.main-header.scrolled {
    height: 120px;
    background: rgba(230, 179, 255, 0.15); /* 스크롤 시에도 연보라 느낌 유지 */
    backdrop-filter: blur(25px); /* 블러 더 강하게 */
    box-shadow: 0 6px 25px rgba(0, 0, 0, 0.5);
}
/* 전체 배경 및 기본 스타일 */
body {
    background: linear-gradient(135deg, #1a1a2e 0%, #2a1e4a 50%, #8a2be2 100%); /* 중간색을 약간 더 보라색 계열로 조정 */
    background-attachment: fixed; /* 배경을 뷰포트에 고정 */
    background-size: cover; /* 배경이 전체 영역을 커버하도록 */
    min-height: 100vh;
    margin: 0;
    font-family: "Noto Sans KR", 돋움, Dotum, 굴림, Gulim, Tahoma, Verdana, sans-serif;
    color: #ffffff;
    overflow-x: hidden;
}
/* 컨테이너 스타일 */
.container {
    max-width: 1200px;
    margin: 30px auto;
    padding: 30px; /* 패딩 증가 */
    background: rgba(255, 255, 255, 0.08); /* 컨테이너 배경도 투명도 유지 */
    backdrop-filter: blur(25px); /* 블러 강도 증가 */
    border-radius: 25px; /* 모서리 더 둥글게 */
    box-shadow: 0 10px 40px rgba(0, 0, 0, 0.4); /* 그림자 진하게 */
    border: 1px solid rgba(255, 255, 255, 0.15);
}

/* 아티스트 그리드 */
.artist-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 30px;
    padding: 30px;
    max-width: 1400px;
    margin: 0 auto;
}

.artist-item {
    background: rgba(255, 255, 255, 0.1); /* 더 투명하게 */
    backdrop-filter: blur(20px); /* 블러 강도 증가 */
    border-radius: 25px; /* 모서리 더 둥글게 */
    box-shadow: 0 10px 35px rgba(0, 0, 0, 0.35); /* 그림자 조정 */
    transition: all 0.4s ease;
    height: 100%;
    border: 1px solid rgba(255, 255, 255, 0.25); /* 테두리 조금 더 선명하게 */
    overflow: hidden;
}

.artist-item:hover {
    transform: translateY(-10px) scale(1.03);
    box-shadow: 0 15px 40px rgba(138, 43, 226, 0.5);
    border-color: rgba(138, 43, 226, 0.6);
}

.artist-link {
    text-decoration: none;
    color: inherit;
    display: block;
    padding: 30px;
    height: 100%;
}

.artist-image-placeholder {
    width: 100%;
    height: 300px;
    background: linear-gradient(135deg, rgba(255, 255, 255, 0.1), rgba(138, 43, 226, 0.2));
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 20px;
    margin-bottom: 25px;
    overflow: hidden;
    position: relative;
}

.artist-image-placeholder::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(45deg, transparent 30%, rgba(255, 255, 255, 0.1) 50%, transparent 70%);
    transform: translateX(-100%);
    transition: transform 0.6s ease-out;
}

.artist-item:hover .artist-image-placeholder::before {
    transform: translateX(100%);
}

.artist-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 20px;
    transition: transform 0.4s ease-out;
}

.artist-item:hover .artist-image {
    transform: scale(1.15);
}

.artist-name {
    text-align: center;
    font-weight: bold;
    margin: 0;
    color: #ffffff;
    font-size: 1.4em;
    padding: 18px 0;
    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
}

/* 팔로우한 아티스트 섹션 */
.followed-artists-section {
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(15px);
    margin-top: 30px;
    margin-bottom: 30px;
    border-radius: 20px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
    min-height: 150px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    border: 1px solid rgba(255, 255, 255, 0.1);
    padding: 30px;
}

.followed-artists-section .section-title {
    text-align: center;
    margin: 0 0 25px 0;
    color: #ffffff;
    font-size: 1.8em;
    font-weight: bold;
    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
}

.followed-artists-section .followed-list {
    display: flex;
    justify-content: center;
    align-items: center;
    list-style: none;
    padding: 0;
    margin: 0;
    gap: 10px;
    flex-wrap: wrap;
}

.followed-artists-section .followed-artist-link {
    display: flex;
    flex-direction: column;
    align-items: center;
    text-decoration: none;
    color: #ffffff;
    transition: all 0.3s ease;
    font-size: 1.1em;
    white-space: nowrap;
    padding: 15px;
    border-radius: 15px;
}

.followed-artists-section .followed-artist-link:hover {
    color: #e6b3ff;
    transform: translateY(-5px);
    background: rgba(138, 43, 226, 0.2);
    box-shadow: 0 10px 25px rgba(138, 43, 226, 0.3);
}

.followed-artist-profile-wrapper {
    position: relative;
    width: 80px;
    height: 80px;
    border-radius: 50%;
    margin-bottom: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
}

.followed-artists-section .followed-artist-profile {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    object-fit: cover;
    margin-bottom: 12px;
    border: 3px solid rgba(255, 255, 255, 0.3);
    transition: all 0.3s ease;
}

.followed-artists-section .followed-artist-link:hover .followed-artist-profile {
    border-color: #e6b3ff;
    transform: scale(1.1);
    box-shadow: 0 0 20px rgba(138, 43, 226, 0.5);
}

/* 멤버십 배지 */
.membership-badge {
    position: absolute;
    bottom: 55px;
    right: 10px;
    background: linear-gradient(135deg, #ffd700, #ffed4e);
    color: #8a2be2;
    border: 2px solid #ffffff;
    border-radius: 50%;
    padding: 8px;
    font-size: 1em;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 4px 15px rgba(255, 215, 0, 0.4);
    z-index: 10;
    animation: pulse 2s infinite;
}

@keyframes pulse {
    0% { transform: scale(1); }
    50% { transform: scale(1.1); }
    100% { transform: scale(1); }
}

/* 굿즈샵 섹션 */
.goods-shop-items-section {
    background: rgba(255, 255, 255, 0.08); /* 더 투명하게 */
    backdrop-filter: blur(20px); /* 블러 강도 증가 */
    border-radius: 25px; /* 모서리 더 둥글게 */
    box-shadow: 0 10px 40px rgba(0, 0, 0, 0.4); /* 그림자 강화 */
    border: 1px solid rgba(255, 255, 255, 0.15); /* 테두리 조정 */
    position: relative;
    padding: 35px;
}

.goods-shop-items-section .section-title {
    text-align: center;
    margin: 0 0 35px 0; /* 마진 증가 */
    color: #ffffff;
    font-size: 2em; /* 폰트 크기 증가 */
    font-weight: bold;
    text-shadow: 0 3px 6px rgba(0, 0, 0, 0.4); /* 텍스트 그림자 강화 */
    padding: 0;
}

.goods-shop-items-section .more-button {
    position: absolute;
    top: 30px; /* 위치 조정 */
    right: 30px; /* 위치 조정 */
    padding: 14px 25px; /* 패딩 증가 */
    color: #e6b3ff;
    text-decoration: none;
    font-size: 17px; /* 폰트 크기 증가 */
    background: rgba(138, 43, 226, 0.25); /* 배경색 투명도 증가 */
    border-radius: 30px; /* 모서리 더 둥글게 */
    transition: all 0.3s ease;
    border: 1px solid rgba(138, 43, 226, 0.4);
}

.goods-shop-items-section .more-button:hover {
    background: rgba(138, 43, 226, 0.45); /* 호버 시 배경색 진하게 */
    transform: translateY(-3px); /* 호버 효과 강화 */
    box-shadow: 0 8px 20px rgba(138, 43, 226, 0.4);
}

.goods-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 30px; /* 간격 증가 */
    justify-content: center;
    padding: 0;
}

.goods-item {
    background: rgba(255, 255, 255, 0.1); /* 더 투명하게 */
    backdrop-filter: blur(20px); /* 블러 강도 증가 */
    border-radius: 25px; /* 모서리 더 둥글게 */
    box-shadow: 0 10px 35px rgba(0, 0, 0, 0.35); /* 그림자 조정 */
    padding: 25px; /* 패딩 증가 */
    text-align: center;
    transition: all 0.4s ease;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    border: 1px solid rgba(255, 255, 255, 0.25); /* 테두리 조금 더 선명하게 */
    overflow: hidden;
    position: relative;
}

.goods-item::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(45deg, transparent 35%, rgba(255, 255, 255, 0.15) 55%, transparent 75%); /* 반짝임 효과 조정 */
    transform: translateX(-100%);
    transition: transform 0.6s ease-out; /* 전환 효과 조정 */
    z-index: 1;
}

.goods-item:hover::before {
    transform: translateX(100%);
}

.goods-item:hover {
    transform: translateY(-10px) scale(1.03); /* 호버 효과 강화 */
    box-shadow: 0 18px 45px rgba(138, 43, 226, 0.5); /* 그림자 강화 및 연보라 색상 */
    border-color: rgba(138, 43, 226, 0.6);
}

.goods-image-placeholder {
    width: 100%;
    height: 220px; /* 높이 증가 */
    background: linear-gradient(135deg, rgba(230, 179, 255, 0.15), rgba(138, 43, 226, 0.25)); /* 연보라 느낌으로 변경 */
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 20px; /* 이미지 플레이스홀더 모서리 조정 */
    margin-bottom: 20px; /* 마진 증가 */
    overflow: hidden;
    position: relative;
    z-index: 2;
}

.goods-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 20px; /* 이미지 모서리 조정 */
    transition: transform 0.4s ease-out;
}

.goods-item:hover .goods-image {
    transform: scale(1.15);
}

.goods-group-name {
    color: #e6b3ff;
    font-size: 1em; /* 폰트 크기 증가 */
    margin: 0 0 10px 0; /* 마진 증가 */
    font-weight: 500;
    z-index: 2;
    position: relative;
}

.goods-name {
    font-weight: bold;
    margin: 0 0 10px 0;
    color: #ffffff;
    font-size: 1.2em;
    z-index: 2;
    position: relative;
}

.goods-price {
    color: #ffd700;
    font-weight: bold;
    font-size: 1.3em;
    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
    z-index: 2;
    position: relative;
}

.goods-link {
    text-decoration: none;
    color: inherit;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

/* 스와이퍼 스타일 */
.swiper {
    height: 370px; /* 스와이퍼 높이 더 늘림 (조절 가능) */
    max-width: 1200px; /* 컨테이너와 동일한 최대 너비 적용 */
    margin: 30px auto; /* 컨테이너와 동일한 마진 적용 */
    border-radius: 25px; /* 모서리 더 둥글게 */
    overflow: hidden;
    box-shadow: 0 12px 45px rgba(0, 0, 0, 0.4);
}

/* 제목 스타일 */
h2, h3 {
    color: #ffffff;
    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.4);
    font-weight: bold;
}

/* 푸터 스타일 */
body .footer-container {
    display: block;
}

footer {
    position: fixed;
    bottom: 0;
    background: rgba(0, 0, 0, 0.8);
    backdrop-filter: blur(10px);
}

</style>
</head>

<body>
    <jsp:include page="/WEB-INF/views/modules/communityHeader.jsp" />

	<section class="slider-section">
		<div class="slider-container swiper">
			<div class="slider-wrapper swiper-wrapper">
				<div class="slide-item swiper-slide" style="background-color: #ffb6c1">
					<a href="/concert/detail/8" target="concert1">
					<img alt="ColdplayConcert" src="${pageContext.request.contextPath}/resources/img/ae_banner.jpg">
					</a>
				</div>
				<div class="slide-item swiper-slide" style="background-color: #add8e6">
					<a href="/concert/detail/14" target="concert1">
					<img alt="IndieMusic" src="${pageContext.request.contextPath}/resources/img/bm_banner.jpg">
					</a>
				</div>
				<div class="slide-item swiper-slide" style="background-color: #90ee90">
					<a href="/concert/detail/15" target="concert1">
					<img alt="SummerStarLight" src="${pageContext.request.contextPath}/resources/img/ml_banner.jpg">
					</a>
				</div>
				<div class="slide-item swiper-slide" style="background-color: #90ee90">
					<a href="/concert/detail/25" target="concert1">
					<img alt="SummerStarLight" src="${pageContext.request.contextPath}/resources/img/cp_banner.jpg">
					</a>
				</div>
<!-- 				<div class="slide-item swiper-slide" style="background-color: #ffd700"> -->
<!-- 				</div> -->
<!-- 				<div class="slide-item swiper-slide" style="background-color: #f08080"> -->
<!-- 				</div> -->
			</div>
			<button class="slide-button prev" aria-label="이전 슬라이드">
				&#10094;</button>
			<button class="slide-button next" aria-label="다음 슬라이드">
				&#10095;</button>
		</div>
		<div class="slide-dots"></div>
	</section>

    <div class="followed-artists-section container mb-4">
        <ul class="followed-list">
        	<c:forEach items="${following }" var="following">
				<div style="position: relative;">
					<a href="/community/gate/${following.artGroupNo}/apt" class="followed-artist-link">
						<c:if test="${not empty following.artGroupProfileImg }">
							<img alt="${following.artGroupNm }" src="${following.artGroupProfileImg }" class="followed-artist-profile">
							<span style="font-size: larger;">${following.artGroupNm }</span>
						</c:if>
						<c:if test="${empty following.artGroupProfileImg }">
							<span>이미지</span>
						</c:if>
						<c:if test="${following.isMembership == 1 }">
							<i class="fas fa-crown membership-badge" title="멤버십 회원"></i>
						</c:if>
					</a>
				</div>
			</c:forEach>
			<c:if test="${empty following }">
				<span style="color: gray">아직 팔로우한 아티스트가 없습니다! 아티스트를 팔로우하세요!</span>
			</c:if>
        </ul>
    </div>

	<div class="container">
		<h2>DDTOWN ARTIST</h2>
		<div class="artist-grid">
			<c:forEach items="${groups }" var="group">
				<div class="artist-item">
					<a href="/community/gate/${group.artGroupNo}" class="artist-link">
						<div class="artist-image-placeholder">
							<c:if test="${not empty group.artGroupProfileImg }">
								<img alt="${group.artGroupNm }" src="${group.artGroupProfileImg }" class="artist-image">
							</c:if>
							<c:if test="${empty group.artGroupProfileImg }">
								<span>이미지</span>
							</c:if>
						</div>
						<p class="artist-name">${group.artGroupNm }</p>
					</a>
				</div>
			</c:forEach>
		</div>
	</div>
	
	<%-- 굿즈샵 상품 5개 공간 추가 --%>
	<div class="goods-shop-items-section container mt-4" style="padding-bottom: 30px; ">
		<h3 class="section-title" style="padding: 20px;">BEST ITEMS</h3>
		<a href="${pageContext.request.contextPath }/goods/main" class="more-button" style="position: ">상품 더보기</a>
		<div class="goods-grid">
			<c:choose>
				<c:when test="${not empty bestItems }">
					<c:forEach items="${bestItems}" var="goods">
						<div class="goods-item">
							<a href="${pageContext.request.contextPath }/goods/detail?goodsNo=${goods.goodsNo}" class="goods-link">
								<div class="goods-image-placeholder">
									<img src="${goods.representativeImageUrl}" 
									     alt="${goods.goodsNm}" class="goods-image"
									     onerror="this.onerror=null; this.src='https://via.placeholder.com/180x180?text=No+Image';">
								</div>
								<p class="goods-group-name">${goods.artGroupName}</p> 
								<p class="goods-name">${goods.goodsNm}</p>
                            	<p class="goods-price"> ₩<fmt:formatNumber value="${goods.goodsPrice}" pattern="#,###"></fmt:formatNumber></p> 
                            </a>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<p>표시할 베스트 아이템이 없습니다.</p>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	
	<div>
		<!-- FOOTER -->
		<jsp:include page="/WEB-INF/views/modules/communityFooter.jsp" />    
	    <script src="${pageContext.request.contextPath}/resources/js/pages/communityFooter.js"></script>
		<!-- FOOTER END -->
	</div>
	
	<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    <script type="text/javascript">
    	const swiper = new Swiper('.swiper', {
	    	  loop: true,
	    	  autoplay : {
	    		  delay : 3000,
	    	  },

	    	  // Navigation arrows
	    	  navigation: {
	    	    nextEl: '.slide-button.next',
	    	    prevEl: '.slide-button.prev',
	    	  },
	    	  
	    	  parallax: true, 	//패럴랙스 효과 활성화

    	});
    </script>
</body>
</html>