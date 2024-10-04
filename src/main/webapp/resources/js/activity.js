function selectCtgr(ctgr) {
	$.ajax({
		type: 'POST',
		url: '/selectctgr',
		data: {
			ctgr: ctgr
		},
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		success: function (data) {
			let str = "";
			let header = `<tr>
				<th width="15%">번호</th>
				<th width="20%">분류</th>
				<th width="30%">이름</th>
				<th width="20%">포인트</th>
				</tr>
				`;
			$.each(data, function (i) {
				str += "<tr>";
				str += `<td id="actNo">` + data[i].actId + `</td>`;
				str += `<td id="actCategory">` + data[i].actCategory + `</td>`;
				str += `<td id="actName"><a href="/actDetail/` + data[i].actId + `">` + data[i].actName + `</a></td>`;
				str += `<td id="point">` + data[i].point + `</td>`;
				str += "</tr>";

				$("#list").empty();
				$("#statusCounts").empty();
				$('#stsListContainer').empty();
				$("#list").append(header);
				$("#list").append(str);
				$('#actContent').empty();
			})
		},
		error: function (err) {
			alert(err.status);
		}
	});
}

function showContent(actNo) {
	$.ajax({
		url: 'showContent/' + actNo,
		success: function (htmlContent) {
			$("#statusCounts").empty();
			$('#stsListContainer').empty();
			$('#actContent').html(htmlContent);
			$('#buttons').append(
				`<input type="hidden" id = "actno">
			 <button id = "start" onclick="actStart()">시작하기</button>
			 <button id = "ctfc" onclick="actCtfc()">인증하기</button>
			 <button id = "bookmark" onclick="addBookmark()">즐겨찾기</button>
			 <button onclick="removeBookmark()">즐겨찾기 해제</button>
			 <button id="sts" onclick="actSts()">결과보기</button>`)
			$('#actno').val(actNo);
		}
	});
}

function actStart() {
	actno = parseInt($('#actno').val());
	location.href = '/activity/actStart?actno=' + actno;
}

function actCtfc() {
	actno = parseInt($('#actno').val());
	var url = '/activity/actCtfcForm?actno=' + actno;
	win = open(url, "Activity Certification", "width=500, height=500, left=100, top=100");
}

function addBookmark(username) {
	if (username == "") {
		alert('로그인이 필요합니다.');
	}

	else {
		actNo = parseInt($('#actno').val());
		$.ajax({
			type: 'GET',
			url: '/activity/addBookmark',
			data: {
				actNo: actNo
			},
			success: function (response) {
				// 성공적으로 북마크가 추가되면 여기에 처리할 코드 작성
				location.reload(true)
			},
			error: function (xhr, status, error) {
				// 오류가 발생했을 때 여기에 처리할 코드 작성
				alert("북마크 추가에 실패했습니다."); // 실패 메시지 출력 예시
			}
		});
	}
}

function removeBookmark(username) {
	actNo = parseInt($('#actno').val());
	alert(actNo);
	$.ajax({
		type: 'GET',
		url: '/activity/removeBookmark',
		data: {
			actNo: actNo
		},
		success: function (response) {
			// 성공적으로 북마크가 삭제될 경우
			alert(response); // 성공 메시지 출력 예시
			location.reload(true)
		},
		error: function (xhr, status, error) {
			// 오류 발생
			alert("즐겨찾기 삭제를 실패했습니다."); // 실패 메시지 출력 예시
		}
	});

}

function actSts() {
	actNo = parseInt($('#actno').val());
	// 카운터 변수 초기화
	var countInProgress = 0;
	var countCompleted = 0;
	$.ajax({
		url: '/actSts/' + actNo,
		success: function (map) {
			// 기존 요소 제거
			$('#stsListContainer').empty();
			$.each(map.stsList, function (index, item) {
				var statusText;
				const listItem = $(`
				<div class="stateContainer">
					<ul>
	                    <li>
	                        <strong>아이디:</strong> ${item.userid}<br>
	                        <strong>상태:</strong> ${item.stateName}<br>
	                        <strong>시작:</strong> ${item.startDate}<br>
	                        <strong>인증:</strong> ${item.endDate}<br>
	                        <button class="report-btn" data-stsno="${item.stateId}">신고하기</button><br><br>
	                    </li>
	                </ul>
	                <div class="image-container">
	                	<img src="/resources/upload/${item.ctfcFilename}" width="300"><br>
	                </div>
                </div>
                    <hr>
                `);

				$('#stsListContainer').append(listItem);
			});

			// 카운터 출력
			$("#statusCounts").text(`진행중: ${map.ing} / 진행완료: ${map.end}`);
		}
	});
}

$(document).ready(function () {
	$('#stsListContainer').on('click', '.report-btn', function () {
		var stsNo = $(this).data('stsno');
		goReportForm(stsNo);
	});

	function goReportForm(stsId){
		var url = '/activity/actReportForm?stsId='+stsId;
		win = open(url, "Activity Report", "width=500, height=500, left=100, top=100");
	}

	document.getElementById("Ctfc_Form").addEventListener("submit", function (event) {

		event.preventDefault();
	
		var formData = new FormData(this);
		
		fetch("/activity/actCtfc", {
            method: "POST",
            body: formData
        })
        .then(function(response) {
            return response.text();
            
        })
        .then(function(data){
        alert(data);
        window.opener.location.reload();
        window.close();
        })
        .catch(function(error) {
            console.error("Error:", error);
        });
	});
});




