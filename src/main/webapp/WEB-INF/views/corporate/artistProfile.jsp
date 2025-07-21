<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DD TOWN 아티스트 프로필</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;700;900&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/artist.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <%@ include file="../modules/headerPart.jsp" %>
    <style>
        /* Enhanced Artist Profile Styles */
        .artist-hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 120px 0 80px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .artist-hero:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
        }
        
        .artist-hero h2 {
            font-size: clamp(3rem, 6vw, 4.5rem);
            font-weight: 900;
            color: white;
            margin-bottom: 20px;
            text-shadow: 0 4px 20px rgba(0,0,0,0.3);
            position: relative;
            z-index: 1;
        }
        
        .artist-hero p {
            font-size: 1.3rem;
            color: rgba(255, 255, 255, 0.9);
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.6;
            position: relative;
            z-index: 1;
        }
        
        .artist-list-section {
            padding: 100px 0;
            background: linear-gradient(45deg, #f8f9ff 0%, #f0f2ff 100%);
        }
        
        .artist-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 40px;
            margin-top: 60px;
        }
        
        .artist-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: all 0.4s ease;
            cursor: pointer;
            border: 1px solid rgba(102, 126, 234, 0.1);
            position: relative;
        }
        
        .artist-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 25px 60px rgba(0,0,0,0.2);
            border-color: rgba(102, 126, 234, 0.3);
        }
        
        .artist-image-wrapper {
            position: relative;
            overflow: hidden;
            height: 300px;
        }
        
        .artist-image-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.4s ease;
        }
        
        .artist-card:hover .artist-image-wrapper img {
            transform: scale(1.1);
        }
        
        .artist-image-wrapper:after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.8) 0%, rgba(118, 75, 162, 0.8) 100%);
            opacity: 0;
            transition: opacity 0.4s ease;
        }
        
        .artist-card:hover .artist-image-wrapper:after {
            opacity: 1;
        }
        
        .artist-image-wrapper:before {
/*             content: '\f04b'; */
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 3rem;
            color: white;
            opacity: 0;
            transition: all 0.4s ease;
            z-index: 2;
        }
        
        .artist-card:hover .artist-image-wrapper:before {
            opacity: 1;
            transform: translate(-50%, -50%) scale(1.2);
        }
        
        .artist-info {
            padding: 30px;
            text-align: center;
        }
        
        .artist-name {
            font-size: 1.5rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .artist-debut {
            color: #666;
            font-size: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        
        /* Enhanced Modal Styles */
        .artist-modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.8);
            backdrop-filter: blur(10px);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000;
            padding: 20px;
        }
        
        .artist-modal-content {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            max-width: 800px;
            width: 100%;
            max-height: 90vh;
            overflow-y: auto;
            position: relative;
            box-shadow: 0 25px 80px rgba(0,0,0,0.3);
            animation: modalSlideIn 0.4s ease;
        }
        
        @keyframes modalSlideIn {
            from {
                opacity: 0;
                transform: translateY(50px) scale(0.9);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }
        
        .artist-modal-close {
            position: absolute;
            top: 20px;
            right: 20px;
            width: 40px;
            height: 40px;
            background: rgba(0, 0, 0, 0.5);
            color: white;
            border: none;
            border-radius: 50%;
            font-size: 1.5rem;
            cursor: pointer;
            z-index: 10;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .artist-modal-close:hover {
            background: rgba(0, 0, 0, 0.8);
            transform: rotate(90deg);
        }
        
        .modal-artist-img {
            width: 100%;
            height: 400px;
            object-fit: cover;
        }
        
        .modal-artist-info {
            padding: 40px;
        }
        
        .modal-artist-info h3 {
            font-size: 2.5rem;
            font-weight: 800;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 30px;
        }
        
        .modal-artist-info p {
            font-size: 1.1rem;
            color: #666;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 15px;
            background: linear-gradient(45deg, #f8f9ff 0%, #f0f2ff 100%);
            border-radius: 10px;
            border-left: 4px solid #667eea;
        }
        
        .modal-artist-info strong {
            color: #333;
            font-weight: 600;
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .artist-grid {
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 30px;
            }
            
            .artist-modal-content {
                margin: 10px;
                max-height: 95vh;
            }
            
            .modal-artist-info {
                padding: 25px;
            }
            
            .modal-artist-info h3 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
<%@ include file="./../corporate/modules/header.jsp" %>
    <main>
        <section class="artist-hero">
            <div class="container">
                <h2>아티스트 프로필</h2>
                <p>DD TOWN 소속 아티스트들을 만나보세요.</p>
            </div>
        </section>

        <section class="artist-list-section">
		    <div class="container">
		        <div class="artist-grid">
				    <c:forEach items="${artistGroupList}" var="group">
				        <div class="artist-card"
				             data-name="${group.artGroupNm}"
				             data-debut="${group.artGroupDebutdate}"
				             data-album="${group.debutAlbum}"
				             data-img="${group.artGroupProfileImg}">
				            <div class="artist-image-wrapper">
				                <img src="${group.artGroupProfileImg}" alt="${group.artGroupNm} 프로필">
				            </div>
				            <div class="artist-info">
				                <div class="artist-name">${group.artGroupNm}</div>
				                <div class="artist-debut">${group.artGroupDebutdate.replaceAll('/', '.')} 데뷔</div>
				            </div>
				        </div>
				    </c:forEach>
				</div>
		    </div>
		</section>

        <div id="artist-modal" class="artist-modal" style="display:none;">
            <div class="artist-modal-content" style="">
                <span class="artist-modal-close">&times;</span>
                <img id="modal-artist-img" src="" alt="아티스트 프로필" class="modal-artist-img">
                <div class="modal-artist-info">
                    <h3 id="modal-artist-name"></h3>
                    <p><i class="fas fa-calendar-alt"></i> <strong>데뷔일:</strong> <span id="modal-artist-debut"></span></p>
                    <p><i class="fas fa-compact-disc"></i> <strong>데뷔앨범:</strong> <span id="modal-artist-album"></span></p>
                </div>
            </div>
        </div>
        
        <%@ include file="./modules/footer.jsp" %>
        
    </main>
<script src="${pageContext.request.contextPath}/resources/js/common/main.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    // 카드 클릭 시 모달 띄우기
    document.querySelectorAll('.artist-card').forEach(function(card) {
        card.addEventListener('click', function() {
            document.getElementById('modal-artist-img').src = card.dataset.img;
            document.getElementById('modal-artist-img').alt = card.dataset.name + " 프로필";
            document.getElementById('modal-artist-name').textContent = card.dataset.name;
            document.getElementById('modal-artist-debut').textContent = card.dataset.debut;
            document.getElementById('modal-artist-album').textContent = card.dataset.album;
            document.getElementById('artist-modal').style.display = 'flex';
        });
    });

    // 모달 닫기
    document.querySelector('.artist-modal-close').addEventListener('click', function() {
        document.getElementById('artist-modal').style.display = 'none';
    });

    // 모달 바깥 클릭 시 닫기
    document.getElementById('artist-modal').addEventListener('click', function(e) {
        if (e.target === this) {
            this.style.display = 'none';
        }
    });
});
</script>
</body>
</html>