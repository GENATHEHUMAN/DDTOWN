<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DDTOWN 전자결재 - 기안서 상세</title>
    <%@ include file="../../modules/headerPart.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/approval_draft_style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style type="text/css">
    	body {
		    font-family: 'Noto Sans KR', sans-serif;
		    color: #333;
		    background-color: #f8f8f8; /* 페이지 전체 배경색 */
		    line-height: 1.6;
		}
		a {
		    text-decoration: none;
		    color: inherit; /* 기본 링크 색상 상속 */
		}
		.approval-detail-card {
		    background: #fff;
		    border-radius: 10px;
		    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08); /* 더 부드러운 그림자 */
		    padding: 32px 28px 24px 28px;
		    border: 1px solid #e0e0e0;
		    font-size: large;
		}
		.approval-detail-title {
		    font-size: 1.8em; /* 제목 더 크게 */
		    font-weight: 700;
		    color: #2c3e50;
		    margin-bottom: 25px;
		    padding-bottom: 15px;
		    border-bottom: 2px solid #234aad; /* 제목 하단 라인 */
		}
		/* 긴급도 및 결재상태 텍스트/뱃지 */
		.status-urgent {
		    color: #e74c3c; /* 긴급: 빨간색 강조 */
		    font-weight: 600;
		}
		.status-normal {
		    color: #6c757d; /* 일반: 회색 */
		    font-weight: 500;
		}

		/* 결재상태 뱃지 (목록 페이지와 동일하게) */
		.status-badge {
		    display: inline-block;
		    padding: 5px 12px;
		    border-radius: 20px;
		    font-size: 1em;
		    font-weight: 600;
		    color: #fff;
		    white-space: nowrap;
		    line-height: 1;
		    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
		}
		.status-badge.pending { /* 결재 대기 (ESC001) */
		    background-color: #6c757d; /* Gray */
		}
		.status-badge.in-progress { /* 결재 진행 (ESC002) */
		    background-color: #28a745; /* Green */
		}
		.status-badge.approved { /* 승인 (ESC003) */
		    background-color: #007bff; /* Blue */
		}
		.status-badge.rejected { /* 반려 (ESC004) */
		    background-color: #dc3545; /* Red */
		}
		.status-badge.recalled { /* 회수 (ESC005) */
		    background-color: #ffc107; /* Orange */
		    color: #343a40; /* Darker text for contrast on orange */
		}
		/* ---------------------------------- */
		/* Approval Line Table                */
		/* ---------------------------------- */
		table.table { /* Bootstrap 'table' 클래스 */
		    width: 100%;
		    border-collapse: collapse;
		    margin-bottom: 25px;
		    border: 1px solid #ddd; /* 테이블 전체 테두리 */
		}
		table.table th, table.table td {
		    border: 1px solid #ddd; /* 셀 테두리 */
		    padding: 10px;
		    text-align: center; /* 모든 셀 기본 가운데 정렬 */
		    vertical-align: middle;
		}
		table.table thead th {
		    background-color: #f8f8f8;
		    font-weight: 700;
		    color: #444;
		}
		table.table tbody td img {
		    max-width: 50px;
		    max-height: 50px;
		    display: block; /* 이미지 중앙 정렬 */
		    margin: 0 auto;
		}
		table.table tbody td div {
		    min-width: 50px; /* placeholder 최소 너비 */
		    min-height: 50px; /* placeholder 최소 높이 */
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    margin: 0 auto;
		}
		/* ---------------------------------- */
		/* Document Content                   */
		/* ---------------------------------- */
		.approval-detail-row {
		    margin-bottom: 20px; /* 섹션 간 간격 */
		}
		.approval-detail-row strong {
		    font-size: 1.1em;
		    color: #2c3e50;
		    display: block; /* 블록 요소로 제목처럼 보이게 */
		    margin-bottom: 8px;
		}
		.approval-detail-content-box {
		    border: 1px solid #e0e0e0;
		    background-color: #fcfcfc; /* 내용 박스 배경색 */
		    border-radius: 6px;
		    padding: 18px 16px;
		    min-height: 150px; /* 최소 높이 */
		    overflow-y: auto; /* 내용 길어질 경우 스크롤 */
		    line-height: 1.8; /* 줄 간격 */
		    color: #444;
		    white-space: nowrap;
		}

		.mb-2.align-items-center { /* 첨부파일 리스트 컨테이너 */
		    margin-top: 20px;
		    border-top: 1px dashed #eee;
		    padding-top: 15px;
		}
		.mb-2.align-items-center .col-form-label {
		    font-size: 1em;
		    color: #2c3e50;
		    margin-bottom: 8px;
		}
		.mb-2.align-items-center .p-1 a {
		    color: #007bff; /* 파일 다운로드 링크 색상 */
		    text-decoration: underline;
		}
		.mb-2.align-items-center .p-1 a:hover {
		    color: #0056b3;
		}
		/* 첨부된 파일이 없을 때 메시지 */
		.mb-2.align-items-center > .col-lg-10 {
		    color: #777;
		    font-size: 1em;
		    margin: 3px;
		}

		/* ---------------------------------- */
		/* Reference List                     */
		/* ---------------------------------- */
		.approval-detail-row:last-of-type { /* 참조자 리스트 */
		    margin-bottom: 20px;
		    border-top: 1px dashed #eee;
		    padding-top: 15px;
		    color: #555;
		    font-size: 0.95em;
		}
		.approval-detail-row:last-of-type strong {
		    font-size: 1.05em;
		    color: #2c3e50;
		}

		/* ---------------------------------- */
		/* Rejection Reason Section           */
		/* ---------------------------------- */
		.approval-detail-card h6 {
		    font-size: 1.2em;
		    color: #2c3e50;
		    margin-bottom: 10px;
		}
		.approval-detail-card hr {
		    border-top: 1px solid #e0e0e0;
		    margin-bottom: 20px;
		}
		.card.mb-3.shadow-sm {
		    border: 1px solid #ffccba; /* 반려 사유 카드 테두리 */
		    background-color: #fff3f2; /* 반려 사유 카드 배경 */
		    border-radius: 8px;
		    box-shadow: 0 2px 8px rgba(0,0,0,0.05) !important;
		}
		.card-body {
		    padding: 15px;
		}
		.card-body strong {
		    color: #dc3545; /* 반려 아이콘/이름 색상 */
		    font-size: 1em;
		    display: inline-block;
		    margin-bottom: 5px;
		}
		.card-body strong i {
		    margin-right: 5px;
		}
		.card-body small {
		    font-size: 1em;
		    color: #777;
		}
		.card-text {
		    margin-top: 10px;
		    font-size: 1em;
		    color: #444;
		}
		/* ---------------------------------- */
		/* Action Buttons                     */
		/* ---------------------------------- */
		.approval-detail-actions {
		    display: flex;
		    justify-content: flex-end; /* 버튼 오른쪽 정렬 */
		    gap: 12px;
		    margin-top: 30px;
		    padding-top: 20px;
		    border-top: 1px solid #eee; /* 버튼 위 구분선 */
		}

		.approval-btn {
		    background-color: #6c757d; /* 기본 버튼 회색 */
		    color: #ffffff;
		    border-radius: 6px;
		    padding: 10px 20px;
		    border: none;
		    font-size: 1em;
		    font-weight: 600;
		    cursor: pointer;
		    transition: background-color 0.2s ease, transform 0.1s ease, box-shadow 0.2s ease;
		    display: inline-flex;
		    align-items: center;
		    gap: 8px;
		    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
		}
		.approval-btn:hover {
		    background-color: #5a6268;
		    transform: translateY(-2px);
		    box-shadow: 0 4px 8px rgba(0,0,0,0.15);
		}

		.approval-btn.submit { /* 승인 버튼 */
		    background-color: #0d6efd;
		}
		.approval-btn.submit:hover {
		    background-color: #218838;
		}

		/* 반려 버튼 */
		.approval-btn[style*="background:#e53935"] { /* 기존 인라인 스타일을 타겟팅 */
		    background-color: #dc3545 !important; /* 표준 빨간색 */
		    color: #fff !important;
		}
		.approval-btn[style*="background:#e53935"]:hover {
		    background-color: #c82333 !important;
		}

		/* ---------------------------------- */
		/* Reject Modal                       */
		/* ---------------------------------- */
		#rejectModal .modal-header {
		    background-color: #f8f9fa;
		    border-bottom: 1px solid #e9ecef;
		    padding: 15px 20px;
		}
		#rejectModal .modal-title {
		    font-size: 1.25em;
		    font-weight: 600;
		    color: #343a40;
		}
		#rejectModal .modal-body {
		    padding: 20px;
		}
		#rejectModal textarea.form-control {
		    border: 1px solid #ced4da;
		    border-radius: 5px;
		    padding: 10px 12px;
		    font-size: 1em;
		    min-height: 120px;
		    resize: vertical; /* 수직 크기 조절 허용 */
		}
		#rejectModal textarea.form-control:focus {
		    border-color: #007bff;
		    box-shadow: 0 0 0 0.25rem rgba(0, 123, 255, 0.25);
		    outline: none;
		}
		#rejectModal .invalid-feedback {
		    display: none; /* JavaScript로 제어 */
		    color: #dc3545;
		    font-size: 1em;
		    margin-top: 5px;
		}
		#rejectModal .modal-footer {
		    padding: 15px 20px;
		    border-top: 1px solid #e9ecef;
		}
		#rejectModal .modal-footer .btn {
		    min-width: 90px;
		    font-weight: 600;
		}
		#rejectModal .btn-primary {
		    background-color: #007bff;
		    border-color: #007bff;
		}
		#rejectModal .btn-primary:hover {
		    background-color: #0056b3;
		    border-color: #0056b3;
		}
		#rejectModal .btn-outline-secondary {
		    border-color: #6c757d;
		    color: #6c757d;
		}
		#rejectModal .btn-outline-secondary:hover {
		    background-color: #6c757d;
		    color: #fff;
		}
    </style>
