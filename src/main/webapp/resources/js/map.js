function sideInfo(lat, lon, page) {
	if (!page) {
		page = 1;
	}
	//alert("##"+lat);
	$.ajax({
		url: '/mapSidebar?lat=' + lat + '&lng=' + lon + '&page=' + page,
		type: 'GET',
		success: function (data) {
			var sidebarContent = ''; // 데이터를 담을 변수 초기화
			for (let i = 0; i < data.mapList.length; i++) {
				sidebarContent += '<p class="shopName" onclick="moveToLocation(' + data.mapList[i].lat + ', ' + data.mapList[i].lng + ')" onmouseover="changeColor(this)" onmouseout="restoreColor(this)">' + data.mapList[i].shopName + '</p>'; // 상점 이름 출력
				sidebarContent += '<p class="shopAddr">' + data.mapList[i].addr + '</p>'; // 주소 출력
				sidebarContent += '<br>';
			}
			//
			let pageCount = data.pageCount;
			let startPage = data.prevBlock + 1;
			let endPage = data.nextBlock - 1;
			if (data.prevBlock > 0) { // 이전 블럭이 존재한다면 
				sidebarContent += '<a href="javascript:sideInfo(' + lat + ',' + lon + ',' + data.prevBlock + ')">prev</a>\t';
			}
			for (let i = startPage; i <= endPage && i <= data.pageCount; i++) {
				sidebarContent += '<a href="javascript:sideInfo(' + lat + ',' + lon + ',' + i + ')" >' + i + '</a>\t';
			}
			if (data.nextBlock < pageCount) {
				sidebarContent += '<a href="javascript:sideInfo(' + lat + ',' + lon + ',' + data.nextBlock + ')">next</a>\t';
			}

			$('#sidebar').html(sidebarContent); // 데이터를 sidebarContent에 채움

			$('#sidebar').css('overflow-y', 'scroll');
			$('#sidebar').css('max-height', '100vh');

		}
	});

}

function searchCheck() {
	if (!searchShop.type.value) {
		alert('검색 유형을 선택하세요');
		return;
	}
	if (searchShop.type.value != "shop_category" && !searchShop.keyword.value) {
		alert('검색어를 입력하세요');
		var key = document.getElementById("keyword");
		key.focus();
		return;
	}
	if (searchShop.type.value == "shop_category" && searchShop.cate.value == 0) {
		alert('카테고리를 선택하세요');
		var key = document.getElementById("cate");
		key.focus();
		return;
	}

	searchShop.submit();

}

function validateForm() {
	var shop_category = document.getElementById("shop_category").value;
	// 문자열을 숫자로 변환
	var categoryInt = parseInt(shop_category);
	// 숫자로 변환된 값을 다시 input 태그의 value에 설정
	document.getElementById("shop_category").value = categoryInt;
	return true; // 폼 제출
}

function changeColor(element) {
	element.style.color = '#FFFFFF'; // 글씨 색상을 하얀색으로 변경
	element.style.backgroundColor = '#006400'; // 배경색을 원하는 색상 코드로 변경
}

function restoreColor(element) {
	element.style.color = '#8AAB95'; // 원래 색상으로 복원
	element.style.backgroundColor = '';
}

function moveToLocation(lat, lng) {
	var moveLatLon = new kakao.maps.LatLng(lat, lng);
	map.panTo(moveLatLon);

}

// 지도에 마커와 인포윈도우를 표시하는 함수입니다
function displayMarker(locPosition, message, lat, lon) {

	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
		map: map,
		position: locPosition
	});

	var iwContent = message, // 인포윈도우에 표시할 내용
		iwRemoveable = true;

	// 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({
		content: iwContent,
		removable: iwRemoveable
	});

	// 인포윈도우를 마커위에 표시합니다 
	infowindow.open(map, marker);

	  // 지도 중심좌표를 접속위치로 변경합니다
		    map.setCenter(locPosition);  
		    sideInfo(lat, lon);
		}  

// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
function makeOverListener(map, marker, infowindow) {
	return function () {
		infowindow.open(map, marker);
	};
}

// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
	return function () {
		infowindow.close();
	};
}

$(document).ready(function() {

document.addEventListener('keydown', function(event) {
  if (event.keyCode === 13) {
    event.preventDefault();
  };
}, true);

// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
if (navigator.geolocation) {

	// GeoLocation을 이용해서 접속 위치를 얻어옵니다
	navigator.geolocation.getCurrentPosition(function (position) {

		var lat = position.coords.latitude, // 위도
			lon = position.coords.longitude; // 경도

		var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
			message = '<div style="padding:5px;">사용자의 현재 위치</div>'; // 인포윈도우에 표시될 내용입니다

		// 마커와 인포윈도우를 표시합니다
		displayMarker(locPosition, message, lat, lon);

	});

} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
	lat = 33.450701;
	lon = 126.570667;

	var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),
		message = 'geolocation을 사용할 수 없어요'

	displayMarker(locPosition, message, lat, lon);
}
//---------
var markers = [];

for (var i = 0; i < data.length; i++) {
	var imageSrc;
	switch (data[i][3]) {
		case 2:
			imageSrc = 'resources/images/open-book.png';
			break;
		case 3:
			imageSrc = 'resources/images/alcohol.png';
			break;
		case 4:
			imageSrc = 'resources/images/optionvege.png';
			break;
		case 5:
			imageSrc = 'resources/images/vegan.png';
			break;
		case 6:
			imageSrc = 'resources/images/ecologism.png';
			break;
		case 7:
			imageSrc = 'resources/images/barber.png';
			break;
		default:
			imageSrc = 'resources/images/optionvege.png';
	}
	var imageSize = new kakao.maps.Size(40, 40);
	var imageOption = { offset: new kakao.maps.Point(20, 10) };
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);



	// 지도에 마커를 생성하고 표시한다
	var marker = new kakao.maps.Marker({
		position: new kakao.maps.LatLng(data[i][0], data[i][1]), // 마커의 좌표
		map: map,
		image: markerImage
		// 마커를 표시할 지도 객체
	});

	var iwContent = '<div style="padding: 5px">내용</div>';
	// 인포윈도우를 생성합니다

	var infowindow = new kakao.maps.InfoWindow({
		content: '<div style="padding: 30px; font-size: 14px; text-align: center; margin-top: -3px;">' + data[i][2] + '</div>'
	});


	markers.push(marker);
	kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(
		map, marker, infowindow));
	kakao.maps.event.addListener(marker, 'mouseout',
		makeOutListener(infowindow));
}
// 클러스터러에 마커들을 추가합니다
clusterer.addMarkers(markers);

document.getElementById("type").addEventListener("change", function () {
	var selectedOption = this.value;
	if (selectedOption === "shop_category") {
		document.getElementById("categoryInput").style.display = "inline-block";
		document.getElementById("keywordInput").style.display = "none";
		document.getElementById("cate").disabled = false;//활성화

	} else {
		document.getElementById("categoryInput").style.display = "none";
		document.getElementById("cate").disabled = true;//비활성화
		document.getElementById("keywordInput").style.display = "inline-block";
	}
});

document.getElementById("type").addEventListener("change", function () {
	var selectedOption = this.value;
	if (selectedOption === "shop_category") {
		document.getElementById("categoryInput").style.display = "inline-block";
		document.getElementById("keywordInput").style.display = "none";
		document.getElementById("cate").disabled = false;//활성화

	} else {
		document.getElementById("categoryInput").style.display = "none";
		document.getElementById("cate").disabled = true;//비활성화
		document.getElementById("keywordInput").style.display = "inline-block";
	}
});

	});
