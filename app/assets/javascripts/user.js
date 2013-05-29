var User = {
	setup:function(){
		this.makeSortable();
	},
	makeSortable:function(){
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
        },
        update: function(){
          var data = {};
          data['card'] = $(this).attr('id');
          data['users'] = $(this).sortable('toArray');
		  data['parent_card_id'] = window.location.pathname.split('/')[2];
		  $.ajax({
            type: 'post',
            data: data,
            dataType: 'script',
            url: '/users/sort'
          })
        }
      });
    }
}
$(User.setup());
