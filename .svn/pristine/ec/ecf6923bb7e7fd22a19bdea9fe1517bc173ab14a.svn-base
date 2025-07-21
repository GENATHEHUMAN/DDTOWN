<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>라이브 요약</title>
    <%@ include file="../../modules/headerPart.jsp" %>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .live-section-title { font-size: 1.5em; font-weight: 700; color: #234aad; margin-bottom: 15px; border-bottom: 2px solid #e0e0e0; padding-bottom: 8px; display: flex; align-items: center; gap: 10px;}
        /* .live-table { width: 100%; border-collapse: collapse; background: #fff; margin-bottom: 18px; }
        .live-table th, .live-table td { border: 1px solid #e0e0e0; padding: 12px; text-align: center; vertical-align: middle;}
        .live-table th { background: #f5f5f5; font-weight: 600; } */
        main.emp-content h2 {
	        font-size: 1.7em;
		    font-weight: 700;
		    color: #234aad;
		    display: flex;
		    align-items: center;
		    gap: 10px;
	    }
	    hr {
	        border: none;
	        border-top: 1px solid; /* 부드러운 구분선 */
	        margin-top: 20px;
	        margin-bottom: 30px; /* 차트와의 간격 확보 */
	    }
	    /* 차트 컨테이너 스타일 */
	    div[style*="width: 90%%; margin: auto;"] { /* 인라인 스타일을 타겟팅하므로 주의 */
	        background: #fff;
	        border-radius: 10px; /* 둥근 모서리 */
	        box-shadow: 0 5px 15px rgba(0,0,0,0.08); /* 부드러운 그림자 */
	        padding: 25px; /* 내부 패딩 */
	        margin-bottom: 30px !important; /* 아래 여백 중요도 높임 */
	        display: flex; /* flexbox를 사용하여 제목과 캔버스 정렬 */
	        flex-direction: column; /* 세로 정렬 */
	        align-items: center; /* 가로 중앙 정렬 */
	    }

	    div[style*="width: 90%%; margin: auto;"] h2 {
	        font-size: 1.6em; /* 차트 제목 크기 조정 */
	        font-weight: 700;
	        color: #234aad;
	        margin-bottom: 20px; /* 제목과 차트 간격 */
	        text-align: center; /* 제목 중앙 정렬 */
	        width: 100%; /* 너비 100%로 설정 */
	    }

	    /* 캔버스 기본 스타일 (차트 라이브러리가 덮어쓰므로 큰 영향 없음) */
	    canvas#liveStatsChart {
	        max-width: 100%; /* 부모 컨테이너에 맞게 최대 너비 설정 */
	        height: auto !important; /* 높이 자동 조절 */
	    }

	    /* 라이브 방송 이력 테이블 */
	    .live-table {
	        width: 100%;
	        border-collapse: separate; /* border-spacing 적용을 위해 */
	        border-spacing: 0; /* 셀 경계선이 겹치지 않도록 */
	        background: #fff;
	        margin-bottom: 25px; /* 하단 여백 */
	        border-radius: 10px; /* 테이블 전체에 둥근 모서리 */
	        box-shadow: 0 5px 15px rgba(0,0,0,0.08); /* 테이블 전체에 그림자 */
	        overflow: hidden; /* 둥근 모서리를 위해 내용 숨김 */
	    }

	    .live-table th, .live-table td {
	        border: none; /* 기본 테두리 제거 */
	        padding: 15px; /* 패딩 조정 */
	        text-align: center;
	        vertical-align: middle;
	    }

	    .live-table thead th {
	        background: #f0f5ff; /* 헤더 배경색 (FullCalendar 버튼과 유사) */
	        color: #234aad; /* 헤더 텍스트 색상 */
	        font-weight: 700; /* 더 굵게 */
	        border-bottom: 1px solid #d0d8e2; /* 헤더 하단에 구분선 */
	    }

	    .live-table tbody tr {
	        transition: background-color 0.2s ease;
	    }

	    .live-table tbody tr:nth-child(even) {
	        background-color: #f9f9f9; /* 짝수 행 배경색 */
	    }

	    .live-table tbody tr:hover {
	        background-color: #eef7ff; /* 호버 시 배경색 변경 */
	    }

	    .live-table td {
	        color: #495057; /* 본문 텍스트 색상 */
	        border-bottom: 1px solid #e9ecef; /* 셀 하단 구분선 */
	    }
	    .live-table tbody tr:last-child td {
	        border-bottom: none; /* 마지막 행 하단 구분선 제거 */
	    }

	    .live-table td[style*="text-align: right;"] { /* 누적 시청자 수 컬럼 */
	        font-weight: 600;
	        color: #343a40;
	    }

	    /* 데이터 없을 때 메시지 */
	    .live-table tbody tr td[colspan="6"] {
	        padding: 30px 15px;
	        color: #6c757d;
	        font-style: italic;
	    }
	    .chart-container {
		    width: 100%;
		    max-height: 400px;
		    margin: auto;
		}
    </style>
