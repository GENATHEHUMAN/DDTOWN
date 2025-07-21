<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %> <%-- fn:escapeXml 또는 기타 함수 사용을 위해 --%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 상세 - DDTOWN 관리자</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <%-- CSS 파일 경로 수정: ${pageContext.request.contextPath}/resources/css/admin/ 를 기준으로 설정 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/admin_portal.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/notice_custom.css">
    <style>
        /* JSP에 직접 스타일을 넣는 것보다 외부 CSS 파일로 분리하는 것이 좋습니다. */
        /* admin_portal.css 또는 notice_custom.css 파일로 이 스타일들을 옮기는 것을 권장합니다. */
        .emp-sidebar .emp-nav-item.active,
        .emp-sidebar .emp-nav-item.open {
            background-color: #495057; /* 예시 활성/오픈 배경색 */
            color: #fff;
        }
        .emp-submenu {
            padding-left: 20px;
        }
        .emp-submenu a.active {
            font-weight: bold;
            color: var(--primary-color, #007bff); /* 기본값 설정 */
        }
        .submenu-arrow {
            transition: transform 0.3s ease;
            display: inline-block; /* transform 적용을 위해 */
        }
        .emp-nav-item.open .submenu-arrow {
            transform: rotate(90deg);
        }
        /* 공지사항 내용 중 이미지 크기 조절 */
        .notice-content-view img {
            max-width: 100%;
            height: auto;
            margin-top: 1em;
            margin-bottom: 1em;
        }
        .notice-attachments-view ul {
            list-style: none;
            padding-left: 0;
        }
        .notice-attachments-view li a {
            text-decoration: none;
            color: #337ab7;
        }
        .notice-attachments-view li a:hover {
            text-decoration: underline;
        }
        .notice-attachments-view .fa-file-download {
            margin-right: 5px;
        }
        .notice-detail-meta span {
            margin-right: 15px;
        }
        .notice-detail-meta #noticeDetailFixed {
            color: var(--primary-color, #007bff);
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="emp-container">
        <header class="emp-header">
            <div class="emp-logo"><a href="${pageContext.request.contextPath}/admin/main">DDTOWN 관리자 포털</a></div>
            <div class="emp-user-info">
                <%-- 로그인한 관리자 정보 (동적으로 표시) --%>
                <span><i class="fas fa-user-circle"></i> <c:out value="${loginAdmin.adminName}" default="관리자"/> (<c:out value="${loginAdmin.adminId}" default="admin_user"/>)</span>
                <a href="${pageContext.request.contextPath}/admin/logout" class="emp-logout-btn" id="adminLogoutBtn"><i class="fas fa-sign-out-alt"></i> 로그아웃</a>
            </div>
        </header>
        <div class="emp-body-wrapper">
            <aside class="emp-sidebar">
                <nav class="emp-nav">
                     <ul>
                        <li>
                            <%-- 현재 페이지가 "공지사항 관리"의 하위 페이지이므로 active 클래스 추가 --%>
                            <a href="${pageContext.request.contextPath}/admin/notice/list" class="emp-nav-item active" data-menu="corp"> <i class="fas fa-bullhorn"></i> 공지사항 관리 </a>
                        </li>
                        <li>
                            <a href="#" class="emp-nav-item has-submenu" data-menu="cs">
                                <i class="fas fa-headset"></i> 고객센터 <span class="submenu-arrow">&gt;</span>
                            </a>
                            <ul class="emp-submenu" id="submenu-cs" style="display: none;"> <%-- 초기에는 닫힌 상태로 --%>
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
                    <c:choose>
                        <c:when test="${not empty noticeVO}">
                            <div class="notice-detail-header">
                                <h2 class="notice-page-title"><c:out value="${noticeVO.entNotiTitle}"/></h2>
                                <div class="notice-detail-meta">
                                    <span>작성자: <c:out value="${noticeVO.empUsername}" default="관리자"/></span>
                                    <span>등록일: <fmt:formatDate value="${noticeVO.entNotiRegDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                    <%-- <c:if test="${noticeVO.important}"> 'important' 필드가 boolean 타입이라고 가정
                                        <span id="noticeDetailFixed"><i class="fas fa-thumbtack"></i> 상단고정</span>
                                    </c:if> --%>
                                </div>
                            </div>
                            <div class="notice-content-view">
                                <%-- HTML 내용을 그대로 출력 (XSS 주의, 필요시 저장 시점에 필터링 또는 출력 시 신뢰할 수 있는 경우에만 사용) --%>
                                ${noticeVO.entNotiContent}
                            </div>

                            <c:if test="${not empty attachmentList}">
                                <div class="notice-attachments-view">
                                    <h4><i class="fas fa-paperclip"></i> 첨부파일</h4>
                                    <ul>
                                        <%-- <c:forEach var="file" items="${attachmentList}">
                                            <li>
                                                파일 다운로드 링크: 실제 파일 ID 또는 저장된 파일명 등으로 변경 필요
                                                컨트롤러에서 파일 다운로드를 처리하는 URL로 연결
                                                <a href="${pageContext.request.contextPath}/admin/file/download?fileId=${file.fileId}" download="<c:out value='${file.originalFileName}'/>">
                                                    <i class="fas fa-file-download"></i> <c:out value="${file.originalFileName}"/>
                                                    (<fmt:formatNumber value="${file.fileSize / 1024}" maxFractionDigits="1"/> KB)
                                                </a>
                                            </li>
                                        </c:forEach> --%>
                                    </ul>
                                </div>
                            </c:if>

                            <div class="notice-actions-bottom">
                                <button class="btn btn-edit" onclick="location.href='${pageContext.request.contextPath}/admin/notice/form?id=${noticeVO.entNotiNo}&mode=edit'"><i class="fas fa-edit"></i> 수정</button>
                                <button class="btn btn-delete" data-notice-id="${noticeVO.entNotiNo}"><i class="fas fa-trash-alt"></i> 삭제</button>
                                <button class="btn btn-detail" onclick="location.href='${pageContext.request.contextPath}/admin/notice/list'"><i class="fas fa-list"></i> 목록</button>
                            </div>
                        </c:when>
                        <c:otherwise>
                             <div class="notice-detail-header">
                                <h2 class="notice-page-title">오류</h2>
                             </div>
                             <div class="notice-content-view">
                                <p style="text-align:center; color:red;">요청하신 공지사항을 찾을 수 없거나 잘못된 접근입니다.</p>
                             </div>
                             <div class="notice-actions-bottom">
                                <button class="btn btn-detail" onclick="location.href='${pageContext.request.contextPath}/admin/notice/list'"><i class="fas fa-list"></i> 목록으로</button>
                            </div>
                        </c:otherwise>
                    </c:choose>
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
                    if (this.getAttribute('href') === '#') { // 링크가 #일 때만 기본 동작 방지
                         event.preventDefault();
                    }
                    const parentLi = this.parentElement;
                    const submenu = this.nextElementSibling;

                    // 다른 열린 서브메뉴 닫기 (선택 사항)
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
                    
                    // 현재 클릭한 메뉴 토글
                    this.classList.toggle('open');
                    if (submenu && submenu.classList.contains('emp-submenu')) {
                        submenu.style.display = this.classList.contains('open') ? 'block' : 'none';
                        if (arrow) arrow.style.transform = this.classList.contains('open') ? 'rotate(90deg)' : 'rotate(0deg)';
                    }
                });
            });

            // 현재 URL 기반 활성 메뉴 표시 (기존 로직 개선)
            const currentFullHref = window.location.href;
            const contextPath = "${pageContext.request.contextPath}";

            document.querySelectorAll('.emp-sidebar .emp-nav-item[href]').forEach(link => {
                const linkHrefAttribute = link.getAttribute('href');
                if (linkHrefAttribute && linkHrefAttribute !== "#") {
                    const fullLinkPath = (linkHrefAttribute.startsWith(contextPath) ? linkHrefAttribute : contextPath + linkHrefAttribute);
                    // 현재 URL이 링크 경로로 시작하는 경우 (파라미터 등 무시)
                    if (currentFullHref.startsWith(fullLinkPath)) {
                        link.classList.add('active');
                        let currentActiveElement = link;
                        // 부모 서브메뉴 펼치기
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
                                    currentActiveElement = controllingAnchor; // 다음 반복을 위해 업데이트
                                } else {
                                    currentActiveElement = null; // 더 이상 부모가 없음
                                }
                            } else {
                                currentActiveElement = null; // 더 이상 부모 서브메뉴가 없음
                            }
                        }
                    }
                }
            });

            // 삭제 버튼 이벤트 리스너 (noticeDetailVO가 있을 때만)
            <c:if test="${not empty noticeDetailVO}">
                const deleteNoticeDetailBtn = document.querySelector('.btn-delete[data-notice-id]');
                if (deleteNoticeDetailBtn) {
                    deleteNoticeDetailBtn.addEventListener('click', function() {
                        const noticeId = this.dataset.noticeId; // data-notice-id 속성에서 ID 가져오기
                        deleteNoticeDetailWithServer(noticeId);
                    });
                }
            </c:if>
        });

        // 공지사항 삭제 기능 (서버 연동 필요)
        function deleteNoticeDetailWithServer(noticeId) {
            if (confirm(`공지사항 ID ${noticeId}를 정말 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.`)) {
                // 실제 서버로 삭제 요청을 보내는 로직
                // 예: <form>을 동적으로 생성하여 submit 하거나, fetch API 사용
                const form = document.createElement('form');
                form.method = 'POST'; // CSRF 보호 등을 위해 POST 권장
                form.action = '${pageContext.request.contextPath}/admin/notice/delete'; // 삭제 처리 URL

                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'entNotiNo'; // 컨트롤러에서 받을 파라미터 이름
                idInput.value = noticeId;
                form.appendChild(idInput);

                // Spring Security CSRF 토큰이 필요하다면 추가
                // const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
                // const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
                // if (csrfToken && csrfHeader) {
                //     const csrfInput = document.createElement('input');
                //     csrfInput.type = 'hidden';
                //     csrfInput.name = csrfHeader; // 또는 '_csrf' 등 실제 파라미터 이름
                //     csrfInput.value = csrfToken;
                //     form.appendChild(csrfInput);
                // }

                document.body.appendChild(form);
                form.submit();

                // fetch API 사용 예시 (CSRF 토큰 필요시 headers에 추가)
                /*
                fetch(`\${pageContext.request.contextPath}/admin/notice/delete?entNotiNo=\${noticeId}`, {
                    method: 'POST', // 또는 'DELETE'
                    // headers: { 'X-CSRF-TOKEN': 'your_csrf_token_value_here' }
                })
                .then(response => {
                    if (response.ok) {
                        alert('공지사항이 삭제되었습니다.');
                        window.location.href = '${pageContext.request.contextPath}/admin/notice/list';
                    } else {
                        alert('삭제에 실패했습니다. 상태: ' + response.status);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('삭제 중 오류가 발생했습니다.');
                });
                */
            }
        }
    </script>
</body>
</html>
