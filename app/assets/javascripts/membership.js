var Membership = {
	setup:function(){
		$('form#add_member').submit(this.addMember);
		$('.members #role_id').change(this.changeRole);
	},
	addMember:function(e){
	  e.preventDefault();
	  $.ajax({
		type: $(this).attr('method'),
		url: $(this).attr('action'), 
		data: $(this).serialize(),
		dataType: "html" 
	  }).success(function(html){
		  $('.members tbody').prepend(html)
	   });
	 },
	changeRole:function(){
		$url  = '/boards/'+ $(this).attr('board_id')+'/change_role';
		$data = {user_id:$(this).attr('user_id'),role_id:$(this).val()};
		$.ajax({
			type:'POST',
			url:$url,
			data:$data,
			dataType:"json",
		}).success(function(html){
			
		});
	}
	
};
$(Membership.setup());