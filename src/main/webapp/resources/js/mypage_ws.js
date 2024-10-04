/**
 * 
 */
 
var socket = new SockJS("http://localhost:9090/validTime");
stompClient=Stomp.over(socket);

stompClient.connect({}, function(frame){

    console.log('----------connected ------------------');
    setInterval(function(){
    	getLeftTime();
    },1000*3);
   
});

function getLeftTime(){

 var items= document.querySelectorAll(".timeLeft");
    
    var username=$('#myid').text();
    //alert(username);
    $.each(items, function(item, index){
        let act_id=$(this).data('act-id');
        let act_state=$(this).data('act-state');
        console.log('act_id: ', act_id);
        let obj={
            act_id:act_id,
            userid:username
        }
        if(act_state=='1'){
        	console.log("act_state가 1");
            stompClient.send("/app/validTime/"+act_id,{}, JSON.stringify(obj)); 
        }
        stompClient.subscribe('/topic/activityItem/'+act_id, function(message){
            console.log(message.body);
            
            let actItem=JSON.parse(message.body);
            let token=actItem.timeLeft.split('/');
            let hh=parseInt(token[0]);
            let mm=parseInt(token[1]);
            let ss=parseInt(token[2]);
            
            if(hh<=0 && mm<=0 && ss<=0){
            	$('#tl'+actItem.actId+'_1').text('');
            }else{
            	let str=hh+'시간 '+mm+'분 '+ss+'초';
            	$('#tl'+actItem.actId+'_1').text(str).css('color','green');
            }   
        });
    });

}