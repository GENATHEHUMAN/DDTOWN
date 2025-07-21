<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>콘서트 공지사항 관리</title>
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/pages/pagination.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/pages/emp_portal_style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <%@ include file="../../../modules/headerPart.jsp" %>
    <style>
        body { font-family: Arial, sans-serif;  background-color: #f8f9fa; }
        .emp-container { background-color: #fff; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .emp-search-add-bar { margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; padding: 10px; background-color: #e9ecef; border-radius: 5px;}
        .emp-search-add-bar form { display: inline-flex; align-items: center; gap: 8px;}
        .emp-search-add-bar input[type="text"], .emp-search-add-bar select { width:auto; padding: 8px; border: 1px solid #ced4da; border-radius: 4px; font-size: 0.9em;}
        .emp-search-add-bar input[type="submit"], .emp-search-add-bar .add-btn {
            padding: 8px 15px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 0.9em;
            border: none;
            cursor: pointer;
            width: auto;
        }
        .emp-search-add-bar input[type="submit"] { background-color: #007bff; color: white; }
        .emp-search-add-bar input[type="submit"]:hover { background-color: #0056b3; }
        .emp-search-add-bar .add-btn { background-color: #28a745; color: white; }
        .emp-search-add-bar .add-btn:hover { background-color: #1e7e34; }


        table { border-collapse: collapse; width: 100%; margin-bottom: 20px; }
        th, td { border: 1px solid #dee2e6; padding: 10px; text-align: left; font-size: 0.95em; }
        th { background-color: #f8f9fa; color: #495057; font-weight: 600; text-align: center;}
        td { vertical-align: middle; }
        tr:nth-child(even) { background-color: #f9f9f9; }
        .action-links a, .action-links button {
            margin-right: 5px;
            text-decoration: none;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 0.85em;
            border: 1px solid transparent;
        }
        .action-links .view-link { color: #007bff; }
        .action-links .view-link:hover { text-decoration: underline; }
        .action-links .edit-btn { background-color: #ffc107; color: #212529; border-color: #ffc107;}
        .action-links .edit-btn:hover { background-color: #e0a800; }
        .action-links .delete-btn { background-color: #dc3545; color: white; border-color: #dc3545; cursor: pointer; }
        .action-links .delete-btn:hover { background-color: #c82333; }

        .pagination-container { text-align: center; background-color: #2c3e50;}
        .pagination { display: inline-block; padding-left: 0; list-style: none; border-radius: 4px; }
        .pagination > li { display: inline; }
        .pagination > li > a, .pagination > li > span {
            position: relative;
            float: left;
            padding: 6px 12px;
            margin-left: -1px;
            line-height: 1.42857143;
            color: #007bff;
            text-decoration: none;
            background-color: #fff;
            border: 1px solid #ddd;
        }
        .pagination > li:first-child > a, .pagination > li:first-child > span { margin-left: 0; border-top-left-radius: 4px; border-bottom-left-radius: 4px;}
        .pagination > li:last-child > a, .pagination > li:last-child > span { border-top-right-radius: 4px; border-bottom-right-radius: 4px;}
        .pagination > li > a:hover, .pagination > li > span:hover, .pagination > li > a:focus, .pagination > li > span:focus { z-index: 2; color: #0056b3; background-color: #e9ecef; border-color: #ddd;}
        .pagination > .active > a, .pagination > .active > span, .pagination > .active > a:hover, .pagination > .active > span:hover, .pagination > .active > a:focus, .pagination > .active > span:focus { z-index: 3; color: #fff; cursor: default; background-color: #007bff; border-color: #007bff;}
        .pagination > .disabled > span, .pagination > .disabled > span:hover, .pagination > .disabled > span:focus, .pagination > .disabled > a, .pagination > .disabled > a:hover, .pagination > .disabled > a:focus { color: #6c757d; cursor: not-allowed; background-color: #fff; border-color: #ddd;}

        .message { padding: 15px; margin-bottom: 20px; border-radius: 5px; text-align: center; font-size: 1.05em;}
        .success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .text-center { text-align: center; }
    </style>
</head>
<body>

    <div class="emp-container">

    <%@ include file="../../modules/header.jsp" %>

		<sec:authentication property="principal.username" var="currentLoggedInUsername"/>
		<%-- <sec:authentication property="principal.employeeVO.empUsername" var="empUsername"/> --%>

        <c:if test="${not empty successMessage}">
            <div class="message success">${successMessage}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="message error">${errorMessage}</div>
        </c:if>

        <div class="emp-body-wrapper">
		<%@ include file="../../modules/aside.jsp" %>
		<main class="emp-content" style="position:relative; min-height:600px;">

        <div class="emp-search-add-bar">
            <form action="<c:url value='/emp/concert/notice/list'/>" method="get" id="searchForm">
                <select name="searchType">
                    <option value="concertNotiTitle" ${pagingVO.searchType == 'concertNotiTitle' ? 'selected' : ''}>공지사항명</option>
                    <option value="concertNotiContent" ${pagingVO.searchType == 'concertNotiContent' ? 'selected' : ''}>내용</option>
                </select>
                <input type="text" name="searchWord" placeholder="검색어 입력" value="<c:out value='${pagingVO.searchWord}'/>">
                <input type="hidden" name="page" value="1">
                <input type="submit" value="검색">
            </form>

          	<sec:authorize access="hasAnyRole('ROLE_EMPLOYEE', 'ROLE_ADMIN')">
            	<a href="<c:url value='/emp/concert/notice/form'/>" class="add-btn">새 공지사항 등록</a>
            </sec:authorize>
        </div>

        <table>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>공지사항명</th>
                    <th>작성일시</th>
                    <sec:authorize access="hasAnyRole('ROLE_EMPLOYEE', 'ROLE_ADMIN')">
                    <th style="width: 150px;">관리</th>
                    </sec:authorize>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty pagingVO.dataList && pagingVO.totalRecord > 0}">
                        <c:forEach var="notice" items="${pagingVO.dataList}">
                            <tr>
                                <td class="text-center">${notice.concertNotiNo}</td>
                                <td>
                                    <c:url var="finalDetailUrl" value="/emp/concert/notice/detail/${notice.concertNotiNo}">
                                        <c:if test="${not empty pagingVO.searchType and not empty pagingVO.searchWord}">
                                            <c:param name="searchType" value="${pagingVO.searchType}"/>
                                            <c:param name="searchWord" value="${pagingVO.searchWord}"/>
                                        </c:if>
                                        <c:if test="${not empty pagingVO.currentPage && pagingVO.currentPage > 1}">
                                            <c:param name="currentPage" value="${pagingVO.currentPage}"/>
                                        </c:if>
                                    </c:url>
                                    <a href="${finalDetailUrl}" class="view-link">
                                        <c:out value="${notice.concertNotiTitle}"/>
                                    </a>
                                </td>
                                <td class="text-center"><fmt:formatDate value="${notice.concertRegDate}" pattern="yyyy-MM-dd"/></td>
                                <sec:authorize access="hasAnyRole('ROLE_EMPLOYEE', 'ROLE_ADMIN')">
                                <td class="action-links text-center">

                                        <sec:authorize access="hasRole('ROLE_ADMIN') or (isAuthenticated() and hasRole('ROLE_EMPLOYEE') and principal.username == '${notice.empUsername }')" >
                                            <c:url var="finalModUrl" value="/emp/concert/notice/mod/${notice.concertNotiNo}">
		                                        <c:if test="${not empty pagingVO.searchType and not empty pagingVO.searchWord}">
		                                            <c:param name="searchType" value="${pagingVO.searchType}"/>
		                                            <c:param name="searchWord" value="${pagingVO.searchWord}"/>
		                                        </c:if>
		                                        <c:if test="${not empty pagingVO.currentPage && pagingVO.currentPage > 1}">
		                                            <c:param name="currentPage" value="${pagingVO.currentPage}"/>
		                                        </c:if>
		                                    </c:url>
	                                    <a href="${finalModUrl}" class="edit-btn">수정</a>
                                            <form action="<c:url value='/emp/concert/notice/delete/${notice.concertNotiNo}'/>" method="post" style="display:inline;">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                <c:if test="${not empty pagingVO.searchType}"><input type="hidden" name="searchType" value="${pagingVO.searchType}"></c:if>
	                                            <c:if test="${not empty pagingVO.searchWord}"><input type="hidden" name="searchWord" value="${pagingVO.searchWord}"></c:if>
	                                            <c:if test="${not empty pagingVO.currentPage}"><input type="hidden" name="currentPage" value="${pagingVO.currentPage}"></c:if>
                                                <button type="submit" class="delete-btn" onclick="return confirm('정말로 [${notice.concertNotiTitle}] 공지를 삭제하시겠습니까?');">삭제</button>
                                            </form>
                                        </sec:authorize>
                                	</td>
                                </sec:authorize>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="8" class="text-center">등록된 콘서트 공지사항이 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        </main>
        </div>

        <div class="pagination-container" id="pagingArea">
             ${pagingVO.pagingHTML}
        </div>

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

$(function(){
    const pagingArea = $('#pagingArea');
    const searchForm = $('#searchForm');

    if(pagingArea.length > 0) {
        pagingArea.on('click', 'a', function(event) {
            event.preventDefault();
            const page = $(this).data('page'); // data-page 속성에서 클릭된 페이지 번호 가져옴

            // 검색폼의 현재 searchType과 searchWord 값을 가져옴
            const searchType = searchForm.find('select[name="searchType"]').val();
            const searchWord = searchForm.find('input[name="searchWord"]').val();

            // 페이지 이동을 위한 URL
            let targetPageUrl = '${pageContext.request.contextPath}/emp/concert/notice/list?currentPage=' + page;


            if (searchType && searchWord && searchWord.trim() !== '') {
                targetPageUrl += '&searchType=' + encodeURIComponent(searchType);
                targetPageUrl += '&searchWord=' + encodeURIComponent(searchWord);
            }
            window.location.href = targetPageUrl;
        });
    }
});
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