</head>
<body>
<sec:authentication property="principal" var="user"/>
    <div class="emp-container">
        <%@ include file="../modules/header.jsp" %>
        <div class="emp-body-wrapper">
            <%@ include file="../modules/aside.jsp" %>

            <main class="approval-content" style="font-size: large;">
                <div class="approval-detail-wrap" style="margin:0 auto;">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
						<ol class="breadcrumb">
						  <li class="breadcrumb-item"><a href="#" style="color:black;">전자결재</a></li>
						  <li class="breadcrumb-item location"><a href="#" style="color:black;">상신 문서함</a></li>
						  <li class="breadcrumb-item active" aria-current="page">기안서 상세</li>
						</ol>
					</nav>
                    <div class="approval-detail-card" style="background:#fff; border-radius:10px; box-shadow:0 2px 8px rgba(0,0,0,0.08); padding:32px 28px 24px 28px;">
                        <div class="approval-detail-title" style="font-size:1.4em;font-weight:700;color:#2c3e50;margin-bottom:18px;">${edmsVO.edmsTitle}</div>
                        	<div id="approval-line-box">
                        		<table >
	                        		<tr>
	                        			<td style="border-color: white;">
					                        <div class="approval-detail-row" style="display:flex;gap:18px;margin-bottom:12px;">
					                            <div style="flex:1;"><strong>문서번호</strong> <br> ${edmsVO.edmsManageNo}</div>
					                            <div style="flex:1;"><strong>긴급도</strong> <br>
					                            	<c:if test="${edmsVO.edmsUrgenYn eq 'Y'}">
					                            		<span style="color:#ec841a;">긴급</span>
					                            	</c:if>
					                            	<c:if test="${edmsVO.edmsUrgenYn eq 'N'}">
					                            		<span style="color:#000; ">일반</span>
					                            	</c:if>
					                             </div>
					                             <div style="flex:1;"><strong>결재상태</strong> <br>
							                       	<c:choose>
							                       		<c:when test="${edmsVO.edmsStatCode eq 'ESC001'}"><span style="color : #818681;">결재 대기</span></c:when>
							                       		<c:when test="${edmsVO.edmsStatCode eq 'ESC002'}"><span style="color : #4caf50;">결재 진행</span></c:when>
							                       		<c:when test="${edmsVO.edmsStatCode eq 'ESC003'}"><span style="color : #007bff;">승인</span></c:when>
							                       		<c:when test="${edmsVO.edmsStatCode eq 'ESC004'}"><span style="color : #b71c1c;">반려</span></c:when>
							                       		<c:when test="${edmsVO.edmsStatCode eq 'ESC005'}"><span style="color : #ec841a;">회수</span></c:when>
							                       	</c:choose>
							                      </div>
					                        </div>
	                        			</td>
	                        		</tr>
	                        		<tr>
	                        			<td style="border-color: white;">
					                        <div class="approval-detail-row" style="display:flex;gap:18px;margin-bottom:12px;">
					                            <div style="flex:1;"><strong>기안자</strong> <br> ${edmsVO.empName}</div>
					                            <div style="flex:1;"><strong>기안일</strong> <br> <fmt:formatDate value="${edmsVO.edmsReqDate}" type="date" pattern="yyyy년 MM월 dd일"/></div>
					                        </div>
	                        			</td>
	                        		</tr>
		                        </table>
	                        	<c:set value="${edmsVO.approverList}" var="approverList"/>
	                        	<c:set var="mySec" value="true"/>
	                        	<c:set var="approveCheck" value="false"/>
	                        	<table class="table">
                        		<tr>
                        			<c:forEach items="${approverList}" var="approver" varStatus="vs">
                        				<c:if test="${ vs.last and approver.empUsername eq user.username and approver.apvSec eq 2 and edmsVO.edmsStatCode eq 'ESC001'}">
                        					<c:set var="mySec" value="false"/>
                        				</c:if>
                        				<c:if test="${vs.first and approver.empUsername eq user.username and approver.apvSec eq 1 and edmsVO.edmsStatCode eq 'ESC002' }">
                        					<c:set var="approveCheck" value="true"/>
                        				</c:if>
	                        			<th style="text-align: center; font-weight: bold;">
											<small>${approver.empDepartNm}</small><br>
											<span>${approver.empName} ${approver.empPositionNm }</span>
                        				</th>
                        			</c:forEach>
                        		</tr>
                        		<tr>
                        			<c:forEach items="${approverList}" var="approver">
	                        			<td>
	                        				<c:choose>
		                        				<c:when test="${approver.apvStatCode eq 'ASC003'}">
		                        					<div class="d-flex justify-content-center align-items-center">
				                        				<img alt="승인" src="${pageContext.request.contextPath}/resources/img/approved.png" width="50px" height="50px">
		                        					</div>
		                        				</c:when>
		                        				<c:when test="${approver.apvStatCode eq 'ASC004'}">
		                        					<div class="d-flex justify-content-center align-items-center">
				                        				<img alt="반려" src="${pageContext.request.contextPath}/resources/img/rejected.png" width="50px" height="50px">
		                        					</div>
		                        				</c:when>
	                        					<c:otherwise>
	                        						<div style="width:50px; height:50px;">
	                        							&nbsp;
	                        						</div>
	                        					</c:otherwise>
	                        				</c:choose>
	                        			</td>
                        			</c:forEach>
                        		</tr>
                        	</table>
                        </div>
                        <div class="approval-detail-row" style="margin-bottom:12px;"><strong>내용</strong>
                            <div class="approval-detail-content-box" style="border-radius:6px;padding:16px 14px;margin-top:6px;">
								${edmsVO.edmsContent}
                            </div>
                            <div class="mb-2 align-items-center">
	                            <label class="col-lg-2 col-md-3 col-form-label col-form-label-sm fw-semibold text-dark">첨부파일 리스트</label>
	                            <div class="col-lg-10 col-md-9">
	                            	<c:choose>
	                            		<c:when test="${empty edmsVO.fileList}">
	                            			첨부된 파일이없습니다.
	                            		</c:when>
	                            		<c:otherwise>
		                            		<c:forEach items="${edmsVO.fileList}" var="file">
		                            			<div class="p-1" >
													<a href="${pageContext.request.contextPath}/emp/edms/file/download/${file.attachDetailNo}" >${file.fileOriginalNm}</a>
												</div>
		                            		</c:forEach>
	                            		</c:otherwise>
	                            	</c:choose>
	                            </div>
	                        </div>
                        </div>
                        <c:set var="referenceFlag" value="false"/>
                        <div class="approval-detail-row" style="margin-bottom:12px;"><strong>참조자:</strong>
                        	<c:forEach items="${edmsVO.referenceList}" var="reference">
                        		<c:if test="${reference.empUsername eq user.username }"> <c:set value="true" var="referenceFlag"/> </c:if>
                        		${reference.empName} ${reference.empPositionNm}
                        	</c:forEach>
                        </div>

                        <c:if test="${edmsVO.edmsStatCode eq 'ESC004' and edmsVO.empUsername eq user.username}">
	                        <h6>문서 반려 사유</h4>
						    <hr>

						    <c:forEach items="${approverList}" var="approver">
						        <c:if test="${approver.apvStatCode eq 'ASC004'}">
						            <div class="card mb-3 shadow-sm">
						                <div class="card-body">
						                    <strong class="mb-0">
						                        <i class="bi bi-x-circle-fill me-2"></i>
						                        ${approver.empName} (${approver.empPositionNm})
						                    </strong>
						                    <small>
						                        <c:if test="${not empty approver.apvResDate}">
						                            <span class="float-end"><fmt:formatDate value="${approver.apvResDate}" pattern="yyyy/MM/dd"/></span>
						                        </c:if>
						                    </small>
						                    <p class="card-text">${approver.apvRejectReason}</p>
						                </div>
						            </div>
						        </c:if>
						    </c:forEach>
                        </c:if>
                        <div class="approval-detail-actions" style="display:flex;justify-content:flex-end;gap:12px;margin-top:24px;">
    	                    <c:if test="${(not referenceFlag) and (edmsVO.edmsStatCode eq 'ESC001' or edmsVO.edmsStatCode eq 'ESC002') and edmsVO.empUsername ne user.username and (not approveCheck)}">
    	                    	<c:if test="${mySec}">
		                            <button class="approval-btn submit" id="approveBtn" data-edms-no="${edmsVO.edmsNo}" data-emp-username="${user.username}"><i class="fas fa-check"></i> 승인</button>
		                            <button class="approval-btn" id="rejectBtn" data-bs-target="#rejectModal" data-bs-toggle="modal" style="background:#e53935;color:#fff;"><i class="fas fa-times"></i> 반려</button>
    	                    	</c:if>
	                        </c:if>
	                        <c:if test="${edmsVO.edmsStatCode eq 'ESC001' and edmsVO.empUsername eq user.username}">
		                    	<button class="approval-btn" id="cancelBtn" style="background-color: #234add"><i class="fa-solid fa-reply"></i> 회수</button>
	                        </c:if>
	                    	<button class="approval-btn btn btn-primary" id="listBtn"><i class="fa-solid fa-list"></i> 목록</button>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
