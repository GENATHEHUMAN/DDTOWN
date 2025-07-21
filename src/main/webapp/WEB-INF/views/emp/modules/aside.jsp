<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<aside class="emp-sidebar">
    <nav class="emp-nav">
        <ul>
            <li>
                <a href="#" class="emp-nav-item has-submenu" data-menu="community">
                    <i class="fas fa-users"></i> 아티스트 커뮤니티 관리 <span class="submenu-arrow">&gt;</span>
                </a>
                <ul class="emp-submenu" id="submenu-community">
<!--                     <li> -->
<!--                         <a href="#" class="emp-nav-item has-submenu" data-menu="artist-mgmt">아티스트 관리 <span class="submenu-arrow">&gt;</span></a> -->
<!--                         <ul class="emp-submenu" id="submenu-artist-mgmt"> -->
<%--                             <li><a href="${pageContext.request.contextPath}/emp/group/group-management" class="emp-nav-item">그룹 관리</a></li> --%>
<%--                             <li><a href="${pageContext.request.contextPath}/emp/artist/artist-management" class="emp-nav-item">아티스트 프로필 관리</a></li> </ul> --%>
<!--                     </li> -->
                    <li>
                        <a href="#" class="emp-nav-item has-submenu" data-menu="membership-mgmt">멤버십 관리 <span class="submenu-arrow">&gt;</span></a>
                        <ul class="emp-submenu" id="submenu-membership-mgmt">
                             <li><a href="${pageContext.request.contextPath}/emp/membership/sub/list" class="emp-nav-item"><span style="margin-left:15px;"></span>멤버십 구독자</a></li>
                             <li><a href="${pageContext.request.contextPath}/emp/membership/des/list" class="emp-nav-item"><span style="margin-left:15px;"></span>멤버십 플랜</a></li>
                        </ul>
                    </li>
                    <li><a href="${pageContext.request.contextPath}/emp/post/list" class="emp-nav-item">게시물 관리</a></li>
                    <li><a href="${pageContext.request.contextPath}/emp/live/main" class="emp-nav-item">라이브 요약</a></li>
                    <li><a href="${pageContext.request.contextPath}/emp/schedule/main" class="emp-nav-item">일정 관리</a></li>
                    <li><a href="${pageContext.request.contextPath}/emp/community/notice/list" class="emp-nav-item">공지사항 관리</a></li>
<%--                     <li><a href="${pageContext.request.contextPath}/emp/membership/main" class="emp-nav-item">멤버십 관리</a></li> --%>
                </ul>
            </li>
            <li>
                <a href="#" class="emp-nav-item has-submenu" data-menu="concert">
                    <i class="fas fa-ticket-alt"></i> 콘서트 관리 <span class="submenu-arrow">&gt;</span>
                </a>
                <ul class="emp-submenu" id="submenu-concert">
                    <li><a href="${pageContext.request.contextPath}/emp/concert/schedule/list" class="emp-nav-item">콘서트 일정 관리</a></li>
                    <li><a href="${pageContext.request.contextPath}/emp/concert/seat" class="emp-nav-item">콘서트 좌석 관리</a></li>
                </ul>
            </li>
            <li>
                <a href="#" class="emp-nav-item has-submenu" data-menu="audition">
                    <i class="fas fa-microphone-alt"></i> 오디션 관리 <span class="submenu-arrow">&gt;</span>
                </a>
                <ul class="emp-submenu" id="submenu-audition">
                    <li><a href="${pageContext.request.contextPath}/emp/audition/applicant" class="emp-nav-item">지원자 정보</a></li>
                    <li><a href="${pageContext.request.contextPath}/emp/audition/schedule" class="emp-nav-item">일정 관리</a></li>
                </ul>
            </li>
            <li>
                <a href="#" class="emp-nav-item has-submenu" data-menu="approval">
                    <i class="fas fa-file-signature"></i> 전자결재 <span class="submenu-arrow">&gt;</span>
                </a>
                <ul class="emp-submenu" id="submenu-approval">
                    <li><a href="${pageContext.request.contextPath}/emp/edms/approvalBox" class="emp-nav-item">상신 문서함</a></li>
                    <li><a href="${pageContext.request.contextPath}/emp/edms/requestList" class="emp-nav-item">받은 결재/참조 문서함</a></li>
                    <li><a href="${pageContext.request.contextPath}/emp/edms/approvalDraft" class="emp-nav-item">기안서 작성</a></li>
                </ul>
            </li>
			<sec:authorize access="hasRole('ADMIN')">
	            <li>
	               <a href="${pageContext.request.contextPath}/admin/main" class="emp-nav-item" data-menu="admin">
	                   <i class="fas fa-bullhorn"></i> 관리자 포탈 가기
	               </a>
	           </li>
			</sec:authorize>
        </ul>
    </nav>
</aside>