<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DDTOWN - 오디션 일정 관리</title>
    <%@ include file="../../../modules/headerPart.jsp" %>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/pages/audition_management_style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
body {
    font-family: 'Noto Sans KR', sans-serif;
    color: #333;
    background-color: #f8f9fa; /* 전체 페이지 배경색 */
}

a {
    text-decoration: none;
}
.am-section-header {
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.06);
    padding: 15px 20px;
    margin-bottom: 25px;
    border: 1px solid #e0e5f0;
    display: flex; /* h2와 뱃지 컨테이너를 가로로 정렬 */
    align-items: center; /* 세로 중앙 정렬 */
    flex-wrap: wrap; /* 작은 화면에서 줄바꿈 */
    gap: 20px; /* 제목과 뱃지 컨테이너 사이 간격 */
}

.am-section-header h2 {
    font-size: 1.6em;
    font-weight: 700;
    color: #234aad; /* 메인 제목 색상 */
    margin-bottom: 0; /* flex 컨테이너이므로 기존 마진 제거 */
    padding-bottom: 5px; /* 하단 선과의 간격 */
}
.am-section-content {
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    padding: 25px;
    margin-top: 20px;
    border: 1px solid #e0e0e0;
    overflow-x: auto; /* 테이블이 넘칠 경우 스크롤 */
    font-size: small;
}

.am-filter-area {
    /* float-right-btn 제거하고 flexbox 사용 */
    display: flex;
    justify-content: flex-end; /* 오른쪽 정렬 */
    margin-bottom: 20px;
    flex-wrap: wrap; /* 작은 화면에서 줄바꿈 */
    gap: 10px; /* 필터 요소들 간 간격 */
}

#searchForm.input-group.input-group-sm {
    display: flex; /* 자식 요소들을 flex로 정렬 */
    align-items: center;
    width: auto; /* 너비 자동 조정 */
    flex-wrap: wrap; /* 작은 화면에서 줄바꿈 */
    border-radius: 8px;
}

.am-filter-select, .am-search-input {
    height: 40px;
    border-radius: 5px;
    border: 1px solid #ced4da;
    padding: 0 12px;
    font-size: 1em;
    color: #495057;
    background-color: #fff;
    transition: all 0.2s ease-in-out;
}
.am-filter-select:focus, .am-search-input:focus {
    border-color: #234aad;
    box-shadow: 0 0 0 0.25rem rgba(35, 74, 173, 0.25);
    outline: none;
}

#filter-schedule-status {
    min-width: 180px; /* 상태 드롭다운 최소 너비 */
    flex-grow: 1; /* 공간이 남으면 확장 */
}
.float-right-btn {
    float: right; /* 등록버튼 오른쪽으로 위치시킴 */
}

.am-btn {
    background-color: #0d6efd; /* 파란색 */
    color: #ffffff;
    border-radius: 8px; /* 더 둥글게 */
    padding: 10px 18px; /* 패딩 증가 */
    border: none;
    font-size: 1em;
    font-weight: 600;
    cursor: pointer;
    transition: background-color 0.2s ease, transform 0.1s ease, box-shadow 0.2s ease;
    display: inline-flex;
    align-items: center;
    gap: 8px; /* 아이콘과 텍스트 사이 간격 */
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}
.am-btn:hover {
    background-color: #1a3c8a;
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.15);
}
.am-btn.primary { /* 등록 버튼 */
    background-color: #007bff;
}
.am-btn.primary:hover {
    background-color: #0056b3;
}
.status-badges-container {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    align-items: center;
    justify-content: center;
    width: fit-content; /* 또는 고정 너비 (예: width: 300px;) */
    margin: 0;
    font-size: medium;
}
.status-badge {
   	display: inline-flex; /* flex를 사용하여 아이콘과 텍스트 정렬 */
    align-items: center;
    padding: .5em 1em; /* 패딩 조정 */
    border-radius: 20px; /* 더 둥글게 */
    font-size: 0.9em; /* 폰트 크기 조정 */
    font-weight: 600;
    color: #fff;
    white-space: nowrap;
    cursor: pointer;
    transition: all 0.2s ease-in-out;
    box-shadow: 0 2px 5px rgba(0,0,0,0.05);
}
.status-badge:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    opacity: 0.9;
}

.status-badge .label {
    margin-right: 8px;
}

