<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>블랙리스트 관리 - DDTOWN 관리자</title>

    <%@ include file="../../modules/headerPart.jsp" %>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .current-info {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f9f9f9;
            border: 1px solid #eee;
            border-radius: 6px;
            font-size: 0.95em;
        }
        .current-info strong {
            color: #333;
        }
        .emp-form .form-group textarea#blacklistReasonText {
            min-height: 150px;
        }
		.blacklist-status-badge {
		    display: inline-block; /* 텍스트 크기만큼만 공간 차지 */
		    padding: 0.25em 0.6em; /* 내부 여백 */
		    font-size: 0.75em;     /* 폰트 크기 */
		    font-weight: 700;      /* 폰트 굵기 */
		    line-height: 1;        /* 줄 높이 */
		    text-align: center;    /* 텍스트 중앙 정렬 */
		    white-space: nowrap;   /* 텍스트 줄바꿈 방지 */
		    vertical-align: baseline; /* 세로 정렬 */
		    border-radius: 12rem; /* 둥근 모서리 */
		    opacity: 0.8; /* 약간의 투명도 */
		}

		/* '비활성' 상태일 때의 스타일 */
		.blacklist-status-badge.status-inactive {
		    color: #fff; /* 글자색 흰색 */
		    background-color: #6c757d; /* 회색 배경 (부트스트랩의 secondary/gray와 유사) */
		    /* 또는 경고색: background-color: #ffc107; */
		}

		/* '활성' 상태일 때의 스타일 */
		.blacklist-status-badge.status-active {
		    color: #fff; /* 글자색 흰색 */
		    background-color: #dc3545; /* 녹색 배경 (부트스트랩의 success/green과 유사) */
		    /* 또는 파란색: background-color: #007bff; */
		}
		 /* 버튼비활성화 */
		.disabled-button {
		    cursor: not-allowed;
		    opacity: 0.6;
		    /* 다른 비활성화 스타일 (예: 배경색 변경) */
		    background-color: #cccccc;
		    color: #666666;
		}

		/* 해당 회원의 신고 내역 섹션 스타일 */
		.report-details-box {
		    background-color: #ffffff; /* 흰색 배경 */
		    border: 1px solid #e0e0e0; /* 연한 회색 테두리 */
		    border-radius: 8px; /* 둥근 모서리 */
		    padding: 25px; /* 내부 여백 */
		    margin-top: 30px; /* 상단 여백 */
		    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05); /* 은은한 그림자 */
		}

		.report-details-box h2 {
		    font-size: 24px; /* 제목 글자 크기 */
		    color: #333333; /* 진한 회색 글자색 */
		    margin-bottom: 25px; /* 제목 하단 여백 */
		    border-bottom: 2px solid #f0f0f0; /* 제목 아래 구분선 */
		    padding-bottom: 15px; /* 구분선과 제목 사이 여백 */
		    font-weight: 600; /* 제목 굵기 */
		}

		/* 신고 내역 테이블 스타일 */
		.report-list-table {
		    width: 100%; /* 너비 100% */
		    border-collapse: collapse; /* 테두리 겹침 */
		    margin-top: 20px; /* 테이블 상단 여백 */
		    font-size: 17px; /* 테이블 내부 글자 크기 */
		    color: #555555; /* 테이블 글자색 */
		}

		.report-list-table th,
		.report-list-table td {
		    padding: 12px 15px; /* 셀 내부 여백 */
		    border-bottom: 1px solid #e9e9e9; /* 하단 테두리 */
		    text-align: left; /* 텍스트 왼쪽 정렬 */
		    vertical-align: middle; /* 세로 가운데 정렬 */
		}

		.report-list-table th {
		    background-color: #f8f8f8; /* 헤더 배경색 */
		    font-weight: 600; /* 헤더 글자 굵기 */
		    color: #444444; /* 헤더 글자색 */
		    border-top: 1px solid #e9e9e9; /* 상단 테두리 추가 */
		}

		/* 홀수/짝수 행 배경색 구분 (선택 사항) */
		.report-list-table tbody tr:nth-child(even) {
		    background-color: #fcfcfc; /* 짝수 행 더 연한 배경 */
		}

		/* 마우스 오버 시 행 강조 */
		.report-list-table tbody tr:hover {
		    background-color: #f5f5f5; /* 마우스 오버 시 배경색 변경 */
		}

		/* 링크 스타일 */
		.report-list-table td a {
		    color: #007bff; /* 파란색 링크 */
		    text-decoration: none; /* 밑줄 없음 */
		    transition: color 0.2s ease; /* 색상 변경 애니메이션 */
		}

		.report-list-table td a:hover {
		    color: #0056b3; /* 마우스 오버 시 더 진한 파란색 */
		    text-decoration: underline; /* 마우스 오버 시 밑줄 */
		}

		/* 내용이 없을 때 메시지 스타일 */
		.report-details-box p {
		    text-align: center; /* 가운데 정렬 */
		    padding: 30px; /* 여백 */
		    color: #777777; /* 회색 글자 */
		    font-size: 16px; /* 글자 크기 */
		    background-color: #fdfdfd; /* 연한 배경 */
		    border-radius: 5px; /* 둥근 모서리 */
		    margin-top: 20px; /* 상단 여백 */
		}
    </style>
