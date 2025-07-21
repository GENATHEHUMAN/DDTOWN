<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components/translation.css">

<div id="google_translate_element" style="display:none;"></div>

    <div class="custom-language-selector">
    <div class="selected-language">
        <span class="flag ko"></span> <span>한국어</span>  <span class="arrow">&#9662;</span> </div>
    <ul class="language-options">
        <li><a href="javascript:void(0);" class="translation-link korean" data-lang="ko" title="한국어"><span class="flag ko"></span>한국어</a></li>
        <li><a href="javascript:void(0);" class="translation-link english" data-lang="en" title="English"><span class="flag en"></span>English</a></li>
        <li><a href="javascript:void(0);" class="translation-link japanese" data-lang="ja" title="日本語"><span class="flag ja"></span>日本語</a></li>
        <li><a href="javascript:void(0);" class="translation-link chinese" data-lang="zh-CN" title="中文(简体)"><span class="flag zh-CN"></span>中文(简体)</a></li>
        <li><a href="javascript:void(0);" class="translation-link russian" data-lang="ru" title="Русский"><span class="flag ru"></span>Русский</a></li>
        <li><a href="javascript:void(0);" class="translation-link spanish" data-lang="es" title="Español"><span class="flag es"></span>Español</a></li>
    </ul>
</div>



<script type="text/javascript">
    // Google Translate Element 초기화 함수
    function googleTranslateElementInit() {
//         console.log("googleTranslateElementInit CALLED.");
        new google.translate.TranslateElement(
            {
                pageLanguage: 'ko', // 웹 페이지의 기본 언어
                autoDisplay: false,
                includedLanguages: 'ko,en,ja,zh-CN,es,ru', // 번역 제공 언어
                layout: google.translate.TranslateElement.InlineLayout.SIMPLE
            },
            'google_translate_element'
        );
    }

    // 쿠키 설정 함수
    function setCookie(name, value, days) {
        let expires = "";
        if (days) {
            let date = new Date();
            date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
            expires = "; expires=" + date.toUTCString();
        }
        // googtrans 쿠키는 path=/ 로 설정되어야 Google Translate가 인식합니다.
        document.cookie = name + "=" + (value || "") + expires + "; path=/";
//         console.log("Cookie set: " + name + "=" + value);
    }

    // 쿠키 가져오기
    function getCookie(name) {
        const nameEQ = name + "=";
        const ca = document.cookie.split(';');
        for(let i = 0; i < ca.length; i++) {
            let c = ca[i];
            while (c.charAt(0) === ' ') c = c.substring(1, c.length);
            if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
        }
        return null;
    }

    // DOM 로드 완료 후 언어 변경 링크에 이벤트 리스너 추가
   document.addEventListener('DOMContentLoaded', function() {
        const customSelector = document.querySelector('.custom-language-selector');
        const selectedLanguageDiv = customSelector.querySelector('.selected-language');
        const languageOptionsUl = customSelector.querySelector('.language-options');

        // 현재 선택된 언어 표시 업데이트 함수
        function updateSelectedLanguageDisplay(langCode, langText, flagClass) {
            const flagSpan = selectedLanguageDiv.querySelector('.flag');
            const textSpan = selectedLanguageDiv.querySelector('span:not(.flag):not(.arrow)');
            if (flagSpan) flagSpan.className = 'flag ' + flagClass; // 국기 아이콘 클래스 변경
            if (textSpan) textSpan.textContent = langText;
        }

        // 페이지 로드 시 쿠키에서 현재 번역 언어 가져와서 selected-language 업데이트
        const currentGoogTrans = getCookie('googtrans');
        if (currentGoogTrans && currentGoogTrans.includes('/')) {
            const langParts = currentGoogTrans.split('/');
            if (langParts.length > 2 && langParts[2]) {
                const activeLangCode = langParts[2];
                const activeLink = languageOptionsUl.querySelector('a[data-lang="' + activeLangCode + '"]');
                if (activeLink) {
                    const langText = activeLink.textContent.trim() || activeLink.innerText.trim(); // 브라우저 호환성
                    const flagClass = activeLink.querySelector('.flag') ? activeLink.querySelector('.flag').className.replace('flag ', '') : activeLangCode;
                    updateSelectedLanguageDisplay(activeLangCode, langText, flagClass);
                }
            }
        }


        // 선택된 언어 표시 영역 클릭 시 옵션 목록 토글
        selectedLanguageDiv.addEventListener('click', function() {
            languageOptionsUl.style.display = languageOptionsUl.style.display === 'block' ? 'none' : 'block';
        });

        // 옵션 링크 클릭 시 언어 변경
        languageOptionsUl.addEventListener('click', function(event) {
            let clickedLink = event.target.closest('a.translation-link');

            if (clickedLink) {
                event.preventDefault();
                const targetLang = clickedLink.getAttribute('data-lang');
                const sourceLang = 'ko'; // 페이지의 기본 언어
                const langText = clickedLink.textContent.trim() || clickedLink.innerText.trim(); // 클릭된 링크의 텍스트
                const flagClass = clickedLink.querySelector('.flag') ? clickedLink.querySelector('.flag').className.replace('flag ', '') : targetLang;

                if (targetLang) {
//                     console.log("Language link clicked. Setting googtrans cookie to: /" + sourceLang + "/" + targetLang);
                    setCookie('googtrans', '/' + sourceLang + '/' + targetLang, 1);
                    updateSelectedLanguageDisplay(targetLang, langText, flagClass); // 선택된 언어 UI 즉시 업데이트
                    languageOptionsUl.style.display = 'none'; // 옵션 목록 숨기기
                    window.location.reload(); // 페이지 새로고침하여 번역 적용
                }
            }
        });

        document.addEventListener('click', function(event) {
            if (!customSelector.contains(event.target)) {
                languageOptionsUl.style.display = 'none';
            }
        });
    });
</script>