<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/mainservice_home.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/mainservice_common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/concert_detail.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.14.1/themes/base/jquery-ui.min.css">
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js" defer integrity="sha256-9zljDKpE/mQxmaR4V2cGVaQ7arF3CcXxarvgr7Sj8Uc=" crossorigin="anonymous"></script>
<title>DDTOWN SQUARE</title>

<style type="text/css">
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

.concert-detail-poster .poster-img {
    width: 80%; /* 부모 요소의 전체 너비를 사용 */
    height: 555px; /* 원하는 고정 높이 설정 (예시: 450px, 디자인에 따라 조절) */
    overflow: hidden; /* 이미지가 이 영역을 벗어나면 숨김 */
    display: flex; /* 이미지 중앙 정렬을 위해 flexbox 사용 */
    justify-content: center; /* 가로 중앙 정렬 */
    align-items: center; /* 세로 중앙 정렬 */
}

/* 실제 이미지 태그 (img) */
.concert-detail-poster .poster-img img {
    width: 100%; /* 부모 컨테이너(poster-img)의 너비에 맞춤 */
    height: 555px; /* 부모 컨테이너(poster-img)의 높이에 맞춤 */
    object-fit: cover; /* 중요: 이미지가 비율을 유지하며 컨테이너를 꽉 채우도록 함 */
    display: block; /* 이미지 하단에 생길 수 있는 미세한 여백 제거 */
}

.concert-detail-container {
    max-width: 1700px;
    padding: 40px 40px;
    margin: 0 auto;
/*     margin-left: 40px; */
    display: flex; /* 자식 요소들을 가로로 배치 */
    justify-content: space-between; /* 자식 요소들 사이에 공간을 고르게 분배 */
    align-items: stretch; /* 자식 요소들을 위쪽으로 정렬 */
}

/* 콘서트 상세 정보 그리드 스타일 */
.concert-detail-grid {
    display: grid;
    grid-template-columns: 1fr 1fr; /* 포스터와 정보를 1:1 비율로 배치 */
    gap: 40px; /* 포스터와 정보 사이 간격 */
    width: 70%; /* 전체 컨테이너의 70% 차지 */
    flex-grow: 1; /* 남은 공간이 있으면 확장 */
    flex-shrink: 1; /* 공간이 부족하면 축소 */
}

.concert-meta i {
	color: #333;
	margin-right: 5px;
}
/* 예약 정보 (달력 + 버튼)를 위한 새로운 컨테이너 */
.concert-reservation-section {
    width: 25%;
    flex-grow: 0;
    flex-shrink: 0;
    padding: 20px;
    background: rgba(255, 255, 255, 0.5); /* 흰색 배경, 투명도 50% */
    backdrop-filter: blur(15px);           /* 배경 블러 효과 */
    border-radius: 20px;                   /* 둥근 모서리 */
    border: 1px solid rgba(255, 255, 255, 0.3); /* 투명한 흰색 테두리 */
    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1); /* 더 은은한 그림자 */
    transition: all 0.4s ease;             /* 부드러운 전환 효과 */
    position: relative;                    /* 필요시 relative 유지 */
    display: flex;
    flex-direction: column;
    align-items: center;
}

.concert-reservation-section h3 {
    margin-top: 15px; /* 상단 마진 살짝 줄임 */
    color: currentcolor;
    padding: 10px;
    font-size: 1.7em; /* 글씨 크기 강조 */
    font-weight: 700;
}
/* Datepicker 컨테이너 스타일 */
#datepicker {
    width: 100%; /* 부모 너비에 맞춤 */
    max-width: 260px; /* 최대 너비 설정 (달력 크기 조절) */
    margin-bottom: 20px; /* 달력 아래 여백 */
    background-color: #fff; /* 달력 전체 배경을 불투명한 흰색으로 설정 */
    border: 1px solid #ddd; /* 깔끔한 테두리 */
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1); /* 달력 자체 그림자 강조 */
    border-radius: 12px; /* 둥근 모서리 */
    overflow: hidden;
}
.ui-datepicker,
.ui-datepicker .ui-datepicker-header,
.ui-datepicker .ui-datepicker-content,
.ui-datepicker .ui-datepicker-calendar thead,
.ui-datepicker .ui-datepicker-calendar tbody {
    background: transparent !important;
    border: none !important;
}
.ui-datepicker td {
    background: transparent !important;
}

/* 달력 헤더 (월, 연도) 스타일 */
.ui-datepicker .ui-datepicker-header {
    padding: 0.8em 0;
    background: #8a2be2 !important; /* 헤더는 불투명한 보라색 */
    color: white !important; /* 글자색 흰색 */
    font-weight: 700; /* 더 굵게 */
    border-radius: 10px 10px 0 0 !important; /* 상단만 둥글게 */
    position: relative;
}

