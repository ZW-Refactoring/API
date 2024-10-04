<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
    
    //sideInfo()
});

function sidebarInfo(){
	$.ajax({
        url: '/mapListAjax',
        type: 'GET',
        success: function(data) {
            var table = $('<table border="1"></table>');
            var thead = $('<thead><tr><th>Shop ID</th><th>Shop Name</th><th>Address</th><th>Latitude</th><th>Longitude</th><th>Category</th></tr></thead>');
            table.append(thead);
            var tbody = $('<tbody></tbody>');
            $.each(data, function(index, map) {
                var row = $('<tr><td>' + map.shopId + '</td><td>' + map.shopName + '</td><td>' + map.addr + '</td><td>' + map.lat + '</td><td>' + map.lng + '</td><td>' + map.category + '</td></tr>');
                tbody.append(row);
            });
            table.append(tbody);
            $('body').append(table);
        }
    });
}


</script>
	 <h1>Map List</h1>
<body>
		
</body>
</html>