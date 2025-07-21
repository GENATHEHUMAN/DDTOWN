<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>통계 관리 - DDTOWN 관리자 시스템</title>
<%--     <%@ include file="../modules/headerPart.jsp" %> --%>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/admin_portal.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script type="text/javascript">
		$(function(){
			<c:if test="${not empty message }">
				Swal.fire({
						title : "${message }",
						icon : "success",
						draggable : true
					});
				<c:remove var="message" scope="request"/>
				<c:remove var="message" scope="session"/>
			</c:if>
		})
		function sweetAlert(type, msg){
			return Swal.fire({
				title : msg,
				icon : type,
				draggable : true
			});
		}

	</script>
    <style>
        /* 기존 CSS는 무시 요청에 따라 여기서는 최소한만 유지 또는 부트스트랩 대체 */
        .chart-container {
            width: 100%;
            height: 300px; /* 차트의 최소 높이 지정 */
            margin: 15px 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        /* 부트스트랩 카드에 맞추어 padding 조정 */
        .card-body.chart-body {
            padding: 0; /* 차트가 카드 바디 전체를 차지하도록 */
        }
        .stats-filter-group .form-select {
            width: auto; /* select 박스 너비 자동 조절 */
        }
        .stats-cards-grid .dashboard-card {
            text-align: center;
            padding: 1rem;
            border-radius: .5rem;
            box-shadow: 0 0.125rem 0.25rem rgba(0,0,0,0.075);
            background-color: #fff;
        }
        .stats-cards-grid .dashboard-card .card-icon {
            font-size: 2.5rem;
            color: #6c757d;
            margin-bottom: 0.5rem;
        }
        .stats-cards-grid .dashboard-card h3 {
            font-size: 1rem;
            color: #6c757d;
            margin-bottom: 0.25rem;
        }
        .stats-cards-grid .dashboard-card .count {
            font-size: 1.8rem;
            font-weight: bold;
            color: #343a40;
        }
        .stats-cards-grid .dashboard-card .unit {
            font-size: 0.9rem;
            font-weight: normal;
            color: #6c757d;
        }
    </style>
</head>
<body>
    <div class="emp-container d-flex flex-column min-vh-100"> <%-- d-flex, flex-column, min-vh-100 추가 --%>
        <%@ include file="./modules/header.jsp" %>
        <div class="emp-body-wrapper flex-grow-1 d-flex"> <%-- flex-grow-1, d-flex 추가 --%>
            <%@ include file="./modules/aside.jsp" %>

            <main class="emp-content p-4 flex-grow-1"> <%-- p-4, flex-grow-1 추가 --%>
                <section class="card shadow-sm mb-4">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h3 class="h5 mb-0"><i class="fas fa-users me-2"></i> 사용자 활동 통계</h3>
                        <div class="stats-filter-group">
                            <label for="userStatsPeriod" class="form-label mb-0 me-2">기간:</label>
                            <select id="userStatsPeriod" class="form-select form-select-sm">
                                <option value="daily">일간</option>
                                <option value="weekly">주간</option>
                                <option value="monthly">월간</option>
                            </select>
                        </div>
                    </div>
                    <div class="card-body chart-body">
                        <div class="chart-container"><canvas id="visitorTrendChart"></canvas></div>
                        <div class="chart-container"><canvas id="signupTrendChart"></canvas></div>
                    </div>
                </section>

                <section class="card shadow-sm mb-4">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h3 class="h5 mb-0"><i class="fas fa-shopping-cart me-2"></i> 굿즈샵 통계</h3>
                        <div class="stats-filter-group">
                            <select id="goodsShopPeriodFilter" class="form-select form-select-sm">
                                <option value="daily">일별</option>
                                <option value="weekly">주별</option>
                                <option value="monthly">월별</option>
                            </select>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row row-cols-1 row-cols-md-3 g-3 mb-4"> <%-- 그리드 시스템으로 변경 --%>
                            <div class="col">
                                <div class="dashboard-card summary-card">
                                    <div class="card-icon"><i class="fas fa-dollar-sign"></i></div>
                                    <div class="card-content">
                                        <h3>이 달 매출액</h3>
                                        <p class="count">5,250,000 <span class="unit">원</span></p>
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <div class="dashboard-card summary-card">
                                    <div class="card-icon"><i class="fas fa-receipt"></i></div>
                                    <div class="card-content">
                                        <h3>이 달 주문 건수</h3>
                                        <p class="count">210 <span class="unit">건</span></p>
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <div class="dashboard-card summary-card">
                                    <div class="card-icon"><i class="fas fa-undo-alt"></i></div>
                                    <div class="card-content">
                                        <h3>이 달 환불/취소 건수</h3>
                                        <p class="count">15 <span class="unit">건</span></p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <h4 class="h6 mb-3">판매 통계</h4>
                        <div class="chart-container"><canvas id="salesRevenueChart"></canvas></div>

                        <div class="stats-table-container">
                            <h5 class="h6 mb-3">인기 판매 품목 (Top 5)</h5>
                            <div class="table-responsive"> <%-- 스크롤 가능한 테이블 --%>
                                <table class="table table-striped table-hover table-bordered caption-top"> <%-- 부트스트랩 테이블 클래스 적용 --%>
                                    <thead>
                                        <tr>
                                            <th>순위</th>
                                            <th>상품명</th>
                                            <th>판매수량</th>
                                            <th>총 판매금액</th>
                                        </tr>
                                    </thead>
                                    <tbody id="topSellingItemsTable">
                                        <tr>
                                            <td>1</td>
                                            <td>샘플 상품 A</td>
                                            <td>120</td>
                                            <td>1,200,000 원</td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" class="text-center text-muted">데이터가 없습니다.</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <h4 class="h6 mb-3 mt-4">환불/취소/교환 통계</h4>
                        <div class="chart-container">
                            <canvas id="returnsCancellationsChart"></canvas>
                        </div>

                        <div class="stats-table-container">
                            <h5 class="h6 mb-3">최근 환불/취소/교환 내역 (최근 5건)</h5>
                            <div class="table-responsive">
                                <table class="table table-striped table-hover table-bordered caption-top">
                                    <thead>
                                        <tr>
                                            <th>주문번호</th>
                                            <th>상품명</th>
                                            <th>유형</th>
                                            <th>사유</th>
                                            <th>처리상태</th>
                                        </tr>
                                    </thead>
                                    <tbody id="recentReturnsTable">
                                        <tr>
                                            <td>ORD001</td>
                                            <td>샘플 상품 B</td>
                                            <td>환불</td>
                                            <td>단순 변심</td>
                                            <td>환불완료</td>
                                        </tr>
                                        <tr>
                                            <td colspan="5" class="text-center text-muted">데이터가 없습니다.</td>
                                        </tr>
                                    </tbody>
                                </div>
                                </table>
                            </div>
                        </div>
                    </div>
                </section>

                <section class="card shadow-sm mb-4">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h3 class="h5 mb-0"><i class="fas fa-wallet me-2"></i> 분야 별 수익 통계</h3>
                        <div class="stats-filter-group">
                            <select id="revenueSectorFilter" class="form-select form-select-sm">
                                <option value="all">전체 수익</option>
                                <option value="goodsshop">굿즈샵</option>
                                <option value="membership">멤버십</option>
                            </select>
                        </div>
                    </div>
                    <div class="card-body chart-body">
                        <div class="chart-container"><canvas id="revenueBySectorChart"></canvas></div>
                    </div>
                </section>

                <section class="card shadow-sm mb-4">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h3 class="h5 mb-0"><i class="fas fa-comments me-2"></i> 커뮤니티 활동 통계</h3>
                        <div class="stats-filter-group">
                            <select id="communityActivityPeriod" class="form-select form-select-sm">
                                <option value="daily">일간</option>
                                <option value="weekly">주간</option>
                                <option value="monthly">월간</option>
                            </select>
                        </div>
                    </div>
                    <div class="card-body chart-body">
                        <div class="chart-container"><canvas id="postCountChart"></canvas></div>
                        <div class="chart-container"><canvas id="likeCountChart"></canvas></div>
                    </div>
                </section>

                <section class="card shadow-sm mb-4">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h3 class="h5 mb-0"><i class="fas fa-trophy me-2"></i> 이상형 월드컵 TOP 아티스트 통계</h3>
                        <div class="stats-filter-group">
                            <label for="worldcupRoundFilter" class="form-label mb-0 me-2">회차/기간:</label>
                            <select id="worldcupRoundFilter" class="form-select form-select-sm">
                                <option value="latest">최근</option>
                                <option value="2025_q1">2025년 1분기</option>
                            </select>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="stats-table-container mb-4">
                            <h5 class="h6 mb-3">TOP 아티스트 (Top 10)</h5>
                            <div class="table-responsive">
                                <table class="table table-striped table-hover table-bordered caption-top">
                                    <thead><tr><th>순위</th><th>아티스트명</th><th>득표수</th><th>비율</th></tr></thead>
                                    <tbody id="topArtistsTable">
                                        <tr><td>1</td><td>아티스트 X</td><td>5,230</td><td>35.2%</td></tr>
                                        <tr><td colspan="4" class="text-center text-muted">데이터가 없습니다.</td></tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="chart-container"><canvas id="topArtistsChart"></canvas></div>
                    </div>
                </section>
            </main>
        </div>
    </div>
    <%@ include file="../modules/footerPart.jsp" %>
    <%@ include file="../modules/sidebar.jsp" %> <%-- sidebar.jsp가 footerPart.jsp보다 뒤에 있어야 할 수 있습니다. --%>

<script>
  document.addEventListener('DOMContentLoaded', function() {
      // Chart.js 초기화
      // 매출 추이 차트
      const salesRevenueCtx = document.getElementById('salesRevenueChart').getContext('2d');
      if (salesRevenueCtx) {
          new Chart(salesRevenueCtx, {
              type: 'line',
              data: {
                  labels: ['1월', '2월', '3월', '4월', '5월', '6월'],
                  datasets: [{
                      label: '매출액',
                      data: [1200000, 1900000, 1500000, 2500000, 2200000, 3000000],
                      borderColor: '#3498db',
                      tension: 0.1,
                      fill: false // 선 그래프 영역 채우지 않음
                  }]
              },
              options: {
                  responsive: true,
                  maintainAspectRatio: false,
                  plugins: {
                      legend: {
                          display: true,
                          position: 'top'
                      }
                  },
                  scales: {
                      y: {
                          beginAtZero: true,
                          title: {
                              display: true,
                              text: '매출액 (원)'
                          }
                      }
                  }
              }
          });
      }

      // 환불/취소 사유 차트
      const returnsCancellationsCtx = document.getElementById('returnsCancellationsChart').getContext('2d');
      if (returnsCancellationsCtx) {
          new Chart(returnsCancellationsCtx, {
              type: 'pie',
              data: {
                  labels: ['단순 변심', '상품 불량', '배송 지연', '기타'],
                  datasets: [{
                      data: [40, 25, 20, 15],
                      backgroundColor: ['#e74c3c', '#f39c12', '#3498db', '#95a5a6'],
                      hoverOffset: 4
                  }]
              },
              options: {
                  responsive: true,
                  maintainAspectRatio: false,
                  plugins: {
                      legend: {
                          position: 'right'
                      }
                  }
              }
          });
      }

      // 기간 필터 변경 이벤트
      const periodFilter = document.getElementById('goodsShopPeriodFilter');
      if (periodFilter) {
          periodFilter.addEventListener('change', function() {
              // TODO: 여기에 기간별 데이터 로딩 및 해당 차트/테이블 업데이트 로직 추가
          });
      }

      // 다른 차트들 초기화
      function createChart(id, type, data, options) {
          const ctx = document.getElementById(id);
          if (ctx) {
              new Chart(ctx.getContext('2d'), {
                  type: type,
                  data: data,
                  options: options
              });
          }
      }

      // 사용자 활동 통계
      createChart('visitorTrendChart', 'line',
          { labels: ['월', '화', '수', '목', '금', '토', '일'], datasets: [{ label: '방문자 수', data: [120, 150, 180, 200, 170, 220, 210], borderColor: '#3498db', tension: 0.2, fill: false }] },
          { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: true } } }
      );
      createChart('signupTrendChart', 'bar',
          { labels: ['월', '화', '수', '목', '금', '토', '일'], datasets: [{ label: '신규 가입자', data: [10, 15, 12, 18, 14, 20, 16], backgroundColor: '#2ecc71' }] },
          { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: true } }, scales: { y: { beginAtZero: true } } }
      );

      // 분야별 수익 통계
      createChart('revenueBySectorChart', 'bar',
          { labels: ['굿즈샵', '멤버십'], datasets: [{ label: '수익', data: [5000000, 2000000], backgroundColor: ['#1abc9c', '#f39c12'] }] },
          { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: true } }, scales: { y: { beginAtZero: true } } }
      );

      // 커뮤니티 활동 통계
      createChart('postCountChart', 'line',
          { labels: ['월', '화', '수', '목', '금', '토', '일'], datasets: [{ label: '게시물 수', data: [30, 40, 35, 50, 45, 60, 55], borderColor: '#34495e', tension: 0.2, fill: false }] },
          { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: true } } }
      );
      createChart('likeCountChart', 'bar',
          { labels: ['월', '화', '수', '목', '금', '토', '일'], datasets: [{ label: '좋아요 수', data: [100, 120, 110, 130, 125, 140, 135], backgroundColor: '#e67e22' }] },
          { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: true } }, scales: { y: { beginAtZero: true } } }
      );

      // 월드컵 TOP 아티스트 통계 (도넛 차트)
      createChart('topArtistsChart', 'doughnut',
          { labels: ['아티스트 X', '아티스트 Y', '아티스트 Z'], datasets: [{ data: [5230, 3200, 2100], backgroundColor: ['#2980b9', '#8e44ad', '#16a085'], hoverOffset: 4 }] },
          { responsive: true, maintainAspectRatio: false, plugins: { legend: { position: 'right' } } }
      );

      // 모든 select 필터에 대한 이벤트 리스너 추가
      document.querySelectorAll('select[id$="Period"], select[id$="Filter"]').forEach(selectElement => {
          selectElement.addEventListener('change', function() {
              // TODO: 각 필터에 따른 데이터 로딩 및 차트/테이블 업데이트 로직 구현
          });
      });
  });
</script>
</body>
</html>
