<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DD TOWN - 재무정보</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;700;900&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components/navigation.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components/buttons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/finance.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Enhanced Finance Page Styles */
        .finance-hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 120px 0 80px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .finance-hero:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
        }
        
        .finance-hero h2 {
            font-size: clamp(3rem, 6vw, 4.5rem);
            font-weight: 900;
            color: white;
            margin-bottom: 20px;
            text-shadow: 0 4px 20px rgba(0,0,0,0.3);
            position: relative;
            z-index: 1;
        }
        
        .finance-hero p {
            font-size: 1.3rem;
            color: rgba(255, 255, 255, 0.9);
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.6;
            position: relative;
            z-index: 1;
        }
        
        .finance-overview {
            padding: 100px 0;
            background: linear-gradient(45deg, #f8f9ff 0%, #f0f2ff 100%);
        }
        
        .overview-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 40px;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .overview-card {
            background: white;
            padding: 40px 30px;
            border-radius: 20px;
            text-align: center;
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
            border: 1px solid rgba(102, 126, 234, 0.1);
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
        }
        
        .overview-card:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
            opacity: 0;
            transition: opacity 0.4s ease;
        }
        
        .overview-card:hover:before {
            opacity: 1;
        }
        
        .overview-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 25px 60px rgba(0,0,0,0.15);
            border-color: rgba(102, 126, 234, 0.3);
        }
        
        .overview-card h3 {
            font-size: 1.3rem;
            font-weight: 600;
            color: #666;
            margin-bottom: 20px;
            position: relative;
            z-index: 1;
        }
        
        .overview-card .number {
            font-size: 2.5rem;
            font-weight: 800;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 15px;
            position: relative;
            z-index: 1;
        }
        
        .overview-card .description {
            color: #999;
            font-size: 1rem;
            position: relative;
            z-index: 1;
        }
        
        .finance-details {
            padding: 100px 0;
            background: white;
        }
        
        .finance-tabs {
            display: flex;
            justify-content: center;
            margin-bottom: 50px;
            background: linear-gradient(45deg, #f8f9ff 0%, #f0f2ff 100%);
            border-radius: 15px;
            padding: 8px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
            margin-bottom: 50px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        
        .tab-button {
            flex: 1;
            padding: 15px 25px;
            background: transparent;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            font-size: 1rem;
            color: #666;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
        }
        
        .tab-button.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }
        
        .tab-button:hover:not(.active) {
            background: rgba(102, 126, 234, 0.1);
            color: #667eea;
        }
        
        .tab-content {
            display: none;
            animation: fadeInUp 0.5s ease;
        }
        
        .tab-content.active {
            display: block;
        }
        
        .tab-content h3 {
            font-size: 2rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 40px;
            color: #333;
        }
        
        .table-responsive {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
            border: 1px solid rgba(102, 126, 234, 0.1);
        }
        
        .finance-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .finance-table thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        
        .finance-table thead th {
            padding: 25px 20px;
            color: white;
            font-weight: 600;
            text-align: left;
            font-size: 1.1rem;
            border: none;
        }
        
        .finance-table thead th:first-child {
            border-radius: 0;
        }
        
        .finance-table thead th:last-child {
            border-radius: 0;
        }
        
        .finance-table tbody tr {
            border-bottom: 1px solid rgba(102, 126, 234, 0.1);
            transition: all 0.3s ease;
        }
        
        .finance-table tbody tr:hover {
            background: linear-gradient(45deg, #f8f9ff 0%, #f0f2ff 100%);
            transform: translateX(5px);
        }
        
        .finance-table tbody tr.highlight {
            background: linear-gradient(45deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
            font-weight: 600;
        }
        
        .finance-table tbody tr.highlight:hover {
            background: linear-gradient(45deg, rgba(102, 126, 234, 0.15) 0%, rgba(118, 75, 162, 0.15) 100%);
        }
        
        .finance-table tbody td {
            padding: 20px;
            color: #333;
            vertical-align: middle;
            border: none;
        }
        
        .finance-table tbody td:first-child {
            font-weight: 600;
            color: #333;
            position: relative;
        }
        
        .finance-table tbody td:first-child:before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            width: 4px;
            height: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 2px;
        }
        
        .finance-table tbody td:not(:first-child) {
            text-align: right;
            font-family: 'Montserrat', sans-serif;
            font-weight: 500;
        }
        
        .finance-table tbody tr.highlight td:first-child {
            color: #667eea;
        }
        
        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .overview-cards {
                grid-template-columns: 1fr;
                gap: 30px;
            }
            
            .finance-tabs {
                flex-direction: column;
                gap: 8px;
                max-width: 100%;
            }
            
            .tab-button {
                padding: 12px 20px;
            }
            
            .table-responsive {
                overflow-x: auto;
            }
            
            .finance-table {
                min-width: 600px;
            }
            
            .finance-table thead th,
            .finance-table tbody td {
                padding: 15px 12px;
                font-size: 0.9rem;
            }
        }
        
        /* Enhanced dropdown styles */
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
    <%@ include file="./modules/header.jsp" %>

    <main>
        <section class="finance-hero">
            <div class="container">
                <h2>재무정보</h2>
                <p>DDTOWN의 투명한 재무 정보를 확인하실 수 있습니다.</p>
            </div>
        </section>

        <section class="finance-overview">
            <div class="container">
                <div class="overview-cards">
                    <div class="overview-card">
                        <h3><i class="fas fa-chart-line" style="color: #667eea; margin-right: 8px;"></i>매출액</h3>
                        <p class="number">₩ <fmt:formatNumber value="${financialSummary.revenue != null ? financialSummary.revenue : 285000000}" type="number"/></p>
                        <p class="description"><c:out value="${financialSummary.year != null ? financialSummary.year : '2024'}" />년 기준</p>
                    </div>
                    <div class="overview-card">
                        <h3><i class="fas fa-coins" style="color: #667eea; margin-right: 8px;"></i>영업이익</h3>
                        <p class="number">₩ <fmt:formatNumber value="${financialSummary.operatingProfit != null ? financialSummary.operatingProfit : 32000000}" type="number"/></p>
                        <p class="description"><c:out value="${financialSummary.year != null ? financialSummary.year : '2024'}" />년 기준</p>
                    </div>
                    <div class="overview-card">
                        <h3><i class="fas fa-piggy-bank" style="color: #667eea; margin-right: 8px;"></i>자본금</h3>
                        <p class="number">₩ <fmt:formatNumber value="${financialSummary.capitalStock != null ? financialSummary.capitalStock : 500000000}" type="number"/></p>
                        <p class="description"><c:out value="${financialSummary.year != null ? financialSummary.year : '2024'}" />년 기준</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="finance-details">
            <div class="container">
                <div class="finance-tabs">
                    <button class="tab-button active" data-tab="income">
                        <i class="fas fa-chart-bar" style="margin-right: 8px;"></i>손익계산서
                    </button>
                    <button class="tab-button" data-tab="balance">
                        <i class="fas fa-balance-scale" style="margin-right: 8px;"></i>대차대조표
                    </button>
                    <button class="tab-button" data-tab="cash">
                        <i class="fas fa-money-bill-wave" style="margin-right: 8px;"></i>현금흐름표
                    </button>
                </div>

                <div class="tab-content active" id="income">
                    <h3>손익계산서</h3>
                    <div class="table-responsive">
                        <table class="finance-table">
                            <thead>
                                <tr>
                                    <th>구분</th>
                                    <th>2024년</th>
                                    <th>2023년</th>
                                    <th>2022년</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${incomeStatement}">
                                    <tr class="${item.highlight ? 'highlight' : ''}">
                                        <td><c:out value="${item.categoryName}"/></td>
                                        <td><fmt:formatNumber value="${item.value2024}" type="number"/> 원</td>
                                        <td><fmt:formatNumber value="${item.value2023}" type="number"/> 원</td>
                                        <td><fmt:formatNumber value="${item.value2022}" type="number"/> 원</td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty incomeStatement}">
                                    <tr>
                                        <td>매출액</td>
                                        <td><fmt:formatNumber value="285000000" type="number"/> 원</td>
                                        <td><fmt:formatNumber value="228000000" type="number"/> 원</td>
                                        <td><fmt:formatNumber value="185000000" type="number"/> 원</td>
                                    </tr>
                                    <tr>
                                        <td>매출원가</td>
                                        <td><fmt:formatNumber value="152000000" type="number"/> 원</td>
                                        <td><fmt:formatNumber value="125000000" type="number"/> 원</td>
                                        <td><fmt:formatNumber value="102000000" type="number"/> 원</td>
                                    </tr>
                                    <tr class="highlight">
                                        <td>영업이익</td>
                                        <td><fmt:formatNumber value="32000000" type="number"/> 원</td>
                                        <td><fmt:formatNumber value="18000000" type="number"/> 원</td>
                                        <td><fmt:formatNumber value="13000000" type="number"/> 원</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="tab-content" id="balance">
                    <h3>대차대조표</h3>
                    <div class="table-responsive">
                        <table class="finance-table">
                             <thead>
                                <tr>
                                    <th>구분</th>
                                    <th>2024년</th>
                                    <th>2023년</th>
                                    <th>2022년</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${balanceSheet}">
                                     <tr class="${item.highlight ? 'highlight' : ''}">
                                        <td><c:out value="${item.categoryName}"/></td>
                                        <td><fmt:formatNumber value="${item.value2024}" type="number"/> 원</td>
                                        <td><fmt:formatNumber value="${item.value2023}" type="number"/> 원</td>
                                        <td><fmt:formatNumber value="${item.value2022}" type="number"/> 원</td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty balanceSheet}">
                                    <tr>
                                        <td>자산총계</td>
                                        <td><fmt:formatNumber value="158000000" type="number"/> 원</td>
                                        <td><fmt:formatNumber value="125000000" type="number"/> 원</td>
                                        <td><fmt:formatNumber value="102000000" type="number"/> 원</td>
                                    </tr>
                                    <tr class="highlight">
                                        <td>자본총계</td>
                                        <td><fmt:formatNumber value="750000000" type="number"/> 원</td>
                                        <td><fmt:formatNumber value="570000000" type="number"/> 원</td>
                                        <td><fmt:formatNumber value="470000000" type="number"/> 원</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="tab-content" id="cash">
                    <h3>현금흐름표</h3>
                    <div class="table-responsive">
                        <table class="finance-table">
                            <thead>
                                <tr>
                                    <th>구분</th>
                                    <th>2024년</th>
                                    <th>2023년</th>
                                    <th>2022년</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${cashFlowStatement}">
                                     <tr class="${item.highlight ? 'highlight' : ''}">
                                        <td><c:out value="${item.categoryName}"/></td>
                                        <td><fmt:formatNumber value="${item.value2024}" type="number"/> 원</td>
                                        <td><fmt:formatNumber value="${item.value2023}" type="number"/> 원</td>
                                        <td><fmt:formatNumber value="${item.value2022}" type="number"/> 원</td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty cashFlowStatement}">
                                    <tr>
                                        <td>영업활동현금흐름</td>
                                        <td><fmt:formatNumber value="280000000" type="number"/> 원</td>
                                        <td><fmt:formatNumber value="150000000" type="number"/> 원</td>
                                        <td><fmt:formatNumber value="100000000" type="number"/> 원</td>
                                    </tr>
                                    <tr class="highlight">
                                        <td>현금및현금성자산증가</td>
                                        <td><fmt:formatNumber value="110000000" type="number"/> 원</td>
                                        <td><fmt:formatNumber value="500000000" type="number"/> 원</td>
                                        <td><fmt:formatNumber value="400000000" type="number"/> 원</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <%@ include file="./modules/footer.jsp" %>

    <script src="${pageContext.request.contextPath}/resources/js/common/main.js"></script>
    <script>
        // Enhanced Tab Functionality
        document.addEventListener('DOMContentLoaded', function() {
            const tabButtons = document.querySelectorAll('.tab-button');
            const tabContents = document.querySelectorAll('.tab-content');

            tabButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const targetTab = this.getAttribute('data-tab');

                    // Remove active class from all buttons and contents
                    tabButtons.forEach(btn => btn.classList.remove('active'));
                    tabContents.forEach(content => content.classList.remove('active'));

                    // Add active class to clicked button and corresponding content
                    this.classList.add('active');
                    document.getElementById(targetTab).classList.add('active');
                });
            });
        });
    </script>
</body>
</html>