<!-- 반려 사유 입력 모달 -->
<div class="modal fade" id="rejectModal" tabindex="-1" aria-labelledby="rejectModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md modal-dialog-centered">
	    <div class="modal-content">

	        <div class="modal-header bg-light">
	            <h5 class="modal-title fw-bold" id="rejectModalLabel">반려 사유 입력</h5>
	            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	        </div>

	        <div class="modal-body">
	            <textarea class="form-control" id="apvRejectReason" rows="4" placeholder="반려 사유를 입력하세요 (필수)" maxlength="300" required></textarea>
	            <div class="invalid-feedback">
	                반려 사유를 입력해주세요.
	            </div>
	        </div>

	        <div class="modal-footer justify-content-center border-top-0">
	            <button type="button" class="btn btn-primary px-4" id="rejectModalBtn" data-edms-no="${edmsVO.edmsNo}" data-emp-username="${user.username}">확인</button>
                <button type="button" class="btn btn-outline-secondary px-4" id="reject-modal-cancel" data-bs-dismiss="modal">취소</button>
           	</div>
        </div>
    </div>
</div>
</body>
<%@ include file="../../modules/footerPart.jsp" %>

<%@ include file="../../modules/sidebar.jsp" %>
<script>
$(function(){
	const listBtn = $("#listBtn"); // 목록가기 버튼
	let baseurl = sessionStorage.getItem("baseurl") || "/emp/edms/approvalBox";
	let breadcrumb = $("ol.breadcrumb");
	let locationItem = breadcrumb.find("li.location").find("a");
	if(baseurl == "/emp/edms/approvalBox"){
		locationItem.text("상신 문서함")
		locationItem.attr("href","${pageContext.request.contextPath}/emp/edms/approvalBox");
	}else{
		locationItem.text("받은 결재/참조 문서함")
		locationItem.attr("href","${pageContext.request.contextPath}/emp/edms/requestList");
	}

	listBtn.on("click",function(){
		let searchWord = sessionStorage.getItem("searchWord") || "";
		let searchType = sessionStorage.getItem("searchType") || "";
		let currentPage = sessionStorage.getItem("currentPage") || 1;

		sessionStorage.removeItem("baseurl");
		sessionStorage.removeItem("currentPage");
		sessionStorage.removeItem("searchWord");
		sessionStorage.removeItem("searchType");

		location.href="${pageContext.request.contextPath}"+baseurl+"?currentPage="+currentPage+"&searchType="+searchType+"&searchWord="+searchWord;
	})


	let flag = ${mySec};
	$("#rejectModalBtn").on("click",function(){
		let edmsNo = $(this).data("edmsNo");
		let empUsername = $(this).data("empUsername");
		let apvRejectReason = $("#apvRejectReason").val();

		if(apvRejectReason == null || apvRejectReason.trim() == ""){
			sweetAlert("error","사유를 입력해주세요");
			return false;
		}
		let data = {
			edmsNo, empUsername, apvRejectReason
		}

		$.ajax({
			url : "/api/emp/edms/reject",
			type : "post",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(data),
			beforeSend : function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}")
			},
			success : function(res){
				if(res == 'OK'){
					Swal.fire({
						title : "해당 결재문서를 반려했습니다.",
						icon : "success",
						draggable : true,
						showConfirmButton: false,
			            timer: 1500,
					}).then(res => location.reload());
				}
			},
			error : function(err){
				sweetAlert("error","해당 결재문서를 반려하는 도중 문제가 발생했습니다. 다시 시도해주세요")
			}
		})
	});

	$("#approveBtn").on("click",function(){

		let edmsNo = $(this).data("edmsNo");
		let empUsername = $(this).data("empUsername");

		data = {edmsNo, empUsername};

		$.ajax({
			url : "/api/emp/edms/approve",
			type : "post",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(data),
			beforeSend : function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}")
			},
			success : function(res){
				if(res == 'OK'){
					Swal.fire({
						title : "해당 결재문서를 승인했습니다.",
						icon : "success",
						draggable : true,
						showConfirmButton: false,
			            timer: 1500,
					}).then(res => location.reload());
				}
			},
			error : function(err){
				sweetAlert("error","해당 결재문서를 승인하는 도중 문제가 발생했습니다. 다시 시도해주세요")
			}
		})
	})

	$("#cancelBtn").on("click",function(){
		Swal.fire({
			   title: '회수 하시겠습니까?',
			   text: '회수 후 다시 상신해주셔야합니다.',
			   icon: 'warning',

			   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
			   confirmButtonText: '회수', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정

			}).then(result => {
			   // 만약 Promise리턴을 받으면,
			    if(result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
					$.ajax({
						url : `/api/emp/edms/withdraw?edmsNo=${edmsVO.edmsNo}`,
						type : "post",
						beforeSend : function(xhr){
							xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}")
						},
						success : function(res){
							if(res == "OK"){
								sweetAlert("success","성공적으로 회수했습니다.").then((data)=>{
									location.href = "${pageContext.request.contextPath}/emp/edms/approvalBox"
								})
							}
						},
						error : function(err){
							sweetAlert("error","회수도중 문제가 발생했습니다. 다시 시도해주세요!");
						}

					})

			    }
			});
	})

});
</script>
</html>