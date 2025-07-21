<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>  

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>굿즈샵 품목 관리 - DDTOWN 관리자 시스템</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <%@ include file="../../../modules/headerPart.jsp" %>
    
    <%-- ★★★ 이 두 줄을 <head> 태그 안에 추가해야 합니다! ★★★ --%>
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/admin_items_detail.css">
   
</head>
<body>
    <div class="emp-container">
        <%@ include file="../../modules/header.jsp" %>

        <div class="emp-body-wrapper">
            <%@ include file="../../modules/aside.jsp" %>
            <main class="emp-content">
            	<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/admin/goods/items/list" style="color:black;">굿즈샵 관리</a></li>
                        <li class="breadcrumb-item"><a href="/admin/goods/items/list" style="color:black;">품목 관리</a></li>
                        <li class="breadcrumb-item active" aria-current="page">품목 관리 상세</li>
                    </ol>
                </nav>
                <section id="goodsItemDetailSection" class="ea-section active-section">
                    <c:choose>
                        <c:when test="${not empty items and not empty items.goodsNm}">
						<div class="item-detail-container">
						    <div class="item-detail-header">
						        <h2 id="itemName"><c:out value="${items.goodsNm}"/></h2>
						        
						        <div class="header-actions"> 
						            <a href="${pageContext.request.contextPath}/admin/goods/items/update?id=${items.goodsNo}" class="ea-btn primary"><i class="fas fa-edit"></i> 수정</a>
						            <button type="button" id="deleteItemBtn" data-goodsno="${items.goodsNo}" data-goodsname="<c:out value='${items.goodsNm}'/>" class="ea-btn danger"><i class="fas fa-trash"></i> 삭제</button>
						        </div>
						    </div>
						</div>

                                <div class="item-images">
                                    <h3><i class="fas fa-image"></i> 상품 이미지</h3>
                                    <c:choose>
                                        <c:when test="${not empty items.representativeImageUrl}">
                                            <img src="${items.representativeImageUrl}" alt="<c:out value="${items.goodsNm}"/> 대표 이미지" class="main-image-display" onerror="this.onerror=null; this.src='https://via.placeholder.com/400x300.png?text=No+Image';">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="https://via.placeholder.com/400x300.png?text=No+Main+Image" alt="대표 이미지 없음" class="main-image-display">
                                        </c:otherwise>
                                    </c:choose>
                                    
                                    <div class="additional-images-display" id="additionalImagesDisplay">
                                        <c:if test="${not empty items.attachmentFileList}">
                                            <c:forEach var="imageFile" items="${items.attachmentFileList}">
                                                <%-- 대표 이미지와 동일한 파일은 여기서 제외할 수도 있습니다 (선택 사항) --%>
                                                <%-- if (item.representativeImageUrl != imageFile.webPath) ... --%>
                                                <img src="${imageFile.webPath}" alt="<c:out value="${imageFile.fileOriginalNm}"/>" onerror="this.style.display='none';">
                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${empty items.attachmentFileList}">
                                            <%-- 대표 이미지가 있고 추가 이미지가 없을 때는 이 메시지가 적절하지 않을 수 있음. --%>
                                            <%-- 좀 더 정교한 로직: item.attachmentFileList의 크기가 1이고 그것이 대표이미지라면 "추가 이미지 없음" 표시 등 --%>
                                            <p>추가 이미지가 없습니다.</p>
                                        </c:if>
                                    </div>
                                </div>
                                <hr>
                                <dl class="item-info-grid">
                                    <div class="item-info-section">
                                        <dt>상품코드</dt>
                                        <dd id="itemSku"><c:out value="${items.goodsCode}"/></dd>
                                        
                                        <dt>아티스트 그룹</dt> <%-- "카테고리" 대신 "아티스트 그룹"으로 가정 --%>
                                        <dd id="itemCategory"><c:out value="${items.artGroupName}"/></dd> <%-- GoodsVO에 artGroupName 필드 및 값이 있어야 함 --%>
                                    </div>
                                    <div class="item-info-section">
                                        <dt>판매가격</dt>
                                        <dd id="itemPrice"><fmt:formatNumber value="${items.goodsPrice}" type="currency" currencySymbol="₩"/> </dd>

                                        <dt>총 재고수량</dt>
                                        <dd id="itemStock">
                                            <c:out value="${items.stockRemainQty}"/> 개
                                            <c:if test="${items.stockRemainQty <= 0}"><span style="color:red;"> (품절)</span></c:if>
                                        </dd>
                                    </div>
                                    <div class="item-info-section">
                                        <dt>판매상태</dt>
                                        <dd>
                                            <span id="itemStatus" class="status-badge 
                                                <c:if test='${items.statusEngKey == "IN_STOCK"}'>status-selling</c:if>
                                                <c:if test='${items.statusEngKey == "SOLD_OUT"}'>status-soldout</c:if>
                                                <%-- 기타 다른 상태가 있다면 추가 --%>
                                                <c:if test='${items.statusEngKey != "IN_STOCK" && items.statusEngKey != "SOLD_OUT"}'>status-hidden</c:if> 
                                            ">
                                                <c:out value="${items.statusKorName}"/>
                                            </span>
                                        </dd>

                                        <dt>등록일</dt>
                                        <dd id="itemRegDate"><fmt:formatDate value="${items.goodsRegDate}" pattern="yyyy-MM-dd HH:mm:ss"/></dd>
                                    </div>
                                     <div class="item-info-section">
                                        <dt>최근 수정일</dt>
                                        <dd id="itemModDate"><fmt:formatDate value="${items.goodsModDate}" pattern="yyyy-MM-dd HH:mm:ss"/></dd>
                                    </div>
                                </dl>
                                <hr>
                                 <div class="item-info-section">
                                    <dt>상품설명</dt>
                                    <%-- white-space: pre-wrap; 은 줄바꿈 등을 유지해줍니다. --%>
                                    <%-- escapeXml="false"는 XSS 공격에 취약할 수 있으므로, 관리자가 직접 입력하는 안전한 내용일 때만 사용합니다. --%>
                                    <dd id="itemDescription" style="white-space: pre-wrap;"><c:out value="${items.goodsContent}" escapeXml="true"/></dd> 
                                </div>

								<%-- ⭐⭐⭐ 옵션 목록 및 옵션별 재고 수량 표시 (initialStockQty 사용) ⭐⭐⭐ --%>
								   <%-- ⭐⭐⭐ 옵션 목록 및 옵션별 재고 수량 표시 (goodsStock.stockRemainQty 사용) ⭐⭐⭐ --%>
									<c:if test="${not empty optionList && items.goodsMultiOptYn == 'Y'}">
									    <hr>
									    <div class="item-options-section item-info-section">
									        <h3><i class="fas fa-tasks"></i> 상품 옵션</h3>
									        <ul style="list-style-type: none; padding: 0;">
									            <c:forEach var="option" items="${optionList}">
									                <li style="margin-bottom: 8px; padding: 8px 12px; background-color: #f9f9f9; border-radius: 5px; border: 1px solid #eee; display: flex; justify-content: space-between; align-items: center;">
									                    <div>
									                        <strong style="color: #007bff;"><c:out value="${option.goodsOptNm}"/></strong> 
									                        <c:if test="${option.goodsOptPrice != null && option.goodsOptPrice > 0}">
									                            <span style="color: #28a745; font-weight: 600;"> (<fmt:formatNumber value="${option.goodsOptPrice}" type="currency" currencySymbol="+₩" currencyCode="KRW"/>)</span>
									                        </c:if>
									                    </div>
									                    <span style="color: #555; font-size: 0.95em; white-space: nowrap;">
									                        재고: <strong><c:out value="${option.goodsStock.stockRemainQty != null ? option.goodsStock.stockRemainQty : '0'}"/></strong> 개
									                        <c:if test="${option.goodsStock.stockRemainQty == null || option.goodsStock.stockRemainQty <= 0}"><span class="stock-soldout"> (품절)</span></c:if>
									                    </span>
									                </li>
									            </c:forEach>
									        </ul>
									    </div>
									</c:if>

                                <div class="item-actions">
									<a href="${pageContext.request.contextPath}/admin/goods/items/list" class="ea-btn">목록</a>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="item-detail-container">
                                <p>상품 정보를 찾을 수 없습니다. <a href="${pageContext.request.contextPath}/admin/goods/items/list">목록으로 돌아가기</a></p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    
                </section>
            </main>
        </div>
    </div>