</head>
<body>
    <div class="emp-container">
        <%@ include file="../modules/header.jsp" %>
        <div class="emp-body-wrapper">
            <%@ include file="../modules/aside.jsp" %>
            <main class="emp-content" style="font-size: large;">
            	<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="#" style="color:black;"> 아티스트 커뮤니티 관리</a></li>
						<li class="breadcrumb-item active" aria-current="page">라이브 요약</li>
					</ol>
				</nav>
                <h2>라이브 방송 요약</h2>

               	<hr>

               	<div class="chart-container">
				    <h2>라이브 조회수 통계</h2>
				    <canvas id="liveStatsChart"></canvas>
				</div>


                <div class="live-section-title" style="margin-top: 30px;">라이브 방송 이력</div>
                <table class="live-table">
                    <thead>
                        <tr>
                            <th>라이브 번호</th>
                            <th>라이브 제목</th>
                            <th>라이브 설명</th>
                            <th>누적 시청자 수</th>
                            <th>방송 품질</th>
                            <th>방송 일시</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty historyList}">
                                <c:forEach items="${historyList}" var="item">
                                    <tr>
                                        <td>${item.liveNo}</td>
                                        <td>${item.liveTitle}</td>
                                        <td style="text-align: left;">${item.liveContent}</td>
                                        <td style="text-align: right;"><fmt:formatNumber value="${item.liveHit}" pattern="#,###" />명</td>
                                        <td>${item.liveQty}</td>
                                        <td><fmt:formatDate value="${item.liveStartDate}" pattern="yy.MM.dd" /></td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr><td colspan="6">라이브 이력이 없습니다.</td></tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </main>
        </div>
        <div class="ea-pagination" id="pagingArea" style="margin-left:auto;">
	    	${pagingVO.pagingHTML }
	    </div>
    </div>
<%@ include file="../../modules/footerPart.jsp" %>
<%@ include file="../../modules/sidebar.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-adapter-date-fns/dist/chartjs-adapter-date-fns.bundle.min.js"></script>
<script type="text/javascript">
	$(function(){
		const artGroupNo = "${managedArtGroupNo}".trim();

		// artGroupNo가 0이거나 없을 경우 차트를 그리지 않음
        if (!artGroupNo || artGroupNo === "0") {
//             console.log("관리하는 아티스트 그룹이 없어 차트를 표시하지 않습니다.");
            return;
        }

		fetch(`/api/emp/live/stats?artGroupNo=\${artGroupNo}`)
			.then(response => {
				if(!response.ok){
					throw new Error('네트워크 응답이 올바르지 않습니다.')
				}
				return response.json();
			})
			.then(data => {
				if(data && data.length > 0){
					createLiveChart(data);
				}else{
// 					console.log("표시할 차트 데이터가 없습니다.")
				}
			})
			.catch(error => {
				console.error('차트 데이터 로딩 중 오류 발생:', error);
			});


		// 차트 생성 함수
		function createLiveChart(chartData){
// 			console.log(chartData[0].x);
// 			console.log(chartData[0].y);
			const ctx = $("#liveStatsChart")[0].getContext('2d');

			new Chart(ctx, {
				type : 'line',
				data : {
					datasets: [{
						label: '조회수'
						, data: chartData
						, borderColor: 'rgba(54, 162, 235, 1)'
						, backgroundColor: 'rgba(54,162,235,0.2)'
						, fill : true // 라인 아래 영역 채우기
						, tension: 0.2 //라인의 부드러운 정도
					}]
				},
				options:{
					responsive: true
					, maintainAspectRatio: false
					, scales: {
						x:{
							type: 'time'
							, time:{
								unit: 'day'
								, tooltipFormat: 'yyyy-MM-dd'
								, displayFormats: {
									day: 'MM.dd일'
								}
							},
							title:{
								display: true
								, text: '방송시간'
							}
						},

						y:{
							beginAtZero: true
							, title: {
								display: true
								, text: '조회수'
							}
						}
					}
				}
			});
		}
		/* 차트 함수 끝 */
	});
</script>
</body>
</html>