<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>자주 묻는 질문</title>
<%@ include file="../modules/headerPart.jsp" %> <%-- 실제 경로로 수정 필요 --%>

<style>
    html, body { height: 100%; }
    .wrapper { min-height: 100%; display: flex; flex-direction: column; }
    .content-wrapper.no-layout { margin-left: 0 !important; min-height: 100vh; flex-grow: 1; background-color: #f4f6f9; } /* AdminLTE 기본 배경색 */
    .page-main-title { font-size: 2.2rem; font-weight: 600; color: #333; text-align: center; }
    
    /* ▼▼▼ 수정된 CSS 적용 부분 ▼▼▼ */
    .faq-category-group {
        text-align: center; /* 라디오 버튼 그룹을 가운데 정렬합니다. */
    }

    .faq-category-group .custom-control-label {
        margin-right: 15px;
        font-weight: 500 !important;
        cursor: pointer;
    }

    /* .faq-category-group .custom-control-input:checked~.custom-control-label { color: #007bff; } */ /* 필요시 주석 해제 */

    .faq-accordion .card-header { padding: 0; }
    .faq-accordion .card-header .btn-faq-toggle {
        color: #333; font-weight: bold; text-decoration: none; font-size: 1.1rem;
        padding: 0.75rem 1.25rem; display: block; width: 100%; text-align: left;
        border: none; background: none; position: relative;
    }
    .faq-accordion .card-header .btn-faq-toggle:hover { color: #8a2be2; background-color: #f8f9fa;}
    .faq-accordion .card-header .btn-faq-toggle .faq-icon {
        position: absolute; right: 1.25rem; top: 50%;
        transform: translateY(-50%);
        transition: transform .2s ease-in-out;
    }
    .faq-accordion .card-header .btn-faq-toggle[aria-expanded="true"] .faq-icon {
        transform: translateY(-50%) rotate(-180deg);
    }
    .faq-answer-body {
        border-left: 3px solid #007bff;
        padding: 15px 15px 15px 20px !important;
        margin-left: 5px; line-height: 1.7; color: #555;
        background-color: #ffffff;
    }

    .custom-control-input { display: none; }
    .custom-control-label::before,
    .custom-control-label::after { display: none !important; }

    .custom-control-label {
        padding: 0.5rem 1rem;
        border: 1px solid #ccc;
        border-radius: 20px;
        cursor: pointer;
        transition: background-color 0.3s ease, color 0.3s ease, border-color 0.3s ease;
        display: inline-block;
        margin-bottom: 5px;
        user-select: none;
        line-height: 1.5;
        background-color: #ffffff;
        color: #000000;
    }

    .custom-control-label:hover {
        background-color: #6200ee;
        color: #ffffff !important;
        border-color: #6200ee;
    }

    .custom-control-input:checked + .custom-control-label {
        background-color: #6200ee;
        color: #ffffff !important;
        border-color: #6200ee;
        font-weight: bold;
    }

    .custom-control-input:focus + .custom-control-label {
        box-shadow: 0 0 0 0.2rem rgba(98, 0, 238, 0.25);
    }

    .custom-control-input:disabled + .custom-control-label {
        background-color: #e9ecef;
        color: #6c757d;
        border-color: #ced4da;
        cursor: not-allowed;
    }

    .custom-control-input:disabled:checked + .custom-control-label {
        background-color: #adb5bd;
        color: #ffffff;
        border-color: #adb5bd;
    }
    /* ▲▲▲ CSS 수정 완료 ▲▲▲ */
</style>
</head>
<body class="hold-transition">
<div class="wrapper">
    <div class="content-wrapper no-layout">
        <section class="content pt-5 pb-4">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12 mb-4">
                        <h1 class="page-main-title">자주 묻는 질문</h1>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-10 offset-md-1">
                        <div class="card card-outline card-primary shadow-sm">
                            <div class="card-header">
                                <h3 class="card-title" style="font-size: 1.3rem; font-weight: 600;">카테고리</h3>
                            </div>
                            <div class="card-body">
                                <div class="form-group faq-category-group">
                                    <div class="custom-control custom-radio custom-control-inline">
                                        <input type="radio" id="cat_all_faq" name="faqCategory" class="custom-control-input" value="null" checked>
                                        <label class="custom-control-label" for="cat_all_faq">전체</label>
                                    </div>
                                    <c:forEach items="${codeList}" var="code" varStatus="loopStatus">
                                        <div class="custom-control custom-radio custom-control-inline">
                                            <%-- commCodeDetNo가 카테고리의 고유 식별자라고 가정 --%>
                                            <input type="radio" id="cat_faq_${code.commCodeDetNo}" name="faqCategory" class="custom-control-input" value="${code.commCodeDetNo}" <c:if test="${selectCode eq code.commCodeDetNo }">checked</c:if>>
                                            <label class="custom-control-label" for="cat_faq_${code.commCodeDetNo}">${code.description}</label>
                                        </div>
                                    </c:forEach>
                                </div>
                                <hr>

                                <c:choose>
                                    <c:when test="${empty list}">
                                        <div class="callout callout-info">
                                            <h5><i class="icon fas fa-info"></i> 정보</h5>
                                            <p>등록된 FAQ가 없습니다.</p>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="accordion faq-accordion" id="faqAccordionList">
                                            <c:forEach items="${list}" var="faq" varStatus="status">
                                                <%-- 
                                                    중요: data-category 값은 라디오 버튼의 value 값과 일치해야 합니다.
                                                    faq 객체에서 카테고리 '코드값' (예: typeDetailCode.commCodeDetNo)을 사용해야 합니다.
                                                    이전 코드에서 "${faq.description}"으로 되어 있었으나, 이는 카테고리 '이름'이므로 필터링이 제대로 안될 수 있습니다.
                                                    아래는 typeDetailCode.commCodeDetNo를 사용한다고 가정합니다. 실제 필드명으로 변경해주세요.
                                                --%>
                                                <div class="card card-light card-outline mb-2 faq-item-panel" data-category="${faq.description}">
                                                    <div class="card-header" id="headingFaq_${faq.faqNo}"> <%-- faqNo가 고유 ID라고 가정 --%>
                                                        <h2 class="mb-0">
                                                            <%-- 
                                                                AdminLTE 버전에 따라 data-toggle 또는 data-bs-toggle 사용.
                                                                AdminLTE 3.2+ & Bootstrap 5: data-bs-toggle="collapse" data-bs-target="..."
                                                                AdminLTE <3.2 & Bootstrap 4: data-toggle="collapse" data-target="..." (또는 href)
                                                                제공해주신 AdminLTE FAQ 예시는 data-toggle을 사용했으므로, 우선 그것을 따릅니다.
                                                            --%>
                                                            <button class="btn-faq-toggle ${status.first ? '' : 'collapsed'}" type="button" 
                                                                    data-toggle="collapse" data-target="#collapseFaq_${faq.faqNo}" 
                                                                    aria-expanded="${status.first ? 'true' : 'false'}" aria-controls="collapseFaq_${faq.faqNo}">
                                                                Q. (${faq.description}) ${faq.faqTitle}
                                                                <span class="faq-icon"><i class="fas fa-chevron-down"></i></span>
                                                            </button>
                                                        </h2>
                                                    </div>
                                                    <div id="collapseFaq_${faq.faqNo}" class="collapse ${status.first ? 'show' : ''}" 
                                                         aria-labelledby="headingFaq_${faq.faqNo}" data-parent="#faqAccordionList">
                                                        <div class="card-body faq-answer-body">
                                                            A. <c:out value="${faq.faqAnswer}" escapeXml="false"/> <%-- HTML 태그가 포함될 수 있다면 escapeXml="false" --%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
<%@ include file="../modules/footerPart.jsp" %>
<script type="text/javascript">

$(function(){
	let radioButtons = $("input[type='radio']");
	
	radioButtons.on("click",function(event){
		let code = event.target.value;
		let faqTypeCode = btoa(code);
		location.href = "/faq/main?faqTypeCode=" + faqTypeCode;
	});
});

</script>
</body>

</html>