/* 달력 이전/다음 버튼 */
.ui-datepicker .ui-datepicker-prev,
.ui-datepicker .ui-datepicker-next {
    color: white !important; /* 화살표 색상 흰색 */
    font-weight: bold;
    font-size: 1.2em;
    cursor: pointer;
    top: 50%;
    transform: translateY(-50%);
    background: rgba(255, 255, 255, 0.25) !important; /* 호버 시 더 명확한 투명 흰색 배경 */
    border-radius: 50% !important;
    padding: 0.2em 0.5em;
}
.ui-datepicker .ui-datepicker-prev:hover,
.ui-datepicker .ui-datepicker-next:hover {
    background: rgba(255, 255, 255, 0.2) !important; /* 호버 시 투명한 흰색 배경 */
    border-radius: 50% !important;
}
/* 달력 요일 (일, 월, 화...) 헤더 */
.ui-datepicker th {
    padding: 0.7em 0.5em; /* 상하 패딩 늘림 */
    font-size: 0.9em;
    color: #555 !important; /* 요일 글자색 조금 더 진하게 */
    background-color: #f8f8f8 !important; /* 요일 배경 연한 회색 유지 */
    border-top: 1px solid #eee !important;
    border-bottom: 1px solid #eee !important;
}

/* 달력 날짜 셀 스타일 */
.ui-datepicker td span,
.ui-datepicker td a {
    padding: 0.6em;
    text-align: center;
    font-size: 1em;
    line-height: 1.5;
    border-radius: 50% !important; /* 날짜 셀을 원형으로 */
    transition: all 0.2s ease;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 2.2em;
    height: 2.2em;
    margin: 0 auto;
    color: #333 !important;
}

.ui-datepicker td a {
	color: #ffff !important;
}

.ui-state-default {
    background: transparent !important; /* 기본 날짜는 배경 없음 */
    color: #333 !important;
}

/* 오늘 날짜 */
.ui-state-highlight {
    background-color: rgba(138, 43, 226, 0.15) !important; /* 오늘 날짜 연한 보라색 배경 (조금 더 진하게) */
    color: #8a2be2 !important; /* 글자색 보라색 */
    font-weight: bold !important;
    border-radius: 50% !important;
}

/* 선택된 날짜 */
.ui-state-active {
    background-color: #8a2be2 !important; /* 선택된 날짜 불투명 보라색 배경 */
    color: white !important;
    box-shadow: 0 2px 8px rgba(138, 43, 226, 0.4);
}

/* 마우스 오버 시 */
.ui-state-hover {
    background-color: rgba(138, 43, 226, 0.25) !important; /* 호버 시 좀 더 진한 연보라색 배경 */
    border-radius: 50% !important;
    color: #8a2be2 !important;
}

/* 비활성화된 날짜 (선택 불가능) */
.ui-state-disabled span,
.ui-state-disabled a {
    color: #ccc !important; /* 더 흐리게 */
    cursor: not-allowed !important;
    background: transparent !important;
}