/* --- ADSC 코드에 따른 뱃지 색상 정의 --- */
/* '전체' 상태일 때의 스타일 */
.status-badge.all-audis {
    background-color: #6c757d; /* 파란색 - 다른 '전체' 뱃지들과 일관성을 위해 */
    color: #fff;             /* 글자색은 흰색 */
}
.status-badge.reason-ADSC001 { /* 예정됨 */
    background-color: #007bff; /* 파란색 계열 */
    color: #fff;
}
.status-badge.reason-ADSC002 { /* 진행중 */
    background-color: #28a745;
    color: #fff;
}
.status-badge.reason-ADSC003 { /* 마감 */
    background-color: #6c757d; /* 회색 계열 */
    color: #fff;
}
 /* 목록 테이블 부분 */
/* 오디션 상태 뱃지 기본 스타일 */
.audition-status-badge {
    display: inline-block;
    padding: 0.25em 0.6em;
    font-size: 1.1em;
    font-weight: 700;
    line-height: 1;
    text-align: center;
    white-space: nowrap;
    vertical-align: baseline;
    border-radius: 12rem; /* 둥근 뱃지 형태 */
    opacity: 0.9; /* 약간의 투명도 */
    color: #fff; /* 기본 글자색 흰색 */
}

/* '예정' 상태일 때의 스타일 (ADSC001) */
.audition-status-badge.status-scheduled {
    background-color: #007bff; /* 파란색 (정보성) */
}

/* '진행중' 상태일 때의 스타일 (ADSC002) */
.audition-status-badge.status-in-progress {
    background-color: #28a745; /* 녹색 (성공/진행) */
}

/* '마감' 상태일 때의 스타일 (ADSC003) */
.audition-status-badge.status-closed {
    background-color: #6c757d; /* 회색 (경고/마감) */
}

.pagination-and-button-container {
    display: flex;             /* 플렉스 컨테이너로 설정 */
    /* justify-content는 여기서는 flex-start (기본값)로 두거나 아예 제거합니다.
       각 아이템의 margin: auto; 로 정렬을 제어할 것입니다. */
    align-items: center;       /* 아이템들을 수직으로 가운데 정렬합니다. */
    width: 100%;               /* 컨테이너가 가로 전체 너비를 차지하도록 합니다. */
    margin-top: 20px;          /* 위쪽 여백 */
    /* clear: both; (필요시 기존 float 해제) */
    padding: 0 10px;           /* 좌우 패딩을 추가하여 내용이 가장자리에 너무 붙지 않게 합니다. */
}

/* 페이징 영역 (정확한 중앙에 가깝게) */
.am-pagination {
    /* 페이징 자체를 가로 중앙으로 정렬합니다. */
    margin-right: auto; /* 왼쪽의 사용 가능한 모든 공간을 차지 */
    margin-left: auto;  /* 오른쪽의 사용 가능한 모든 공간을 차지 */
    text-align: center; /* 페이징 내부 요소 (숫자, 이전/다음)를 div 안에서 가운데 정렬 */
}
.am-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
    font-size: 1em;
    min-width: 700px; /* 작은 화면에서 테이블 최소 너비 보장 */
}

.am-table thead th {
    background-color: #f0f5ff; /* 헤더 배경색 */
    color: #234aad;
    font-weight: 600;
    padding: 12px 15px;
    text-align: center; /* 헤더 텍스트 중앙 정렬 */
    border-bottom: 1px solid #dddddd;
    white-space: nowrap; /* 헤더 텍스트 줄바꿈 방지 */
}

.am-table tbody td {
    padding: 10px 15px;
    border-bottom: 1px solid #eeeeee;
    color: #555555;
    text-align: center; /* 기본적으로 중앙 정렬 */
    vertical-align: middle;
}

/* Specific Column Alignments for tbody */
.am-table tbody td:nth-child(1) { /* 오디션 ID */
    text-align: center;
}
.am-table tbody td:nth-child(2) { /* 진행 상태 */
    text-align: center;
}
.am-table tbody td:nth-child(3) { /* 오디션명 */
    text-align: left; /* 오디션명은 왼쪽 정렬 */
}
.am-table tbody td:nth-child(4) { /* 모집 기간 */
    text-align: center;
}
.am-table tbody td:nth-child(5) { /* 담당자 */
    text-align: center;
}

