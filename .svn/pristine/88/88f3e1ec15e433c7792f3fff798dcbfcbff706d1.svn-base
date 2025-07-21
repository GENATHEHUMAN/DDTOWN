<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 회원 관리</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/ckeditorInquiry/ckeditor.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.1/dist/js/adminlte.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
<%@ include file="../../modules/headerPart.jsp" %>
<style type="text/css">
#memberSearchButton {
    width: auto;
    min-width: max-content;
    white-space: nowrap;
    writing-mode: horizontal-tb !important;
    padding-left: 12px;
    padding-right: 12px;
}

.pagination-container{

}

.pagination-container li{
	float : left;
}

.input-group-append {
    display: -webkit-inline-box;
    padding: 0px 8px;
}

.ea-search-input {
    width: 250px;
}

.ea-filter-select {
    /* min-width: 150px; */
    width: auto;
}

.ea-search-input, .ea-filter-select {
    padding: 8px 12px;
    border: 1px solid #ced4da;
    border-radius: 4px;
    font-size: 0.9em;
    height: 38px;
    box-sizing: border-box;
}

div#cntArea {
    display: flex;
    gap: 10px;
    font-size: medium;
    align-items: center;
}

.cntArea .status-badge {
    font-size: medium;
}

.cntArea input{
	display : none;
}
label.status-badge.allMem {
    padding: 5px 10px;
    font-size: medium;
    font-weight: 500;
    color: white;
    display: inline-block;
    background-color: #227bff;
}

#cntArea label{
	cursor:pointer;
	transition : 0.3s ease;
	font-size: medium;
}

#cntArea label:hover {
    transform: scale(1.1);
    box-shadow: 0px 2px 10px #adaaad;
}

/* #cntArea input[name='searchCode']:checked + label{ */
/* 	border : none; */
/* 	transform : scale(0.95); */
/* } */
.cntGroup {
    display: flex;
    gap: 20px;
    align-items: center;
}
</style>
</head>
<body>
<div class="emp-container">
        <%@ include file="../modules/header.jsp" %>

        <div class="emp-body-wrapper">
            <%@ include file="../modules/aside.jsp" %>

			<main class="emp-content" style="font-size: large;">
				<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
					<ol class="breadcrumb">
					  <li class="breadcrumb-item"><a href="#" style="color:black;">아티스트 커뮤니티 관리</a></li>
					  <li class="breadcrumb-item active" aria-current="page">회원 관리</li>
					</ol>
				</nav>
				<section class="ea-section">
					<div class="ea-section-header">
						<div class="cntGroup">
							<h2>전체 회원 관리</h2>
							<div id="cntArea" class="cntArea">
								<input type="radio" name="searchCode" id="all" value="" <c:if test="${empty searchCode }">checked</c:if>/>
								<label for="all" class="status-badge allMem">전체 ${cntMap.totalMemCnt}명</label>

								<input type="radio" name="searchCode" id="general" value="MSC001" <c:if test="${searchCode eq 'MSC001'}">checked</c:if>/>
								<label for="general" class="status-badge answered">정상 ${cntMap.generalMemCnt}명</label>

								<input type="radio" name="searchCode" id="out" value="MSC002" <c:if test="${searchCode eq 'MSC002'}">checked</c:if>/>
								<label for="out" class="status-badge danger">탈퇴 ${cntMap.outMemCnt}명</label>

								<input type="radio" name="searchCode" id="black" value="MSC003" <c:if test="${searchCode eq 'MSC003'}">checked</c:if>/>
								<label for="black" class="status-badge pending">블랙리스트 ${cntMap.blackMemCnt}명</label>
							</div>
						</div>
						<div class="ea-header-actions">
							<form class="input-group input-group-sm" action="/admin/community/member/main" method="get" id="searchForm" style="flex-wrap: nowrap; ">
	                            <select id="memberStatusFilter" name="searchType" class="ea-filter-select" style="margin-right: 10px;">
	                                <option value="memId" id="memId" <c:if test="${pagingVO.searchType eq 'memId'}">selected</c:if>>아이디</option>
	                                <option value="name" id="name" <c:if test="${pagingVO.searchType eq 'name'}">selected</c:if>>이름</option>
	                                <option value="nick" id="nick" <c:if test="${pagingVO.searchType eq 'nick'}">selected</c:if>>닉네임</option>
	                                <option value="email" id="email" <c:if test="${pagingVO.searchType eq 'email'}">selected</c:if>>이메일</option>
	                            </select>
	                            <input type="search" id="memberSearchInput" name="searchWord" class="ea-search-input" placeholder="아이디, 이름, 닉네임, 이메일 검색" value="${pagingVO.searchWord}">
	                            <input type="hidden" id="searchCodeVal" name="searchCode" />
								<input type="hidden" name="currentPage" value="1" id="page" />

	                            <div class="input-group-append">
									<button type="submit" id="memberSearchButton" class="ea-btn primary">검색</button>
								</div>
                        	</form>
						</div>
					</div>

						<table class="ea-table" id="memberListTable" style="font-size: larger;">
			                <thead>
			                    <tr>
			                        <th>번호</th>
			                        <th>상태</th>
			                        <th>아이디</th>
			                        <th>이름</th>
			                        <th>닉네임</th>
			                        <th>이메일</th>
			                        <th>가입일</th>
			                    </tr>
			                </thead>
			                <tbody id="memberTableBody">
			                	<c:if test="${empty pagingVO.dataList}">
	                                <tr>
	                                    <td colspan="7" class="text-center">등록된 회원 정보가 없습니다.</td>
	                                </tr>
                                </c:if>
			                	<c:forEach items="${pagingVO.dataList }" var="vo">
			                		<tr>
			                			<td>${vo.rowNum }</td>
			                			<c:choose>
			                				<c:when test="${vo.memStatCode eq 'MSC001'}">
			                					<td><span class="status-badge answered">${vo.memStatDetCode }</span></td>
			                				</c:when>
			                				<c:when test="${vo.memStatCode eq 'MSC003' }">
			                					<td><span class="status-badge pending">${vo.memStatDetCode }</span></td>
			                				</c:when>
			                				<c:otherwise>
			                					<td><span class="status-badge danger">${vo.memStatDetCode }</span></td>
			                				</c:otherwise>
			                			</c:choose>
			                			<td style="text-align: left;">
			                				<a href="/admin/community/member/detail/${vo.memUsername }" class="member-id-link">
				                			${vo.memUsername }
			                				</a>
			                			</td>
			                			<td >
			                				<c:choose>
			                					<c:when test="${not empty vo.peopleVO.peoName }">${vo.peopleVO.peoName }</c:when>
			                					<c:otherwise>작성필요</c:otherwise>
			                				</c:choose>
			                			</td>
			                			<td>
			                				<div style="display: flex; gap: 10px; text-align: left;">
					                			${vo.memNicknm }
				                				<c:if test="${vo.peopleVO.userTypeCode == 'UTC002' }">
				                					<img alt="아티스트 인증 마크" src="${pageContext.request.contextPath }/resources/img/verified.png" style="width: 15px; height: 15px;">
				                				</c:if>
											</div>
			                			</td>
			                			<td style="text-align: left;">
			                				<c:choose>
			                					<c:when test="${empty vo.peopleVO.peoEmail }">작성필요</c:when>
			                					<c:otherwise>${vo.peopleVO.peoEmail }</c:otherwise>
			                				</c:choose>
			                			</td>
			                			<td><fmt:formatDate value="${vo.memRegDate}" pattern="yyyy-MM-dd"/></td>

			                		</tr>
			                	</c:forEach>
			                </tbody>
			            </table>
			            <div class="pagination-container" id="pagingArea">
			            	${pagingVO.pagingHTML}
			            </div>
				</section>
			</main>
		</div>
    </div>
