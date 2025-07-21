<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<aside class="mypage-sidebar">
    <h2>MY PAGE</h2>
    <nav class="mypage-nav">
        <ul>
            <li class="nav-depth1">
                <a href="<c:url value='/mypage/info' />" class="mypage-nav-item ${currentPage eq 'profile' or empty currentPage ? 'active-menu' : ''}">개인정보 관리</a>
            </li>
            <li class="nav-depth1">
                <a href="<c:url value='/mypage/memberships' />" class="mypage-nav-item ${currentPage eq 'subDetail' ? 'active-menu' : ''}">APT 구독현황</a>
            </li>
            
            <%-- 주문 관리 메뉴 시작 --%>
            <li class="nav-depth1">
                <a href="<c:url value='/mypage/orders' />" class="mypage-nav-item ${currentPage eq 'orders' ? 'active-menu' : ''}">주문 내역</a>
            </li>
            <%-- 주문 관리 메뉴 끝 --%>

            <li class="nav-depth1">
                <a href="#" class="mypage-nav-item has-submenu ${currentPage eq 'alerts' or currentPage eq 'alertSettings' ? 'open' : ''}" data-menu="alerts-parent">
                    알림 관리 <span class="submenu-arrow">&gt;</span>
                </a>
                <ul class="mypage-submenu" id="submenu-alerts-parent" style="display: ${currentPage eq 'alerts' or currentPage eq 'alertSettings' ? 'block' : 'none'};">
                    <li><a href="<c:url value='/mypage/alerts' />" class="mypage-nav-item ${currentPage eq 'alerts' ? 'active-menu' : ''}">알림 내역</a></li>
                    <li><a href="<c:url value='/mypage/alerts/settings' />" class="mypage-nav-item ${currentPage eq 'alertSettings' ? 'active-menu' : ''}">알림 설정</a></li>
                </ul>
            </li>
        </ul>
    </nav>
</aside>