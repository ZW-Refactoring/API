 function openRankPage() {
        // 새 창의 속성 설정
        var width = 600; // 창의 너비
        var height = 400; // 창의 높이
        var left = (screen.width - width) / 2; // 화면 가로 중앙 정렬
        var top = (screen.height - height) / 2; // 화면 세로 중앙 정렬
        var options = 'width=' + width + ',height=' + height + ',top=' + top + ',left=' + left;

        // 새 창 열기
        window.open('/myrank', '_blank', options);
    }

// 페이지 로드 시 실행되는 함수
        
