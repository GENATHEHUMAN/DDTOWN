<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DD TOWN 오디션 일정</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;700;900&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <%@ include file="../modules/headerPart.jsp" %>
    <style>
        /* Enhanced Audition List Styles */
        body {
            background: linear-gradient(135deg, #f8f9ff 0%, #f0f2ff 100%);
            font-family: 'Noto Sans KR', 'Montserrat', sans-serif;
            margin: 0;
            padding: 0;
        }
        
        .audition-hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 120px 0 80px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .audition-hero:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
        }
        
        .audition-hero h2 {
            font-size: clamp(3rem, 6vw, 4.5rem);
            font-weight: 900;
            color: white;
            margin-bottom: 20px;
            text-shadow: 0 4px 20px rgba(0,0,0,0.3);
            position: relative;
            z-index: 1;
        }
        
        .audition-hero p {
            font-size: 1.3rem;
            color: rgba(255, 255, 255, 0.9);
            max-width: 800px;
            margin: 0 auto;
            line-height: 1.6;
            position: relative;
            z-index: 1;
        }
        
        .audition-list-section {
            padding: 100px 0;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        /* Enhanced Search Form */
        .input-group {
            background: white;
            border-radius: 20px;
            padding: 15px;
            box-shadow: 0 15px 40px rgba(102, 126, 234, 0.1);
            border: 1px solid rgba(102, 126, 234, 0.1);
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
            margin-bottom: 50px;
        }
        
        .am-filter-select,
        .am-search-input {
            border: 1px solid rgba(102, 126, 234, 0.2) !important;
            border-radius: 12px !important;
            padding: 12px 16px !important;
            font-size: 1rem !important;
            font-family: 'Noto Sans KR', sans-serif !important;
            transition: all 0.3s ease !important;
            background: #f8f9ff !important;
        }
        
        .am-filter-select:focus,
        .am-search-input:focus {
            outline: none !important;
            border-color: #667eea !important;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1) !important;
        }
        
        .am-btn,
        .ea-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
            color: white !important;
            border: none !important;
            border-radius: 12px !important;
            padding: 6px 10px !important;
            font-weight: 600 !important;
            cursor: pointer !important;
            transition: all 0.3s ease !important;
            display: inline-flex !important;
            align-items: center !important;
            gap: 8px !important;
            white-space: nowrap;
            font-size: 0.95rem !important;
        }
        
        .am-btn:hover,
        .ea-btn:hover {
            transform: translateY(-2px) !important;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3) !important;
        }
        
        .ea-btn {
            background: linear-gradient(135deg, #6c757d 0%, #495057 100%) !important;
        }
        
        /* Enhanced Audition Cards */
        .audition-list {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 30px;
            margin-bottom: 50px;
        }
        
        .audition-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 15px 40px rgba(102, 126, 234, 0.1);
            border: 1px solid rgba(102, 126, 234, 0.1);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            
            display: flex; 
		    flex-direction: column; 
		    justify-content: space-between;
        }
        
        .audition-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 25px 50px rgba(102, 126, 234, 0.2);
        }
        
        .audition-card:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        
        .audition-status {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 700;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 15px;
        }
        
        .audition-status.recruiting.status-scheduled {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
        }
        
        .audition-status.recruiting.status-in-progress {
            background: linear-gradient(135deg, #28a745 0%, #1e7e34 100%);
            color: white;
        }
        
        .audition-status.recruiting.status-closed {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
        }
        
        .audition-title {
            font-size: 1.4rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 15px;
            line-height: 1.3;
        }
        
        .audition-info {
            color: #666;
            line-height: 1.6;
            margin-bottom: 20px;
            font-size: 0.95rem;
        }
        
        .audition-info strong {
            color: #667eea;
            font-weight: 600;
        }
        
        .audition-card a {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            padding: 12px 20px;
            border-radius: 25px;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }
        
        .audition-card a:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }
        
        .audition-card a:before {
            content: '\f06e';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
        }
        
        /* Enhanced Pagination */
        .pagination-container {
            margin: 50px 0 !important;
            text-align: center !important;
            padding: 20px 0 !important;
        }
        
        .pagination-container .pagination,
        .pagination-container > div {
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            gap: 8px !important;
            margin: 0 !important;
            padding: 0 !important;
            list-style: none !important;
        }
        
        .pagination-container a,
        .pagination-container span,
        .pagination-container .page-link {
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            min-width: 44px !important;
            height: 44px !important;
            padding: 8px 12px !important;
            margin: 0 3px !important;
            background: white !important;
            color: #667eea !important;
            text-decoration: none !important;
            border: 2px solid rgba(102, 126, 234, 0.2) !important;
            border-radius: 12px !important;
            font-weight: 600 !important;
            transition: all 0.3s ease !important;
            cursor: pointer !important;
            box-shadow: 0 2px 8px rgba(102, 126, 234, 0.1) !important;
        }
        
        .pagination-container a:hover,
        .pagination-container .page-link:hover {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
            color: white !important;
            transform: translateY(-2px) !important;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3) !important;
        }
        
        .pagination-container .active,
        .pagination-container .page-item.active .page-link {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
            color: white !important;
            border-color: #667eea !important;
        }
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            color: #666;
        }
        
        .empty-state i {
            font-size: 4rem;
            color: #ccc;
            margin-bottom: 20px;
        }
        
        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: #333;
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .input-group {
                flex-direction: column;
                align-items: stretch;
            }
            
            .am-filter-select,
            .am-search-input {
                width: 100% !important;
            }
            
            .audition-list {
                grid-template-columns: 1fr;
            }
            
            .audition-card {
                padding: 25px;
            }
        }
        /* 새로 추가할 부분 */
		.audition-card-content {
		    flex-grow: 1; /* 이 부분이 내용이 사용 가능한 공간을 모두 채우도록 합니다. */
		    margin-bottom: 20px; /* 버튼과 내용 사이에 간격을 줍니다. (선택 사항, 기존 하단 마진과 조절) */
		}
		
		/* Enhanced Pagination Styles - High Specificity to Override Conflicts */
		.pagination-container {
		    margin: 50px 0 !important;
		    text-align: center !important;
		    padding: 20px 0 !important;
		    clear: both !important;
		}
		
		/* Reset any inherited pagination styles */
		.pagination-container * {
		    box-sizing: border-box !important;
		}
		
		/* Main pagination wrapper */
		.pagination-container .pagination,
		.pagination-container > div,
		.pagination-container > span {
		    display: inline-flex !important;
		    align-items: center !important;
		    justify-content: center !important;
		    gap: 8px !important;
		    margin: 0 !important;
		    padding: 0 !important;
		    list-style: none !important;
		    background: none !important;
		    border: none !important;
		}
		
		/* Individual pagination links and buttons */
		.pagination-container a,
		.pagination-container span,
		.pagination-container button {
		    display: inline-flex !important;
		    align-items: center !important;
		    justify-content: center !important;
		    min-width: 44px !important;
		    height: 44px !important;
		    padding: 8px 12px !important;
		    margin: 0 3px !important;
		    background: white !important;
		    color: #667eea !important;
		    text-decoration: none !important;
		    border: 2px solid rgba(102, 126, 234, 0.2) !important;
		    border-radius: 12px !important;
		    font-family: 'Montserrat', 'Noto Sans KR', sans-serif !important;
		    font-size: 0.95rem !important;
		    font-weight: 600 !important;
		    line-height: 1 !important;
		    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
		    cursor: pointer !important;
		    position: relative !important;
		    overflow: hidden !important;
		    box-shadow: 0 2px 8px rgba(102, 126, 234, 0.1) !important;
		}
		
		/* Hover effects */
		.pagination-container a:hover,
		.pagination-container span:hover,
		.pagination-container button:hover {
		    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
		    color: white !important;
		    border-color: #667eea !important;
		    transform: translateY(-2px) !important;
		    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3) !important;
		}
		
		/* Active/Current page */
		.pagination-container a.active,
		.pagination-container span.active,
		.pagination-container .current,
		.pagination-container [data-page].active {
		    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
		    color: white !important;
		    border-color: #667eea !important;
		    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4) !important;
		    transform: translateY(-1px) !important;
		}
		
		/* Disabled state */
		.pagination-container a.disabled,
		.pagination-container span.disabled,
		.pagination-container button:disabled,
		.pagination-container .disabled {
		    background: #f8f9fa !important;
		    color: #6c757d !important;
		    border-color: #dee2e6 !important;
		    cursor: not-allowed !important;
		    opacity: 0.6 !important;
		    transform: none !important;
		    box-shadow: none !important;
		}
		
		.pagination-container a.disabled:hover,
		.pagination-container span.disabled:hover,
		.pagination-container button:disabled:hover {
		    background: #f8f9fa !important;
		    color: #6c757d !important;
		    transform: none !important;
		    box-shadow: none !important;
		}
		
		/* Previous/Next buttons styling */
		.pagination-container a[data-page]:first-child,
		.pagination-container a:first-child,
		.pagination-container span:first-child {
		    padding-left: 16px !important;
		    padding-right: 16px !important;
		}
		
		.pagination-container a[data-page]:last-child,
		.pagination-container a:last-child,
		.pagination-container span:last-child {
		    padding-left: 16px !important;
		    padding-right: 16px !important;
		}
		
		/* Focus states for accessibility */
		.pagination-container a:focus,
		.pagination-container button:focus {
		    outline: 2px solid #667eea !important;
		    outline-offset: 2px !important;
		}
		
		/* Animation for page transitions */
		.pagination-container a:active,
		.pagination-container button:active {
		    transform: translateY(0) scale(0.98) !important;
		    transition: transform 0.1s ease !important;
		}
		
		/* Responsive design */
		@media (max-width: 768px) {
		    .pagination-container {
		        padding: 15px 10px !important;
		    }
		    
		    .pagination-container a,
		    .pagination-container span,
		    .pagination-container button {
		        min-width: 40px !important;
		        height: 40px !important;
		        font-size: 0.9rem !important;
		        margin: 0 2px !important;
		        padding: 6px 10px !important;
		    }
		    
		    /* Hide some page numbers on mobile */
		    .pagination-container > div > a:not(:first-child):not(:last-child):not(.active) {
		        display: none !important;
		    }
		    
		    .pagination-container > div > a.active ~ a:nth-child(n+3):not(:last-child),
		    .pagination-container > div > a.active ~ a:nth-child(n+3):not(:last-child) {
		        display: none !important;
		    }
		}
		
		@media (max-width: 480px) {
		    .pagination-container a,
		    .pagination-container span,
		    .pagination-container button {
		        min-width: 36px !important;
		        height: 36px !important;
		        font-size: 0.85rem !important;
		        padding: 4px 8px !important;
		    }
		}
		
		/* Override Bootstrap pagination if present */
		.pagination-container .pagination.pagination {
		    background: none !important;
		    border: none !important;
		    margin: 0 !important;
		    padding: 0 !important;
		}
		
		.pagination-container .pagination .page-item {
		    margin: 0 !important;
		    background: none !important;
		    border: none !important;
		}
		
		.pagination-container .pagination .page-link {
		    display: inline-flex !important;
		    align-items: center !important;
		    justify-content: center !important;
		    min-width: 44px !important;
		    height: 44px !important;
		    padding: 8px 12px !important;
		    margin: 0 3px !important;
		    background: white !important;
		    color: #667eea !important;
		    text-decoration: none !important;
		    border: 2px solid rgba(102, 126, 234, 0.2) !important;
		    border-radius: 12px !important;
		    font-family: 'Montserrat', 'Noto Sans KR', sans-serif !important;
		    font-size: 0.95rem !important;
		    font-weight: 600 !important;
		    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
		    box-shadow: 0 2px 8px rgba(102, 126, 234, 0.1) !important;
		}
		
		.pagination-container .pagination .page-link:hover {
		    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
		    color: white !important;
		    border-color: #667eea !important;
		    transform: translateY(-2px) !important;
		    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3) !important;
		}
		
		.pagination-container .pagination .page-item.active .page-link {
		    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
		    color: white !important;
		    border-color: #667eea !important;
		    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4) !important;
		}
		
		.pagination-container .pagination .page-item.disabled .page-link {
		    background: #f8f9fa !important;
		    color: #6c757d !important;
		    border-color: #dee2e6 !important;
		    cursor: not-allowed !important;
		    opacity: 0.6 !important;
		}
    </style>
