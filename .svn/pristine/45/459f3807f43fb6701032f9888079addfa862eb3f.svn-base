<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:choose><c:when test="${mode == 'edit'}">공지사항 수정</c:when><c:otherwise>공지사항 등록</c:otherwise></c:choose> - DDTOWN 관리자</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <%-- CSS 파일 경로 수정: ${pageContext.request.contextPath}/resources/css/admin/ 를 기준으로 설정 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/admin_portal.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/notice_custom.css">
    <style>
        /* 기존 스타일 유지 또는 외부 CSS 파일로 이동 */
        .emp-sidebar .emp-nav-item.active,
        .emp-sidebar .emp-nav-item.open {
            background-color: #495057;
            color: #fff;
        }
        .emp-submenu { padding-left: 20px; }
        .emp-submenu a.active { font-weight: bold; color: var(--primary-color, #007bff); }
        .submenu-arrow { transition: transform 0.3s ease; display: inline-block; }
        .emp-nav-item.open .submenu-arrow { transform: rotate(90deg); }
        .current-attachments-list { list-style: none; padding-left: 0; }
        .current-attachments-list li { margin-bottom: 5px; }
        .current-attachments-list button { margin-left: 10px; background: none; border: none; color: red; cursor: pointer; }
        .current-attachments-list button .fa-times { font-size: 0.9em; }
        .file-input-wrapper { margin-bottom: 10px; }
    </style>
</head>
<body>
    <div class="emp-container">
        <header class="emp-header">
            <div class="emp-logo"><a href="${pageContext.request.contextPath}/admin/main">DDTOWN 관리자 포털</a></div>
            <div class="emp-user-info">
                <span><i class="fas fa-user-circle"></i> <c:out value="${loginAdmin.adminName}" default="관리자"/> (<c:out value="${loginAdmin.adminId}" default="admin_user"/>)</span>
                <a href="${pageContext.request.contextPath}/admin/logout" class="emp-logout-btn" id="adminLogoutBtn"><i class="fas fa-sign-out-alt"></i> 로그아웃</a>
            </div>
        </header>
        <div class="emp-body-wrapper">
            <aside class="emp-sidebar">
                <nav class="emp-nav">
                     <ul>
                        <li>
                            <a href="${pageContext.request.contextPath}/admin/notice/list" class="emp-nav-item active" data-menu="corp"> <i class="fas fa-bullhorn"></i> 공지사항 관리 </a>
                        </li>
                        <li>
                            <a href="#" class="emp-nav-item has-submenu" data-menu="cs">
                                <i class="fas fa-headset"></i> 고객센터 <span class="submenu-arrow">&gt;</span>
                            </a>
                            <ul class="emp-submenu" id="submenu-cs" style="display: none;">
                                <li><a href="${pageContext.request.contextPath}/admin/cs/faq/list" class="emp-nav-item">FAQ 관리</a></li>
                                <li><a href="${pageContext.request.contextPath}/admin/cs/inquiry/list" class="emp-nav-item">1:1문의 관리</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="#" class="emp-nav-item has-submenu" data-menu="community">
                                <i class="fas fa-users"></i> 아티스트 커뮤니티 관리 <span class="submenu-arrow">&gt;</span>
                            </a>
                            <ul class="emp-submenu" id="submenu-community" style="display: none;">
                                <li><a href="${pageContext.request.contextPath}/admin/community/member/list" class="emp-nav-item">회원관리</a></li>
                                <li><a href="${pageContext.request.contextPath}/admin/community/artist/list" class="emp-nav-item">아티스트 관리</a></li>
                                <li><a href="${pageContext.request.contextPath}/admin/community/group/list" class="emp-nav-item">그룹 관리</a></li>
                                <li><a href="${pageContext.request.contextPath}/admin/community/report/list" class="emp-nav-item">신고 관리</a></li>
                                <li><a href="${pageContext.request.contextPath}/admin/community/blacklist/list" class="emp-nav-item">블랙리스트 관리</a></li>
                                <li><a href="${pageContext.request.contextPath}/admin/community/apt/list" class="emp-nav-item">APT 관리</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="#" class="emp-nav-item has-submenu" data-menu="goods">
                                <i class="fas fa-store"></i> 굿즈샵 관리 <span class="submenu-arrow">&gt;</span>
                            </a>
                            <ul class="emp-submenu" id="submenu-goods" style="display: none;">
                                <li><a href="${pageContext.request.contextPath}/admin/goods/notice/list" class="emp-nav-item">공지사항 관리</a></li>
                                <li><a href="${pageContext.request.contextPath}/admin/goods/items/list" class="emp-nav-item">품목 관리</a></li>
                                <li><a href="${pageContext.request.contextPath}/admin/goods/categories/list" class="emp-nav-item">품목 카테고리 관리</a></li>
                                <li><a href="${pageContext.request.contextPath}/admin/goods/orders/list" class="emp-nav-item">주문내역 관리</a></li>
                                <li><a href="${pageContext.request.contextPath}/admin/goods/cancelRefund/list" class="emp-nav-item">취소 / 환불 관리</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/admin/stats" class="emp-nav-item" data-menu="stats">
                                <i class="fas fa-chart-line"></i> 통계관리
                            </a>
                        </li>
                    </ul>
                </nav>
            </aside>
            <main class="emp-content">
                <div class="notice-main-box">
                    <h2 class="notice-form-title">
                        <c:choose>
                            <c:when test="${mode == 'edit'}">공지사항 수정</c:when>
                            <c:otherwise>공지사항 등록</c:otherwise>
                        </c:choose>
                    </h2>
                    <%-- 폼 전송 시 파일 업로드를 위해 enctype="multipart/form-data" 추가 --%>
                    <form class="notice-form" id="noticeForm" action="${pageContext.request.contextPath}/admin/notice/save" method="post" enctype="multipart/form-data">
                        <%-- CSRF 토큰 (Spring Security 사용 시) --%>
                        <%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> --%>

                        <%-- 수정 모드일 경우 공지사항 ID를 hidden 필드로 전달 --%>
                        <c:if test="${mode == 'edit'}">
                            <input type="hidden" id="entNotiNo" name="entNotiNo" value="<c:out value='${noticeVO.entNotiNo}'/>">
                        </c:if>
                        <input type="hidden" name="mode" value="<c:out value='${mode}' default='new'/>">
                        <div class="notice-form-group">
                            <label for="noticeTitleInput">제목</label>
                            <input type="text" id="noticeTitleInput" name="entNotiTitle" placeholder="공지사항 제목을 입력하세요" value="<c:out value='${noticeVO.entNotiTitle}'/>" required>
                        </div>
                        <div class="notice-form-group">
                            <label for="noticeContentInput">내용</label>
                            <%-- CKEditor 등을 사용한다면 해당 에디터 초기화 로직 필요 --%>
                            <textarea id="noticeContentInput" name="entNotiContent" placeholder="공지사항 내용을 입력하세요" required><c:out value='${noticeVO.entNotiContent}'/></textarea>
                        </div>
                        <div class="notice-form-group">
                            <label for="noticeAttachmentsInput">첨부파일</label>
                            <div class="file-input-wrapper">
                                <%-- name 속성은 컨트롤러에서 MultipartFile 리스트로 받을 때의 이름과 일치해야 함 --%>
                                <input type="file" id="noticeAttachmentsInput" name="uploadFiles" multiple>
                            </div>
                            <c:if test="${mode == 'edit' && not empty noticeVO.attachmentList}">
                                <div id="currentAttachments" style="margin-top:10px;">
                                    <h4>기존 첨부파일:</h4>
                                    <ul class="current-attachments-list" id="currentAttachmentsList">
                                        <c:forEach var="file" items="${noticeVO.attachmentList}">
                                            <li data-file-id="${file.fileId}"> <%-- 파일의 고유 ID를 data 속성으로 저장 --%>
                                                <c:out value="${file.originalFileName}"/> (<fmt:formatNumber value="${file.fileSize / 1024}" maxFractionDigits="1"/> KB)
                                                <%-- 기존 파일 삭제를 위한 체크박스 또는 버튼 (서버에서 처리 로직 필요) --%>
                                                <label style="margin-left: 10px;">
                                                    <input type="checkbox" name="deleteFileIds" value="${file.fileId}"> 삭제
                                                </label>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </c:if>
                        </div>
                       <%--  <div class="notice-form-group">
                            <label>
                                <input type="checkbox" id="isFixed" name="important" value="true" ${noticeVO.important ? 'checked' : ''}>
                                <span class="fixed-label-text">상단고정 (체크 시 목록 상단에 노출)</span>
                            </label>
                            체크되지 않았을 때 false 값을 보내기 위한 hidden input (선택적)
                             <input type="hidden" name="_important" value="on"/>
                        </div> --%>
                        <div class="notice-form-actions">
                            <button type="button" class="btn btn-detail" onclick="location.href='${pageContext.request.contextPath}/admin/notice/list'"><i class="fas fa-times"></i> 취소</button>
                            <button type="submit" class="btn btn-edit">
                                <i class="fas fa-save"></i> <c:choose><c:when test="${mode == 'edit'}">수정 완료</c:when><c:otherwise>등록</c:otherwise></c:choose>
                            </button>
                        </div>
                    </form>
                </div>
            </main>
        </div>
        <footer class="emp-footer">
            <p>&copy; <fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy"/> DDTOWN Entertainment. All rights reserved.</p>
        </footer>
    </div>
    <script>
        // 로그아웃 기능
        const logoutButton = document.getElementById('adminLogoutBtn');
        if (logoutButton) {
            logoutButton.addEventListener('click', function(e) {
                e.preventDefault();
                if (confirm('로그아웃 하시겠습니까?')) {
                    window.location.href = '${pageContext.request.contextPath}/admin/logout';
                }
            });
        }

        // 사이드바 메뉴 기능 (기존 HTML의 스크립트 로직 유지)
        document.addEventListener('DOMContentLoaded', function() {
            const navItemsWithSubmenu = document.querySelectorAll('.emp-sidebar .emp-nav-item.has-submenu');
            navItemsWithSubmenu.forEach(item => {
                const arrow = item.querySelector('.submenu-arrow');
                item.addEventListener('click', function(event) {
                     if (this.getAttribute('href') === '#') {
                        event.preventDefault();
                    }
                    const parentLi = this.parentElement;
                    const submenu = this.nextElementSibling;

                    if (submenu && submenu.classList.contains('emp-submenu')) {
                        const parentUl = parentLi.parentElement;
                        if (parentUl) {
                            Array.from(parentUl.children).forEach(siblingLi => {
                                if (siblingLi !== parentLi) {
                                    const siblingSubmenuControl = siblingLi.querySelector('.emp-nav-item.has-submenu.open');
                                    if (siblingSubmenuControl) {
                                        const siblingSubmenu = siblingSubmenuControl.nextElementSibling;
                                        siblingSubmenuControl.classList.remove('open');
                                        if (siblingSubmenu && siblingSubmenu.classList.contains('emp-submenu')) {
                                            siblingSubmenu.style.display = 'none';
                                        }
                                        const siblingArrow = siblingSubmenuControl.querySelector('.submenu-arrow');
                                        if (siblingArrow) siblingArrow.style.transform = 'rotate(0deg)';
                                    }
                                }
                            });
                        }
                    }
                    
                    this.classList.toggle('open');
                    if (submenu && submenu.classList.contains('emp-submenu')) {
                        submenu.style.display = this.classList.contains('open') ? 'block' : 'none';
                        if (arrow) arrow.style.transform = this.classList.contains('open') ? 'rotate(90deg)' : 'rotate(0deg)';
                    }
                });
            });

            const currentFullHref = window.location.href;
            const contextPath = "${pageContext.request.contextPath}";

            document.querySelectorAll('.emp-sidebar .emp-nav-item[href]').forEach(link => {
                const linkHrefAttribute = link.getAttribute('href');
                if (linkHrefAttribute && linkHrefAttribute !== "#") {
                    const fullLinkPath = (linkHrefAttribute.startsWith(contextPath) ? linkHrefAttribute : contextPath + linkHrefAttribute);
                    if (currentFullHref.startsWith(fullLinkPath)) {
                        link.classList.add('active');
                        let currentActiveElement = link;
                        while (currentActiveElement) {
                            const parentSubmenuUl = currentActiveElement.closest('.emp-submenu');
                            if (parentSubmenuUl) {
                                parentSubmenuUl.style.display = 'block';
                                const controllingAnchor = parentSubmenuUl.previousElementSibling;
                                if (controllingAnchor && controllingAnchor.classList.contains('has-submenu')) {
                                    controllingAnchor.classList.add('active', 'open');
                                    const arrow = controllingAnchor.querySelector('.submenu-arrow');
                                    if (arrow) {
                                        arrow.style.transform = 'rotate(90deg)';
                                    }
                                    currentActiveElement = controllingAnchor;
                                } else { currentActiveElement = null; }
                            } else { currentActiveElement = null; }
                        }
                    }
                }
            });

            // 폼 제출 로직 (필요시 여기에 유효성 검사 등 추가)
            const noticeForm = document.getElementById('noticeForm');
            if (noticeForm) {
                noticeForm.addEventListener('submit', function(event) {
                    // event.preventDefault(); // 기본 제출을 막고 AJAX로 처리하려면 주석 해제
                    // 폼 유효성 검사 로직 추가 가능
                    const title = document.getElementById('noticeTitleInput').value;
                    const content = document.getElementById('noticeContentInput').value;
                    if (!title.trim() || !content.trim()) {
                        alert('제목과 내용은 필수 입력 항목입니다.');
                        event.preventDefault(); // 폼 제출 중단
                        return;
                    }
                    // 실제 폼 제출 (기본 동작)
                    // alert(( '${mode}' === 'edit' ? '수정' : '등록') + ' 요청을 서버로 보냅니다.');
                });
            }
        });

        // 기존 첨부파일 삭제 관련 로직은 서버에서 처리 후 결과를 받아와야 하므로,
        // 여기서는 단순히 UI에서만 제거하는 예시는 생략하고,
        // 폼 제출 시 삭제할 파일 ID 목록 (deleteFileIds)을 서버로 보내는 방식으로 처리합니다.
    </script>
</body>
</html>
