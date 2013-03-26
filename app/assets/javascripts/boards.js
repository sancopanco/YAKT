$(function(){
  var switch_new_story_button_text = function(){
    var link = $('#new-story-button').children('a');
    if (link.html() == '+') {
      link.html('-');
    } else {
      link.html('+');
    }
  };

  $('#new-story-button').click(function(){
	//kanban_app.modalLoad('/open_new_card_modal','');  
    $('#new-story').toggle();
    $('#story_name').focus();
    switch_new_story_button_text();
  });

  $('#new-story form').submit(function(){
    var data = {'story': {'name': $(this).children('#story_name').val()}};

    $.ajax({
      type: 'post',
      data: data,
      dataType: 'script',
      url: '/cards',
      success: function(){
        $('#story_name').val('');
        $('#new-story').toggle();
        switch_new_story_button_text();
      }
    });

    return false;
  });
  /*		
  setInterval(function(){
    $.ajax({
      dataType: 'json',
      url: '/accounts/1/boards/1',
      success: function(data){
        console.log(data);
      }
    });
  }, 3000);
 */
  
});