<%@ include file="../../modules/footerPart.jsp" %>

<%@ include file="../../modules/sidebar.jsp" %>
<script type="text/javascript">

$(function(){

	let currentPage = sessionStorage.getItem("currentPage");
	let searchWord = sessionStorage.getItem("searchWord");
	let searchType = sessionStorage.getItem("searchType");

	if(currentPage != null){
		sessionStorage.removeItem("currentPage");
	}
	if(searchWord != null){
		sessionStorage.removeItem("searchWord");
	}
	if(searchType != null){
		sessionStorage.removeItem("searchType");
	}

	//페이지네이션 처리 시작
	const searchForm = document.getElementById("searchForm");
    const pageInput = searchForm.querySelector("input[name='currentPage']"); // hidden input의 name 사용
    const paginationControls = document.getElementById("pagingArea");

    if (paginationControls) { // paginationControls 요소가 존재할 때만 이벤트 리스너 추가
        paginationControls.addEventListener("click", function(e) {
            e.preventDefault(); // 기본 링크 이동 방지

            // 클릭된 요소가 'page-link' 클래스를 가지고 있고 'A' 또는 'SPAN' 태그인지 확인
            if (e.target.classList.contains("page-link") && (e.target.nodeName === "A" || e.target.nodeName === "SPAN")) {
                pageInput.value = e.target.dataset.page; // data-page 속성 값으로 hidden input 업데이트
                let searchCode = $('input[name="searchCode"]:checked').val();
                $("#searchCodeVal").val(searchCode);
                searchForm.submit(); // 폼 제출
            }
        });
    }
    // 페이지네이션 처리 끝

	// 검색결과 유지한채 이동
	let aLinkList = document.querySelectorAll('a');
	aLinkList.forEach(a => {
		a.addEventListener("click",function(e){
			let searchType = $("#memberStatusFilter").val();
			let searchWord = "${pagingVO.searchWord}";
			let currentPage = "${pagingVO.currentPage}";

			sessionStorage.setItem("currentPage",currentPage);
			sessionStorage.setItem("searchWord",searchWord);
			sessionStorage.setItem("searchType",searchType);

		})
	});
	/* let memberListTable = $("#memberListTable");
	memberListTable.on("click","button",function(e){
		console.log("123");
		e.perventDefault();
		const memberId = $(this).data("member-id");
		let searchWord = "${pagingVO.searchWord}";
		let currentPage = "${pagingVO.currentPage}";

		sessionStorage.setItem("currentPage",currentPage);
		sessionStorage.setItem("searchWord",searchWord);


		location.href="/admin/community/member/detail/" + memberId;
	});
	 */

	 $("input[name=searchCode]").on("click",function(){
		let currentCode = $(this).val();
		$("#searchCodeVal").val(currentCode);
		$("#searchForm").submit();
	 })

});


</script>
</body>
</html>