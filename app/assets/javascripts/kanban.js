
var kanban_app = {
	setup:function(){
		//$("#new-board").bind('click',kanban_app.openNewBoardModal);
		$("#add_task").bind('click',kanban_app.addTask);	
	},
	addTask:function(){
		var task_name = $("#task_name").val();
		var card_id = $("#task_name").attr("card_id");
		var data = {name:task_name,card_id:card_id};
		if (task_name != ''){
			kanban_app.do_ajax_post("/add_task_to_card",data);
			$("#task_name").val('');
		}
	},
	openNewBoardModal:function(){
		//console.log("deneme");
		kanban_app.modalLoad('/open_model_to_create_new_board','');
	},
	modalLoad:function(ajax_url, data){
		var $modal = $('#ajax-modal');
		$modal.load(ajax_url,data, function(){
			$modal.modal();
		});		
	},
	do_ajax_post:function(url,data){
	    $.ajax({
	      type: 'post',
	      data: data,
	      dataType: 'json',
	      url:url,
	      success:function(data,textStatus){
			  //var json_data = JSON.parse(JSON.stringify(data.responseText));
			  var task_name = data.name;
			  //var checked_or_not = json_data.checked;
			  //console.log(json_data.name);
			  $("#card_tasks").append("<li><p><input type='checkbox' /> "+task_name+"<br/></p></li>");
		 },
		 error:function(request, textStatus, error){
			 alert(error.fullMessages);
			 if( $xhr.getAllResponseHeaders().length < 1 ){
			    // fair probability server is down
				alert("server is down");
			 }
		 }
	    });
	}
	
};
$(kanban_app.setup);


