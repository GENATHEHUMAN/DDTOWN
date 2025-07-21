<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>DDTOWN 아티스트 인기 투표</title>
<style type="text/css">
body {
    background: linear-gradient(135deg, #1a1a2e 0%, #2a1e4a 50%, #8a2be2 100%); /* 중간색을 약간 더 보라색 계열로 조정 */
    background-attachment: fixed; /* 배경을 뷰포트에 고정 */
    background-size: cover; /* 배경이 전체 영역을 커버하도록 */
    min-height: 100vh;
    margin: 0;
    font-family: "Noto Sans KR", 돋움, Dotum, 굴림, Gulim, Tahoma, Verdana, sans-serif;
    color: #ffffff;
    overflow-x: hidden;
}
div#voteGate {
    display: flex;
    flex-flow: wrap;
}

.card {
	cursor: pointer;
	position: absolute;
	transition : 0.3s ease;
}

.card:hover {
    transform: translateY(-5px) !important;
    box-shadow: 0px 2px 10px #adaaad;

}

.cartIcon {
    height: auto;
}

.cartIcon i {
    font-size: 50pt;
}
.main-container{
	display: flex;
	height: 75vh;
}

.vote-lose {
    align-content: flex-end;
    height: 550pt;
}

.winner-card {
    display: flex;
    justify-content: center;
}
div#voteResult {
    width: 500pt;
}
.trophy {
    font-size: 50pt;
}
.vote-container {
    min-width: 80%;
    height: 100%;
    margin: 30px auto;
    padding: 20px;
    background-color: #fff;
    border-radius: 12px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    font-size: x-large;
}
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/pages/mainservice_common.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/pages/artist_community.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/animejs/lib/anime.iife.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@tsparticles/confetti@3.0.3/tsparticles.confetti.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@tsparticles/preset-fireworks@3/tsparticles.preset.fireworks.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<script type="text/javascript">

function getPageCenter() {
  const pageWidth = window.innerWidth;
  const pageHeight = window.innerHeight;
  const centerX = pageWidth / 2;
  const centerY = pageHeight / 2;

  return { x: centerX, y: centerY };
}