/* 예매하기 버튼 스타일 */
.btn-reserve {
    width: 100%;
    max-width: 300px;
    padding: 18px 25px;
    background: linear-gradient(135deg, #7c2bd9 0%, #a06fff 100%); /* 보라색 그라데이션 */
    color: white;
    border: none;
    border-radius: 15px;
    font-size: 1.2em;
    cursor: pointer;
    box-shadow: 0 8px 25px rgba(124, 43, 217, 0.6);
    transition: all 0.3s ease;
    margin-top: 25px;
}

.btn-reserve:hover {
    background: linear-gradient(135deg, #6a1fa6 0%, #8b4aff 100%);
    transform: translateY(-5px);
    box-shadow: 0 15px 40px rgba(106, 31, 166, 0.7);
}

/* 콘서트 시간 표시 및 수량 */
.concert-time-display {
    background: rgba(255, 255, 255, 0.5); /* 흰색 배경, 투명도 50% */
    backdrop-filter: blur(8px);
    border: 1px solid rgba(255, 255, 255, 0.3); /* 투명한 흰색 테두리 */
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08); /* 은은한 그림자 */
    border-radius: 12px;
    transition: all 0.3s ease;
    padding: 10px 15px;
    text-align: center;
    margin-top: 15px;
    margin-bottom: 25px;
    display: block;
    color: #333;
    font-weight: 600;
    font-size: large;
}

.concert-time-display span.time {
    color: #8a2be2;
    font-weight: 700;
    font-size: 1.1em;
}

.concert-time-display span.divider::before {
    content: '';
    display: inline-block;
    width: 1.5px;
    height: 1.4em;
    background-color: rgba(138, 43, 226, 0.6);
    margin-right: 15px;
    margin-left: 5px;
    vertical-align: middle;
}
.concert-time-display span.quantity {
    color: #555;
}

</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/modules/communityHeader.jsp" />

<div class="concert-detail-container">
	<c:choose>
        <c:when test="${not empty concertVO }">
			    <div class="concert-detail-grid">
			        <div class="concert-detail-poster">
			            <div class="poster-img">
			                <img alt="${concertVO.concertNm }" src="${concertVO.representativeImageUrl }">
			            </div>
			        </div>
			        <div class="concert-detail-info" style="font-size: large;">
			            <h1 class="concert-title">${concertVO.concertNm }</h1>
			            <div class="concert-meta">
			                <div><i class="fa-solid fa-heart"></i><b>아티스트</b>&nbsp;&nbsp;${concertVO.artGroupName }</div>
			                <div><i class="fa-regular fa-calendar"></i><b>일시</b>&nbsp;&nbsp;<fmt:formatDate value="${concertVO.concertDate }" pattern="yyyy-MM-dd (E) HH:mm"></fmt:formatDate></div>
			                <div><i class="fa-solid fa-location-dot"></i><b>장소</b>&nbsp;&nbsp;${concertVO.concertHallName }</div>
			            </div>
			            <hr>
			            <div class="concert-desc">
			                <h3><i class="fa-solid fa-tag"></i> <b>공연 소개</b></h3>
			                <p>${concertVO.concertGuide }</p>
			                <div class="concert-desc-meta">
			                    <span><i class="fa-solid fa-clock"></i><b> 관람 시간</b>&nbsp;&nbsp;${concertVO.concertRunningTime }분</span>
			                </div>
			            </div>
			            <hr>
			            <c:choose>
				            <c:when test="${not empty seatList }">
					            <div class="concert-price">
					                <h3><i class="fa-solid fa-ticket-simple"></i> <b>티켓 가격</b></h3>
					                <c:forEach var="seat" items="${seatList }">
						                <div>
						                	<c:if test="${seat.seatGradeCode == 'SGC001' }">
						                		STANDING석: ${ seat.seatPrice}원
						                	</c:if>
						                	<c:if test="${seat.seatGradeCode == 'SGC002' }">
						                		VIP석: ${ seat.seatPrice}원
						                	</c:if>
						                	<c:if test="${seat.seatGradeCode == 'SGC003' }">
						                		R석: ${ seat.seatPrice}원
						                	</c:if>
						                	<c:if test="${seat.seatGradeCode == 'SGC004' }">
						                		S석: ${ seat.seatPrice}원
						                	</c:if>
						                </div>
					                </c:forEach>
					            </div>
				            </c:when>
				            <c:otherwise>
				            	<div>가격 정보가 없습니다.</div>
				            </c:otherwise>
			            </c:choose>
			        </div>
			    </div>
    	</c:when>
    	<c:otherwise>
    		<div>콘서트 상세 내용을 불러올 수 없습니다.</div>
    	</c:otherwise>
    </c:choose>

    <div class="concert-reservation-section">
    	<h3>관람일</h3>
    	<div id="datepicker"></div>
    	<div class="concert-time-display">
    		<span>1회 <fmt:formatDate value="${concertVO.concertDate }" pattern="HH:mm"/></span>
    		<span class="divider">1매</span>
    	</div>
    	<button class="btn-reserve" id="btnReserve">예매하기</button>
    </div>

</div>
<div id="footer">
    <!-- FOOTER -->
    <jsp:include page="/WEB-INF/views/modules/communityFooter.jsp" />
    <script src="${pageContext.request.contextPath}/resources/js/pages/communityFooter.js"></script>
    <!-- FOOTER END -->
</div>
</body>
    <script>
    $(function() {

    	const concertDateString = "<fmt:formatDate value="${concertVO.concertDate}" pattern="yyyy-MM-dd"/>";
    	const concertDate = new Date(concertDateString);

    	// Date 객체의 시간을 0으로 설정하여 날짜만 비교할 수 있게 함.
    	concertDate.setHours(0, 0, 0, 0);

        $( "#datepicker" ).datepicker({
        	dateFormat: 'yy-mm-dd' //달력 날짜 형태
           ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
           ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
           ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시
           ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
           ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
           ,monthNames: ['.01','.02','.03','.04','.05','.06','.07','.08','.09','.10','.11','.12'] //달력의 월 부분 Tooltip
           ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
           ,beforeShowDay: function(date) {
        	   date.setHours(0, 0, 0, 0);

        	   if(date.getTime() === concertDate.getTime()) {
        		   return [true, '', '']; 	// 콘서트 날짜는 선택 가능하도록 활성화.
        	   } else {
        		   return [false, '', ''];	// 그 외 모든 날짜 비활성화.
        	   }
           }
        });

        // 달력의 초기값을 콘서트 날짜로 설정
        $('#datepicker').datepicker('setDate', concertDate);

        // 예매하기 버튼 클릭 이벤트
        $('#btnReserve').on('click', function() {
        	const selectedDate = $('#datepicker').datepicker('getDate');
        	const formattedDate = $.datepicker.formatDate('yy-mm-dd', selectedDate);

        	// 콘서트 번호 가져오기
        	const concertNo = ${concertVO.concertNo};

        	if(selectedDate) {
        		window.location.href = `/concert/seat/${concertNo}`;
        	}
        })
      });
    </script>
</html>