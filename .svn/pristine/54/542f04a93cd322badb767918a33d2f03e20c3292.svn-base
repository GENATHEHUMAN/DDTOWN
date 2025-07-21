<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의 - DDTOWN 관리자</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
<%@ include file="../../modules/headerPart.jsp" %>
<style type="text/css">
#searchBtn {
    width: auto; /* 내용에 맞게 너비 자동 조절 */
    min-width: max-content; /* 최소 너비를 내용만큼 확보 (예: "검색" 두 글자) */
    white-space: nowrap; /* 글자가 두 줄로 나뉘는 것을 방지 */
    writing-mode: horizontal-tb !important; /* 혹시라도 writing-mode가 세로로 설정된 경우 강제 변경 */
    padding-left: 12px; /* 버튼 내부 여백 (기존 .ea-btn 스타일에 따라 조절) */
    padding-right: 12px; /* 버튼 내부 여백 (기존 .ea-btn 스타일에 따라 조절) */
}
.input-group {
    gap: 5px;
    flex-wrap: nowrap;
}
div#cntArea {
    display: flex;
    gap: 10px;
    font-size: 6pt;
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
    font-weight: 500;
    color: white;
    display: inline-block;
    background-color: #227bff;

}

#cntArea label{
	cursor:pointer;
	transition : 0.3s ease;
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

.breadcrumb a{
	color : black;
}

.ea-table .inquiry-title a {
    color: #007fff;
    text-decoration: none;
    font-weight: 500;
}
</style>
</head>
<body onload="list()">
<div class="emp-container">
	<%@ include file="../modules/header.jsp" %>

		<div class="emp-body-wrapper">
			<%@ include file="../modules/aside.jsp" %>

				<main class="emp-content" style="font-size: large;">
					<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
						<ol class="breadcrumb">
						  <li class="breadcrumb-item"><a href="#">고객센터</a></li>
						  <li class="breadcrumb-item" aria-current="page">1:1문의</li>
						</ol>
					</nav>
					<section id="csInquiryListSection" class="ea-section active-section" onsubmit="return false;">
						<div class="ea-section-header">
							<div class="cntGroup">
								<h2>1:1 문의 관리</h2>
								<div id="cntArea" class="cntArea">
								</div>
							</div>
							<div class="ea-header-actions">

								<form class="input-group input-group-sm" method="get" id="searchForm">

									<input type="hidden" name="currentPage" value="1" id="page">

									<select id="searchType" class="ea-filter-select" name="searchType">
										<option value="">전체</option>
										<option value="title">제목</option>
										<option value="id">아이디</option>
									</select>

									<input type="search" class="ea-search-input" id="searchWord" placeholder="문의 제목 검색...">

									<div class="input-group-append">
										<button type="button" class="ea-btn primary" id="searchBtn">
											<i class="fas fa-search"></i>검색
										</button>
									</div>
								</form>
							</div>
						</div>

						<table class="ea-table">
							<thead>
				                <tr>
				                    <th class="col-number">번호</th>
				                    <th class="col-status">
				                    	<div class="dropdown">
					                    	<button type="button" data-bs-toggle="dropdown" aria-expanded="false">상태</button>
					                    	<ul class="dropdown-menu">
					                    		<li class="liclass" id="li">da</li>
					                    	</ul>
				                    	</div>
				                    </th>
				                    <th class="col-type">문의유형</th>
				                    <th class="col-title">제목</th>
				                    <th class="col-user">문의자(ID)</th>
				                    <th class="col-date">문의일</th>
				                </tr>
				            </thead>
				            <tbody id="inquiryTableBody">

				            </tbody>
						</table>
						<div class="pagination-container" id="pagingArea">
						</div>
					</section>
				</main>
		</div>
</div>
</body>
<%@ include file="../../modules/footerPart.jsp" %>

<%@ include file="../../modules/sidebar.jsp" %>
<script type="text/javascript">


function dateFormat(jsonDate){
	if (!jsonDate) return "";
	let date = new Date(jsonDate);
	let month = date.getMonth() + 1;
    let day = date.getDate();
    let hour = date.getHours();
    let minute = date.getMinutes();
    let second = date.getSeconds();

    month = month >= 10 ? month : '0' + month;
    day = day >= 10 ? day : '0' + day;
    hour = hour >= 10 ? hour : '0' + hour;
    minute = minute >= 10 ? minute : '0' + minute;
    second = second >= 10 ? second : '0' + second;

    return date.getFullYear() + '-' + month + '-' + day;
}