</head>
<body>
    <div class="emp-container">
        <%@ include file="../modules/header.jsp" %>
        <div class="emp-body-wrapper">
            <%@ include file="../modules/aside.jsp" %>
            <main class="emp-content" style="font-size: large;">
            <!-- 네비게이션 바 -->
            	<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
					<ol class="breadcrumb">
					  <li class="breadcrumb-item"><a href="#" style="color:black;">아티스트 커뮤니티 관리</a></li>
					  <li class="breadcrumb-item location"><a href="/admin/community/blacklist/list" style="color:black;">블랙리스트 관리</a></li>
					  <li class="breadcrumb-item active" aria-current="page">상세</li>
					</ol>
				</nav>
                <section id="blacklistReasonFormSection" class="ea-section active-section">
                    <div class="ea-section-header">
                        <h2 id="blacklistFormTitle">블랙리스트 사유 상세
                        	<td>
							    <span class="blacklist-status-badge
							        <c:choose>
							            <c:when test="${blacklist.banActYn eq 'N'}">status-inactive</c:when>
							            <c:when test="${blacklist.banActYn eq 'Y'}">status-active</c:when>
							        </c:choose>
							    ">
							        <c:choose>
							            <c:when test="${blacklist.banActYn eq 'N'}">해제</c:when>
							            <c:when test="${blacklist.banActYn eq 'Y'}">차단</c:when>
							        </c:choose>
							    </span>
							</td>
					    </h2>
					    <button type="button" class="ea-btn primary" id="modBtn">수정</button>
                    </div>

                    <div class="current-info">
                        <p><strong>대상 회원 ID:</strong> <span id="targetUserId">${blacklist.memUsername } (${blacklist.peoLastNm}${blacklist.peoFirstNm})</span></p>
                        <p><strong>현재 지정 사유:</strong>
                           <span id="currentBlacklistReason">
                           <c:choose>
                              	<c:when test="${blacklist.banReasonCode eq 'BRC001'}">스팸</c:when>
                              	<c:when test="${blacklist.banReasonCode eq 'BRC002'}">욕설</c:when>
                              	<c:when test="${blacklist.banReasonCode eq 'BRC003'}">음란물</c:when>
                              	<c:when test="${blacklist.banReasonCode eq 'BRC004'}">기타</c:when>
                            </c:choose>
                           </span>
                       </p>
                    </div>

                    <form class="ea-form" id="blacklistReasonForm">
                        <input type="hidden" id="blacklistRecordId" name="blacklistRecordId">
                        <input type="hidden" id="targetMemberIdHidden" name="targetMemberId">

                        <div class="form-group">
                            <label for="blacklistReasonText">추가 사항 및 상세</label>
                            <span>${blacklist.banReasonDetail }</span>
                        </div>

                        <div class="form-group-group" style="display: flex; gap: 16px; align-items: flex-end;">
                            <div class="form-group" style="flex:1;">
                                <label for="blacklistReleaseDate">정지 기간</label>
                                 <li><strong>차단 시작 일시:</strong><c:set value="${fn:split(blacklist.banStartDate, ' ')}" var="banStartDate"/> ${banStartDate[0]}</li>
		                    	<li><strong>차단 해제 일시:</strong><c:set value="${fn:split(blacklist.banEndDate, ' ')}" var="banEndDate"/> ${banEndDate[0]}</li>
                            </div>
                        </div>
                        <label for="blacklistReleaseDate">차단 담당자</label>
                        <span>${blacklist.empUsername }</span>
                        <div class="ea-form-actions">
                            <button type="button" class="ea-btn success" id="delBtn" style="margin-right: auto;">
                            	<i class="fas fa-undo"></i>즉시 해제
                            </button>
                            <a href="/admin/community/blacklist/list" class="ea-btn outline">목록</a>
                        </div>
                    </form>
                    <form action="/admin/community/blacklist/delete"  method="post" id="delForm">
						<input type="hidden" name="banNo" value="${blacklist.banNo}" />
						<input type="hidden" name="memUsername" value="${blacklist.memUsername}" />
		                <sec:csrfInput/>
					</form>
                </section>
      <!-- 신고당한 내역 -->
                <div class="report-details-box">
				    <h2>해당 회원의 신고 내역 (${pagingVO.totalRecord}건)</h2>
				    <c:choose>
				        <c:when test="${not empty userReports}">
				            <table class="report-list-table"> <%-- 테이블 스타일은 직접 정의 필요 --%>
				                <thead>
				                    <tr>
				                        <th>신고 번호</th>
				                        <th>신고자 ID</th>
				                        <th>피신고자 ID</th>
				                        <th>신고 유형</th>
				                        <th>신고 사유</th>
				                        <th>신고일</th>
				                        <th>작성 내용</th>
				                        <th>상태</th>
				                    </tr>
				                </thead>
				                <tbody>
				                    <c:forEach var="report" items="${userReports}">
				                        <tr>
				                            <td>${report.reportNo}</td>
				                            <td>${report.memUsername}</td>
				                            <td>${report.targetMemUsername}</td>
				                            <td>
				                                <c:choose>
				                                    <c:when test="${report.reportTargetTypeCode eq 'RTTC001'}">게시글</c:when>
				                                    <c:when test="${report.reportTargetTypeCode eq 'RTTC002'}">댓글</c:when>
				                                    <c:when test="${report.reportTargetTypeCode eq 'RTTC003'}">채팅</c:when>
				                                    <c:otherwise>알 수 없음</c:otherwise>
				                                </c:choose>
				                            </td>
				                            <td>
				                                <c:choose>
				                                    <c:when test="${report.reportReasonCode eq 'RRC001'}">스팸</c:when>
				                                    <c:when test="${report.reportReasonCode eq 'RRC002'}">욕설</c:when>
				                                    <c:when test="${report.reportReasonCode eq 'RRC003'}">음란물</c:when>
				                                    <c:when test="${report.reportReasonCode eq 'RRC004'}">기타</c:when>
				                                    <c:otherwise>알 수 없음</c:otherwise>
				                                </c:choose>
				                            </td>
				                            <td>${report.reportRegDate}</td>
				                            <td><a href="/admin/community/report/detail?reportNo=${report.reportNo}">${report.reportedContent}</a></td>
				                            <td>
				                                <c:choose>
				                                    <c:when test="${report.reportStatCode eq 'RSC001'}">접수</c:when>
				                                    <c:when test="${report.reportStatCode eq 'RSC002'}">처리 완료</c:when>
				                                    <c:otherwise>알 수 없음</c:otherwise>
				                                </c:choose>
				                            </td>
				                        </tr>
				                    </c:forEach>
				                </tbody>
				            </table>
				        </c:when>
				        <c:otherwise>
				            <p>해당 회원의 신고 내역이 없습니다.</p>
				        </c:otherwise>
				    </c:choose>
				<form id="searchForm" action="/admin/community/blacklist/detail" method="get">
					<input type="hidden" name="banNo" value="${blacklist.banNo}">
					<input type="hidden" id="page" name="page" value="1">
				</form>
                <div class="pagination-container" id="pagingArea">
                    ${pagingVO.pagingHTML}
                </div>
				</div>
            </main>
        </div>
    </div>