.am-table tbody tr:nth-child(even) {
    background-color: #fcfdff; /* 짝수 행 배경색 */
}

.am-table tbody tr:hover {
    background-color: #e9f7ff;
}

.am-table tbody tr:last-child td {
    border-bottom: none;
}

/* Detail Link in Table */
.detail-link {
    color: #007bff;
    font-weight: 500;
    transition: color 0.2s ease-in-out;
}
.detail-link:hover {
    color: #0056b3;
    text-decoration: underline;
}

/* Table Internal Status Badges */
.audition-status-badge {
    display: inline-block;
    padding: 0.5em 1em;
    font-size: 90%;
    font-weight: 700;
    line-height: 1;
    text-align: center;
    font-size: 1em;
    white-space: nowrap;
    vertical-align: baseline;
    border-radius: 1rem;
}

/* Specific Table Badge Colors */
.audition-status-badge.status-scheduled {
    background-color: #007bff; /* 예정 - 파란색 */
}
.audition-status-badge.status-in-progress {
    background-color: #28a745; /* 진행중 - 녹색 */
}
.audition-status-badge.status-closed {
    background-color: #6c757d; /* 마감 - 회색 */
}


</style>
</head>
<body>
     <div class="emp-container">
     	<%@ include file="../../modules/header.jsp" %>
        <div class="emp-body-wrapper">
        	<%@ include file="../../modules/aside.jsp" %>
<!-- main 페이지 -->
            <main class="emp-content">
            	<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
					<ol class="breadcrumb">
					  <li class="breadcrumb-item"><a href="#" style="color:black;">오디션 관리</a></li>
					  <li class="breadcrumb-item active" aria-current="page">일정 관리</li>
					</ol>
				</nav>
                <section id="schedule-management-section" class="am-section active-section">
                    <div class="am-section-header">
                        <h2>오디션 일정 관리</h2>
                        <div class="status-badges-container">
                         <%-- 2. 상태별 인원 수 --%>
                         	<form id="statusFilterForm" method="get" action="/emp/audition/schedule" style="display: flex; gap: 10px;">
                         		<input type="hidden" name="page" value="1">
                         		<input type="hidden" name="badgeSearchType">
                         		<div class="status-badge all-audis" data-status-code="" style="cursor: pointer;">
							        <span class="label">전체</span>
							        <span class="count">${totalAuditionCount}건</span>
							    </div>
						    	<c:forEach var="entry" items="${auditionStatCnts}">
							    	<div class="status-badge reason-${entry.key}" data-status-code="${entry.key}" style="cursor: pointer;">
							        	<span class="label">
							            	<c:choose>
							                	<c:when test="${entry.key eq 'ADSC001'}">예정됨</c:when>
							                	<c:when test="${entry.key eq 'ADSC002'}">진행중</c:when>
							                	<c:when test="${entry.key eq 'ADSC003'}">마감</c:when>
							                	<c:otherwise>${entry.key}</c:otherwise>
							            	</c:choose>
							        	</span>
							        	<span class="count">${entry.value}건</span>
							    	</div>
								</c:forEach>
							</form>
						</div>
                    </div>
                    <div class="am-section-content">
                        <div class="am-filter-area float-right-btn">
                        	<form class="input-group input-group-sm " method="get" id="searchForm">
                        		<input type="hidden" name="page" id="page"/>
	                            <select id="filter-schedule-status" name="searchType" class="am-filter-select">
							        <option value="all" ${searchType == 'all' ? 'selected' : ''}>전체 상태</option>
							        <option value="ADSC001" ${searchType == 'ADSC001' ? 'selected' : ''}>예정</option>
							        <option value="ADSC002" ${searchType == 'ADSC002' ? 'selected' : ''}>진행중</option>
							        <option value="ADSC003" ${searchType == 'ADSC003' ? 'selected' : ''}>마감/종료</option>
	                            </select>&nbsp;
	                            <input type="search" name="searchWord" id="search-schedule-input" placeholder="오디션명 검색" class="am-search-input" value="${searchWord }">&nbsp;
	                            <button type="submit" id="btn-search-schedule" class="am-btn" >
	                            	<i class="fas fa-search"></i> 검색
	                            </button>
	                            <!-- <button type="button" id="resetSearchButton" class="ea-btn" style="width:70px; margin-left: 5px;">초기화</button> -->
                            </form>
                        </div>
                        <table class="am-table" id="schedule-table">
                            <thead>
                                <tr>
                                    <th>오디션 ID</th>
                                    <th>진행 상태</th>
                                    <th>오디션명</th>
                                    <th>모집 기간</th>
                                    <th>담당자</th>
                                </tr>
                            </thead>
                            <tbody id="schedule-table-body">
                                <c:forEach var="audition" items="${auditionList}">
					                <tr>
					                    <td>${audition.audiNo}</td>
					                    <td>
										    <span class="audition-status-badge
										        <c:choose>
										            <c:when test="${audition.audiStatCode eq 'ADSC001'}">status-scheduled</c:when>
										            <c:when test="${audition.audiStatCode eq 'ADSC002'}">status-in-progress</c:when>
										            <c:when test="${audition.audiStatCode eq 'ADSC003'}">status-closed</c:when>
										        </c:choose>
										    ">
										        <c:choose>
										            <c:when test="${audition.audiStatCode eq 'ADSC001'}">예정</c:when>
										            <c:when test="${audition.audiStatCode eq 'ADSC002'}">진행중</c:when>
										            <c:when test="${audition.audiStatCode eq 'ADSC003'}">마감</c:when>
										        </c:choose>
										    </span>
										</td>
					                    <td>
						                    <a href="/emp/audition/detail.do?audiNo=${audition.audiNo }" class="detail-link aDetail">
						                    	${audition.audiTitle}
						                    </a>
					                    </td>
					                    <td>
					                    	<c:set value="${fn:split(audition.audiStartDate, ' ')}" var="auditionStartDate"/>
		                       				<c:set value="${fn:split(audition.audiEndDate, ' ')}" var="auditionEndDate"/>
		                       				${auditionStartDate[0]} ~ ${auditionEndDate[0]}
		                       			</td>

					                    <td>${audition.empUsername}</td>
					                </tr>
					            </c:forEach>
					            <c:if test="${empty auditionList}">
					                <tr>
					                    <td colspan="9">등록된 오디션이 없습니다.</td>
					                </tr>
					            </c:if>
                            </tbody>
                        </table>
                        <div class="pagination-and-button-container">
                        <div class="am-pagination" id="pagingArea">
                            ${pagingVO.pagingHTML }
                            <sec:csrfInput/>
                        </div>
                        <button type="button" id="formBtn" name="formBtn"class="am-btn primary float-right-btn"><i class="fas fa-plus"></i>등록</button>
                    </div>
                </section>
            </main>
