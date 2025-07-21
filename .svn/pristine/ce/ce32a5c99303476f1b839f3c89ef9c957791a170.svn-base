<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <%-- CSS 파일 경로 수정: ${pageContext.request.contextPath}/resources 를 기준으로 설정 --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/admin_portal.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
관리자 1대1문의 페이지

<main class="emp-content">
	<section id="csInquiryListSection" class="ea-section active-section">
		<div class="ea-section-header">
			<h2>1:1 문의 관리</h2>
			<div class="ea-header-actions">
				<input type="text" class="ea-search-input" id="inquirySearchInput" placeholder="문의 제목, 내용, 사용자 검색...">
				<select id="inquiryStatusFilter" class="ea-filter-select" style="min-width: 120px;">
				</select>
				<select id="inquiryTypeFilter" class="ea-filter-select" style="min-width: 140px;">
				</select>
			</div>
		</div>
		
		<table class="ea-table">
			<thead>
                <tr>
                    <th class="col-number">번호</th>
                    <th class="col-status">상태</th>
                    <th class="col-type">문의유형</th>
                    <th class="col-title">제목</th>
                    <th class="col-user">문의자(ID)</th>
                    <th class="col-date">문의일</th>
                    <th class="col-actions">관리</th>
                </tr>
            </thead>
            <tbody id="inquiryTableBody">
            
            </tbody>
		</table>
	</section>
</main>

		<footer class="emp-footer">
            <p>&copy; <fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy"/> DDTOWN Entertainment. All rights reserved. (관리자 전용)</p>
        </footer>
</body>
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
	$.ajax({
		url : "/admin/inquiry/list",
		type : "get",
		success : function(res){
			console.log(res)
			let html = ``;
			if(res != null && res.length > 0) {
				for(let i=0; i<res.length; i++){
					let vo = res[i];
					let statCodeCss = (vo.inqStatCodeDes === '접수됨') ? "status-badge pending" : "status-badge answered";
					let date = dateFormat(vo.inqRegDate);
					console.log(statCodeCss);
					html += `
					<tr data-inquiry-id="\${vo.inqNo}">
	                    <td>\${vo.inqNo}</td>
	                    <td><span class="\${statCodeCss}">\${vo.inqStatCodeDes}</span></td>
	                    <td>\${vo.inqTypeCodeDes}</td>
	                    <td class="inquiry-title"><a href="cs_inquiry_detail.html?id=201">\${vo.inqTitle}</a></td>
	                    <td>\${vo.memUsername}</td>
	                    <td>\${date}</td>
	                    <td class="notice-actions">
	                        <a href="cs_inquiry_detail.html?id=201" class="ea-btn sm outline"><i class="fas fa-eye"></i> 보기/답변</a>
	                    </td>
	                </tr>
					`;
				}
			}else{
				
			}
			
			$("#inquiryTableBody").html(html);
		},
		error : function(error, thrown){
			console.log(error.status);
		}
	});
});

</script>
</html>