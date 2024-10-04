function sideInfo(lat, lon){
   // alert("##"+lat);
    $.ajax({
           url: '/mapSidebar?lat='+lat+'&lng='+lon,
           type: 'GET',
           success: function(data) {
                  var sidebarContent = ''; // 데이터를 담을 변수 초기화
                  for(i=0; i<data.length; i++){
                      sidebarContent += '<p class="shopName" onclick="moveToLocation(' + data[i].lat + ', ' + data[i].lng + ')" onmouseover="changeColor(this)" onmouseout="restoreColor(this)">' + data[i].shopName + '</p>'; // 상점 이름 출력
                      sidebarContent += '<p>' + data[i].addr + '</p>'; // 주소 출력
                  }
               $('#sidebar').html(sidebarContent); // 데이터를 sidebarContent에 채움
               
               $('#sidebar').css('overflow-y', 'scroll');
               $('#sidebar').css('max-height', '100vh');
               
           }
       });
   
}

function validateForm() {
  var category = document.getElementById("category").value;
  // 문자열을 숫자로 변환
  var categoryInt = parseInt(category);
  // 숫자로 변환된 값을 다시 input 태그의 value에 설정
  document.getElementById("category").value = categoryInt;
  return true; // 폼 제출
}


function changeColor(element) {
      element.style.color = '#FFFFFF'; // 글씨 색상을 하얀색으로 변경
      element.style.backgroundColor = '#006400'; // 배경색을 원하는 색상 코드로 변경
  }

   function restoreColor(element) {
      element.style.color = 'green'; // 원래 색상으로 복원
      element.style.backgroundColor = '';
   }

function moveToLocation(lat, lng) {
      var moveLatLon = new kakao.maps.LatLng(lat, lng);
      map.panTo(moveLatLon);
  }


  function searchCheck(){
    if(!searchShop.type.value){
        alert('검색 유형을 선택하세요');
        return;
    }
    if(searchShop.type.value!="category" && !searchShop.keyword.value){
        alert('검색어를 입력하세요');
        var key = document.getElementById("keyword");
        key.focus();
        return;
    }
    if(searchShop.type.value=="category" && searchShop.cate.value==0){
        alert('카테고리를 선택하세요');
        var key = document.getElementById("cate");
        key.focus();
        return;
    }
    
    searchShop.submit();
    
}


function hideSidebar() {
    var element = document.getElementById("sidebar");
    element.style.display = "none";
    
    // 사이드바가 숨겨질 때 맵의 너비를 늘립니다.
    var mapContainer = document.getElementById('map');
    mapContainer.style.width = "70%"; // 예시로 250px을 뺍니다.
    //mapContainer.style.height = "900px";
    mapContainer.style.justifyContent="center"
    map.setCenter(map.getCenter());
    map.relayout();
}

function showSidebar() {
    var element = document.getElementById("sidebar");
    element.style.display = "block";
    element.style.width='25%';
    
    // 사이드바가 표시될 때 맵의 너비를 재설정합니다.
    var mapContainer = document.getElementById('map');
    mapContainer.style.width = "70%"; // 전체 너비로 재설정합니다.
    //mapContainer.style.height = "600px";
    mapContainer.style.justifyContent="flex-start"
    map.setCenter(map.getCenter());
    map.relayout();
}

function validateForm() {
    var category = document.getElementById("category").value;
    // 문자열을 숫자로 변환
    var categoryInt = parseInt(category);
    // 숫자로 변환된 값을 다시 input 태그의 value에 설정
    document.getElementById("category").value = categoryInt;
    return true; // 폼 제출
}

function changeColor(element) {
    element.style.color = '#FFFFFF'; // 글씨 색상을 하얀색으로 변경
    element.style.backgroundColor = '#006400'; // 배경색을 원하는 색상 코드로 변경
}

 function restoreColor(element) {
    element.style.color = 'green'; // 원래 색상으로 복원
    element.style.backgroundColor = '';
 }