$(function(){

	let {animate, createTimeline } = anime;

	const center = getPageCenter();

	let artistArr = [];
	let artistList = [];
	let cnt = 0;

	let temp = 2;
	let artistCnt = 0;	// 라운드에 참가할 아티스트의 수

	let totalRound = 0;		// 진행될 총 라운드 수

	let curOne = ``;
	let curTwo = ``;

	let nextRoundArtist = [];

	$("#btnStartVote").on("click",function(){
		$("#btnStartVote").css("display","none");
		$("#voteArena").css("display","flex")
		$.ajax({
			url : '/community/worldcup/artist/list',
			type : 'get',
			success : function(res){

				let html = ``;
				for(let i=0; i<res.length; i++){
					let artist = res[i];
					html = `
						<div class="card" style="width: 21rem; height: auto;" data-artNo= \${artist.artNo}>
						  <img src="\${artist.artProfileImg}" class="card-img-top" alt="..." style="height : 280pt">
						  <div class="card-body">
						    <h5 class="card-title">\${artist.artNm}</h5>
						  </div>
						</div>
					`;
					artistList.push(html);
				}

				for(let i=0; i<res.length; i++){
					artistCnt = temp
					temp = temp * 2 ;
					if(temp > res.length){
						break;
					}
				}


				for(let i=res.length - 1; i>0; i--){
					let j = Math.floor(Math.random() * (i + 1));
				    [artistList[i], artistList[j]] = [artistList[j], artistList[i]];
				}

				artistArr =  artistList.slice(0, artistCnt / 2);

				totalRound = artistCnt / 2 + "강";
				$("#roundInfo").html(totalRound);

				suffle();


			},
			error : function(error){
				console.log(error.status);
			}
		});
	});



	$("#suffle").on("click",function(){
		let artistList = document.querySelectorAll(".card");
		artistList.forEach( artist => {
			let artistPosition = artist.getBoundingClientRect();
			const initialX = artistPosition.left;
        	const initialY = artistPosition.top;
			const translateX_amount = Math.floor(center.x) - Math.floor(initialX);
        	const translateY_amount = Math.floor(center.y) - Math.floor(initialY);
			animate(artist,
				{
					translateX: translateX_amount,
		            translateY: translateY_amount,
		            duration: 800,
		            easing: 'easeInOutQuad',
				}
			)
		})

	});

	$("#artistList").on("click",function(){
		let other = $(this).parent('div[id=voteArena]').children('div[id=artistList2]').children('div[class=card]')[0];
		let target = $(this).children('div[class=card]')[0];
		let container = document.querySelector('#artistList');
		let containerPosition = container.getBoundingClientRect();
		let containerY = containerPosition.height;

		const originX = (containerPosition.left + containerPosition.width / 2) / window.innerWidth;
        const originY = (containerPosition.top) / window.innerHeight;

        const defaults = {
  			  spread: 360,
  			  ticks: 100,
  			  gravity: 2,
  			  decay: 1,
  			  startVelocity: 30,
  			  shapes: ["heart"],
  			  colors: ["FFC0CB", "FF69B4", "FF1493", "C71585"],
  			  speed: 1.5,
  		};

  		confetti({
  			...defaults,
  			particleCount: 50,
  			scalar: 2,
  			origin: {
                  x: originX, // 클릭된 요소의 중앙 X 좌표 (0~1)
                  y: originY  // 클릭된 요소의 중앙 Y 좌표 (0~1)
              },
              zIndex: 1
  		})

  		let t1A = animate(target,{
  			scale: [.8,1],
  			duration : 100,
  			loop : 1,
  			onUpdate: function(anim) {
  		        if(anim.progress == 1){
  		        	nextRoundArtist.push(curOne);
  					suffle();
  		        }
  		    },
  		})

  		animate(other,{
			scale : [.8,.5],
			duration : 1000,
		})

	});

	$("#artistList2").on("click",function(e){
		let other = $(this).parent('div[id=voteArena]').children('div[id=artistList]').children('div[class=card]')[0];
		let target = $(this).children('div[class=card]')[0];
		let container = document.querySelector('#artistList2');
		let containerPosition = container.getBoundingClientRect();
		let containerY = containerPosition.height;

		const originX = (containerPosition.left + containerPosition.width / 2) / window.innerWidth;
        const originY = (containerPosition.top) / window.innerHeight;

		const defaults = {
			  spread: 360,
			  ticks: 100,
			  gravity: 2,
			  decay: 1,
			  startVelocity: 30,
			  shapes: ["heart"],
			  colors: ["FFC0CB", "FF69B4", "FF1493", "C71585"],
			  speed: 1.5,
		};

		confetti({
			...defaults,
			particleCount: 50,
			scalar: 2,
			origin: {
                x: originX, // 클릭된 요소의 중앙 X 좌표 (0~1)
                y: originY  // 클릭된 요소의 중앙 Y 좌표 (0~1)
            },
            zIndex: 1
		})

		let t1A = animate(target,{
			scale: [.8,1],
			duration : 100,
			loop : 1,
			onUpdate: function(anim) {
		        if(anim.progress == 1){
		        	nextRoundArtist.push(curTwo);
					suffle();
		        }
		    },
		})

		animate(other,{
			scale : [.8,.5],
			duration : 1000,
		})

	});

	function suffle(){
		if(artistArr.length == 0){

			artistArr = [];
			artistArr = nextRoundArtist;
			nextRoundArtist = [];
			if(artistArr.length == 1){
				winner(artistArr);
				return;
			}
			totalRound = artistArr.length + "강";
			if(artistArr.length == 2){
				totalRound = "결승전"
			}
			$("#roundInfo").html(totalRound);
		}

		let i = Math.floor(Math.random() * artistArr.length);
		let j = Math.floor(Math.random() * artistArr.length);

		let suffle = setInterval(function(){

			if(i == j){
				j = Math.floor(Math.random() * artistArr.length);
			}
// 			let cardHtml = artistArr[Math.floor(Math.random() * artistArr.length)];
// 			let cardTwoHtml = artistArr[Math.floor(Math.random() * artistArr.length)];

// 			$("#artistList").html(cardHtml);
// 			$("#artistList2").html(cardTwoHtml);
			cnt++;
			if(cnt == 20){
				clearInterval(suffle);

				curOne = artistArr[i];
				curTwo = artistArr[j];


				$("#artistList").html(curOne);
				$("#artistList2").html(curTwo);

				artistArr = artistArr.filter((v,idx) => idx != i && idx != j);

				animate(".card",
					{
						scale: [.5,1],
						duration : 100
					}
				)
				cnt = 0;
			}
		},10)
	}

	function winner(artistArr){
		$("#voteGate").css("display","none");
		$("#voteArena").css("display","none");
		$(".vote-header").css("display","none");


		$("#voteResult").css("display","block");

		$(".winner-card").html(artistArr[0]);

		let winnerArtNo = parseInt($(".winner-card").children(".card")[0].dataset.artno);

		let target = $(".winner-card").children(".card")[0];

		animate(target, {
			scale: [.8,1],
			duration : 1000,
			loop : 15,
		})

		const end = Date.now() + 15 * 1000;

		// go Buckeyes!
		const colors = ["#bb0000", "#ffffff"];

		(function frame() {
		  confetti({
		    particleCount: 2,
		    angle: 60,
		    spread: 55,
		    origin: { x: 0 },
		    colors: colors,
		  });

		  confetti({
		    particleCount: 2,
		    angle: 120,
		    spread: 55,
		    origin: { x: 1 },
		    colors: colors,
		  });

		  if (Date.now() < end) {
		    requestAnimationFrame(frame);
		  }
		})();

		let data = new FormData();
		data.append("artNo",winnerArtNo );

		$.ajax({
			url : '/community/worldcup/insert',
			type : 'post',
			data : data,
			processData : false,
			contentType : false,
			success : function(res){
				if(res.result == 'OK'){
					let winnerList = res.winnerList;
					let firstList = [];
					let secondList = [];
					let thirdList = [];
					for(let i=0; i<winnerList.length; i++){
						let winner = winnerList[i];
						if(winner.rank == 1){
							firstList.push(winner);
						}else if(winner.rank == 2){
							secondList.push(winner);
						}else if(winner.rank == 3){
							thirdList.push(winner);
						}
					}

					let rankHtml = `
						<ul>
					`;
					for(let i=0; i<firstList.length; i++){
						let firstArtist =firstList[i];
						rankHtml += `
							<li><span class="rank">`;
						if(firstList.length >= 2){
							rankHtml += `공동`;
						}
						rankHtml += `1위</span> <span class="artist-name">\${firstArtist.artistVO.artNm}</span> <span class="vote-count">\${firstArtist.voteCnt}표</span></li>
						`;
					}

					for(let i=0; i<secondList.length; i++){
						let secondArtist =secondList[i];
						rankHtml += `
							<li><span class="rank">`;
						if(secondList.length >= 2){
							rankHtml += `공동`;
						}
						rankHtml += `2위</span> <span class="artist-name">\${secondArtist.artistVO.artNm}</span> <span class="vote-count">\${secondArtist.voteCnt}표</span></li>
						`;
					}

					for(let i=0; i<thirdList.length; i++){
						let thirdArtist = thirdList[i];
						rankHtml += `
							<li><span class="rank">`;
						if(thirdList.length >= 2){
							rankHtml += `공동`;
						}
						rankHtml += `3위</span> <span class="artist-name">\${thirdArtist.artistVO.artNm}</span> <span class="vote-count">\${thirdArtist.voteCnt}표</span></li>
						`;
					}

					rankHtml += `</ul>`;

					$("#weeklyRankingResult").append(rankHtml);
				}
			},
			error : function(error){
				console.log(error.status)
			},
			beforeSend : function(xhr) {
		        xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
		    }

		});
	}
});


