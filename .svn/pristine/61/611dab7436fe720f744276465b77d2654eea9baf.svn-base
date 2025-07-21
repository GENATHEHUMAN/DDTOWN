<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>굿즈샵 공지사항 상세 - DDTOWN 관리자 시스템</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <%@ include file="../../../modules/headerPart.jsp" %>
    <style>
        .goods-notice-detail-section {
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .notice-detail-header {
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        .notice-detail-header h2 {
            margin: 0 0 10px 0;
            font-size: 1.5em;
            color: #333;
        }
        .notice-meta {
            color: #777;
            font-size: 0.95em;
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .notice-meta span {
            display: flex;
            align-items: center;
        }
        .notice-meta i {
            margin-right: 5px;
        }
        .notice-content {
            margin: 20px 0 30px;
            line-height: 1.8;
            font-size: 1.05em;
            white-space: pre-wrap;
        }
        .attachment-section {
            margin-top: 20px;
            padding-top: 15px;
            border-top: 1px dashed #eee;
        }
        .attachment-section h4 {
            margin: 0 0 10px 0;
            color: #333;
        }
        .attachment-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .attachment-list li {
            margin: 5px 0;
        }
        .attachment-list a {
            color: #007bff;
            text-decoration: none;
        }
        .attachment-list a:hover {
            text-decoration: underline;
        }
        .notice-actions {
            margin-top: 30px;
            text-align: right;
        }
        .emp-btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            margin-left: 8px;
        }
        .emp-btn i {
            margin-right: 5px;
        }
        .emp-btn.primary {
            background-color: #007bff;
            color: white;
        }
        .emp-btn.primary:hover {
            background-color: #0056b3;
        }
        .emp-btn.danger {
            background-color: #dc3545;
            color: white;
        }
        .emp-btn.danger:hover {
            background-color: #c82333;
        }
        .emp-btn.default {
            background-color: #6c757d;
            color: white;
        }
        .emp-btn.default:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
    <div class="emp-container">
        <%@ include file="../../modules/header.jsp" %>
        <div class="emp-body-wrapper">
            <%@ include file="../../modules/aside.jsp" %>
            <main class="emp-content">
            <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/admin/goods/notice/list" style="color:black;">굿즈샵 관리</a></li>
                        <li class="breadcrumb-item"><a href="/admin/goods/notice/list" style="color:black;">공지사항 관리</a></li>
                        <li class="breadcrumb-item active" aria-current="page">공지사항 상세</li>
                    </ol>
                </nav>
                <section class="goods-notice-detail-section">
                    <div class="notice-detail-header">
                        <h2 id="noticeTitle">${notice.goodsNotiTitle}</h2>
                        <div class="notice-meta">
                            <span><i class="fas fa-user"></i> 작성자: ${notice.empUsername}</span>
                            <span><i class="fas fa-calendar-alt"></i> 작성일: <span id="noticeRegDate"><fmt:formatDate value="${notice.goodsRegDate}" pattern="yyyy-MM-dd"/></span></span>
                            <c:if test="${not empty notice.goodsModDate}">
                                <span><i class="fas fa-history"></i> 수정일: <span id="noticeModDate"><fmt:formatDate value="${notice.goodsModDate}" pattern="yyyy-MM-dd"/></span></span>
                            </c:if>
                        </div>
                    </div>
                    <div id="noticeContent" class="notice-content">
                        ${notice.goodsNotiContent}
                    </div>

                    <c:if test="${not empty notice.fileGroupNo && not empty notice.fileDetailList}">
                        <div class="attachment-section" id="attachmentSection">
                            <h4><i class="fas fa-paperclip"></i> 첨부파일</h4>
                            <ul class="attachment-list" id="attachmentList">
                                <c:forEach var="file" items="${notice.fileDetailList}">
                                    <li>
                                        <i class="fas fa-file-alt"></i>
                                        <a href="${pageContext.request.contextPath}/files/${file.fileSavepath}/${file.fileSaveNm}" target="_blank" download="${file.fileOriginalNm}">
                                            ${file.fileOriginalNm} (${file.fileFancysize})
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:if>
                    <c:if test="${not empty notice.fileGroupNo && empty notice.fileDetailList}">
                         <div class="attachment-section">
                            <h4><i class="fas fa-paperclip"></i> 첨부파일</h4>
                            <p>첨부된 파일이 없습니다.</p>
                        </div>
                    </c:if>

                    <div class="notice-actions">
					    <a href="/admin/goods/notice/list?currentPage=${currentPage}&searchType=${searchType}&searchWord=${searchWord}" class="emp-btn default">
					        <i class="fas fa-list"></i> 목록
					    </a>
					
					    <a href="/admin/goods/notice/form?id=${notice.goodsNotiNo}" class="emp-btn primary"><i class="fas fa-edit"></i> 수정</a>
					    <button type="button" id="deleteNoticeBtn" class="emp-btn danger" data-goods-noti-no="${notice.goodsNotiNo}"><i class="fas fa-trash"></i> 삭제</button>
					</div>
                </section>
            </main>
        </div>
    </div>
<%@ include file="../../../modules/footerPart.jsp" %>

<%@ include file="../../../modules/sidebar.jsp" %>
<script>
document.addEventListener('DOMContentLoaded', function() {
    const deleteButton = document.getElementById('deleteNoticeBtn');

    if (deleteButton) {
        deleteButton.addEventListener('click', function() {
            const goodsNotiNo = this.dataset.goodsNotiNo;

            if (confirm('정말로 이 공지사항을 삭제하시겠습니까?')) {
                const form = document.createElement('form');
                form.setAttribute('method', 'post');
                form.setAttribute('action', '/admin/goods/notice/delete');

                // CSRF 토큰 추가 (삭제 폼에도 필요합니다!)
                const csrfParamName = "${_csrf.parameterName}";
                const csrfToken = "${_csrf.token}";
                const csrfHiddenInput = document.createElement('input');
                csrfHiddenInput.setAttribute('type', 'hidden');
                csrfHiddenInput.setAttribute('name', csrfParamName);
                csrfHiddenInput.setAttribute('value', csrfToken);
                form.appendChild(csrfHiddenInput);

                const hiddenInput = document.createElement('input');
                hiddenInput.setAttribute('type', 'hidden');
                hiddenInput.setAttribute('name', 'id');
                hiddenInput.setAttribute('value', goodsNotiNo);

                form.appendChild(hiddenInput);
                document.body.appendChild(form);
                form.submit();
            }
        });
    }
});
</script>
</body>
</html>