<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 취소 - DDTOWN 관리자 시스템</title>
 	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/admin_refund.css">
 	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/admin_cancel.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <%@ include file="../../../modules/headerPart.jsp" %>
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style type="text/css">
	    /* admin_cancel.css 또는 <style> 태그 내부에 추가 */
	
	/* 뱃지 버튼들을 담는 컨테이너 */
	.filter-buttons {
	    display: flex;
	    flex-wrap: wrap;
	    align-items: center;
	    width: 100%;
	}
	
	/* 모든 필터 뱃지 버튼에 공통적으로 적용될 기본 스타일 */
	.status-filter-badge {
	    display: inline-flex;
	    align-items: center;
	    justify-content: center;
	    font-weight: 700;
	    line-height: 1;
	    text-align: center;
	    white-space: nowrap;
	    vertical-align: middle;
	    border-radius: 1rem;
	    color: #fff;
	    margin-right: 7px;
	    cursor: pointer;
	    border: none;
	    text-decoration: none;
	    min-height: 32px;
	    transition: all 0.2s ease-in-out;
	}
	
	/* 1. "전체" 필터 뱃지 - 파란색 */
	.status-filter-badge.status-filter-all {
	    background-color: #0d6efd; /* Bootstrap primary blue */
	}
	
	/* 2. 각 취소 상태 코드에 따른 배경색 정의 */
	/* CSC001: 취소 요청 접수 */
	.status-filter-badge.status-cancel-csc001 {
	    background-color: #ffc107; /* warning (노랑) */
	    color: #212529; /* 글자색 검정 */
	}
	/* CSC002: 취소 처리중 */
	.status-filter-badge.status-cancel-csc002 {
	    background-color: #6c757d; /* secondary (회색) */
	}
	/* CSC003: 취소 완료 */
	.status-filter-badge.status-cancel-csc003 {
	    background-color: #20c997; /* teal */
	}
	
	/* 선택된 필터 버튼의 스타일 (강조 효과) */
	.status-filter-badge.active {
	    filter: brightness(1.15);
	}
	
	/* 마우스 호버 시 효과 */
	.status-filter-badge:hover {
	    filter: brightness(0.9);
	    transform: translateY(-1px);
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	}
	
	/* 뱃지 내부의 숫자 스타일 */
	.status-count {
	    margin-left: 5px;
	    font-weight: 700;
	}
	
	/* 테이블 내 취소/환불 상태 뱃지 스타일 */
	.refund-status-badge {
	    display: inline-block;
	    font-size: medium;
	    font-weight: 600;
	    line-height: 1;
	    text-align: center;
	    white-space: nowrap;
	    vertical-align: baseline;
	    color: #fff;
	}
	.refund-status-badge.status-CSC001 { background-color: #ffc107; color: #212529; } /* 취소 요청 접수 (노랑) */
	.refund-status-badge.status-CSC002 { background-color: #6c757d; } /* 취소 처리중 (회색) */
	.refund-status-badge.status-CSC003 { background-color: #20c997; } /* 취소 완료 (청록) */
	
	/* 테이블 내 취소/환불 유형 뱃지 스타일 (필요하다면) */
	/* 예시: */
	.CANCEL {
	    background-color: #dc3545; /* 빨강 */
	    color: #fff;
	    padding: .2em .5em;
	    border-radius: .25rem;
	}
	.REFUND {
	    background-color: #0dcaf0; /* 하늘 */
	    color: #212529;
	    padding: .2em .5em;
	    border-radius: .25rem;
	}
	
	/* 차트 컨테이너 스타일 */
    .chart-container-flex {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-around; /* 차트들이 적절히 공간을 배분하도록 */
        gap: 20px; /* 차트 사이 간격 */
        margin-bottom: 30px; /* 차트와 테이블 사이 간격 */
    }

    .chart-box {
        background-color: #fff;
        border: 1px solid #e0e0e0;
        border-radius: 8px;
        padding: 20px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        width: 48%; /* 2개씩 나열 */
        min-width: 350px; /* 너무 작아지지 않도록 최소 너비 설정 */
        box-sizing: border-box; /* 패딩 포함 너비 계산 */
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .chart-box h4 {
        margin-top: 0;
        margin-bottom: 15px;
        color: #333;
        font-size: 1.1em;
    }
    /* 캔버스 자체 스타일 (Chart.js 옵션으로도 제어 가능) */
    .chart-box canvas {
        max-width: 100%;
        height: 300px !important; /* Chart.js height는 중요도를 높여서 설정 */
    }

    /* 미디어 쿼리: 작은 화면에서 차트가 세로로 쌓이도록 */
    @media (max-width: 992px) {
        .chart-box {
            width: 90%; /* 한 줄에 하나씩 */
        }
    }
    
    /* admin_order.css 또는 <style> 태그 내에 추가 */
	.ea-section-header h2 {
	    white-space: nowrap; /* 텍스트가 줄바꿈되지 않도록 강제 */
	    margin-right: 20px; /* h2와 필터 버튼 사이 간격 유지 (필요시) */
	}
	.ea-table th, .ea-table td {
		font-size: large;
	}
    </style>
</head>
<body>
    <div class="emp-container">
        <%@ include file="../../modules/header.jsp" %>

        <div class="emp-body-wrapper">
            <%@ include file="../../modules/aside.jsp" %>
            <main class="emp-content" style="font-size: large;">
            	<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/admin/goods/cancelRefund/list" style="color:black;">굿즈샵 관리</a></li>
                        <li class="breadcrumb-item active" aria-current="page">주문 취소 관리</li>
                    </ol>
                </nav>
                <div class="ea-section">
                    <div class="ea-section-header">
                        <h2>주문 취소 관리</h2>
                        
	                    <div class="filter-sub-group filter-buttons">
					        <button type="button" class="status-filter-badge status-filter-all ${param.statusCode == null || param.statusCode == '' ? 'active' : ''}" data-status-code="">
					            전체 <span class="status-count"></span> </button>
					        <button type="button" class="status-filter-badge status-cancel-csc001 ${param.statusCode eq 'CSC001' ? 'active' : ''}" data-status-code="CSC001">
					            요청 <span class="status-count"></span>
					        </button>
					        <button type="button" class="status-filter-badge status-cancel-csc002 ${param.statusCode eq 'CSC002' ? 'active' : ''}" data-status-code="CSC002">
					            처리 중 <span class="status-count"></span>
					        </button>
					        <button type="button" class="status-filter-badge status-cancel-csc003 ${param.statusCode eq 'CSC003' ? 'active' : ''}" data-status-code="CSC003">
					            완료 <span class="status-count"></span>
					        </button>
					    </div>
                    </div>
				                    
				<form id="searchForm" action="/admin/goods/cancelRefund/list" method="get" class="search-filter-controls" style="margin-bottom:20px;">
				    <input type="hidden" name="currentPage" id="currentPage" value="${pagingVO.currentPage}" />
				    <input type="hidden" id="cancelStatusCodeFilter" name="statusCode" value="${param.statusCode}">
				
				    <div class="filter-sub-group date-filter-group">
				        <input type="date" id="orderDateStart" name="orderDateStart" class="ea-date-input" value="${param.orderDateStart}">
				        <span>~</span>
				        <input type="date" id="orderDateEnd" name="orderDateEnd" class="ea-date-input" value="${param.orderDateEnd}">
				    </div>
				    <div class="filter-sub-group">
				        <input type="text" id="searchKeyword" name="searchKeyword" class="ea-search-input" 
				               placeholder="회원ID, 주문번호, 상품명 검색" value="${param.searchKeyword}">
				    </div>
			
				    
				    <div class="filter-sub-group search-group">
				        <button type="submit" id="searchButton" class="ea-btn"><i class="fas fa-search"></i> 검색</button>
<!-- 				        <button type="button" id="resetButton" class="ea-btn" onclick="resetSearchForm()">초기화</button> -->
				    </div>
				</form>
				
				<div class="chart-container-flex">
                    <div class="chart-box">
                        <h4>취소/환불 상태 현황</h4>
                        <canvas id="cancelStatusChart"></canvas>
                    </div>
                    <div class="chart-box">
                        <h4>취소/환불 사유별 비율 (TOP 5)</h4>
                        <canvas id="cancelReasonChart"></canvas>
                    </div>
                    <div class="chart-box" style="width: 98%;"> <%-- 일별 취소는 가로로 길게 --%>
                        <h4>일별 취소 요청 건수</h4>
                        <canvas id="dailyCancelChart"></canvas>
                    </div>
                </div>
                    
                    <table class="ea-table" id="cancelRefundTable" style="font-size: large;">
                        <thead>
                            <tr style="white-space: nowrap;">
                                <th>취소번호</th>
                                <th>상태</th>
                                <th>상품명</th>
                                <th>유형</th>
                                <th>주문번호</th>
                                <th>회원ID</th>
                                <th>요청일</th>
                                <th>처리일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty pagingVO.dataList}">
                                    <c:forEach var="cancel" items="${pagingVO.dataList}">
                                        <tr>
                                            <td>
                                                <c:url var="detailLink" value="/admin/goods/cancelRefund/detail">
                                                    <c:param name="cancelNo" value="${cancel.cancelNo}"/>
                                                    <c:param name="currentPage" value="${pagingVO.currentPage}"/>
                                                    <c:param name="searchKeyword" value="${param.searchKeyword}"/>
                                                    <c:param name="statusCode" value="${param.statusCode}"/>
                                                </c:url>
                                                ${cancel.cancelNo}
                                            </td>
                                            
                                            
                                            <td>
                                                <span class="refund-status-badge status-${cancel.cancelStatCode}">
                                                    ${cancel.cancelStatName}
                                                </span>
                                            </td>
                                            
                                            <td>
                                            <a href="${detailLink}" class="btn btn-info" style="font-size: large;">${cancel.goodsNm}
											    <c:if test="${cancel.otherGoodsCount != null && cancel.otherGoodsCount > 0}" >
											        외 ${cancel.otherGoodsCount}건
											    </c:if></a>
											</td>
                                            <td>
                                                <span class="${cancel.cancelType}" style="white-space: nowrap;">
                                                    ${cancel.cancelTypeName}
                                                </span>
                                            </td>
                                            <td>${cancel.orderNo}</td>
                                            <td style="text-align: left;">${cancel.memUsername}</td>
                                            
                                            
                                            <td><fmt:formatDate value="${cancel.cancelReqDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                            <td><fmt:formatDate value="${cancel.cancelResDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="9" class="text-center">조회된 취소/환불 내역이 없습니다.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>

                    <div class="d-flex justify-content-center ea-pagination" id="paginationArea">
                        ${pagingVO.pagingHTML}
                    </div>

                </div>
            </main>
        </div>
    </div>
<%@ include file="../../../modules/footerPart.jsp" %>
<%@ include file="../../../modules/sidebar.jsp" %>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const searchForm = document.getElementById("searchForm");
        const currentPageInput = document.getElementById("currentPage");
        const paginationArea = document.getElementById("paginationArea");
        const cancelStatusCodeFilterInput = document.getElementById("cancelStatusCodeFilter");
        const statusFilterBadges = document.querySelectorAll(".status-filter-badge");
		
        const searchKeywordInput = document.getElementById("searchKeyword");
        const searchButton = document.getElementById("searchButton");

        const orderDateStartInput = document.getElementById("orderDateStart"); // 날짜 시작
        const orderDateEndInput = document.getElementById("orderDateEnd");     // 날짜 끝
        
        if (paginationArea) {
            paginationArea.addEventListener("click", function(e) {
                e.preventDefault();
                const clickedElement = e.target.closest(".page-link");
                if (clickedElement && clickedElement.dataset.page) {
                    currentPageInput.value = clickedElement.dataset.page;
                    searchForm.submit();
                }
            });
        }
        
        

     // ⭐ 뱃지 필터링 처리 수정 ⭐
        statusFilterBadges.forEach(badge => {
            badge.addEventListener('click', function() {
                const statusCode = this.dataset.statusCode;
                cancelStatusCodeFilterInput.value = statusCode;
                currentPageInput.value = 1;
                // ⭐ 뱃지 클릭 시 검색어 초기화 ⭐
                searchKeywordInput.value = ''; // 검색어 초기화
                searchForm.submit();
            });
        });

        // ⭐ 검색 버튼 클릭 시 처리 수정 ⭐
        if (searchButton) {
            searchButton.addEventListener('click', function(e) {
                // e.preventDefault(); // submit 이벤트를 막지 않고, 필터 초기화만 합니다.
                currentPageInput.value = 1;
                // ⭐ 검색 버튼 클릭 시 상태 필터 초기화 ⭐
                cancelStatusCodeFilterInput.value = ''; // 상태 필터 초기화
                // searchForm.submit(); // 버튼이 type="submit" 이므로 직접 호출할 필요 없음
            });
        }
        
     // ⭐⭐⭐ 변경된 뱃지 카운트 업데이트 로직 ⭐⭐⭐
        // 컨트롤러에서 JSON 문자열로 넘겨받은 데이터를 파싱합니다.
        // ${cancelStatusCountsJson} 은 서버에서 변환된 JSON 문자열입니다.
        const cancelStatusCountsData = JSON.parse('${cancelStatusCountsJson}');
        const totalAllCancelRefundCount = ${totalAllCancelRefundCount};

        // 각 뱃지 버튼을 순회하며 카운트 업데이트
        statusFilterBadges.forEach(badge => {
            const statusCode = badge.dataset.statusCode;
            let countSpan = badge.querySelector('.status-count');
            
            if (countSpan) {
                if (statusCode === '') { // "전체" 뱃지인 경우
                    countSpan.textContent = totalAllCancelRefundCount + '건';
                } else { // 특정 상태 코드 뱃지인 경우
                    // JSON 파싱된 객체에서 해당 상태 코드의 카운트를 찾아 할당
                    if (cancelStatusCountsData && cancelStatusCountsData[statusCode] !== undefined && cancelStatusCountsData[statusCode] !== null) {
                         countSpan.textContent = cancelStatusCountsData[statusCode] + '건';
                    } else {
                         countSpan.textContent = 0 + '건';
                    }
                }
            }
        });
        // ⭐⭐⭐ 변경된 뱃지 카운트 업데이트 로직 끝 ⭐⭐⭐
		// --- ⭐⭐⭐ 차트 초기화 시작 ⭐⭐⭐ ---

        // 1. 취소/환불 상태 차트
        const cancelStatusCtx = document.getElementById('cancelStatusChart').getContext('2d');
        const statusLabels = [];
        const statusCounts = [];
        const statusColors = {
            'CSC001': 'rgb(255, 193, 7)',   // 취소 요청 접수 (warning - 노랑)
            'CSC002': 'rgb(108, 117, 125)', // 취소 처리중 (secondary - 회색)
            'CSC003': 'rgb(32, 201, 151)'   // 취소 완료 (teal - 청록)
        };
        const statusDisplayNames = {
            'CSC001': '취소 요청 접수',
            'CSC002': '취소 처리중',
            'CSC003': '취소 완료'
        };

        // 데이터를 Map에서 배열로 변환하고 순서 보장 (Object.keys()는 삽입 순서를 보장하지 않을 수 있음)
        // 여기서는 미리 정의된 statusDisplayNames의 순서대로 데이터를 채웁니다.
        Object.keys(statusDisplayNames).forEach(code => {
            statusLabels.push(statusDisplayNames[code]);
            statusCounts.push(cancelStatusCountsData[code] || 0); // 데이터가 없으면 0으로
        });

        new Chart(cancelStatusCtx, {
            type: 'doughnut',
            data: {
                labels: statusLabels,
                datasets: [{
                    data: statusCounts,
                    backgroundColor: statusLabels.map(label => statusColors[Object.keys(statusDisplayNames).find(key => statusDisplayNames[key] === label)]),
                    hoverOffset: 4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    title: {
                        display: false, // H4 태그로 제목을 표시하므로 여기서는 숨김
                        text: '취소/환불 상태 현황',
                        font: { size: 16 }
                    },
                    legend: {
                        position: 'bottom',
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                let label = context.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed !== null) {
                                    label += context.parsed + '건 (' + (context.parsed / totalAllCancelRefundCount * 100).toFixed(1) + '%)';
                                }
                                return label;
                            }
                        }
                    }
                }
            }
        });

        // 2. 취소/환불 사유별 비율 차트 (TOP 5)
        const cancelReasonCountsData = JSON.parse('<c:out value="${cancelReasonCountsJson}" escapeXml="false"/>');
        
        const reasonLabels = [];
        const reasonCounts = [];
        const reasonBackgroundColors = [
            'rgba(255, 99, 132, 0.7)',  // Red
            'rgba(54, 162, 235, 0.7)',  // Blue
            'rgba(255, 206, 86, 0.7)',  // Yellow
            'rgba(75, 192, 192, 0.7)',  // Green
            'rgba(153, 102, 255, 0.7)', // Purple
            'rgba(255, 159, 64, 0.7)'   // Orange
        ];

        // 사유 코드에 대한 실제 이름 매핑 (필요에 따라 더 추가)
        const reasonDisplayNames = {
            'CRC001': '단순 변심/필요 없음',
            'CRC002': '다른 상품 구매',
            'CRC003': '배송 지연',
            // 여기에 다른 CRC 코드를 추가하고 적절한 이름을 매핑해주세요.
            // 예: 'CRC004': '상품 불량', 'CRC005': '오배송', ...
        };

        const sortedReasons = Object.entries(cancelReasonCountsData)
            .sort(([,a],[,b]) => b - a)
            .slice(0, 5); // TOP 5

        sortedReasons.forEach(([code, count]) => {
            reasonLabels.push(reasonDisplayNames[code] || code); // 매핑된 이름 사용, 없으면 코드 그대로
            reasonCounts.push(count);
        });

        const cancelReasonCtx = document.getElementById('cancelReasonChart').getContext('2d');
        new Chart(cancelReasonCtx, {
            type: 'bar',
            data: {
                labels: reasonLabels,
                datasets: [{
                    label: '취소 건수',
                    data: reasonCounts,
                    backgroundColor: reasonBackgroundColors.slice(0, reasonLabels.length),
                    borderColor: reasonBackgroundColors.slice(0, reasonLabels.length).map(color => color.replace('0.7', '1')), // 테두리 색상을 배경색보다 진하게
                    borderWidth: 1
                }]
            },
            options: {
                indexAxis: 'y', // 가로 막대 그래프
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    title: {
                        display: false, // H4 태그로 제목을 표시하므로 여기서는 숨김
                        text: '취소/환불 사유별 비율 (TOP 5)',
                        font: { size: 16 }
                    },
                    legend: {
                        display: false
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return context.dataset.label + ': ' + context.parsed.x + '건';
                            }
                        }
                    }
                },
                scales: {
                    x: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: '건수'
                        },
                        ticks: {
                            stepSize: 1, // 정수 단위로 표시
                            callback: function(value) {
                                if (value % 1 === 0) return value; // 정수만 표시
                            }
                        }
                    },
                    y: {
                        title: {
                            display: false, // 사유 자체가 라벨이므로 숨김
                            text: '취소 사유'
                        }
                    }
                }
            }
        });

        // 3. 일별 취소 요청 건수 차트
        const dailyCancelCountsData = JSON.parse('<c:out value="${dailyCancelCountsJson}" escapeXml="false"/>');
        
        const dailyLabels = Object.keys(dailyCancelCountsData); // 날짜 (MM-dd)
        const dailyCounts = Object.values(dailyCancelCountsData); // 해당 날짜의 취소 건수

        const dailyCancelCtx = document.getElementById('dailyCancelChart').getContext('2d');
        new Chart(dailyCancelCtx, {
            type: 'line', // 라인 차트
            data: {
                labels: dailyLabels,
                datasets: [{
                    label: '일별 취소 건수',
                    data: dailyCounts,
                    fill: false,
                    borderColor: 'rgb(75, 192, 192)',
                    tension: 0.1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    title: {
                        display: false, // H4 태그로 제목을 표시하므로 여기서는 숨김
                        text: '일별 취소 요청 건수',
                        font: { size: 16 }
                    },
                    legend: {
                        display: false // 범례 숨김
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return context.dataset.label + ': ' + context.parsed.y + '건';
                            }
                        }
                    }
                },
                scales: {
                    x: {
                        title: {
                            display: true,
                            text: '날짜'
                        }
                    },
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: '건수'
                        },
                        ticks: {
                            stepSize: 1, // 정수 단위로 표시
                            callback: function(value) {
                                if (value % 1 === 0) return value; // 정수만 표시
                            }
                        }
                    }
                }
            }
        });

        // --- ⭐⭐⭐ 차트 초기화 끝 ⭐⭐⭐ ---
    });

    // 검색 초기화 함수 (resetButton 클릭 시)는 그대로 유지
    function resetSearchForm() {
        document.getElementById('searchKeyword').value = '';
        document.getElementById('cancelStatusCodeFilter').value = '';
        document.getElementById('currentPage').value = '1';
        document.getElementById('orderDateStart').value = ''; // ⭐ 이 줄 추가 ⭐
        document.getElementById('orderDateEnd').value = '';   // ⭐ 이 줄 추가 ⭐
        document.getElementById('searchForm').submit();
    }
</script>
</body>
</html>