$(function(){


	let currentPage = sessionStorage.getItem("currentPage");
	let searchWord = sessionStorage.getItem("searchWord");
	let searchType = sessionStorage.getItem("searchType");

	if(currentPage != null && searchWord != null && searchType != null){
		sessionStorage.removeItem("currentPage");
		sessionStorage.removeItem("searchWord");
		sessionStorage.removeItem("searchType");
		let data = {
			page : currentPage,
			searchWord : searchWord,
			searchType : searchType
		}
		list(data);
	}else{
		list();
	}

	$("#cntArea").on("click","input[name=searchCode]",function(){
		let searchCode = $(this).val()

		let data = {
			"searchCode" : searchCode
		}

		list(data);
	});



	$("#inquiryTableBody").on("click","td[class=inquiry-title]",function(e){
		let currentPage = $('#pagingArea').children().children('li.page-item.active').text()

		sessionStorage.setItem("currentPage",parseInt(currentPage));
		sessionStorage.setItem("searchWord",$("#searchWord").val());
		sessionStorage.setItem("searchType",$("#searchType").val());
	})


	$("#searchWord").on("keydown",function(e){
		let data = {
			searchWord : $("#searchWord").val(),
			searchType : $("#searchType").val()
		}
		if (e.key === 'Enter') {
			list(data);
		}
	})

	$("#searchBtn").on("click",function(){

		let data = {
			searchWord : $("#searchWord").val(),
			searchType : $("#searchType").val()
		}

		list(data);
	});

	const pagingArea = $('#pagingArea');
    if(pagingArea.length > 0) {
        pagingArea.on('click', 'a', function(event) {
            event.preventDefault();
            const page = $(this).data('page');

            let searchCode = $('input[name="searchCode"]:checked').val();

            let searchType = $("#searchType").val();
            let searchWord = $("#searchWord").val();

            let data = {
            	searchCode : searchCode,
            	searchType : searchType,
            	searchWord : searchWord,
            	page : page
            };
            list(data);
        });
    }
});

function list(data){

	$.ajax({
		url : "/admin/inquiry/list",
		type : "get",
		data : data,
		success : function(res){

			let cntHtml = `
				<input type="radio" name="searchCode" id="all" value=""`;

			if(res.searchCode == null || res.searchCode == ''){
				cntHtml += `checked`;
			}
			cntHtml +=`
				/>
				<label for="all" class="status-badge allMem">전체 \${res.totalInq}건</label>`;

			for(let j=0; j<res.cntList.length; j++){
				let cnt = res.cntList[j];
				cntHtml +=`
					<input type="radio" name="searchCode"`;
				if(cnt.commCodeDetNo == 'ISC002'){
					cntHtml += `id="complete" value="\${cnt.commCodeDetNo}"`;
					if(res.searchCode == cnt.commCodeDetNo){
						cntHtml += `checked`;
					}
					cntHtml += `
						/>
						<label for="complete" class="status-badge answered">답변완료 \${cnt.codeCnt}건</label>`;
				}else{
					cntHtml += `<input type="radio" name="searchCode" id="Unresolved" value="\${cnt.commCodeDetNo}"`;
					if(res.searchCode == cnt.commCodeDetNo){
						cntHtml += `checked`;
					}
					cntHtml +=`
						/>
						<label for="Unresolved" class="status-badge pending">접수됨 \${cnt.codeCnt}건</label>`;
				}
			}

			$("#cntArea").html(cntHtml);


			let html = ``;
			if(res.inqVOList != null && res.inqVOList.length > 0) {
				for(let i=0; i<res.inqVOList.length; i++){
					let vo = res.inqVOList[i];
					let statCodeCss = (vo.inqStatCodeDes === '접수됨') ? "status-badge pending" : "status-badge answered";
					let date = dateFormat(vo.inqRegDate);
					html += `
					<tr data-inquiry-id="\${vo.inqNo}">
	                    <td>\${vo.inqNo}</td>
	                    <td><span class="\${statCodeCss}">\${vo.inqStatCodeDes}</span></td>
	                    <td>\${vo.inqTypeCodeDes}</td>
	                    <td class="inquiry-title"><a href="/admin/inquiry/detail/\${vo.inqNo}">\${vo.inqTitle}</a></td>
	                    <td style="text-align: left;">\${vo.memUsername}</td>
	                    <td>\${date}</td>
	                </tr>
					`;
				}
			}else{
				html += `
				<tr>
					<td class="inquiry-title" colspan="6">조회하실 1:1문의가 없습니다.</td>
				</tr>
				`;
			}


			let typeCode = `<option value="">전체</option>`;
			if(res.typeCodeList != null && res.typeCodeList.length > 0){
				for(let i=0; i < res.typeCodeList.length; i++){
					let type = res.typeCodeList[i];
					let select = "";
					if(type.commCodeDetNo == res.pagingVO.searchType){
						select = "selected"
					}
					typeCode += `<option value="\${type.commCodeDetNo}" \${select}>\${type.description}</option>`;
				}
			}

			if(data != null){
				if(data.searchWord){
					$("#searchWord").val(data.searchWord);
				}
			}

			let statCode = `<li class="statDrop">전체</li>`;
			for(let i=0; i<res.statCodeList.length; i++){
				let stat = res.statCodeList[i];
				statCode += `<li class="statDrop" data-bs-stat-code="\${stat.commCodeDetNo}">\${stat.description}</li>`;
			}

			$("#inquiryTableBody").html(html);
			$("#pagingArea").html(res.pagingVO.pagingHTML)
			$(".dropdown-menu").html(statCode);
		},
		error : function(error, thrown){
			console.log(error.status);
		}
	});
}

</script>
</html>