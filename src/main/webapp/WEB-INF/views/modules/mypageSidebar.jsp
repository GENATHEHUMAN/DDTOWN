<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script type="text/javascript">
// 사이드바 메뉴 기능
document.addEventListener('DOMContentLoaded', function() {
    // 서브메뉴가 있는 모든 네비게이션 아이템 선택 (mypage-nav-item 클래스와 has-submenu 클래스 모두 가진 요소)
    const navItemsWithSubmenu = document.querySelectorAll('.mypage-sidebar .mypage-nav-item.has-submenu');

    navItemsWithSubmenu.forEach(item => {
        const arrow = item.querySelector('.submenu-arrow'); // 서브메뉴를 나타내는 화살표 요소
        item.addEventListener('click', function(event) {
            // 링크의 href가 '#'인 경우 기본 동작(페이지 이동)을 방지하여 서브메뉴 토글 기능만 수행
            if (this.getAttribute('href') === '#') {
                event.preventDefault();
            }

            const parentLi = this.parentElement; // 현재 클릭된 <a> 태그의 부모 <li> 요소
            const submenu = this.nextElementSibling; // <a> 태그 바로 다음에 오는 형제 요소 (ul.mypage-submenu)

            // 클릭된 아이템이 서브메뉴(mypage-submenu 클래스를 가진 ul)를 가지고 있을 경우
            if (submenu && submenu.classList.contains('mypage-submenu')) {
                const parentUl = parentLi.parentElement; // 부모 <ul> (즉, 최상위 <ul> 또는 다른 서브메뉴 <ul>)
                if (parentUl) {
                    // 같은 레벨의 다른 서브메뉴 닫기 로직
                    Array.from(parentUl.children).forEach(siblingLi => {
                        if (siblingLi !== parentLi) { // 현재 클릭된 <li> 요소가 아닌 경우
                            const siblingSubmenuControl = siblingLi.querySelector('.mypage-nav-item.has-submenu.open');
                            if (siblingSubmenuControl) {
                                const siblingSubmenuElement = siblingSubmenuControl.nextElementSibling;
                                siblingSubmenuControl.classList.remove('open'); // 'open' 클래스 제거
                                if (siblingSubmenuElement && siblingSubmenuElement.classList.contains('mypage-submenu')) {
                                    siblingSubmenuElement.style.display = 'none'; // 서브메뉴 숨기기
                                }
                                const siblingArrow = siblingSubmenuControl.querySelector('.submenu-arrow');
                                if (siblingArrow) siblingArrow.style.transform = 'rotate(0deg)'; // 화살표 원래대로
                            }
                        }
                    });
                }
            }
            
            // 현재 클릭된 아이템의 'open' 클래스 토글 (메뉴 열림/닫힘 상태 표시)
            this.classList.toggle('open');
            // 서브메뉴의 display 속성을 토글하여 보이거나 숨김
            if (submenu && submenu.classList.contains('mypage-submenu')) {
                submenu.style.display = this.classList.contains('open') ? 'block' : 'none';
                // 화살표 회전 (열리면 90도 회전, 닫히면 0도)
                if (arrow) arrow.style.transform = this.classList.contains('open') ? 'rotate(90deg)' : 'rotate(0deg)';
            }
        });
    });

	// 현재 페이지 URL 기반으로 사이드바 메뉴 활성화
	const currentFullHref = window.location.href;
	document.querySelectorAll('.mypage-sidebar .mypage-nav-item[href]').forEach(link => {
	    // 링크의 href가 현재 페이지의 전체 URL과 일치하는 경우
	    if (link.href === currentFullHref) {
	        link.classList.add('active'); // 'active' 클래스 추가하여 현재 메뉴임을 표시

	        let currentActiveElement = link;
	        while (true) {
	            const parentLi = currentActiveElement.parentElement;
	            if (!parentLi) break; // 더 이상 부모 <li>가 없으면 반복 중단

	            // 가장 가까운 부모 ul.mypage-submenu를 찾음
	            const parentSubmenuUl = parentLi.closest('ul.mypage-submenu');
	            if (parentSubmenuUl) {
	                parentSubmenuUl.style.display = 'block'; // 부모 서브메뉴를 보이게 함
	                // 이 서브메뉴를 제어하는 <a> 태그 (has-submenu 클래스를 가진)를 찾음
	                const controllingAnchor = parentSubmenuUl.previousElementSibling;
	                if (controllingAnchor && controllingAnchor.classList.contains('has-submenu')) {
	                    controllingAnchor.classList.add('active', 'open'); // 제어하는 <a>에 'active'와 'open' 클래스 추가
	                    const arrow = controllingAnchor.querySelector('.submenu-arrow');
	                    if (arrow) arrow.style.transform = 'rotate(90deg)'; // 화살표 회전
	                    currentActiveElement = controllingAnchor; // 다음 반복을 위해 현재 활성 요소를 상위 제어 <a>로 설정
	                } else {
	                    break; // 제어하는 <a>를 찾지 못하면 중단
	                }
	            } else {
	                break; // 부모 ul.mypage-submenu를 찾지 못하면 중단
	            }
	        }
	    }
	});
});
</script>