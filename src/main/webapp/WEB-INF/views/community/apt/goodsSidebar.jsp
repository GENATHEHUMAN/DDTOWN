<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components/goods-sidebar-widget.css">

<div class="goods-sidebar-widget" id="goodsSidebarWidget">
    <c:choose>
        <c:when test="${empty thumnailImages}">
            <!-- No goods available -->
            <div class="no-goods-container">
                <i class="bi bi-bag no-goods-icon"></i>
                <p class="no-goods-text">굿즈 준비 중입니다</p>
            </div>
        </c:when>
        
        <c:otherwise>
            <!-- Header -->
            <div class="goods-widget-header">
                <div class="goods-widget-header-content">
                    <div class="goods-badge">
                        <i class="bi bi-bag"></i>
                        굿즈
                    </div>
                    <div id="newBadge" class="new-badge" style="display: none;">NEW</div>
                </div>
            </div>

            <!-- Main Image Container -->
            <div class="goods-image-container">
                <c:forEach items="${thumnailImages}" var="item" varStatus="status">
                    <div class="goods-slide" 
                    	 data-index="${status.index}" 
                    	 style="display: ${status.index == 0 ? 'block' : 'none'};"
                    	 data-goods-no="${item.goodsNo }"
                    	 >
                        <img src="${item.representativeImageFile.webPath}" 
                             alt="${item.goodsNm}" 
                             class="goods-image"
                             onerror="this.src='${pageContext.request.contextPath}/resources/img/placeholder.png'">
                    </div>
                </c:forEach>

                <!-- Navigation Arrows -->
                <c:if test="${fn:length(thumnailImages) > 1}">
                    <button class="nav-arrow prev" onclick="goodsWidget.prevSlide()">
                        <i class="bi bi-chevron-left"></i>
                    </button>
                    <button class="nav-arrow next" onclick="goodsWidget.nextSlide()">
                        <i class="bi bi-chevron-right"></i>
                    </button>
                </c:if>

                <!-- Dots Indicator -->
                <c:if test="${fn:length(thumnailImages) > 1}">
                    <div class="dots-indicator">
                        <c:forEach items="${thumnailImages}" var="item" varStatus="status">
                            <button class="dot ${status.index == 0 ? 'active' : ''}" 
                                    onclick="goodsWidget.goToSlide(${status.index})"></button>
                        </c:forEach>
                    </div>
                </c:if>
            </div>

            <!-- Content -->
            <div class="goods-content">
                <c:forEach items="${thumnailImages}" var="item" varStatus="status">
                    <div class="goods-info" 
                         data-index="${status.index}" 
                         style="display: ${status.index == 0 ? 'block' : 'none'};"
                         data-goods-no="${item.goodsNo }">
                        <!-- Title -->
                        <h3 class="goods-title">${item.goodsNm}</h3>

                        <!-- Price -->
                        <c:if test="${not empty item.price && item.price > 0}">
                            <div class="price-container">
                                <div class="price-info">
                                	<span class="regular-price">₩<fmt:formatNumber value="${item.price}" pattern="#,###"/></span>
                                </div>
                            </div>
                        </c:if>

                        <!-- Action Button -->
                        <a href="${pageContext.request.contextPath}/goods/detail?goodsNo=${item.goodsNo}" class="action-button">
                            <span>자세히 보기</span>
                            <i class="bi bi-box-arrow-up-right"></i>
                        </a>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
// Goods Widget JavaScript
const goodsWidget = {
    currentIndex: 0,
    totalItems: ${fn:length(thumnailImages)},
    isAutoPlaying: true,
    autoPlayInterval: null,
    contextPath: '',

    init: function() {
        // Context Path는 필요하다면 가져옵니다.
        const widgetElement = document.getElementById('goodsSidebarWidget');
        if (widgetElement) {
            this.contextPath = widgetElement.dataset.contextPath || '';
        }

        if (this.totalItems <= 1) {
            document.querySelectorAll('.nav-arrow').forEach(arrow => arrow.style.display = 'none');
            const dotsIndicator = document.querySelector('.dots-indicator');
            if (dotsIndicator) {
                dotsIndicator.style.display = 'none';
            }
            return;
        }

        this.startAutoPlay();
        this.updateNewBadge();
    },

    startAutoPlay: function() {
        if (!this.isAutoPlaying) return;
        
        this.autoPlayInterval = setInterval(() => {
            this.nextSlide();
        }, 4000);
        
        document.getElementById('progressContainer').classList.add('auto-play-active');
    },

    stopAutoPlay: function() {
        this.isAutoPlaying = false;
        if (this.autoPlayInterval) {
            clearInterval(this.autoPlayInterval);
        }
        document.getElementById('progressContainer').classList.remove('auto-play-active');
    },

    nextSlide: function() {
        this.currentIndex = (this.currentIndex + 1) % this.totalItems;
        this.updateSlide();
        if (this.autoPlayInterval) {
            this.stopAutoPlay();
        }
    },

    prevSlide: function() {
        this.currentIndex = (this.currentIndex - 1 + this.totalItems) % this.totalItems;
        this.updateSlide();
        this.stopAutoPlay();
    },

    goToSlide: function(index) {
        this.currentIndex = index;
        this.updateSlide();
        this.stopAutoPlay();
    },

    updateSlide: function() {
        // Hide all slides and info
        document.querySelectorAll('.goods-slide').forEach((slide, index) => {
            slide.style.display = index === this.currentIndex ? 'block' : 'none';
        });

        document.querySelectorAll('.goods-info').forEach((info, index) => {
            info.style.display = index === this.currentIndex ? 'block' : 'none';
        });

        // Update dots
        document.querySelectorAll('.dot').forEach((dot, index) => {
            dot.classList.toggle('active', index === this.currentIndex);
        });

        // Update progress bar
        const progressBar = document.getElementById('progressBar');
        if (progressBar) {
            progressBar.style.width = `${((this.currentIndex + 1) / this.totalItems) * 100}%`;
        }

        this.updateNewBadge();
    },

    updateNewBadge: function() {
        const newBadge = document.getElementById('newBadge');

        // 현재 활성화된 goods-slide 요소에서 data-is-new 값을 가져옵니다.
        const currentSlideElement = document.querySelector(`.goods-slide[data-index="${this.currentIndex}"]`);
        if (newBadge && currentSlideElement) {
            const isNew = currentSlideElement.dataset.isNew === 'true'; // dataset은 문자열로 가져옵니다.

            if (isNew) {
                newBadge.style.display = 'block';
            } else {
                newBadge.style.display = 'none';
            }
        }
    },

};

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    goodsWidget.init();
});
</script>
