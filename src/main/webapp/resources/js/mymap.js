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