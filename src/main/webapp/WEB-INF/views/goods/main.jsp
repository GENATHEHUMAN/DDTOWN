<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="_csrf" content="${_csrf.token}"/>
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>DDTOWN 굿즈샵</title>
 	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/goods_main.css">
 	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/mainservice_common.css" />
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<style type="text/css">
		.floating-nav {
		    position: fixed;
		    bottom: 100px;
		    right: 24px;
		    z-index: 1000;
		    display: flex;
		    flex-direction: column;
		    gap: 15px;
		}
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
		.main-content-wrapper {
		    background: rgba(255, 255, 255, 0.08); /* 투명한 흰색 배경 (Glassmorphism) */
		    backdrop-filter: blur(12px);           /* 배경 블러 효과 (Glassmorphism) */
		    border-radius: 18px;                   /* 둥근 모서리 (Glassmorphism) */
		    border: 1px solid rgba(255, 255, 255, 0.2); /* 투명한 흰색 테두리 (Glassmorphism) */
		    box-shadow: 0 6px 25px rgba(0, 0, 0, 0.35); /* 깊이감 있는 그림자 (Glassmorphism) */
		    transition: all 0.4s ease;             /* 부드러운 전환 효과 추가 (Glassmorphism) */
		    position: relative;                    /* 필요시 relative 유지 (Glassmorphism) */
		    max-width: 1200px; /* 최대 너비를 설정하여 콘텐츠가 너무 넓게 퍼지지 않도록 합니다. */
		    margin: 40px auto; /* 상단 여백 40px, 좌우 자동 (가운데 정렬), 하단 여백 0 */
		    padding: 30px;
		}
	</style>

