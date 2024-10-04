<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script src="/resources/js/map.js"></script>
<script
	src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=4da202d77036151199a56057c568131d&libraries=clusterer"></script>

<div  id="mapList">
<div id="sidebarContents">
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
							<c:if test="${param.cate eq '5'}">selected</c:if>>비건식당</option>
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
							<c:if test="${param.cate eq '5'}">selected</c:if>>비건식당</option>
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
	<!-- 검색 결과 표시 영역 -->
	<div id="sidebar"></div>
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

</div>


<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(37.55489, 126.9708), // 지도의 중심좌표
			level : 3, // 지도의 확대 레벨
			mapTypeId : kakao.maps.MapTypeId.ROADMAP
		// 지도종류
		};

		// 지도를 생성한다 
		var map = new kakao.maps.Map(mapContainer, mapOption);
		
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
                ]);		   
			</c:forEach>
		</c:when>

		<c:otherwise>
			alert('검색 결과가 존재하지 않습니다.');
			var key = document.getElementById("keyword");
			key.focus();
		</c:otherwise>
	</c:choose>
	   
</script>

</div>