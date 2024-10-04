<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/inc/header.jspf"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="https://kit.fontawesome.com/d547fb2b9c.js"
	crossorigin="anonymous"></script>
<!--FontAwesome-->

	<div id="sidebarContents">
		<!-- 검색 폼 시작 -->
		<form name="searchShop" method="get" action="/mapList/searchShop">
			<!-- 검색 유형 선택 -->
			<select name="type" id="type">
				<option value="">검색 유형 선택</option>
				<option value="shop_name"
					<c:if test="${param.type eq 'shop_name'}">selected</c:if>>상점이름</option>
				<option value="addr"
					<c:if test="${param.type eq 'addr'}">selected</c:if>>주소</option>
				<option value="shop_category"
					<c:if test="${param.type eq 'shop_category'}">selected</c:if>>카테고리</option>
			</select>

			<!-- 카테고리에 따라 키워드 입력창 보이기/숨기기 -->
			<c:choose>
				<c:when test="${param.cate ne null and param.cate != 0}">
					<div id="keywordInput" style="display: none;">
						<span> <input class="form-control me-2" type="text"
							name="keyword" id="keyword" placeholder="검색어 입력">
						</span>
					</div>
				</c:when>
				<c:otherwise>
					<div id="keywordInput" style="display: inline-block;">
						<span> <input class="form-control me-2" type="text"
							name="keyword" id="keyword" placeholder="검색어 입력">
						</span>
					</div>
				</c:otherwise>
			</c:choose>

			<!-- 카테고리 입력창 보이기/숨기기 -->
			<c:choose>
				<c:when test="${param.cate ne null and param.cate != 0}">
					<div id="categoryInput" style="display: inline-block">
						<select name="cate" id="cate">
							<option value="0"
								<c:if test="${param.cate eq '0'}">selected</c:if>>::선택::</option>
							<option value="2"
								<c:if test="${param.cate eq '2'}">selected</c:if>>책방</option>
							<option value="3"
								<c:if test="${param.cate eq '3'}">selected</c:if>>술집</option>
							<option value="4"
								<c:if test="${param.cate eq '4'}">selected</c:if>>채식 옵션
								가능 식당</option>
							<option value="5"
								<c:if test="${param.cate eq '5'}">selected</c:if>>비건 식당</option>
							<option value="6"
								<c:if test="${param.cate eq '6'}">selected</c:if>>제로웨이스트샵</option>
							<option value="7"
								<c:if test="${param.cate eq '7'}">selected</c:if>>미용실</option>
							<option value="1"
								<c:if test="${param.cate eq '1'}">selected</c:if>>기타</option>
						</select>
					</div>
				</c:when>
				<c:otherwise>
					<div id="categoryInput" style="display: none;">
						<select name="cate" id="cate">
							<option value="0"
								<c:if test="${param.cate eq '0'}">selected</c:if>>::선택::</option>
							<option value="2"
								<c:if test="${param.cate eq '2'}">selected</c:if>>책방</option>
							<option value="3"
								<c:if test="${param.cate eq '3'}">selected</c:if>>술집</option>
							<option value="4"
								<c:if test="${param.cate eq '4'}">selected</c:if>>채식 옵션
								가능 식당</option>
							<option value="5"
								<c:if test="${param.cate eq '5'}">selected</c:if>>비건 식당</option>
							<option value="6"
								<c:if test="${param.cate eq '6'}">selected</c:if>>제로웨이스트샵</option>
							<option value="7"
								<c:if test="${param.cate eq '7'}">selected</c:if>>미용실</option>
							<option value="1"
								<c:if test="${param.cate eq '1'}">selected</c:if>>기타</option>
						</select>
					</div>
				</c:otherwise>
			</c:choose>

			<!-- 검색 버튼 -->
			<input class="btn btn-outline-success" type="button" value="검색"
				onclick="searchCheck()">
		</form>

		<br>

		<form id="sidebarContent">
			<%-- <h2>${type }/${keyword }/${cate }</h2> --%>
			
			<ul>
				<c:forEach var="map" items="${mapList }">
					<li class="shopNameMap"
						onclick="moveToLocation(${map.lat}, ${map.lng})"
						onmouseover="changeColor(this)" onmouseout="restoreColor(this)">${map.shopName}</li>
					<li class="addrMap">${map.addr }</li>
					<br>
				</c:forEach>
			</ul>
		</form>

	</div>
	<br>

	<div id="center">
		<div id="map" style="width: 60vw; height: 70vh;"></div>
		<br>
		<div id="buttons">
			<button type="reset" class="reset-button"
				onclick="location.href='/mapList'">초기화</button>
		</div>
	</div>
	<script
		src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=4da202d77036151199a56057c568131d&libraries=clusterer"></script>

	<script>
	document.addEventListener('keydown', function(event) {
		  if (event.keyCode === 13) {
		    event.preventDefault();
		  };
		}, true);
	
	$(function(){
		zoomOut();
	})

	function validateForm() {
	    var shopCategory = document.getElementById("shop_category").value;
	    // 문자열을 숫자로 변환
	    var categoryInt = parseInt(shopCategory);
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

	document.getElementById("type").addEventListener("change", function() {
        var selectedOption = this.value;
        if (selectedOption === "shop_category") {
          document.getElementById("categoryInput").style.display = "inline-block";
          document.getElementById("keywordInput").style.display = "none";
          document.getElementById("cate").disabled=false;//활성화
          
        } else {
          document.getElementById("categoryInput").style.display = "none";
          document.getElementById("cate").disabled=true;//비활성화
          document.getElementById("keywordInput").style.display = "inline-block";
        }
      });
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(37.55489, 126.9708), // 지도의 중심좌표
			level : 5, // 지도의 확대 레벨
			mapTypeId : kakao.maps.MapTypeId.ROADMAP
		// 지도종류
		};

		// 지도를 생성한다 
		var map = new kakao.maps.Map(mapContainer, mapOption);
		
		//지도 레벨을 올리는 함수
		function zoomOut() {    
		    // 현재 지도의 레벨을 얻어옵니다
		    var level = map.getLevel(); 
		    
		    // 지도를 9레벨 올립니다 (지도가 축소됩니다)
		    map.setLevel(level + 9); 
		}
		
		// 지도 확대 축소를 제어할 수 있는 줌 컨트롤을 생성합니다
		var zoomControl = new kakao.maps.ZoomControl();
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
		
		// 마커 클러스터러를 생성합니다 
		var clusterer = new kakao.maps.MarkerClusterer({
			map : map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
			averageCenter : true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
			minLevel : 10
		// 클러스터 할 최소 지도 레벨 
		});
		var data = [];
		
		
		// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
		if (navigator.geolocation) {
		    
		    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
		    navigator.geolocation.getCurrentPosition(function(position) {
		        
		        	var lat = position.coords.latitude, // 위도
		             	lon = position.coords.longitude; // 경도
		        
		        var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
		            message = '<div style="padding:5px;">사용자의 현재 위치</div>'; // 인포윈도우에 표시될 내용입니다
		        
		        // 마커와 인포윈도우를 표시합니다
		        displayMarker(locPosition, message, lat, lon);
		            
		      });
		    
		} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
		    lat=33.450701;
			lon=126.570667;
			
		    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
		        message = 'geolocation을 사용할 수 없어요'
		        
		    displayMarker(locPosition, message, lat, lon);
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
		        content : iwContent,
		        removable : iwRemoveable
		    });
		    
		    // 인포윈도우를 마커위에 표시합니다 
		    infowindow.open(map, marker);
		    
		    // 지도 중심좌표를 접속위치로 변경합니다
		    map.setCenter(locPosition);  
		    sideInfo(lat, lon);
		}    
		
		var categoryMap = {
			    1: '기타',
			    2: '책방',
			    3: '술집',
			    4: '채식 옵션 가능 식당',
			    5: '비건 식당',
			    6: '제로웨이스트샵',
			    7: '미용실'
			};	
		
		
		<c:choose>
		<c:when test="${not empty mapList}">
		   <c:forEach items="${mapList}" var="m">
			data.push([ ${m.lat}, ${m.lng},
                '<div class="shopNameMap" style="padding: 5px">${m.shopName}</div> <br> <div class="addrMap">${m.addr}</div> <div class="categoryMap">' + categoryMap[${m.shopCategory}] + '</div>',
                ${m.shopCategory}
                ]);		   </c:forEach>
		</c:when>
		<c:otherwise>
			alert('검색 결과가 존재하지 않습니다.');
			var key = document.getElementById("keyword");
			key.focus();
			
		</c:otherwise>
	</c:choose>
	   
	 var markers = [];
		
		for (var i = 0; i < data.length; i++) {
		    var imageSrc;
		    switch (data[i][3]) {
		        case 2:
		            imageSrc = '/resources/images/open-book.png';
		            break;
		        case 3:
		            imageSrc = '/resources/images/alcohol.png';
		            break;
		        case 4:
		            imageSrc = '/resources/images/optionvege.png';
		            break;
		        case 5:
		            imageSrc = '/resources/images/vegan.png';
		            break;
		        case 6:
		            imageSrc = '/resources/images/ecologism.png';
		            break;
		        case 7:
		            imageSrc = '/resources/images/barber.png';
		            break;
		        default:
		            imageSrc = '/resources/images/optionvege.png';
		    }
			    var imageSize = new kakao.maps.Size(40, 40);
			    var imageOption = { offset: new kakao.maps.Point(20, 10) };
			    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
			  
			
			// 지도에 마커를 생성하고 표시한다
			var marker = new kakao.maps.Marker({
				position : new kakao.maps.LatLng(data[i][0], data[i][1]), // 마커의 좌표
				map : map,
				image : markerImage
			// 마커를 표시할 지도 객체
			});

			var iwContent = '<div style="padding: 5px">내용</div>';
			// 인포윈도우를 생성합니다
			
			var infowindow = new kakao.maps.InfoWindow({
 		   content: '<div style="padding: 20px; font-size: 14px; text-align: center; margin-top: -3px;">' + data[i][2] + '</div>'
			});

			
			markers.push(marker);
			kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(
					map, marker, infowindow));
			kakao.maps.event.addListener(marker, 'mouseout',
					makeOutListener(infowindow));
		}
		// 클러스터러에 마커들을 추가합니다
		clusterer.addMarkers(markers);

		// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
		function makeOverListener(map, marker, infowindow) {
			return function() {
				infowindow.open(map, marker);
			};
		}

		// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
		function makeOutListener(infowindow) {
			return function() {
				infowindow.close();
			};
		}
		
		function moveToLocation(lat, lng) {
			 map.setLevel(5);  
		    var moveLatLon = new kakao.maps.LatLng(lat, lng);
		    map.panTo(moveLatLon);
		}
	</script>


	<script>
	function searchCheck(){
		if(!searchShop.type.value){
			alert('검색 유형을 선택하세요');
			return;
		}
		if(searchShop.type.value!="shop_category" && !searchShop.keyword.value){
			alert('검색어를 입력하세요');
			var key = document.getElementById("keyword");
			key.focus();
			return;
		}
		if(searchShop.type.value=="shop_category" && searchShop.cate.value==0){
			alert('카테고리를 선택하세요');
			var key = document.getElementById("cate");
			key.focus();
			return;
		}
		//zoomOut();
		searchShop.submit();
		//zoomOut();
	}


	</script>
