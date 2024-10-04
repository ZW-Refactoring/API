function goCancle(actno){
	let yn=confirm('정말 취소하시겠습니까?');
	if(yn){
		$('#cancleNo').val(actno);
		cancleForm.submit();
	}
}

function selectCtgr(ctgr) {
    $.ajax({
        type: 'POST',
        url: '/user/selectstate',
        data: {
            ctgr: ctgr
        },
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        success: function(data) {
            let str = "";
            let header = `<tr>
                <th>활동번호</th>
                <th>이름</th>
                <th>활동상태</th>
                <th>시작일</th>
                <th>종료일</th>
                <th>인증 유효시간</th>
                <th>취소</th>
            </tr>`;

            if (data.length === 0) {
                str += `<tr>
                            <td colspan="7" style="text-align: center;"><b>해당되는 활동이 없습니다.</b></td>
                        </tr>`;
            } else {
                $.each(data, function(i) {
                    str += "<tr>";
                    str += `<td class="actNo">` + data[i].actId + `</td>`;
                    str += `<td class="actName"><a href="/actDetail/`+data[i].actId+`">` + data[i].actName + `</a></td>`;
                    str += `<td class="actState">` + data[i].stateName + `</td>`;

                    // Format startDate
                    let startDate = new Date(data[i].startDate);
                    let formattedStartDate = startDate.getFullYear() + '-' +
                        ('0' + (startDate.getMonth() + 1)).slice(-2) + '-' +
                        ('0' + startDate.getDate()).slice(-2) + ' ' +
                        ('0' + startDate.getHours()).slice(-2) + ':' +
                        ('0' + startDate.getMinutes()).slice(-2) + ':' +
                        ('0' + startDate.getSeconds()).slice(-2);
                    str += `<td class="sdate">` + formattedStartDate + `</td>`;

                    //Format endDate or assign empty string if null
                    let formattedEndDate = '';
                    if (data[i].endDate) {
                        let endDate = new Date(data[i].endDate);
                        formattedEndDate = endDate.getFullYear() + '-' +
                            ('0' + (endDate.getMonth() + 1)).slice(-2) + '-' +
                            ('0' + endDate.getDate()).slice(-2) + ' ' +
                            ('0' + endDate.getHours()).slice(-2) + ':' +
                            ('0' + endDate.getMinutes()).slice(-2) + ':' +
                            ('0' + endDate.getSeconds()).slice(-2);
                    }
                    str += `<td class="edate">` + formattedEndDate + `</td>`;

                    str += `<td id="tl${data[i].actId}_${data[i].state}" class="timeLeft" data-act-id="${data[i].actId}" data-act-state="${data[i].state}" style="color: green;">`
                            + data[i].timeLeft + `</td>`;

                    // Conditionally render the cancel button
                    str += `<td class="cancle">`;
                    if (data[i].state == '1') {
                        str += `<button id="btnCancle" onclick="goCancle(${data[i].actId})">취소</button>`;
                    }
                    str += `</td>`;

                    str += "</tr>";
                });
            }

            $("#list").empty();
            $("#statusCounts").empty();
            $('#stsListContainer').empty();
            $("#list").append(header);
            $("#list").append(str);
            $('#actContent').empty();
        },
        error: function(err) {
            alert(err.status);
        }
    });
}

 function removeBookmark(username, actNo) {
 	//alert(actNo);
    $.ajax({
        type: 'GET',
        url: '/activity/removeBookmark',
        data: {
            actNo: actNo
        },
        success: function(response) {
            // 성공적으로 북마크가 삭제될 경우
            alert(response); // 성공 메시지 출력 예시
            location.reload(true)
        },
        error: function(xhr, status, error) {
            // 오류 발생
            alert("즐겨찾기 삭제를 실패했습니다."); // 실패 메시지 출력 예시
        }
    });
}