</head>
<body>

    <%-- 여기에 communityHeader.jsp를 포함시킵니다. --%>
    <jsp:include page="/WEB-INF/views/modules/communityHeader.jsp" />

    <c:if test="${not empty notice}">
        <div class="shop-notice-bar">
            ✨ ${notice.goodsNotiTitle}
            <hr> 
            <a href="${pageContext.request.contextPath}/goods/notice/detail/${notice.goodsNotiNo}">자세히 보기</a>
            <%-- ✨ 여기를 수정합니다. ✨ --%>
            <span class="separator"> | </span> 
            <a href="${pageContext.request.contextPath}/goods/notice/list" class="more-notices-link">전체 공지 보기</a>
        </div>
    </c:if>

	<div class="main-content-wrapper">
	    <nav class="artist-filter-bar" style="font-size: large;">
	        <button class="filter-btn ${empty artGroupNo || artGroupNo == 0 ? 'active' : ''}" 
	                data-artist-id="all">전체</button>
	        <c:forEach var="artist" items="${artistList}">
	            <button class="filter-btn ${artGroupNo eq artist.artGroupNo ? 'active' : ''}"
	                    data-artist-id="${artist.artGroupNo}">${artist.artGroupNm}</button>
	        </c:forEach>
	    </nav>
	
	    <section class="product-list-section">
	        <div class="product-grid-header">
	            <h2>전체 상품</h2>
	            <div class="sort-options">
	                <select id="sortProducts">
	                    <option value="newest" ${searchType eq 'newest' ? 'selected' : ''}>신상품순</option>
	                    <option value="popularity" ${searchType eq 'popularity' ? 'selected' : ''}>인기순</option>
	                    <option value="priceLowHigh" ${searchType eq 'priceLowHigh' ? 'selected' : ''}>낮은가격순</option>
	                    <option value="priceHighLow" ${searchType eq 'priceHighLow' ? 'selected' : ''}>높은가격순</option>
	                </select>
	            </div>
	        </div>
	
	        <div class="product-grid" id="productGrid">
	            <c:choose>
	                <c:when test="${not empty pagingVO.dataList and pagingVO.totalRecord > 0}">
	                    <c:forEach items="${pagingVO.dataList}" var="goods">
	                        <div class="product-item">
	                            <button class="wish-button ${goods.isWished() ? 'wished' : ''}"
	                                    data-wished="${goods.isWished()}"
	                                    data-goods-no="${goods.goodsNo}">
	                                <i class="fa-heart ${goods.isWished() ? 'fas' : 'far'}"></i>
	                            </button>
	                            <a href="${pageContext.request.contextPath}/goods/detail?goodsNo=${goods.goodsNo}" class="product-link">
	                                <c:choose>
						                <c:when test="${not empty goods.representativeImageUrl}">
						                    <%-- ★★★ 이 부분을 아래와 같이 변경해주세요. (pageContext.request.contextPath 제거) ★★★ --%>
						                    <img src="${goods.representativeImageUrl}" alt="${goods.goodsNm}" class="product-image">
						                </c:when>
						                <c:otherwise>
						                    <img src="https://via.placeholder.com/200?text=No+Image" alt="이미지 없음" class="product-image">
						                </c:otherwise>
						            </c:choose>
	                                <div class="product-info">
	                                    <div>
	                                        <span class="product-artist-tag">${goods.artGroupName}</span>
	                                        <h3 class="product-name">${goods.goodsNm}</h3>
	                                    </div>
	                                    <div class="product-price">
	                                        <fmt:formatNumber value="${goods.goodsPrice}" type="number" />
	                                        <span class="currency">원</span>
	                                    </div>
	                                    <div class="product-status-stock">
	                                        <c:if test="${goods.stockRemainQty <= 0}">
	                                            <span style="color: red; font-weight: bold;">[품절]</span>
	                                        </c:if>
	                                    </div>
	                                </div>
	                            </a>
	                        </div>
	                    </c:forEach>
	                </c:when>
	                <c:otherwise>
	                    <p style="text-align: center; width: 100%; padding: 50px;">등록된 상품이 없습니다.</p>
	                </c:otherwise>
	            </c:choose>
	        </div>
	    </section>
    </div>

    <div class="pagination">
        <%-- ★★★ pagingVO.getGoodsPagingHTML() 메서드 호출 ★★★ --%>
        ${pagingVO.getGoodsPagingHTML(pageContext.request.contextPath)}
    </div>

    <c:set var="cartCount" value="${not empty cartItemCount ? cartItemCount : 0}" />
    <c:set var="wishCount" value="${not empty wishlistItemCount ? wishlistItemCount : 0}" />

    <nav class="floating-nav">
        <a href="${pageContext.request.contextPath}/goods/cart/list" class="floating-btn" id="floatingCartBtn" title="장바구니">
            <i class="fa-solid fa-cart-shopping"></i>
            <span class="item-count-badge" id="cartItemCount" style="display: ${cartCount > 0 ? 'flex' : 'none'};">${cartCount}</span>
        </a>
        <a href="${pageContext.request.contextPath}/goods/wishlist" class="floating-btn" id="floatingWishlistBtn" title="찜목록">
            <i class="fa-solid fa-heart"></i>️
            <span class="item-count-badge" id="wishlistItemCount" style="display: ${wishCount > 0 ? 'flex' : 'none'};">${wishCount}</span>
        </a>

    </nav>
	<div id="footer">
        <!-- FOOTER -->
        <jsp:include page="/WEB-INF/views/modules/communityFooter.jsp" />
        <script src="${pageContext.request.contextPath}/resources/js/pages/communityFooter.js"></script>
        <!-- FOOTER END -->
    </div>
    <script>
    let csrfToken;
    let csrfHeader;
    
    const contextPath = "${pageContext.request.contextPath}";

    document.addEventListener('DOMContentLoaded', function() {
        const csrfMeta = document.querySelector('meta[name="_csrf"]');
        const csrfHeaderMeta = document.querySelector('meta[name="_csrf_header"]');
        if (csrfMeta && csrfHeaderMeta) {
            csrfToken = csrfMeta.content;
            csrfHeader = csrfHeaderMeta.content;
        } else {
            console.error("CSRF meta tags not found. CSRF protection might be disabled or misconfigured.");
        }

        const isUserLoggedIn = <c:out value='${isLoggedIn}' default='false'/>;

        const logoutBtn = document.getElementById('logoutBtn');
        if (logoutBtn) {
            logoutBtn.addEventListener('click', function(event) {
                alert("로그아웃되었습니다.");
            });
        }

        // --- 찜(Wishlist) 기능 스크립트 (변동 없음) ---
        const wishButtons = document.querySelectorAll('.wish-button');

        wishButtons.forEach(button => {
            button.addEventListener('click', function(event) {
                event.preventDefault();

                const goodsNo = this.dataset.goodsNo;
                const isWished = this.dataset.wished === 'true';
                const icon = this.querySelector('i');

                if (!isUserLoggedIn) {
                	Swal.fire({
                        title: '로그인이 필요해요!', // SweetAlert 제목
                        text: '이 기능은 로그인한 사용자만 이용할 수 있습니다. 로그인 페이지로 이동하시겠어요?', // SweetAlert 내용
                        icon: 'warning', // 경고 아이콘 (info, success, error, question 등)
                        showCancelButton: true, // '취소' 버튼 표시
                        confirmButtonText: '로그인 페이지로 이동', // '확인' 버튼 텍스트 변경
                        cancelButtonText: '취소' // '취소' 버튼 텍스트
                    }).then((result) => { // 사용자가 버튼을 클릭했을 때의 결과 처리
                        if (result.isConfirmed) { // 사용자가 '로그인 페이지로 이동' 버튼을 눌렀다면
                            window.location.href = `${contextPath}/login`; // 로그인 페이지로 이동
                        }
                        // 사용자가 '취소' 버튼을 눌렀거나 모달을 닫았다면 아무것도 하지 않음
                    });
                    return; // SweetAlert이 뜨고 나서 바로 함수 종료
                }

                const requestBody = { goodsNo: parseInt(goodsNo) };

                fetch(`${contextPath}/goods/wishlist`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        [csrfHeader]: csrfToken
                    },
                    body: JSON.stringify(requestBody)
                })
                .then(response => {
                    if (!response.ok) {
                         if (response.status === 401) {
                             alert('로그인 세션이 만료되었거나 로그인이 필요합니다.');
                             window.location.href = `${contextPath}/login`;
                         }
                        return response.json().then(errorData => {
                            throw new Error(errorData.message || `서버 오류 발생 (HTTP ${response.status})`);
                        });
                    }
                    return response.json();
                })
                .then(data => {

                    if (data.status === 'success') {
                        if (data.action === 'added') {
                            icon.classList.remove('far');
                            icon.classList.add('fas');
                            button.classList.add('wished');
                            this.dataset.wished = 'true';
                            
                            Swal.fire({
                                title: '상품 찜 완료!',
                                text: '선택하신 상품이 찜 목록에 성공적으로 추가되었습니다.',
                                icon: 'success',
                                confirmButtonText: '확인'
                            });
                        } else if (data.action === 'removed') {
                            icon.classList.remove('fas');
                            icon.classList.add('far');
                            button.classList.remove('wished');
                            this.dataset.wished = 'false';
                            
                         
                            Swal.fire({
                                title: '찜 해제 완료!',
                                text: '선택하신 상품이 찜 목록에서 제거되었습니다.',
                                icon: 'success',
                                confirmButtonText: '확인'
                            });
                        }
                    }
                })
                .catch(error => {
                    console.error('찜 처리 중 오류:', error);
                    
                    Swal.fire({
                        title: '오류 발생',
                        text: '찜 처리 중 오류가 발생했습니다: ' + error.message,
                        icon: 'error',
                        confirmButtonText: '확인'
                    });
                });
            });
        });

     // --- 아티스트 필터 버튼 클릭 스크립트 ---
        const filterButtons = document.querySelectorAll('.artist-filter-bar .filter-btn');
        filterButtons.forEach(button => {
            button.addEventListener('click', function() {
                const artistId = this.dataset.artistId; // 'all' 또는 실제 아티스트 ID (숫자)
                const currentPage = 1; // 필터 변경 시 첫 페이지로 이동

                const urlParams = new URLSearchParams(window.location.search);

                let currentSortType = urlParams.get('searchType') || 'newest';

                urlParams.set('currentPage', currentPage);
                urlParams.set('searchType', currentSortType);

                if (artistId !== 'all') {
                    urlParams.set('artGroupNo', artistId);
                } else {
                    urlParams.delete('artGroupNo');
                }

                urlParams.delete('searchWord');

                if(urlParams.get('searchType') === 'goodsNm' || currentSortType === 'goodsNm') {
                    urlParams.set('searchType', 'newest');
                }

                // 이 부분이 핵심입니다!
                window.location.href = `\${contextPath}/goods/main?\${urlParams.toString()}`;
            });
        });

     // --- 상품 정렬 변경 스크립트 ---
        const sortProductsSelect = document.getElementById('sortProducts');
        if (sortProductsSelect) {
            sortProductsSelect.addEventListener('change', function() {
                const selectedSortType = this.value;
                const currentPage = 1; // 정렬 변경 시 첫 페이지로 이동

                const urlParams = new URLSearchParams(window.location.search);

                let currentArtGroupNo = urlParams.get('artGroupNo') || '';
                let currentSearchWord = urlParams.get('searchWord') || '';

                urlParams.set('currentPage', currentPage);
                urlParams.set('searchType', selectedSortType);

                if (currentArtGroupNo) {
                    urlParams.set('artGroupNo', currentArtGroupNo);
                }

                if (currentSearchWord) {
                    urlParams.set('searchWord', currentSearchWord);
                } else {
                    urlParams.delete('searchWord');
                }

                // 이 부분이 핵심입니다!
                window.location.href = `\${contextPath}/goods/main?\${urlParams.toString()}`;
            });
        }
        
    });
    </script>
</body>
</html>