<%@ include file="../../modules/footerPart.jsp" %>

<%@ include file="../../modules/sidebar.jsp" %>
 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
 <script>
 $(function(){
	let delBtn = $("#delBtn");	//삭제 버튼
	let delForm = $("#delForm");	//삭제 폼

	let pagingArea = $("#pagingArea");	//페이징 영역
	//수정 버튼 클릭 시
	$("#modBtn").on("click", function(){
	       location.href = "/admin/community/blacklist/modForm?banNo=${blacklist.banNo }";
	   });

	//삭제 버튼 클릭시
	delBtn.on("click", function(){
// 		console.log("버튼 클릭됨!");

		delForm.submit();
	})

	$(document).ready(function() {
	    var banActYn = "${blacklist.banActYn}";

	    // 2. 상태에 따라 '수정' 버튼 제어
	    if (banActYn === 'N') {
	        // blacklist.banActYn이 'N' (비활성)일 경우
	        $('#modBtn').prop('disabled', true); // 수정버튼을 비활성화
	        $('#delBtn').prop('disabled', true); // 즉시 해제버튼을 비활성화
	        $('#modBtn').addClass('disabled-button');
	        $('#delBtn').addClass('disabled-button');
	    } else {
	        // blacklist.banActYn이 'Y' (활성)일 경우 (또는 다른 상태일 경우)
	        $('#modBtn').prop('disabled', false); // 수정버튼을 활성화
	        $('#delBtn').prop('disabled', false); // 즉시 해제버튼을 활성화
	        $('#modBtn').removeClass('disabled-button'); // 스타일링 클래스 제거
	        $('#delBtn').removeClass('disabled-button'); // 스타일링 클래스 제거
	    }
	});
	//페이징 관련
	$(document).on('click', '.page-link', function(e) {
	     e.preventDefault(); // 기본 링크 동작(href="#") 방지

	     var page = $(this).data('page'); // data-page 속성 값 가져오기

	     if (page) { // page 값이 유효한 경우에만 실행
	         $('#page').val(page); // hidden input #page의 값을 설정
	         $('#searchForm').submit(); // 검색 폼 제출
	     }
	 });
})
</script>
</body>
</html>