</head>
<body>
    <%@ include file="./../corporate/modules/header.jsp" %>

    <main>
        <section class="audition-hero">
            <div class="container">
                <h2>DD TOWN 오디션</h2>
                <p>DD TOWN과 함께 꿈을 펼칠 예비 스타를 찾습니다. 지금 바로 도전하세요!<br>
                자세한 오디션 정보 및 일정은 '오디션 일정' 메뉴에서 확인하실 수 있습니다.</p>
            </div>
        </section>
        
        <section class="audition-list-section">
            <div class="container">
                <div style="display: flex; justify-content: flex-end; width: 100%; margin-bottom: 20px;">
                    <form class="input-group input-group-sm" method="get" id="searchForm" style="flex-wrap: nowrap;">
                        <input type="hidden" name="page" id="page"/>
                        <select id="filter-schedule-status" name="searchType" class="am-filter-select" onchange="this.form.submit();">
                            <option value="all" ${searchType == 'all' ? 'selected' : ''}>전체 상태</option>
                            <option value="ADSC001" ${searchType == 'ADSC001' ? 'selected' : ''}>예정</option>
                            <option value="ADSC002" ${searchType == 'ADSC002' ? 'selected' : ''}>진행중</option>
                            <option value="ADSC003" ${searchType == 'ADSC003' ? 'selected' : ''}>마감</option>
                        </select>
                        <input type="text" name="searchWord" id="search-schedule-input" placeholder="오디션명 검색" class="am-search-input" value="${searchWord}">   
                        <button type="submit" id="btn-search-schedule" class="am-btn">
                            <i class="fas fa-search"></i> 검색
                        </button>
                        <button type="button" id="resetSearchButton" class="ea-btn">초기화</button>
                    </form>
                </div>
                
                <div class="audition-list">
                    <c:choose>
                        <c:when test="${empty auditionList}">
                            <div class="empty-state" style="grid-column: 1 / -1;">
                                <i class="fas fa-inbox"></i>
                                <h3>조회하신 오디션이 없습니다</h3>
                                <p>다른 검색 조건으로 시도해보세요.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${auditionList}" var="audition">
							    <div class="audition-card">
							        <div class="audition-card-content">
							            <div class="audition-status recruiting
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
							            </div>
							            <div class="audition-title">${audition.audiTitle}</div>
							            <div class="audition-info">
							                <strong>모집 기간:</strong>
							                <c:set value="${fn:split(audition.audiStartDate, ' ')}" var="auditionStartDate"/>
							                <c:set value="${fn:split(audition.audiEndDate, ' ')}" var="auditionEndDate"/>
							                ${auditionStartDate[0]} ~ ${auditionEndDate[0]}<br>
							                <strong>모집 분야:</strong>
							                <c:choose>
							                    <c:when test="${audition.audiTypeCode eq 'ADTC001'}">보컬</c:when>
							                    <c:when test="${audition.audiTypeCode eq 'ADTC002'}">댄스</c:when>
							                    <c:when test="${audition.audiTypeCode eq 'ADTC003'}">연기</c:when>
							                </c:choose>
							            </div>
							        </div> 
							        <a href="/corporate/audition/detail.do?audiNo=${audition.audiNo}" style="width: 40%">상세보기</a>
							    </div>
							</c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <div class="pagination-container" id="pagingArea">
                    ${pagingVO.pagingHTML}
                </div>
            </div>
        </section>
    </main>

    <%@ include file="../corporate/modules/footer.jsp" %>

    <script src="${pageContext.request.contextPath}/resources/js/common/main.js"></script>
    <script type="text/javascript">
        $(function(){
            let detailBtn = $("#detailBtn");	//상세보기 버튼
            //상세보기
            detailBtn.on("click", function(){
                location.href = "/corporate/audition/detail.do";
            });
            //페이징 관련
            $(document).on('click', '.page-link', function(e) {
                e.preventDefault();
                var page = $(this).data('page');
                
                if (page) {
                    $('#page').val(page);
                    $('#searchForm').submit();
                }
            });
            //초기화 버튼
            $('#resetSearchButton').on('click', function() {
                $('#filter-schedule-status').val('all');
                $('#search-schedule-input').val('');
                $('#page').val(1);
                $('#searchForm').submit();
            });
        })
    </script>
</body>
</html>