</script>
</head>
<body class="vote-page">
    <jsp:include page="/WEB-INF/views/modules/communityHeader.jsp" />

    <div class="main-container">
		<div class="vote-container">
	        <div class="vote-header">
	            <h1>DDTOWN 아티스트 인기 투표</h1>
	            <p>당신의 최애 아티스트를 선택해주세요!</p>
	            <div class="round-info" id="roundInfo"></div>
	         </div>

	        <div class="vote-gate" id="voteGate">
	            <button class="btn-start-vote" id="btnStartVote">월드컵 시작하기</button>
	            <button class="btn-view-ranking" id="btnViewLastWeekRanking" style="display: none;">지난 주 순위 보기</button>
	        </div>
		    <div class="vote-arena" id="voteArena" style="display: none;">
	            <div id="artistList">
		    	</div>
	            <div class="vs-text">VS</div>
	            <div id="artistList2" class="artistList2">
		    	</div>
	        </div>
		    <div class="vote-result" id="voteResult" style="display: none;">
		    	<div class="trophy">🏆</div>
	            <div class="winner-announcement" id="winnerAnnouncement">축하합니다! 당신의 최애 아티스트는...</div>
	            <div class="winner-card">

	            </div>
	            <div class="weekly-ranking" id="weeklyRankingResult">
	                <h3>지난 인기 아티스트 TOP 3 (투표 수)</h3>
	            </div>
	            <button class="btn-start-vote" id="btnRestartVote" style="margin-top: 30px; display:none;">새로운 월드컵 시작하기 (관리자용/테스트용)</button>
	        </div>
	    </div>
    </div>
</body>
</html>