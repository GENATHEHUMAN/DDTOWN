<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DD TOWN - 기업공지</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;700;900&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <%@ include file="../../modules/headerPart.jsp" %>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
    	.notice-table th {
		    background-color: transparent;
		    font-weight: var(--font-weight-medium);
		    color: var(--text-color-primary);
	        border-bottom: none;
		}
        /* Enhanced Notice List Styles */
        .notice-hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 120px 0 80px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .notice-hero:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
        }
        
        .notice-hero h2 {
            font-size: clamp(3rem, 6vw, 4.5rem);
            font-weight: 900;
            color: white;
            margin-bottom: 20px;
            text-shadow: 0 4px 20px rgba(0,0,0,0.3);
            position: relative;
            z-index: 1;
        }
        
        .notice-hero p {
            font-size: 1.3rem;
            color: rgba(255, 255, 255, 0.9);
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.6;
            position: relative;
            z-index: 1;
        }
        
        .notice-list {
            padding: 100px 0;
            background: linear-gradient(45deg, #f8f9ff 0%, #f0f2ff 100%);
        }
        
        .notice-search {
            margin-bottom: 50px;
            text-align: center;
        }
        
        .notice-search form {
            display: inline-flex;
            align-items: center;
            background: white;
            border-radius: 50px;
            padding: 8px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            border: 1px solid rgba(102, 126, 234, 0.2);
            max-width: 600px;
            width: 100%;
        }
        
        .notice-search-select {
            border: none;
            background: transparent;
            padding: 12px 20px;
            font-size: 1rem;
            color: #333;
            outline: none;
            border-radius: 25px;
            font-weight: 500;
        }
        
        .notice-search input[type="text"] {
            flex: 1;
            border: none;
            padding: 12px 20px;
            font-size: 1rem;
            outline: none;
            background: transparent;
            color: #333;
        }
        
        .notice-search input[type="text"]::placeholder {
            color: #999;
        }
        
        .notice-search .btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 25px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .notice-search .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }
        
        .notice-table {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
            border: 1px solid rgba(102, 126, 234, 0.1);
            font-size: large;
        }
        
        .notice-table table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .notice-table thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        
        .notice-table thead th {
            padding: 20px;
            color: white;
            font-weight: 600;
            text-align: center;
            font-size: 1.1rem;
        }
        
        .notice-table tbody tr {
            border-bottom: 1px solid rgba(102, 126, 234, 0.1);
            transition: all 0.3s ease;
        }
        
        .notice-table tbody tr:hover {
            background: linear-gradient(45deg, #f8f9ff 0%, #f0f2ff 100%);
            transform: translateX(5px);
        }
        
        .notice-table tbody td {
            padding: 20px;
            color: #333;
            vertical-align: middle;
        }
        
        .notice-table tbody td:first-child {
            font-weight: 600;
            color: #667eea;
            text-align: center;
            width: 80px;
        }
        
        .notice-table tbody td a {
            color: #333;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .notice-table tbody td a:hover {
            color: #667eea;
        }
        
        .notice-table tbody td a:before {
            content: '\f15c';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            color: #667eea;
            font-size: 0.9rem;
        }
        
        .notice-table tbody td:last-child {
            color: #666;
            text-align: center;
            width: 150px;
            font-size: 0.95rem;
        }
        
        .pagination-container {
            margin-top: 50px;
            text-align: center;
        }
        .pagination {
          	--bs-pagination-active-bg: #0d6efd;
        }
        
        /* Enhanced pagination styles */
        .pagination-container a {
            display: inline-block;
            padding: 12px 16px;
            margin: 0 5px;
            background: white;
            color: #667eea;
            text-decoration: none;
            border-radius: 10px;
            border: 1px solid rgba(102, 126, 234, 0.2);
            transition: all 0.3s ease;
            font-weight: 500;
        }
        
        .pagination-container a:hover {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }
        
        .pagination-container a.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .notice-search form {
                flex-direction: column;
                gap: 10px;
                padding: 20px;
                border-radius: 20px;
            }
            
            .notice-search-select,
            .notice-search input[type="text"] {
                width: 100%;
            }
            
            .notice-table {
                overflow-x: auto;
            }
            
            .notice-table table {
                min-width: 600px;
            }
        }
    </style>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/components/corp-pagination.css">
</head>
<body>
	<%@ include file="../modules/header.jsp" %>
    <main>
        <section class="notice-hero">
            <div class="container">
                <h2>기업공지</h2>
                <p>DD TOWN의 최신 소식과 공지사항을 확인하실 수 있습니다.</p>
            </div>
        </section>

        <section class="notice-list">
            <div class="container">
                <div class="notice-search">
	                    <form id="searchForm" action="${pageContext.request.contextPath}/corporate/notice/list" method="get">
	                        <select name="searchType" class="notice-search-select" style="border-radius: 25px;">
	                            <option value="title" selected>제목</option>
	                        </select>
	                        <input type="text" name="searchWord" placeholder="검색어를 입력하세요" value="<c:out value='${searchVO.searchWord}'/>"/>
	                        <button type="submit" class="btn btn-primary">
	                            <i class="fas fa-search"></i> 검색
	                        </button>
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
                            <c:if test="${empty pagingVO.dataList}">
                                <tr>
                                    <td colspan="3" style="text-align: center; padding: 60px; color: #999;">
                                        <i class="fas fa-inbox" style="font-size: 3rem; margin-bottom: 20px; display: block;"></i>
                                        등록된 공지사항이 없습니다.
                                    </td>
                                </tr>
                            </c:if>
                            <c:forEach var="notice" items="${pagingVO.dataList}" varStatus="status">
                                <tr>
                                    <td>${notice.entNotiNo}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/corporate/notice/detail?id=${notice.entNotiNo}">${notice.entNotiTitle}</a>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${notice.entNotiRegDate}" pattern="yyyy-MM-dd"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="pagination-container" id="pagingArea">
			         ${pagingVO.pagingHTML}
			    </div>
            </div>
        </section>
    </main>

    <%@ include file="../modules/footer.jsp" %>
    
    <script src="${pageContext.request.contextPath}/resources/js/common/main.js"></script>
    <script type="text/javascript">
    
    $(function(){
        const pagingArea = $('#pagingArea');
        if(pagingArea.length > 0) {
            pagingArea.on('click', 'a', function(event) { 
                event.preventDefault();
                const page = $(this).data('page');
                
                const currentSearchUrl = new URL(window.location.href);
                const searchType = currentSearchUrl.searchParams.get("searchType");
                const searchWord = currentSearchUrl.searchParams.get("searchWord");

                let targetPageUrl = '${pageContext.request.contextPath}/corporate/notice/list?page=' + page;

                if (searchType && searchWord != null && searchWord.trim() !== '') {
                    targetPageUrl += '&searchType=' + encodeURIComponent(searchType);
                    targetPageUrl += '&searchWord=' + encodeURIComponent(searchWord);
                }
                window.location.href = targetPageUrl;
            });
        }
    });
    </script>
</body>
</html>