</body>
<%@ include file="../../../modules/footerPart.jsp" %>

<%@ include file="../../../modules/sidebar.jsp" %>
<script>
document.addEventListener('DOMContentLoaded', function() {
 // --- ★★★ 삭제 버튼 클릭 이벤트 핸들러 (수정된 부분) ★★★ ---
    const deleteItemBtn = document.getElementById('deleteItemBtn'); // 이 변수가 선언되어 있어야 함

    if (deleteItemBtn) {
        deleteItemBtn.addEventListener('click', function() {
            const goodsNo = this.dataset.goodsno;
            const goodsName = this.dataset.goodsname;

            if (confirm(`'${goodsName}' 상품을 정말로 삭제하시겠습니까?`)) {
                const contextPath = '${pageContext.request.contextPath}';
                const deleteUrl = `${contextPath}/admin/goods/items/delete`;

                // 동적으로 폼 생성
                const form = document.createElement('form');
                form.setAttribute('method', 'post');
                form.setAttribute('action', deleteUrl);
                form.style.display = 'none'; // 폼을 화면에 보이지 않게 숨김

                // goodsNo를 hidden input으로 추가
                const goodsNoInput = document.createElement('input');
                goodsNoInput.setAttribute('type', 'hidden');
                goodsNoInput.setAttribute('name', 'goodsNo');
                goodsNoInput.setAttribute('value', goodsNo);
                form.appendChild(goodsNoInput);

                // ★★★ CSRF 토큰을 hidden input으로 추가 (핵심!) ★★★
                // <head>에 추가한 <meta> 태그에서 CSRF 토큰 값을 가져옵니다.
                const csrfTokenMeta = document.querySelector('meta[name="_csrf"]');
                
                if (csrfTokenMeta) { // _csrf 메타 태그가 존재하는지 확인
                    const csrfToken = csrfTokenMeta.getAttribute('content');
                    
                    const csrfInput = document.createElement('input');
                    csrfInput.setAttribute('type', 'hidden');
                    // Spring Security는 폼 제출 시 '_csrf'라는 이름의 파라미터에서 토큰을 찾습니다.
                    csrfInput.setAttribute('name', '_csrf'); // 이 부분을 반드시 '_csrf'로 설정해야 합니다!
                    csrfInput.setAttribute('value', csrfToken);
                    form.appendChild(csrfInput);
                } else {
                    console.warn("CSRF meta tag ('_csrf') not found. If Spring Security CSRF is enabled, this might cause 403 Forbidden errors.");
                }

                // 폼을 body에 추가하고 제출
                document.body.appendChild(form);
                form.submit(); // 이 호출로 인해 페이지가 새로고침됩니다.
            }
        });
    }
});
</script>
</html> 