<!--  main 끝 -->
        </div>
    </div>
</body>
<%@ include file="../../../modules/footerPart.jsp" %>

<%@ include file="../../../modules/sidebar.jsp" %>
<script type="text/javascript">
$(function(){
	let formBtn = $("#formBtn");	// 등록버튼

	let pagingArea = $("#pagingArea");	//페이징 영역
	let searchForm = $("#searchForm");	//검색 Form 태그 Element
	let statusFilterForm = $("#statusFilterForm");	//상태 뱃지 Form
	//등록페이지 이동
	formBtn.on("click", function(){
		location.href = "/emp/audition/form.do";
	})

	// 페이지네이션 로직
	$(document).on('click', '.page-link', function(e) {
        e.preventDefault(); // 기본 링크 동작(href="#") 방지

        var page = $(this).data('page'); // data-page 속성 값 가져오기

        if (page) { // page 값이 유효한 경우에만 실행
            $('#page').val(page); // hidden input #page의 값을 설정
            $('#searchForm').submit(); // 검색 폼 제출
        }
    });

/* 	//검색어 초기화 버튼
	$('#resetSearchButton').on('click', function() {
        // 검색 필드 값 초기화
        $('#filter-schedule-status').val('all');
        $('#search-schedule-input').val('');
        $('#page').val(1);             // 페이지를 1페이지로 초기화

        // 폼 제출
        $('#searchForm').submit();
    }); */

	// 상태별 인원수 버튼 이벤트
	$(".status-badges-container .status-badge").on("click", function(){
		const statusCode = $(this).data("status-code");
// 		console.log("선택된 오디션 상태 코드:", statusCode);
		statusFilterForm.find("input[name='badgeSearchType']").val(statusCode);

		$('#filter-schedule-status').val('all');
		$('#search-schedule-input').val('');
		$('#page').val(1);

		statusFilterForm.submit();

	})

})

</script>


</html>