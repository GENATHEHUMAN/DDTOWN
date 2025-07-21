<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>  <%-- 날짜나 숫자 포맷팅이 필요할 경우 사용 --%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DD TOWN - 기업 공지</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;700;900&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <%@ include file="../../modules/headerPart.jsp" %>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* 드롭다운 메뉴 스타일 (다른 JSP와 공통으로 사용될 수 있으므로, 별도 common.css 등으로 옮기는 것을 권장합니다) */
        .has-submenu { position: relative; }
        .has-submenu:hover .submenu { display: block; }
        .submenu { display: none; position: absolute; top: 100%; left: 0; background: white; min-width: 200px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); border-radius: 4px; padding: 8px 0; z-index: 1000; }
        .submenu li { padding: 0; }
        .submenu a { display: block; padding: 8px 16px; color: #333; text-decoration: none; transition: background-color 0.2s; }
        .submenu a:hover { background-color: #f5f5f5; }
        .footer-links .has-submenu .submenu { position: static; box-shadow: none; padding-left: 16px; margin-top: 8px; }
        .footer-links .has-submenu .submenu a { color: #fff; opacity: 0.8; }
        .footer-links .has-submenu .submenu a:hover { opacity: 1; background: none; }
    </style>
</head>
<body>
    <%-- 헤더 부분 --%>
    <%-- 실제 프로젝트에서는 <jsp:include page="/WEB-INF/views/common/header.jsp" /> 와 같이 공통 헤더를 포함하는 것이 좋습니다. --%>
    <header class="site-header">
        <div class="header-container container">
            <div class="logo">
                <%-- 메인 페이지 링크 (예: corporate_main.jsp 또는 해당 컨트롤러 경로) --%>
                <h1><a href="${pageContext.request.contextPath}/corporate/main">DD TOWN</a></h1>
            </div>
            <nav class="main-nav">
                <button class="nav-toggle" aria-label="메뉴 열기/닫기">
                    <span class="hamburger"></span>
                </button>
                <ul>
                    <li class="has-submenu">
                        <a href="#">기업 정보</a>
                        <ul class="submenu">
                            <%-- 각 메뉴는 해당 기능을 처리하는 컨트롤러 경로 또는 JSP 파일 경로로 수정되어야 합니다. --%>
                            <li><a href="${pageContext.request.contextPath}/corporate/finance">재무정보</a></li>
                            <li><a href="${pageContext.request.contextPath}/corporate/about">기업소개</a></li>
                            <li><a href="${pageContext.request.contextPath}/corporate/notice/list">기업 공지</a></li>
                            <li><a href="${pageContext.request.contextPath}/corporate/location">기업 위치</a></li>
                        </ul>
                    </li>
                    <li><a href="${pageContext.request.contextPath}/corporate/audition/schedule">오디션</a></li>
                    <li><a href="${pageContext.request.contextPath}/corporate/artist/profile">아티스트 프로필</a></li>
                    <li><a href="${pageContext.request.contextPath}/community/artist/main">아티스트 커뮤니티</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <main>
        <section class="notice-hero">
            <div class="container">
                <h2>기업 공지</h2>
                <p>DD TOWN의 최신 소식과 공지사항을 확인하실 수 있습니다.</p>
            </div>
        </section>

        <section class="notice-list">
            <div class="container">
                <div class="notice-search">
                    <form action="${pageContext.request.contextPath}/corporate/notice/search" method="get">
                        <select name="searchType">
                            <option value="title" ${searchVO.searchType == 'title' ? 'selected' : ''}>제목</option>
                        </select>
                        <input type="text" name="searchKeyword" placeholder="검색어를 입력하세요" value="${searchVO.searchKeyword}">
                        <button type="submit" class="btn btn-primary">검색</button>
                    </form>
                </div>

                <div class="notice-table">
                    <table>
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>제목</th>
                                <th>작성일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- 컨트롤러에서 전달된 noticeList가 비어있는 경우 메시지 표시 --%>
                            <c:if test="${empty noticeList}">
                                <tr>
                                    <td colspan="5">등록된 공지사항이 없습니다.</td>
                                </tr>
                            </c:if>
                            <%-- JSTL을 사용하여 noticeList 반복 처리 --%>
                            <%-- notice는 개별 공지사항 객체 (예: com.example.NoticeVO) --%>
                            <%-- varStatus는 반복 상태를 나타내는 변수 (예: status.index로 0부터 시작하는 인덱스 접근 가능) --%>
                            <c:forEach var="notice" items="${noticeList}" varStatus="status">
                                <tr>
                                    <td>${notice.entNotiNo}</td>
                                    <td>
                                        <%-- 공지사항 상세 보기 링크: id는 공지사항의 고유 식별자 --%>
                                        <a href="${pageContext.request.contextPath}/corporate/notice/detail?id=${notice.entNotiNo}">${notice.entNotiTitle}</a>
                                    </td>
                                    <td>
                                        <%-- 날짜 포맷팅: notice.regDate가 java.util.Date 객체일 경우 --%>
                                        <fmt:formatDate value="${notice.entNotiRegDate}" pattern="yyyy-MM-dd"/>
                                        <%-- 만약 notice.regDate가 이미 "yyyy-MM-dd" 형식의 문자열이라면 그냥 ${notice.regDate} 사용 --%>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <%-- <div class="notice-pagination">
                    페이지네이션 UI 생성
                    paginationInfo는 컨트롤러에서 전달받은 페이지 정보 객체 (예: 전자정부프레임워크의 PaginationInfo 또는 직접 구현한 객체)
                    <c:if test="${paginationInfo.totalPageCount > 0}">
                        처음 페이지로 이동
                        <c:if test="${paginationInfo.currentPageNo > paginationInfo.firstPageNoOnPageList && paginationInfo.totalPageCount > 1}">
                            <a href="${pageContext.request.contextPath}/corporate/notice/list?pageIndex=1&searchType=${searchVO.searchType}&searchKeyword=${searchVO.searchKeyword}">&laquo;</a>
                        </c:if>

                        이전 페이지 블록으로 이동
                        <c:if test="${paginationInfo.currentPageNo > paginationInfo.pageSize}">
                            <a href="${pageContext.request.contextPath}/corporate/notice/list?pageIndex=${paginationInfo.firstPageNoOnPageList - 1}&searchType=${searchVO.searchType}&searchKeyword=${searchVO.searchKeyword}">&lt;</a>
                        </c:if>

                        페이지 번호 목록 출력
                        <c:forEach var="i" begin="${paginationInfo.firstPageNoOnPageList}" end="${paginationInfo.lastPageNoOnPageList}">
                            <c:choose>
                                <c:when test="${i == paginationInfo.currentPageNo}">
                                    <a href="#" class="active">${i}</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/corporate/notice/list?pageIndex=${i}&searchType=${searchVO.searchType}&searchKeyword=${searchVO.searchKeyword}">${i}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                        다음 페이지 블록으로 이동
                        <c:if test="${paginationInfo.lastPageNoOnPageList < paginationInfo.totalPageCount}">
                             <a href="${pageContext.request.contextPath}/corporate/notice/list?pageIndex=${paginationInfo.firstPageNoOnPageList + paginationInfo.pageSize}&searchType=${searchVO.searchType}&searchKeyword=${searchVO.searchKeyword}">&gt;</a>
                        </c:if>

                        마지막 페이지로 이동
                        <c:if test="${paginationInfo.currentPageNo < paginationInfo.totalPageCount && paginationInfo.totalPageCount > 1}">
                            <a href="${pageContext.request.contextPath}/corporate/notice/list?pageIndex=${paginationInfo.totalPageCount}&searchType=${searchVO.searchType}&searchKeyword=${searchVO.searchKeyword}">&raquo;</a>
                        </c:if>
                    </c:if>
                </div> --%>
            </div>
        </section>
    </main>

    <%-- 푸터 부분 --%>
    <%-- 실제 프로젝트에서는 <jsp:include page="/WEB-INF/views/common/footer.jsp" /> 와 같이 공통 푸터를 포함하는 것이 좋습니다. --%>
    <footer class="site-footer">
        <div class="container">
            <div class="footer-container">
                <div class="footer-info">
                    <div class="footer-logo">DD TOWN</div>
                    <p class="footer-description">
                        DD TOWN은 창의성과 열정을 바탕으로 아티스트와 팬 모두에게 최고의 경험을 선사합니다.
                        우리는 혁신적인 콘텐츠와 글로벌 네트워크를 통해 K-Culture의 미래를 만들어갑니다.
                    </p>
                    <div class="footer-contact">
                        <div class="contact-item">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>대전광역시 중구 계룡로 846</span> <%-- 이전 HTML 파일의 주소 --%>
                        </div>
                        <div class="contact-item">
                            <i class="fas fa-phone"></i>
                            <span>042-123-4567</span> <%-- 이전 HTML 파일의 전화번호 --%>
                        </div>
                        <div class="contact-item">
                            <i class="fas fa-envelope"></i>
                            <span>contact@ddtown.com</span> <%-- 이전 HTML 파일의 이메일 --%>
                        </div>
                    </div>
                </div>
                <div class="footer-links">
                    <h3>바로가기</h3>
                    <ul>
                        <li class="has-submenu">
                            <a href="#">기업 정보</a>
                            <ul class="submenu">
                                <li><a href="${pageContext.request.contextPath}/corporate/finance">재무정보</a></li>
                                <li><a href="${pageContext.request.contextPath}/corporate/about">기업소개</a></li>
                                <li><a href="${pageContext.request.contextPath}/corporate/notice/list">기업 공지</a></li>
                                <li><a href="${pageContext.request.contextPath}/corporate/location">기업 위치</a></li>
                            </ul>
                        </li>
                        <li><a href="${pageContext.request.contextPath}/corporate/audition/schedule">오디션</a></li>
                        <li><a href="${pageContext.request.contextPath}/corporate/artist/profile">아티스트 프로필</a></li>
                        <li><a href="${pageContext.request.contextPath}/community/artist/main">아티스트 커뮤니티</a></li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 DD TOWN Entertainment. All Rights Reserved.</p>
            </div>
        </div>
    </footer>

    <%-- JS 파일 경로: 웹 애플리케이션의 컨텍스트 루트를 기준으로 동적으로 생성합니다. --%>
    <script src="${pageContext.request.contextPath}/resources/js/common/main.js"></script>
</body>
</html>