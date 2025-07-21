<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DDTOWN 직원 포털 - 멤버십 관리</title>
    <%@ include file="../../../modules/headerPart.jsp" %>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.2.0/dist/chartjs-plugin-datalabels.min.js"></script>
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <style>
        .membership-header-bar { display: flex; align-items: center; justify-content: space-between; margin-bottom: 18px; }
        .membership-header-bar .membership-title { font-size: 1.5em; font-weight: 700; color: #234aad; display: flex; align-items: center; gap: 10px; }
        .membership-header-bar .membership-title .management-info { font-size: 0.8em; font-weight: 500; color: #555; display: flex; align-items: center; gap: 4px; }
        .membership-header-bar .membership-title .management-info .fas { font-size: 0.85em; color: #234aad; }
        .membership-search-bar { display: flex; align-items: center; gap: 10px; }
        .membership-search-bar select,
        .membership-search-bar input[type="text"],
        .membership-search-bar button { padding: 7px 10px; border: 1px solid #ccc; border-radius: 4px; font-size: 1em; height: 38px; box-sizing: border-box; }
        .membership-search-bar select { width: auto; min-width: 120px; max-width: 180px; -webkit-appearance: none; -moz-appearance: none; appearance: none;         /* Standard */
        background-image: url('data:image/svg+xml;utf8,<svg fill="%234A4A4A" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>');
        background-repeat: no-repeat; background-position: right 8px center; background-size: 16px; padding-right: 28px; }
    	.membership-search-bar input[type="text"] { flex-grow: 1; min-width: 180px; }
        .membership-search-bar button { background: #1976d2; color: #fff; border: none; cursor: pointer; }
        .membership-info-box { background: #fff; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.05); padding: 24px 30px 18px 30px; margin-bottom: 24px; }
        .membership-info-row { display: flex; align-items: center; gap: 32px; margin-bottom: 18px; }
        .membership-info-row .artist-name { font-size: 1.2em; font-weight: 600; color: #234aad; margin-right: 18px; }
        .membership-info-row .info-label { color: #888; font-size: 0.98em; margin-right: 6px; }
        .membership-info-row .info-value { font-size: 1.1em; font-weight: 600; margin-right: 18px; }
        .membership-chart-box { background: #fff; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.05); padding: 18px 18px 8px 18px; }
        .membership-chart-title { font-size: 1.1em; font-weight: 600; margin-bottom: 8px; color: #234aad; }
    	.status-badge { display: inline-block; padding: 4px 8px; border-radius: 12px; font-size: 0.85em; font-weight: 600; color: #fff; text-align: center; min-width: 50px; box-shadow: 0 1px 3px rgba(0,0,0,0.1);}
    	.status-badge.active {background-color: #28a745;}
    	.status-badge.expired {background-color: #ffc107; color: #333;}
    	.status-badge.canceled {background-color: #dc3545;}
    	.ea-btn {display: inline-flex; align-items: center; justify-content: center; padding: 8px 15px; font-size: 0.9em; font-weight: 500; text-align: center; text-decoration: none;
        border-radius: 4px; cursor: pointer; transition: all 0.2s ease; border: 1px solid transparent; height: 38px; box-sizing: border-box; white-space: nowrap; }
    	.modal-header {font-size: 1.5em; font-weight: 700; color: #234aad; display: flex; align-items: center; gap: 10px; }
    	#responsibleInfo1 { color: #dc3545; font-weight: bold; font-size: 0.9em; }
    	#responsibleInfo2 { color: #dc3545; font-weight: bold; font-size: 0.9em; }
    	.membership-plan-name { font-weight: bold; color: #234aad; font-size: 1.1em; text-align: left !important; }
    	.membership-cards-container { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));  gap: 20px; margin-top: 20px; }

	.membership-card {
	    background: #fff;
	    border-radius: 8px;
	    box-shadow: 0 4px 12px rgba(0,0,0,0.08); /* 그림자 효과 강화 */
	    overflow: hidden; /* 모서리 둥글게 */
	    display: flex;
	    flex-direction: column;
	    transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
	}

	.membership-card:hover {
	    transform: translateY(-5px); /* 호버 시 살짝 위로 이동 */
	    box-shadow: 0 6px 16px rgba(0,0,0,0.12); /* 호버 시 그림자 강화 */
	}

	.card-header {
	    background-color: #eaf1fb; /* 헤더 배경색 */
	    padding: 15px 20px;
	    border-bottom: 1px solid #dcebf7;
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	}

	.card-header .membership-plan-name {
	    margin: 0;
	    font-size: 1.3em;
	    color: #1976d2; /* 플랜명 색상 */
	    display: flex;
	    align-items: center;
	}

	.card-header .card-plan-number {
	    font-size: 0.9em;
	    color: #666;
	    font-weight: 500;
	}

	.card-body {
	    padding: 20px;
	    flex-grow: 1; /* 내용이 많아지면 확장 */
	}

	.card-info-item {
	    margin-bottom: 10px;
	    font-size: 0.95em;
	    color: #444;
	}

	.card-info-item:last-child {
	    margin-bottom: 0;
	}

	.card-info-item strong {
	    color: #234aad;
	    margin-right: 5px;
	}

	.card-footer {
	    padding: 15px 20px;
	    border-top: 1px solid #eee;
	    background-color: #f9f9f9;
	    display: flex;
	    justify-content: flex-end; /* 버튼을 오른쪽으로 정렬 */
	    gap: 10px;
	}

	/* 기존 버튼 스타일도 카드에 맞게 약간 조정될 수 있습니다. */
	.ea-btn.primary {
	    background-color: #234aad; /* 버튼 색상 변경 예시 */
	    border-color: #234aad;
	}
	.ea-btn.danger {
	    background-color: #dc3545;
	    border-color: #dc3545;
	}
	.ea-btn.danger:hover {
	    background-color: #c82333;
	    border-color: #b02a37;
	}

	/* Pagination container를 중앙 정렬하기 */
	.pagination-container {
	    display: flex;
	    justify-content: center;
	    margin-top: 30px;
	    margin-left: auto;
	}
	#membershipDesAddButton {
		margin-left: auto;
	}
	.chart-grid-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); /* 두 개의 차트를 위한 레이아웃 */
        gap: 20px;
        margin-top: 20px; /* 멤버십 카드 목록 아래에 충분한 간격 */
        margin-bottom: 20px;
        align-items: start;
    }
    .chart-box {
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        padding: 15px;
        height: 380px;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        align-items: center;
    }
    .chart-line {
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        padding: 18px;
        height: 380px;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        align-items: center;
    }
    .chart-title {
        font-size: 1.2em;
        font-weight: 600;
        margin-bottom: 20px;
        color: #234aad;
        text-align: center; /* 제목 중앙 정렬 */
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
    }
    #topPopularMembershipsChart {
    max-width: 100%; /* 부모 너비에 맞춤 */
    max-height: calc(100% - 50px); /* 컨테이너 높이에서 제목/패딩 공간 제외 (예상치) */
    display: block; /* 인라인 요소의 여백 문제 방지 */
	}
	.mem { text-decoration: none !important; }
	/* 로그아웃 버튼 css */
	.emp-logout-btn {
		all:unset;
	    color: #ecf0f1;
	    text-decoration: none;
	    display: flex;
	    align-items: center;
	    gap: 0.5rem;
	    padding: 0.6rem 1.2rem;
	    border-radius: 4px;
	    transition: background-color 0.3s;
	    font-size: 0.95rem;
	}

	.emp-logout-btn:hover {
	    background-color: #34495e;
	    color: #3498db;
	}
    </style>
</head>
<body>
    <div class="emp-container">
        <%@ include file="../../modules/header.jsp" %>
        <div class="emp-body-wrapper">
            <%@ include file="../../modules/aside.jsp" %>
            <main class="emp-content" style="position:relative; min-height:600px; font-size: larger;">
   	<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a class="mem" href="#" style="color:black;">아티스트 커뮤니티 관리</a></li>
			<li class="breadcrumb-item"><a class="mem" href="#" style="color:black;">멤버십 관리</a></li>
			<li class="breadcrumb-item active" aria-current="page">멤버십 플랜 목록</li>
		</ol>
	</nav>
    <div class="membership-header-bar">
        <div class="membership-title">멤버십 플랜 목록</div>
        <div class="membership-search-bar">
            <form class="input-group input-group-sm" method="get" id="searchForm" onchange="this.form.submit();">
                <input type="hidden" name="currentPage" value="1" id="currentPage">
                <input type="text" id="searchWord" name="searchWord" value="${pagingVO.searchWord }" class="ea-search-input" placeholder="플랜명을 입력해주세요.">
                <div class="input-group-append">
                    <button type="submit" class="ea-btn primary">
                        <i class="fas fa-search"></i>검색
                    </button>
                </div>
            </form>
        </div>
    </div>
    <hr/>

    <div class="chart-grid-container">
       <div class="chart-box">
           <h4 class="chart-title"><i class="fas fa-star"></i> 인기 멤버십 플랜 Top 3</h4>
           <canvas id="topPopularMembershipsChart"></canvas>
       </div>
       <div class="chart-line">
           <h4 class="chart-title"><i class="fas fa-chart-line"></i> 월별 멤버십 플랜 매출 추이</h4>
           <canvas id="monthlySalesTrendChart"></canvas>
       </div>
   </div>

    <hr/>

    <div class="membership-cards-container">
        <c:if test="${empty pagingVO.dataList }">
            <p class="text-center" style="grid-column: 1 / -1; margin-top: 20px;">멤버십 플랜이 없습니다.</p>
        </c:if>
        <c:forEach var="des" items="${pagingVO.dataList }" varStatus="status">
            <a>
            <div class="membership-card">
                <div class="card-header">
                    <h3 class="membership-plan-name"><i class="fa-solid fa-gem" style="margin-right: 8px; color: #63DEFD;"></i><c:out value="${des.mbspNm}" /></h3>
                    <span class="card-plan-number">No. <c:out value="${des.mbspNo}" /></span>
                </div>
                <div class="card-body">
                    <p class="card-info-item"><strong>아티스트:</strong> <c:out value="${des.artGroupNm}" /></p>
                    <p class="card-info-item"><strong>담당자:</strong> <c:out value="${des.empUsername}" /></p>
                    <p class="card-info-item"><strong>가격:</strong> ₩<fmt:formatNumber value="${des.mbspPrice}" type="number" groupingUsed="true" /></p>
                    <p class="card-info-item"><strong>기간:</strong> <c:out value="${des.mbspDuration}" />일</p>
                    <p class="card-info-item"><strong>등록일:</strong> <fmt:formatDate value="${des.mbspRegDate}" pattern="yyyy-MM-dd" /></p>
                    <p class="card-info-item"><strong>수정일:</strong> <fmt:formatDate value="${des.mbspModDate}" pattern="yyyy-MM-dd" /></p>
                </div>
                <div class="card-footer">
                    <c:if test="${not empty empUsername && (des.empUsername eq empUsername || isAdmin)}">
                        <button type="button" class="ea-btn primary update-btn"
                                data-mbsp-no="${des.mbspNo}"
                                data-mbsp-nm="${des.mbspNm}"
                                data-art-group-no="${des.artGroupNo}"
                                data-art-group-nm="${des.artGroupNm}"
                                data-mbsp-price="${des.mbspPrice}"
                                data-mbsp-duration="${des.mbspDuration}"
                                data-emp-username="${des.empUsername}"
                                data-bs-toggle="modal" data-bs-target="#membershipUpdateModal">
                            <i class="fas fa-edit"></i> 수정
                        </button>
                        <button type="button" class="ea-btn danger delete-btn"
                            data-mbsp-no="${des.mbspNo }"
                            data-mbsp-nm="${des.mbspNm }"
                            data-emp-username="${des.empUsername }">
                            <i class="fas fa-trash-alt"></i> 삭제
                        </button>
                    </c:if>
                </div>
            </div>
            </a>
        </c:forEach>
    </div>
    <div class="d-flex justify-content-between align-items-center mt-3">
	    <div class="pagination-container" id="pagingArea">
	         ${pagingVO.pagingHTML}
	    </div>
	    <a class="ea-btn primary" href="#" id="membershipDesAddButton"><i class="fas fa-plus"></i> 등록 </a>
    </div>
</main>
        </div>
    </div>

    <!-- 멤버십 플랜 생성하는 모달 -->
    <div class="modal fade" id="membershipModal" tabindex="-1" aria-labelledby="membershipModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <div class="modal-title" id="membershipModalLabel">멤버십 플랜 등록</div>
	        <button type="button" class="btn-close" id="closeButton1" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <form>
	          <div class="mb-3">
	            <label for="mbspNm" class="col-form-label">플랜명:</label>
	            <input type="text" class="form-control" id="mbspNm" placeholder="플랜명을 적어주세요.">
	          </div>
	          <div class="mb-3">
	            <label for="artGroupNm" class="col-form-label">아티스트명:</label>
	            <select  class="ea-filter-select" id="artGroupNm" name="artGroupNo"></select>
	          </div>
	          <div class="mb-3">
	            <label for="empUsername" class="col-form-label">담당자:</label>
	            <p id="responsibleInfo1">담당하고 계신 아티스트 그룹(솔로)만 추가해주세요.</p>
	            <input type="text" class="form-control" id="empUsername" value="${empUsername }" readonly>
	          </div>
	          <div class="mb-3">
	            <label for="mbspPrice" class="col-form-label">멤버십 가격:</label>
	            <input type="text" class="form-control" id="mbspPrice" placeholder="가격을 적어주세요. 예) 30000">
	          </div>
	          <div class="mb-3">
	            <label for="mbspDuration" class="col-form-label">멤버십 기간:</label>
	            <input type="text" class="form-control" id="mbspDuration" value="30" placeholder="기준은 30일입니다.">
	          </div>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" id="closeButton2" data-bs-dismiss="modal"><i class="fa-solid fa-xmark"></i> 취소</button>
	        <button type="button" class="btn btn-primary" id="membershipInsert"><i class="fa-solid fa-floppy-disk"></i> 등록</button>
	      </div>
	    </div>
	  </div>
	</div>

	<!-- 모달 수정 -->
	<div class="modal fade" id="membershipUpdateModal" tabindex="-1" aria-labelledby="membershipUpdateModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="modal-title" id="membershipUpdateModalLabel">멤버십 플랜 수정</div>
                    <button type="button" class="btn-close" id="closeButton3" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="mb-3">
                            <label for="updateMbspNm" class="col-form-label">플랜명:</label>
                        	<input type="hidden" id="updateMbspNo">
                        	<input type="hidden" id="originalEmpUsername">
                            <input type="text" class="form-control" id="updateMbspNm" placeholder="플랜명을 적어주세요.">
                        </div>
                        <div class="mb-3">
                            <label for="updateArtGroupNm" class="col-form-label">아티스트명:</label>
                            <input type="hidden" id="hiddenGroupNo" name="updateArtGroupNo">
                            <input type="text" class="form-control" id="updateArtGroupNm" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="updateEmpUsername" class="col-form-label">담당자:</label>
                            <p id="responsibleInfo2">멤버십 플랜 담당자와 관리자만 수정할 수 있습니다.</p>
                            <input type="text" class="form-control" id="updateEmpUsername" value="${empUsername }" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="updateMbspPrice" class="col-form-label">멤버십 가격:</label>
                            <input type="text" class="form-control" id="updateMbspPrice" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="updateMbspDuration" class="col-form-label">멤버십 기간:</label>
                            <input type="text" class="form-control" id="updateMbspDuration" placeholder="기준은 30일입니다.">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" id="closeButton4" data-bs-dismiss="modal"><i class="fa-solid fa-xmark"></i> 취소</button>
                    <button type="button" class="btn btn-primary" id="membershipUpdate"><i class="fa-solid fa-floppy-disk"></i> 수정</button>
                </div>
            </div>
        </div>
    </div>
</body>
<script>

	$(document).ready(function() {
    	 // 현재 로그인한 직원 아이디
        const logEmpUsername = $("#empUsername").val();

       	// csrf 토큰 값
       	const csrfToken = $("meta[name='_csrf']").attr("content");
       	const csrfHeader = $("meta[name='_csrf_header']").attr("content");

       	// 페이징 처리
       	const pagingArea = $('#pagingArea');
	    const searchForm = $('#searchForm');

	    if(pagingArea.length > 0) {
	        pagingArea.on('click', 'a', function(event) {
	            event.preventDefault();
	            const page = $(this).data('page'); // data-page 속성에서 클릭된 페이지 번호 가져옴

	            // 검색폼의 현재 searchType과 searchWord 값을 가져옴
	            const searchType = searchForm.find('select[name="searchType"]').val();
	            const searchWord = searchForm.find('input[name="searchWord"]').val();

	            // 페이지 이동을 위한 URL
	            let targetPageUrl = '${pageContext.request.contextPath}/emp/membership/des/list?currentPage=' + page;


	            if (searchType && searchWord && searchWord.trim() !== '') {
	                targetPageUrl += '&searchType=' + encodeURIComponent(searchType);
	                targetPageUrl += '&searchWord=' + encodeURIComponent(searchWord);
	            }
	            window.location.href = targetPageUrl;
	        });
	    }

	    searchForm.on('submit', function(e) {
	    	$('#currentPage').val(1);
	    });

	 // 사이드바 메뉴 토글 기능 (jQuery로 변경)
	    $('.emp-sidebar .emp-nav-item.has-submenu').on('click', function(event) {
	        if ($(this).attr('href') === '#') {
	            event.preventDefault();
	        }
	        const $parentLi = $(this).parent();
	        const $submenu = $(this).next('.emp-submenu');

	        if ($submenu.length) {
	            const $parentUl = $parentLi.parent();
	            if ($parentUl.length) {
	                $parentUl.children().not($parentLi).find('.emp-nav-item.has-submenu.open').each(function() {
	                    $(this).removeClass('open');
	                    $(this).next('.emp-submenu').css('display', 'none');
	                    $(this).find('.submenu-arrow').css('transform', 'rotate(0deg)');
	                });
	            }
	        }

	        $(this).toggleClass('open');
	        if ($submenu.length) {
	            $submenu.css('display', $(this).hasClass('open') ? 'block' : 'none');
	            $(this).find('.submenu-arrow').css('transform', $(this).hasClass('open') ? 'rotate(90deg)' : 'rotate(0deg)');
	        }
	    });

	    // 현재 페이지 URL 기반으로 사이드바 메뉴 활성화 및 펼침 (jQuery로 변경)
	    const currentFullHref = window.location.href;
	    $('.emp-sidebar .emp-nav-item[href]').each(function() {
	        const linkHrefAttribute = $(this).attr('href');
	        if (linkHrefAttribute && linkHrefAttribute !== "#" && currentFullHref.endsWith(linkHrefAttribute)) {
	            $(this).addClass('active');
	            let $currentActiveElement = $(this);
	            while (true) {
	                const $parentLi = $currentActiveElement.parent();
	                if (!$parentLi.length) break;
	                const $parentSubmenuUl = $parentLi.closest('ul.emp-submenu');
	                if ($parentSubmenuUl.length) {
	                    $parentSubmenuUl.css('display', 'block');
	                    const $controllingAnchor = $parentSubmenuUl.prev('a.has-submenu');
	                    if ($controllingAnchor.length) {
	                        $controllingAnchor.addClass('active open');
	                        $controllingAnchor.find('.submenu-arrow').css('transform', 'rotate(90deg)');
	                        $currentActiveElement = $controllingAnchor;
	                    } else { break; }
	                } else { break; }
	            }
	        }
	    });

	 	// 멤버십 플랜 생성 모달 이벤트
        $("#membershipDesAddButton").on("click", function(e){
        	e.preventDefault();

        	// 모달 필드 초기화
        	$("#mbspNm").val('');
            $("#artGroupNm").val(''); // 드롭다운 초기화
            $("#mbspPrice").val('');
            $("#mbspDuration").val('30'); // 기본값
        	$("#membershipModal").modal('show');	// bootstrap 모달 열기
        });

        // 멤버십 플랜 모달 닫기 이벤트
        $("#closeButton1").on("click", function(e) {
        	e.preventDefault();
        	$("#membershipModal").modal('hide')
        });
        $("#closeButton2").on("click", function(e) {
        	e.preventDefault();
        	$("#membershipModal").modal('hide')
        });

     	// 모달이 열릴 때 (show.bs.modal 이벤트 발생 시) 아티스트명 드롭다운 채우기
        $("#membershipModal").on("show.bs.modal",function(){

        	$.ajax({
        		url: "${pageContext.request.contextPath}/emp/membership/des/api/artist-groups/all",
        		method: "GET",
        		dataType: "json",
        		success: function(res) {

        			const artGroupSelect = $("#artGroupNm");	// <select> 태그 아이디
        			artGroupSelect.empty();	// 초기화

        			artGroupSelect.append($('<option>', {
        				value: '',
        				text: '아티스트 그룹을 선택해주세요.',
        				selected: true,
        				disabled: true
        			}));

        			// 서버에서 받은 response 데이터를 반복하여 <option>요소 생성
        			$.each(res, function(index, artistGroup) {
        				artGroupSelect.append($('<option>', {
        					value: artistGroup.artGroupNo,		// option의 실제 값 (db에 저장되는 아이디)
        					text: artistGroup.artGroupNm,		// 표시될 텍스트
        					'data-emp-username': artistGroup.empUsername
        				}));
        			});
        		},
        		error: function(xhr, status, error) {
        			alert("아티스트 그룹 목록을 불러오는데 실패했습니다. 관리자에게 문의해주세요.");
        		}
        	});
        });

     	// 가격 입력 필드에 쉼표 자동 추가 (등록 모달용)
        $("#mbspPrice").on("input", function() {
            let value = $(this).val();
            value = value.replace(/[^0-9]/g, '');
            if (value) {
                value = new Intl.NumberFormat('ko-KR').format(parseInt(value));
            }
            $(this).val(value);
        });

    	// 모달 등록 버튼 폼 전송
        $("#membershipInsert").on("click", function() {
        	const mbspNm = $("#mbspNm").val();
        	const artGroupNo = $("#artGroupNm").val();
        	let mbspPrice = $("#mbspPrice").val().replace(/,/g, '');	// 쉼표 제거
        	const mbspDuration = $("#mbspDuration").val();
        	const empUsername =  $("#empUsername").val();

        	// 선택된 아티스트 그룹의 담당자 아이디 가져오기
        	const selectedEmpUsername = $("#artGroupNm option:selected").data('emp-username');

        	// 1차 유효성 검사
        	if(!mbspNm || !artGroupNo || !mbspPrice || !mbspDuration) {
        		Swal.fire({
                    icon: 'warning',
                    title: '필수 정보 누락',
                    text: '모든 필수 정보를 입력해주세요!',
                    confirmButtonText: '확인'
                });
                return;;
        	}

        	// 담당자 아이디 비교 로직
        	if(selectedEmpUsername !== logEmpUsername) {
        		Swal.fire({
        			icon: 'error',
        			title: '권한 없음',
        			text: '선택하신 아티스트 그룹의 담당자가 아닙니다.',
        			confirmButtonText: '확인'
        		});
        		return;
        	}

        	// db에 보낼 데이터 객체 생성
        	const requestData = {
        			mbspNm: mbspNm,
        			artGroupNo: artGroupNo,
        			mbspPrice: parseInt(mbspPrice),
        			mbspDuration: parseInt(mbspDuration),
        			empUsername: empUsername,
        	};

        	$.ajax({
        		url: "${pageContext.request.contextPath}/emp/membership/des/register",
        		method: "POST",
        		contentType: "application/json",
        		data: JSON.stringify(requestData),
        		processData: false,
        		beforeSend: function(xhr) {
        			xhr.setRequestHeader(csrfHeader, csrfToken);
        		},
        		success: function(res) {
        			if(res.success) {
        				Swal.fire({
        					icon: 'success',
        					title: '등록 성공',
        					text: res.message,
        					confirmButtonText: '확인'
        				}).then((result) => {
        					$("#membershipModal").modal('hide');
        					window.location.reload();
        				});
        			} else {
        				Swal.fire({
                            icon: 'error',
                            title: '등록 실패',
                            text: "멤버십 플랜 등록 실패: " + res.message,
                            confirmButtonText: '확인'
                        });
        			}
        		},
        		error: function(xhr, status, error) {
        			console.log("멤버십 플랜 등록중 AJAX 오류: ", status, error, xhr);
        			Swal.fire({
                        icon: 'error',
                        title: '오류 발생',
                        text: '멤버십 플랜 등록 중 오류가 발생했습니다. 관리자에게 문의해주세요.',
                        confirmButtonText: '확인'
                    });
        		}
        	});
        });

    	// 플랜 수정 모달 클릭 시
    	$("#membershipUpdateModal").on("show.bs.modal",function(e) {
    		const button = $(e.relatedTarget);


    		const mbspNo = button.data('mbsp-no');
            const mbspNm = button.data('mbsp-nm');
            const artGroupNo = parseInt(button.data('art-group-no'));
            const artGroupNm = button.data('art-group-nm');
            const mbspPrice = button.data('mbsp-price');
            const mbspDuration = button.data('mbsp-duration');
            const originalEmpUsername = button.data('emp-username');

         	// 모달 필드에 데이터 채우기
            $("#updateMbspNo").val(mbspNo);
            $("#updateMbspNm").val(mbspNm);
            $("#updateMbspPrice").val(new Intl.NumberFormat('ko-KR').format(mbspPrice));
            $("#updateMbspDuration").val(mbspDuration);
            $("#originalEmpUsername").val(originalEmpUsername);
            $("#updateEmpUsername").val(logEmpUsername);

            $('#hiddenGroupNo').val(artGroupNo);
            $('#updateArtGroupNm').val(artGroupNm);
        });

     	// 가격 입력 필드에 쉼표 자동 추가 (수정 모달용)
        $("#mbspPrice").on("input", function() {
            let value = $(this).val();
            value = value.replace(/[^0-9]/g, '');
            if (value) {
                value = new Intl.NumberFormat('ko-KR').format(parseInt(value));
            }
            $(this).val(value);
        });

     	// 멤버십 플랜 수정 버튼 클릭 이벤트
        $("#membershipUpdate").on("click", function() {
            const mbspNo = $("#updateMbspNo").val();
            const mbspNm = $("#updateMbspNm").val();
            const artGroupNo = $("#hiddenGroupNo").val();
            const mbspPrice = $("#updateMbspPrice").val().replace(/,/g, '');
            const mbspDuration = $("#updateMbspDuration").val();
            const originalEmpUsername = $("#originalEmpUsername").val();

            if(!mbspNm || !artGroupNo || !mbspPrice || !mbspDuration || !mbspNo) {
                Swal.fire({ icon: 'warning', title: '필수 정보 누락', text: '모든 필수 정보를 입력해주세요!', confirmButtonText: '확인' });
                return;
            }

            const requestData = {
                mbspNo: mbspNo,
                mbspNm: mbspNm,
                artGroupNo: artGroupNo,
                mbspPrice: parseInt(mbspPrice),
                mbspDuration: parseInt(mbspDuration),
                empUsername: logEmpUsername
            };

            $.ajax({
                url: "${pageContext.request.contextPath}/emp/membership/des/update",
                method: "POST",
                contentType: "application/json",
                data: JSON.stringify(requestData),
                processData: false,
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                },
                success: function(res) {
                    if(res.success) {
                        Swal.fire({ icon: 'success', title: '수정 성공', text: res.message, confirmButtonText: '확인' }).then(() => {
                            $("#membershipUpdateModal").modal('hide');
                            window.location.reload();
                        });
                    } else {
                        Swal.fire({ icon: 'error', title: '수정 실패', text: "멤버십 플랜 수정 실패: " + res.message, confirmButtonText: '확인' });
                    }
                },
                error: function(xhr, status, error) {
                    console.error("멤버십 플랜 수정 중 AJAX 오류: ", status, error, xhr);
                    Swal.fire({ icon: 'error', title: '오류 발생', text: '멤버십 플랜 수정 중 오류가 발생했습니다. 관리자에게 문의해주세요.', confirmButtonText: '확인' });
                }
            });
        });

     	// 플랜 삭제 기능
     	// 동적으로 추가되는 버튼에 대한 이벤트 위해 'body'에 위임
     	$('body').on('click', '.delete-btn', function() {
     		const button = $(this);
     		const mbspNo = button.data('mbsp-no');
     		const mbspNm = button.data('mbsp-nm');
     		const originalEmpUsername = button.data('emp-username');

     		Swal.fire({
     			title: '플랜 삭제',
     			html: `"\${mbspNm}" 플랜을 정말 삭제하시겠습니까?<br>삭제 후 복구할 수 없습니다.`,
     			icon: 'warning',
     			showCancelButton: true,
     			confirmButtonText: '삭제',
     			cancelButtonText: '취소'
     		}).then((result) => {
     			if(result.isConfirmed) {
     				$.ajax({
     					url: "${pageContext.request.contextPath}/emp/membership/des/delete/" + mbspNo,
     					method: "POST",
     					beforeSend: function(xhr) {
     						xhr.setRequestHeader(csrfHeader, csrfToken);
     					},
     					success: function(res) {
     						if(res.success) {
     							Swal.fire({
         							icon: 'success',
         							title: '삭제 성공',
         							text: res.message,
         							confirmButtonText: '확인'
         						}).then(() => {
         							window.location.reload();
         						});
     						} else {
     							Swal.fire({
         							icon: 'error',
         							title: '삭제 실패',
         							text: res.message,
         							confirmButtonText: '확인'
         						}).then(() => {
         							window.location.reload();
         						});
     						}
     					},
     					error: function(xhr, status, error) {
     						console.error("멤버십 플랜 삭제 중 AJAX 오류: ", status, error, xhr);
                            Swal.fire({
                                icon: 'error',
                                title: '오류 발생',
                                text: '멤버십 플랜 삭제 중 오류가 발생했습니다. 관리자에게 문의해주세요.',
                                confirmButtonText: '확인'
                            });
     					}
     				});
     			}
     		});
     	});

     	// ================ 통계용 ================
     	// top3 인기 멤버십 플랜 차트
     	fetch('${pageContext.request.contextPath}/emp/membership/des/chartData/topPopularMemberships')
     		.then(response => response.json())
     		.then(TopPopularMembershipsChartData => {
     			const labels = TopPopularMembershipsChartData.map(item => item.mbspNm);				// 멤버십 플랜 이름
     			const counts = TopPopularMembershipsChartData.map(item => item.totalSalesCount);		// 판매량
     			const ctx1 = document.getElementById('topPopularMembershipsChart').getContext('2d');
     			new Chart(ctx1, {
     				type: 'doughnut',
     				data: {
     					labels: labels,
     					datasets: [{
     						label: '판매량',
     						data: counts,
     						backgroundColor: [
     							'rgba(255, 99, 132, 0.6)', // 빨강
                                'rgba(54, 162, 235, 0.6)', // 파랑
                                'rgba(255, 206, 86, 0.6)'  // 노랑
     						],
     						borderColor: [					// 선색상
     							'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 206, 86, 1)'
     						],
     						borderWidth: 1
     					}]
     				},
     				plugins :[ChartDataLabels],
     				options: {
     					responsive: true,
     					plugins: {
     						datalabels: {
     						    color: function(context) {
     						    	const index = context.dataIndex;
     						    	if(index === 0 || index === 1) {
     						    		return '#fff';
     						    	} else {
     						    		return '#333';
     						    	}
     						    },
     						    font: {
     						        weight: 'bold',
     						        size: 16
     						    },
     						    backgroundColor: function(context) {
     						    	const index = context.dataIndex;
     						    	const labelBackgrounds = [
     						    		'rgba(255, 99, 132, 0.8)', // 1위 (빨강)
     	                                'rgba(54, 162, 235, 0.8)', // 2위 (파랑)
     	                                'rgba(255, 206, 86, 0.8)'  // 3위 (노랑)
     						    	];
     						    	return labelBackgrounds[index];
     						    },
     						   	borderColor: function(context) {
     	                            const index = context.dataIndex;
     	                            // 차트 조각의 테두리색과 동일하게 사용
     	                            const labelBorders = [
     	                                'rgba(255, 99, 132, 1)',
     	                                'rgba(54, 162, 235, 1)',
     	                                'rgba(255, 206, 86, 1)'
     	                            ];
     	                            return labelBorders[index];
     	                        },
     						    borderWidth: 1,
     						    borderRadius: 50,
     						    padding: {
     						    	top: 6,
          							bottom: 6,
          							left: 6,
          							right: 6
     						    },
     						    formatter: function(value, context) {
     						    	// 판매량과 함께 퍼센트도 표시
     	                            const total = context.chart.data.datasets[0].data.reduce((a, b) => a + b, 0);
     	                            const percentage = ((value / total) * 100).toFixed(1); // 소수점 첫째 자리까지
     	                            return `\${value}명 (\${percentage}%)`;
     						    },
     						    anchor: 'center',
     						    align: 'center',
     						    offset: 4,
     						    clamp: true,
     						},
     						legend: { position: 'top' },
     						title: { display: false, text: 'Top 3 인기 멤버십 플랜' },
     						tooltip: {
     							callbacks: {
     								label: function(context) {
     									let label = context.label || '';
     									if(label) { label += ': '; }
     									if(context.parsed !== null) { label += context.parsed + '명'; }
     									return label;
     								}
     							}
     						},

     					}
     				}
     			});
     		})
     		.catch(error => console.error('Error fetching TopPopularMembershipsChartData: ', error));

     		// 월별 멤버십 매출 추이 차트
     		fetch('${pageContext.request.contextPath}/emp/membership/des/chartData/monthlySalesTrend')
     			.then(response => response.json())
     			.then(monthlySalesTrendChartData => {

     				// 데이터를 월별로 그룹화하여 각 멤버십 플랜 매출 합산
     				const allMonths = [...new Set(monthlySalesTrendChartData.map(item => item.saleMonth))].sort();	// 모든 월 정렬

     				const datasets = {};	// 각 멤버십 플랜별 데이터셋 저장할 객체

     				monthlySalesTrendChartData.forEach(item => {
     					if(!datasets[item.mbspNm]) {
     						// 새로운 멤버십 플랜 데이터셋 초기화
     						const randomBaseColor = getRandomColorBase();
     						datasets[item.mbspNm] = {
     								label: item.mbspNm,
     								data: new Array(allMonths.length).fill(0),
     								borderColor: randomBaseColor,
     								backgroundColor: 'rgba(0,0,0,0)',
     								tension: 0.1,
     								fill: true
     						};
     					}
     					// 해당 월의 인덱스 찾아 데이터 업데이트
     					const monthIndex = allMonths.indexOf(item.saleMonth);
     					if(monthIndex !== -1) {
     						datasets[item.mbspNm].data[monthIndex] += item.monthlySalesAmount;
     					}
     				});

     				// datasets 객체 배열로 변환
     				const chartDatasets = Object.values(datasets);

     				const ctx2 = document.getElementById('monthlySalesTrendChart').getContext('2d');
     				new Chart(ctx2, {
     					type: 'line',
     					data: {
     						labels: allMonths,	// x축 라벨 (월)
     						datasets: chartDatasets
     					},
     					options: {
     						responsive: true,
     						plugins: {
     							legend: {
     								position: 'top',
     							},
     							title: {
     								display: false
     							},
     							tooltip: {
     								callbacks: {
     									label: function(context) {
     										let label = context.dataset.label || '';
     										if(label) {
     											label += ': ';
     										}
     										if(context.parsed.y !== null) {
     											label += context.parsed.y + '원';
     										}
     										return label;
     									}
     								}
     							},
     							datalabels: {
     								color: '#333',
     								font: {
     									weight: 'bold',
     									size: 10
     								},
     								formatter: function(value, context) {
     									return value + '원';
     								},
     								display: true
     							}
     						},
     						scales: {
     							x: {
     								title: {
     									display: true,
     									text: '월'
     								}
     							},
     							y: {
     								title: {
     									display: true,
     									text: '매출액 (원)'
     								},
     								beginAtZero: true
     							}
     						}
     					}
     				});
     			})
     			.catch(error => console.error('Error fetching MonthlySalesTrendChartData: ', error));

     		// 랜덤 색상 생성 함수 (여러 개의 라인이 있을 때 유용)
     		function getRandomColorBase() {
     		    const r = Math.floor(Math.random() * 200); // 겹치지 않게 약간 밝게
     		    const g = Math.floor(Math.random() * 200);
     		    const b = Math.floor(Math.random() * 200);
     		    return `rgba(\${r},\${g},\${b},0.8)`;
     		}
	});
    </script>
</html>