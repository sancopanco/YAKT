
var KANBAN_APP = {
	doc_this:this,
	setup:function(){
		$("#add_task").bind('click',KANBAN_APP.addTask);	
		$('#new-card-button').bind('click',KANBAN_APP.openNewCard);
		$('#new-card form').submit(KANBAN_APP.createNewCard);
		//$("#new-board").bind('click',KANBAN_APP.openNewBoardModal);
		KANBAN_APP.make_users_sortable();
		KANBAN_APP.make_state_sortable();
		//console.log(this);
	},
	make_state_sortable:function(){
	    $('.state').sortable({
	      connectWith:['.state'],
	      cursor: 'move',
	      items: 'li',
	      start: function(){
	        $(this).addClass('droppable');
	      },
	      over: function(){
	        $('.droppable').removeClass('droppable');
	        $(this).addClass('droppable');
	      },
	      out: function(){
	        $('.droppable').removeClass('droppable');
	      },
	      stop: function(){
	        $('.droppable').removeClass('droppable');
	      },
	      update: function(){
	        var data = {};
	        data['state']   = $(this).attr('id');
	        data['cards'] = $(this).sortable('toArray');

	        $.ajax({
	          type: 'post',
	          data: data,
	          dataType: 'script',
	          url: '/cards/sort'
	        })
	      }
	    });
	},
	update_inactive_users_text:function(){
	    var users = $('#inactive-users .user').length;
	    var text  = '';

	    switch(users) {
	    case 0:
	      text = 'Nobody is slacking off';
	      break;
	    case 1:
	      text = 'is slacking off';
	      break;
	    default:
	      text = 'are slacking off';
	    }

	    $('#inactive-users h3').html(text);
	},
	make_users_sortable:function(){
      $('.users').sortable({
        connectWith:['.users'],
        cursor: 'move',
        items: 'img',
        start: function(){
          $(this).addClass('droppable');
        },
        over: function(){
          $('.droppable').removeClass('droppable');
          $(this).addClass('droppable');
        },
        out: function(){
          $('.droppable').removeClass('droppable');
        },
        stop: function(){
          $('.droppable').removeClass('droppable');
          KANBAN_APP.update_inactive_users_text();
        },
        update: function(){
          var data = {};
          data['card'] = $(this).attr('id');
          data['users'] = $(this).sortable('toArray');
		  data['board_id'] = KANBAN_APP.doc_this.location.pathname.split('/')[2];
  		console.log(data['card']);
  		console.log(data['users']);
          $.ajax({
            type: 'post',
            data: data,
            dataType: 'script',
            url: '/users/sort'
          })
        }
      });
    },
	openNewCard:function(){
	    $('#new-card').toggle();
	    $('#card_name').focus();
	    KANBAN_APP.switch_new_card_button_text();
	},
	createNewCard:function(){
		//console.log(this);
		//console.log(KANBAN_APP.doc_this);
		var board_id = KANBAN_APP.doc_this.location.pathname.split('/')[2];
	    var data = {'card': {'name': $(this).children('#card_name').val()}, 'board_id' : board_id };
		$.ajax({
	      type: 'POST',
	      data: data,
		  timeout: 5000,
	      dataType: 'script',
	      url: $(this).attr("action"),
	      success: function(){
	        $('#card_name').val('');
	        $('#new-card').toggle();
	        KANBAN_APP.switch_new_card_button_text();
	      }
	    });
		return (false);
	},
	switch_new_card_button_text:function(){
	    var link = $('#new-card-button').children('a');
	    if (link.html() == '+') {
	      link.html('-');
	    } else {
	      link.html('+');
	    }
	},
	addTask:function(){
		var task_name = $("#task_name").val();
		var card_id = $("#task_name").attr("card_id");
		var data = {name:task_name,card_id:card_id};
		if (task_name != ''){
			KANBAN_APP.do_ajax_post("/add_task_to_card",data);
			$("#task_name").val('');
		}
	},
	openNewBoardModal:function(){
		//console.log("deneme");
		KANBAN_APP.modalLoad('/open_model_to_create_new_board','');
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
	},
	ajax_form_submit:function(){
		$.ajax({
			type:'POST',
			url:$(this).attr("href"),
			timeout: 5000,
			success:function(data, requestStatus, xhrObj){
				
			},
			error:function(xhrObj, textStatus, exception){
				
			}
			
		})
		return (false);
	}
	
};

$(function(){
	$(KANBAN_APP.setup);
});



