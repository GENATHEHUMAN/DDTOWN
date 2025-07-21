document.addEventListener('DOMContentLoaded', () => {
    // 서브메뉴 토글
    const hasSubmenuItems = document.querySelectorAll('.main-nav .has-submenu');
    hasSubmenuItems.forEach(item => {
        const submenu = item.querySelector('.submenu');
        if (!submenu) return;

        item.addEventListener('mouseenter', () => {
            submenu.style.display = 'block';
        });
        item.addEventListener('mouseleave', () => {
            submenu.style.display = 'none';
        });
    });

    // 스무스 스크롤
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            const targetId = this.getAttribute('href');
            if (targetId === '#') return;
            
            try {
                const targetElement = document.querySelector(targetId);
                if (targetElement) {
                    e.preventDefault();
                    targetElement.scrollIntoView({ behavior: 'smooth' });
                }
            } catch (error) {
                console.error("Invalid selector for anchor: ", targetId, error);
            }
        });
    });

    // 마우스 아우라 효과
    const dynamicBgWrapper = document.querySelector('.dynamic-background-wrapper');
    const mouseAura = document.querySelector('.mouse-aura');

    if (dynamicBgWrapper && mouseAura) {
        dynamicBgWrapper.addEventListener('mousemove', (e) => {
            const rect = dynamicBgWrapper.getBoundingClientRect();
            const x = e.clientX - rect.left;
            const y = e.clientY - rect.top;
            mouseAura.style.left = x + 'px';
            mouseAura.style.top = y + 'px';
        });

        dynamicBgWrapper.addEventListener('mouseenter', () => {
            mouseAura.style.opacity = '1';
        });
        dynamicBgWrapper.addEventListener('mouseleave', () => {
            mouseAura.style.opacity = '0';
        });
    }

    // 헤더 스크롤 효과
    const header = document.querySelector('.site-header');
    let lastScroll = 0;

    window.addEventListener('scroll', () => {
        const currentScroll = window.pageYOffset;
        
        if (currentScroll > 50) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
        
        lastScroll = currentScroll;
    });

    // 반응형 이미지 로딩
    const lazyImages = document.querySelectorAll('img[data-src]');
    const imageObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                img.src = img.dataset.src;
                img.removeAttribute('data-src');
                observer.unobserve(img);
            }
        });
    });

    lazyImages.forEach(img => imageObserver.observe(img));
}); 