function moveToLocation(lat, lng) {
    var moveLatLon = new kakao.maps.LatLng(lat, lng);
    map.panTo(moveLatLon);
}

	
	document.getElementById("type").addEventListener("change", function() {
        var selectedOption = this.value;
        if (selectedOption === "category") {
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
		    
		    // 지도를 11레벨로 올립니다 (지도가 축소됩니다)
		    map.setLevel(11); 
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
			    5: '100% 비건 식당',
			    6: '제로웨이스트샵',
			    7: '미용실'
			};	
		
		
	<c:choose>
		<c:when test="${not empty mapList}">
		   <c:forEach items="${mapList}" var="m">
			data.push([ ${m.lat}, ${m.lng},
                '<div class="shopNameMap" style="padding: 5px">${m.shopName}</div> <br> <div class="addrMap">${m.addr}</div> <div class="categoryMap">' + categoryMap[${m.category}] + '</div>']);		   </c:forEach>
		</c:when>
		<c:otherwise>
			alert('검색 결과가 존재하지 않습니다.');
			var key = document.getElementById("keyword");
			key.focus();
			
		</c:otherwise>
	</c:choose>
	   
	   
		var markers = [];

		for (var i = 0; i < data.length; i++) {
			
			// 지도에 마커를 생성하고 표시한다
			var marker = new kakao.maps.Marker({
				position : new kakao.maps.LatLng(data[i][0], data[i][1]), // 마커의 좌표
				map : map
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
		
function searchCheck(){
		if(!searchShop.type.value){
			alert('검색 유형을 선택하세요');
			return;
		}
		if(searchShop.type.value!="category" && !searchShop.keyword.value){
			alert('검색어를 입력하세요');
			var key = document.getElementById("keyword");
			key.focus();
			return;
		}
		if(searchShop.type.value=="category" && searchShop.cate.value==0){
			alert('카테고리를 선택하세요');
			var key = document.getElementById("cate");
			key.focus();
			return;
		}
	
		searchShop.submit();
		
	}
	
	function hideSidebar() {
	    var element = document.getElementById("sidebarContent");
	    element.style.display = "none";

	    // 사이드바가 숨겨질 때 맵의 너비를 늘립니다.
	    var mapContainer = document.getElementById('map');
	    mapContainer.style.width = "1500px"; // 예시로 250px을 뺍니다.
	    mapContainer.style.height = "900px";
	    map.setCenter(map.getCenter());
	    map.relayout();
	}

	function showSidebar() {
	    var element = document.getElementById("sidebarContent");
	    element.style.display = "block";
	    
	    // 사이드바가 표시될 때 맵의 너비를 재설정합니다.
	    var mapContainer = document.getElementById('map');
	    mapContainer.style.width = "1200px"; // 전체 너비로 재설정합니다.
	    mapContainer.style.height = "600px";
	    map.setCenter(map.getCenter());
	    map.relayout();
	}

	 function sideInfo(lat, lon){
		  //alert("##"+lat);
		  $.ajax({
				 url: '/mapSidebar?lat='+lat+'&lng='+lon,
				 type: 'GET',
				 success: function(data) {
						var sidebarContent = ''; // 데이터를 담을 변수 초기화
						for(i=0; i<data.length; i++){
							sidebarContent += '<p class="shopName" onclick="moveToLocation(' + data[i].lat + ', ' + data[i].lng + ')" onmouseover="changeColor(this)" onmouseout="restoreColor(this)">' + data[i].shopName + '</p>'; // 상점 이름 출력
							sidebarContent += '<p>' + data[i].addr + '</p>'; // 주소 출력
						}
					 $('#sidebar').html(sidebarContent); // 데이터를 sidebarContent에 채움
	 				
					 $('#sidebar').css('overflow-y', 'scroll');
			         $('#sidebar').css('max-height', '100vh');
					 
				 }
			 });
		 
	 }	