// Community Footer JavaScript
document.addEventListener('DOMContentLoaded', function() {
    // 푸터 애니메이션 초기화
    initFooterAnimations();

    // 소셜 링크 이벤트
    initSocialLinks();

    // 연락처 카드 인터랙션
    initContactCards();

    // 링크 그룹 호버 효과
    initLinkGroups();
});

// 푸터 애니메이션 초기화
function initFooterAnimations() {
    const footer = document.querySelector('.community-footer');
    if (!footer) return;

    // Intersection Observer로 푸터가 보일 때 애니메이션 실행
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('footer-visible');
                animateFooterElements();
            }
        });
    }, {
        threshold: 0.1
    });

    observer.observe(footer);
}

// 푸터 요소들 순차 애니메이션
function animateFooterElements() {
    const elements = [
        '.footer-brand',
        '.link-group',
        '.contact-card',
        '.footer-bottom'
    ];

    elements.forEach((selector, index) => {
        const items = document.querySelectorAll(selector);
        items.forEach((item, itemIndex) => {
            setTimeout(() => {
                item.style.opacity = '0';
                //item.style.transform = 'translateY(30px)';
                item.style.transition = 'all 0.6s ease';

                setTimeout(() => {
                    item.style.opacity = '1';
                    //item.style.transform = 'translateY(0)';
                }, 100);
            }, (index * 200) + (itemIndex * 100));
        });
    });
}

// 소셜 링크 이벤트
function initSocialLinks() {
    const socialLinks = document.querySelectorAll('.social-link');

    socialLinks.forEach(link => {
        // 클릭 이벤트
        link.addEventListener('click', function(e) {
            e.preventDefault();

            // 클릭 효과
            this.style.transform = 'scale(0.95)';
            setTimeout(() => {
                this.style.transform = '';
            }, 150);

            // 실제 소셜 미디어 링크로 이동 (예시)
            const platform = this.querySelector('i').classList[1].split('-')[1];
            console.log(`${platform} 소셜 미디어로 이동`);

            // 실제 구현시 아래와 같이 사용
            // window.open(`https://www.${platform}.com/ddtown_official`, '_blank');
        });

        // 호버 효과 강화
        link.addEventListener('mouseenter', function() {
            this.style.boxShadow = '0 8px 25px rgba(255, 255, 255, 0.3)';
        });

        link.addEventListener('mouseleave', function() {
            this.style.boxShadow = '';
        });
    });
}

// 연락처 카드 인터랙션
function initContactCards() {
    const contactCards = document.querySelectorAll('.contact-card');

    contactCards.forEach(card => {
        // 클릭시 연락처 정보 복사
        card.addEventListener('click', function() {
            const contactValue = this.querySelector('.contact-value').textContent;
            const contactType = this.querySelector('.contact-label').textContent;

            // 클립보드에 복사
            if (navigator.clipboard) {
                navigator.clipboard.writeText(contactValue).then(() => {
                    showCopyNotification(contactType, contactValue);
                });
            } else {
                // 구형 브라우저 지원
                const textArea = document.createElement('textarea');
                textArea.value = contactValue;
                document.body.appendChild(textArea);
                textArea.select();
                document.execCommand('copy');
                document.body.removeChild(textArea);
                showCopyNotification(contactType, contactValue);
            }

            // 클릭 효과
            this.style.transform = 'scale(0.98)';
            setTimeout(() => {
                this.style.transform = '';
            }, 200);
        });

    });
}

// 복사 알림 표시
function showCopyNotification(type, value) {
    // 기존 알림 제거
    const existingNotification = document.querySelector('.copy-notification');
    if (existingNotification) {
        existingNotification.remove();
    }

    // 새 알림 생성
    const notification = document.createElement('div');
    notification.className = 'copy-notification';
    notification.innerHTML = `
        <div class="notification-content">
            <i class="fas fa-check-circle"></i>
            <span>${type} 정보가 복사되었습니다!</span>
            <small>${value}</small>
        </div>
    `;

    // 스타일 적용
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 15px 20px;
        border-radius: 10px;
        box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        z-index: 10000;
        transform: translateX(100%);
        transition: transform 0.3s ease;
        font-family: 'Noto Sans KR', sans-serif;
    `;

    notification.querySelector('.notification-content').style.cssText = `
        display: flex;
        flex-direction: column;
        gap: 5px;
        align-items: flex-start;
    `;

    notification.querySelector('i').style.cssText = `
        color: #4ade80;
        margin-bottom: 5px;
    `;

    notification.querySelector('small').style.cssText = `
        opacity: 0.8;
        font-size: 0.8rem;
    `;

    document.body.appendChild(notification);

    // 애니메이션
    setTimeout(() => {
        notification.style.transform = 'translateX(0)';
    }, 100);

    // 자동 제거
    setTimeout(() => {
        notification.style.transform = 'translateX(100%)';
        setTimeout(() => {
            notification.remove();
        }, 300);
    }, 3000);
}

// 링크 그룹 호버 효과
function initLinkGroups() {
    const linkGroups = document.querySelectorAll('.link-group');

    linkGroups.forEach(group => {
        const links = group.querySelectorAll('.link-list a');

        // 그룹 호버시 모든 링크 강조
        group.addEventListener('mouseenter', function() {
            links.forEach(link => {
                link.style.color = 'rgba(255, 255, 255, 0.9)';
            });
        });

        group.addEventListener('mouseleave', function() {
            links.forEach(link => {
                link.style.color = '';
            });
        });

        // 개별 링크 클릭 효과
        links.forEach(link => {
            link.addEventListener('click', function(e) {
                // 페이지 이동 전 효과
                this.style.transform = 'scale(1.05)';
                this.style.color = '#ffffff';

                setTimeout(() => {
                    this.style.transform = '';
                }, 200);
            });
        });
    });
}

// 스크롤에 따른 푸터 배경 효과
function initScrollEffects() {
    let ticking = false;

    function updateFooterBackground() {
        const footer = document.querySelector('.community-footer');
        if (!footer) return;

        const scrolled = window.pageYOffset;
        const rate = scrolled * -0.5;

        //footer.style.transform = `translateY(${rate}px)`;
        ticking = false;
    }

    function requestTick() {
        if (!ticking) {
            requestAnimationFrame(updateFooterBackground);
            ticking = true;
        }
    }

    window.addEventListener('scroll', requestTick);
}

// 반응형 처리
function handleResponsive() {
    const footer = document.querySelector('.community-footer');
    if (!footer) return;

    function checkScreenSize() {
        const isMobile = window.innerWidth <= 768;

        if (isMobile) {
            // 모바일에서 애니메이션 간소화
            footer.classList.add('mobile-mode');
        } else {
            footer.classList.remove('mobile-mode');
        }
    }

    checkScreenSize();
    window.addEventListener('resize', checkScreenSize);
}

// 초기화 함수들 실행
document.addEventListener('DOMContentLoaded', function() {
    initScrollEffects();
    handleResponsive();
});

// 유틸리티 함수들
const FooterUtils = {
    // 부드러운 스크롤
    smoothScrollTo: function(target) {
        const element = document.querySelector(target);
        if (element) {
            element.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    },

    // 랜덤 색상 생성 (테마 컬러 기반)
    getRandomThemeColor: function() {
        const colors = [
            '#667eea',
            '#764ba2',
            '#ff4757',
            '#ff3742'
        ];
        return colors[Math.floor(Math.random() * colors.length)];
    },

    // 디바운스 함수
    debounce: function(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    }
};

// 전역으로 유틸리티 함수 노출
window.FooterUtils = FooterUtils;