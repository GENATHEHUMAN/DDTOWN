document.addEventListener('DOMContentLoaded', () => {
    // 카카오맵 초기화
    const container = document.getElementById('map');
    const options = {
        center: new kakao.maps.LatLng(36.325, 127.422), // 대전광역시 중구 계룡로 846 좌표
        level: 3
    };

    const map = new kakao.maps.Map(container, options);

    // 마커 생성
    const markerPosition = new kakao.maps.LatLng(36.325, 127.422);
    const marker = new kakao.maps.Marker({
        position: markerPosition
    });

    // 마커를 지도에 표시
    marker.setMap(map);

    // 인포윈도우 생성
    const iwContent = `
        <div style="padding:10px;text-align:center;">
            <strong>DD TOWN</strong><br>
            대전광역시 중구 계룡로 846
        </div>
    `;
    const infowindow = new kakao.maps.InfoWindow({
        content: iwContent
    });

    // 마커 클릭 이벤트
    kakao.maps.event.addListener(marker, 'click', function() {
        infowindow.open(map, marker);
    });

    // 초기 인포윈도우 표시
    infowindow.open(map, marker);
}); 