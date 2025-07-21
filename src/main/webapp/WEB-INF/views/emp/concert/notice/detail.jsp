<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>콘서트 공지사항 상세</title>
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <%@ include file="../../../modules/headerPart.jsp" %>
<style>
    /* ---------------------------------- */
    /* 상세 페이지 레이아웃         */
    /* ---------------------------------- */
    h4{
    	font-size: 1.2em; margin-bottom: 15px; color: #34495e; padding-bottom: 10px;
    }
    .detail-view-container {
        background: #fff;
        padding: 30px 35px;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.06);
    }
    .detail-header {
        padding-bottom: 20px;
        border-bottom: 1px solid #dee2e6;
        margin-bottom: 25px;
    }
    .detail-title {
        font-size: 1.8em;
        font-weight: 600;
        margin-bottom: 10px;
        color: #2c3e50;
    }
    .detail-meta {
        font-size: 1em;
        color: #6c757d;
        display: flex;
        align-items: center;
        gap: 12px;
    }
    .detail-meta .divider {
        color: #e0e0e0;
    }
    .detail-content {
        min-height: 100px;
        line-height: 1.7;
        font-size: 1em;
        margin-bottom: 30px;
        padding: 15px;
        white-space: pre-wrap;
        word-break: keep-all;
        background-color: #f8f9fa;
        border-radius: 5px;
        border-inline: 2px solid #333;
    	border-block: 2px solid #333;
    }
    .detail-info-table { margin-bottom: 30px;  }
    .detail-info-table h4 { font-size: 1.2em; margin-bottom: 15px; color: #34495e; padding-bottom: 10px; }
    .detail-info-table table { width: 100%; border-top: 2px solid #333; border-collapse: collapse; }
    .detail-info-table th, .detail-info-table td { border-bottom: 1px solid #dee2e6; padding: 15px; font-size: 0.95em; }
    .detail-info-table th { background-color: #f8f9fa; width: 25%; text-align: left; font-weight: 600; }

    .detail-attachments { margin-bottom: 30px; }
    .detail-attachments h4 { font-size: 1.2em; margin-bottom: 15px; color: #34495e; padding-bottom: 10px; border-bottom: 2px solid #34495e;}
    .detail-attachments ul { list-style: none; padding: 0; margin: 0; }
    .detail-attachments li { display: flex; align-items: center; padding: 12px; border-radius: 5px; transition: background-color 0.2s; border: 1px solid #e9ecef; }
    .detail-attachments li:not(:last-child) { margin-bottom: 10px; }
    .detail-attachments li:hover { background-color: #f4f6f9; }
    .detail-attachments .file-preview { width: 100px; height: 100px; object-fit: cover; border-radius: 4px; margin-right: 15px; }
    .detail-attachments a { text-decoration: none; color: #007bff; }
    .detail-attachments a:hover { text-decoration: underline; }

    /* ---------------------------------- */
    /* 상태 표시 배지             */
    /* ---------------------------------- */
    .status-badge {
        display: inline-block;
        padding: 4px 10px;
        font-size: 0.85em;
        font-weight: 400;
        border-radius: 12px;
        color: #fff;
    }
    .status-scheduled { background-color: #007bff; } /* 예정: 파란색 */
    .status-ongoing { background-color: #28a745; } /* 진행: 초록색 */
    .status-finished { background-color: #6c757d; } /* 종료: 회색 */
    .status-unknown { background-color: #ffc107; color: #212529; } /* 알수없음: 노란색 */

    .btn {
        display: inline-block;
        padding: 10px 20px;
        font-size: 0.95em;
        font-weight: 500;
        text-align: center;
        text-decoration: none;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        transition: all 0.2s ease-in-out;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    }
    .btn:hover {
        transform: translateY(-1px);
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
    /* 목록 페이지의 '새 일정 등록' 버튼 */
    .btn-primary { background-color: #007bff; color: white; }
    .btn-primary:hover { background-color: #0069d9; }
    
    /* 상세 페이지 버튼들 */
    .detail-actions { text-align: right; padding-top: 15px; }
    .detail-actions .btn { margin-left: 8px; }
    .btn-secondary { background-color: #6c757d; color: white; }
    .btn-secondary:hover { background-color: #5a6268; }
    .btn-warning { background-color: #ffc107; color: #212529; }
    .btn-warning:hover { background-color: #e0a800; }
    .btn-danger { background-color: #dc3545; color: white; }
    .btn-danger:hover { background-color: #c82333; }
</style>
</head>
<body>
    <div class="emp-detail-container">
    <%@ include file="../../modules/header.jsp" %>
    	<sec:authentication property="principal.username" var="currentLoggedInUsername"/>
        <c:if test="${not empty noticeVO}">

			<div class="emp-body-wrapper">
				<%@ include file="../../modules/aside.jsp" %>
			<main class="emp-content" style="position:relative; min-height:600px;">
            <h1><c:out value="${noticeVO.concertNotiTitle}"/></h1>
            
            <div class="emp-detail-info">
            	<span><strong>작성자:</strong>
                    <c:out value="${noticeVO.empUsername}"/>
                </span>
                <span><strong>등록일:</strong> <fmt:formatDate value="${noticeVO.concertRegDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                <c:if test="${noticeVO.concertModDate != null && noticeVO.concertModDate != noticeVO.concertRegDate}">
                    <span><strong>수정일:</strong> <fmt:formatDate value="${noticeVO.concertModDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                </c:if>
            </div>
            
            <div class="emp-detail-content">
                <pre><c:out value="${noticeVO.concertNotiContent}"/></pre>
            </div>

            
            <c:if test="${not empty noticeVO.attachmentFileList}">
                <div class="attachment-section">
                    <strong>첨부파일:</strong>
                    <ul class="attachment-list">
                        <c:forEach var="file" items="${noticeVO.attachmentFileList}">
                            <li>
                                <c:choose>
                                    <c:when test="${file.fileMimeType != null && file.fileMimeType.startsWith('image/')}">
                                        <a href="<c:url value='${file.webPath}'/>" target="_blank" title="클릭하여 원본 이미지 보기">
                                            <img src="<c:url value='${file.webPath}'/>" alt="<c:out value='${file.fileOriginalNm}'/>" class="file-preview"/>
                                        </a>
                                        <a href="<c:url value='${file.webPath}'/>" download="${file.fileOriginalNm}">
                                            <c:out value="${file.fileOriginalNm}"/> (<c:out value="${file.fileFancysize}"/>) - 다운로드
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="<c:url value='${file.webPath}'/>" download="${file.fileOriginalNm}">
                                            <c:out value="${file.fileOriginalNm}"/> (<c:out value="${file.fileFancysize}"/>)
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>

            <div class="actions">
                <%-- 검색 조건 유지 --%>
                <c:url var="listBackUrl" value="/emp/concert/notice/list">
                    <c:if test="${not empty searchType}"><c:param name="searchType" value="${searchType}"/></c:if>
                    <c:if test="${not empty searchWord}"><c:param name="searchWord" value="${searchWord}"/></c:if>
                    <c:if test="${not empty currentPage && currentPage > 1}"><c:param name="currentPage" value="${currentPage}"/></c:if>
                </c:url>
                <a href="${listBackUrl}" class="list-btn">목록으로</a>

                <%-- 시큐리티 태그로 권한 체크 --%>
                <sec:authorize access="hasRole('ROLE_ADMIN') or (isAuthenticated() and hasRole('ROLE_EMPLOYEE') and principal.username == '${noticeVO.empUsername}')">
                    <c:url var="modUrlWithParams" value="/emp/concert/notice/mod/${noticeVO.concertNotiNo}">
                        <c:if test="${not empty searchType}"><c:param name="searchType" value="${searchType}"/></c:if>
                        <c:if test="${not empty searchWord}"><c:param name="searchWord" value="${searchWord}"/></c:if>
                        <c:if test="${not empty currentPage && currentPage > 1}"><c:param name="currentPage" value="${currentPage}"/></c:if>
                    </c:url>
                    <a href="${modUrlWithParams}" class="edit-btn">수정하기</a>
                    <form action="<c:url value='/emp/concert/notice/delete/${noticeVO.concertNotiNo}'/>" method="post" style="display:inline;">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <%-- 삭제 후 목록으로 돌아갈 때 검색 조건 유지 --%>
                        <c:if test="${not empty searchType}"><input type="hidden" name="searchType" value="${searchType}"></c:if>
                        <c:if test="${not empty searchWord}"><input type="hidden" name="searchWord" value="${searchWord}"></c:if>
                        <c:if test="${not empty currentPage}"><input type="hidden" name="currentPage" value="${currentPage}"></c:if>
                        <button type="submit" class="delete-btn" onclick="return confirm('정말로 이 공지사항을 삭제하시겠습니까?');">삭제하기</button>
                    </form>
                </sec:authorize>
            </div>
            </main>
            </div>

        </c:if>
        <c:if test="${empty noticeVO}">
            <c:if test="${not empty errorMessage}">
                <div class="message error">${errorMessage}</div>
            </c:if>
            <p style="text-align:center; font-size: 1.1em; color: #555;">해당 공지사항 정보를 찾을 수 없습니다.</p>
            <div class="actions" style="text-align:center;">
               <a href="<c:url value='/emp/concert/notice/list'/>" class="list-btn">목록으로</a>
           </div>
       </c:if>
    </div>
    <script type="text/javascript">
    const logoutButton = document.querySelector('.btn emp-logout-btn');
	if (logoutButton) {
	    logoutButton.addEventListener('click', function(e) {
	        e.preventDefault();
	        if (confirm('로그아웃 하시겠습니까?')) {
	            alert('로그아웃 되었습니다.');
	        }
	    });
	}
	document.addEventListener('DOMContentLoaded', function() {
        // 메뉴 토글 기능
        const navItemsWithSubmenu = document.querySelectorAll('.emp-sidebar .emp-nav-item.has-submenu');
        navItemsWithSubmenu.forEach(item => {
            const arrow = item.querySelector('.submenu-arrow');
            item.addEventListener('click', function(event) {
                event.preventDefault();
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
        // 현재 페이지 URL 기반으로 사이드바 메뉴 활성화
        const currentFullHref = window.location.href;
        document.querySelectorAll('.emp-sidebar .emp-nav-item[href]').forEach(link => {
            const linkHrefAttribute = link.getAttribute('href');
            if (linkHrefAttribute && linkHrefAttribute !== "#" && currentFullHref.endsWith(linkHrefAttribute)) {
                link.classList.add('active');
                let currentActiveElement = link;
                while (true) {
                    const parentLi = currentActiveElement.parentElement;
                    if (!parentLi) break;
                    const parentSubmenuUl = parentLi.closest('.emp-submenu');
                    if (parentSubmenuUl) {
                        parentSubmenuUl.style.display = 'block';
                        const controllingAnchor = parentSubmenuUl.previousElementSibling;
                        if (controllingAnchor && controllingAnchor.tagName === 'A' && controllingAnchor.classList.contains('has-submenu')) {
                            controllingAnchor.classList.add('active', 'open');
                            const arrow = controllingAnchor.querySelector('.submenu-arrow');
                            if (arrow) {
                                arrow.style.transform = 'rotate(90deg)';
                            }
                            currentActiveElement = controllingAnchor;
                        } else {
                            break;
                        }
                    } else {
                        break;
                    }
                }
            }
        });
    });
    </script>
</body>
</html>