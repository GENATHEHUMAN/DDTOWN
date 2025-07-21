<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>콘서트 공지사항 수정</title>
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <%@ include file="../../../modules/headerPart.jsp" %>
    <style> 
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; }
        .emp-form-container { border: 1px solid #ddd; border-radius: 8px; background-color: #fff; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { text-align: center; color: #333; margin-bottom: 30px;}
        .emp-form-group { margin-bottom: 18px; }
        .emp-form-group label { display: block; margin-bottom: 6px; font-weight: bold; color: #555; }
        .emp-form-group input[type="text"],
        .emp-form-group textarea,
        .emp-form-group input[type="file"] { width: calc(100% - 20px); padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; font-size: 1em; }
        .emp-form-group textarea { resize: vertical; min-height: 200px; }
        .emp-form-actions { margin-top: 30px; padding-top: 20px; border-top: 1px solid #eee; text-align: right; }
        .emp-form-actions input, .emp-form-actions a { padding: 10px 20px; margin-left: 10px; border-radius: 5px; text-decoration: none; font-size: 1em; border: none; cursor: pointer;}
        .emp-form-actions input[type="submit"] { background-color: #007bff; color: white; }
        .emp-form-actions a { padding: 10px 20px; background-color: #6c757d; color: white; display: inline-block; }
        .message { padding: 15px; margin-bottom: 20px; border-radius: 5px; text-align: center; }
        .error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .attachment-list { list-style-type: none; padding-left: 0; margin-top: 5px; }
        .attachment-list li { margin-bottom: 8px; display: flex; align-items: center; font-size: 0.9em; background-color:#f9f9f9; padding:5px; border:1px solid #eee; border-radius:3px;}
        .attachment-list img.file-preview-small { max-width: 60px; max-height: 60px; object-fit: contain; border: 1px solid #ddd; margin-right: 8px; border-radius: 3px;}
        .attachment-list input[type="checkbox"] { margin-right: 5px; vertical-align: middle;}
        .attachment-list label.del-label { font-weight: normal; vertical-align: middle; }
        input, textarea, select {
    width: auto;
    padding: var(--spacing-sm);
    border: 1px solid var(--border-color);
    border-radius: var(--border-radius-sm);
    font-family: var(--font-family-base);
    font-size: var(--font-size-base);
    transition: border-color var(--transition-fast);
    </style>
</head>
<body>
    <div class="emp-form-container">
    <%@ include file="../../modules/header.jsp" %>

        <c:if test="${not empty errorMessage}">
            <div class="message error">${errorMessage}</div>
        </c:if>
        <c:if test="${not empty successMessage}"> <%-- For redirects --%>
            <div class="message success">${successMessage}</div>
        </c:if>

        <div class="emp-body-wrapper">
				<%@ include file="../../modules/aside.jsp" %>
		<main class="emp-content" style="position:relative; min-height:600px;">
		
		<h1>콘서트 공지사항 수정 (번호: ${noticeVO.concertNotiNo})</h1>
        
        <form method="post" action="<c:url value='/emp/concert/notice/mod/${noticeVO.concertNotiNo}'/>" enctype="multipart/form-data">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

            <div class="emp-form-group">
                <label for="concertNotiTitle">제목:</label>
                <input type="text" id="concertNotiTitle" name="concertNotiTitle" value="<c:out value='${noticeVO.concertNotiTitle}'/>" required>
            </div>

            <div class="emp-form-group">
                <label for="concertNotiContent">내용:</label>
                <textarea id="concertNotiContent" name="concertNotiContent" required><c:out value='${noticeVO.concertNotiContent}'/></textarea>
            </div>

            
            <c:if test="${not empty noticeVO.attachmentFileList}">
            <div class="emp-form-group">
                <label>기존 첨부파일 :</label>
                <ul class="attachment-list">
                <c:forEach var="file" items="${noticeVO.attachmentFileList}">
                    <li>
                        <input type="checkbox" name="deleteFileNos" value="${file.attachDetailNo}" id="delFile_${file.attachDetailNo}">
                        <c:choose>
                            <c:when test="${file.fileMimeType != null && file.fileMimeType.startsWith('image/')}">
                                <img src="<c:url value='${file.webPath}'/>" alt="<c:out value='${file.fileOriginalNm}'/>" class="file-preview-small"/>
                            </c:when>
                        </c:choose>
                        <label for="delFile_${file.attachDetailNo}" class="del-label">
                            <a href="<c:url value='${file.webPath}'/>" target="_blank"><c:out value="${file.fileOriginalNm}"/></a>
                            (<c:out value="${file.fileFancysize}"/>) - 삭제
                        </label>
                    </li>
                </c:forEach>
                </ul>
            </div>
            </c:if>

            <div class="emp-form-group">
                <label for="noticeFiles">새 첨부파일 :</label>
                <input type="file" id="noticeFiles" name="noticeFiles" multiple="multiple">
            </div>

            <div class="emp-form-actions">
                <a href="<c:url value='/emp/concert/notice/list'/>">목록으로</a>
                <input type="submit" value="수정 완료">
            </div>
        </form>
    </div>
    </main>
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