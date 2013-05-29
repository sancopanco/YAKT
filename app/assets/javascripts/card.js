/*
 * Script inspired [by James Padolsey]
 * @requires jQuery($), jQuery UI & sortable/draggable UI modules
 */
/*The MIT License (MIT)

Copyright (c) 2013 ali kargin,tansel ersavas,hande kuskonmaz,yusuf aydin

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE
*/
var Card = {
    jQuery : $,
	docThis: this,
    settings : {
        states : '.state',
        cardSelector: '.card',
        handleSelector: '.card-head',
        contentSelector: '.card-content',
        cardDefault : {
            movable: true,
            removable: true,
            collapsible: true,
            editable: true,
            colorClasses : ['color-yellow', 'color-red', 'color-blue', 'color-white', 'color-orange', 'color-green']
        },
        cardIndividual : {
            intro : {
                movable: false,
                removable: false,
                collapsible: false,
                editable: false
            }
        }
	},
    setup : function () {
		this.makeSortable();
		$(".card-head .remove").on('click',this.removeCard); 
		$(".card-head .edit").on('click',this.editCard); 
		$(".card-head .collapse").on('click',this.collapseCard); 
	    $('.edit-box ul.colors li').click(this.changeCardColor);
		
		$('#new-card-button').bind('click',this.openNewCard);
		$('#new-card form').submit(this.createNewCard); 	
	},
	openNewCard:function(){
	    $('#new-card').toggle();
	    $('#card_name').focus();
	    this.switchNewCardBtntext();
	},
	switchNewCardBtntext:function(){
	    var link = $('#new-card-button').children('a');
	    if (link.html() == '+') {
	      link.html('-');
	    } else {
	      link.html('+');
	    }
	},
	createNewCard:function(){
		var board_id = this.docThis.location.pathname.split('/')[2];
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
	        this.switchNewCardBtntext();
	      }
	    });
		return (false);
	},
	changeCardColor:function(){
		console.log("hebel");
		var colorStylePattern = /\bcolor-[\w]{1,}\b/,
            thisCardColorClass = $(this).parents(".card").attr('class').match(colorStylePattern);
        if (thisCardColorClass) {
            $(this).parents(".card")
                .removeClass(thisCardColorClass[0])
                .addClass($(this).attr('class').match(colorStylePattern)[0]);
        }
        return false;
    },
	removeCard:function(e){
		e.stopPropagation();
		if(confirm("This card wile get be removed, ok?")){
			$(this).parents(".card").animate(
			    {opacity: 0},
			    function(){
			        $(this).wrap('<div/>').parent().slideUp(function(){
			            $(this).remove();
			        });
			    }    
			); 
		}
		return false;
	},
	editCard:function(e){
		e.stopPropagation(); 
		e.preventDefault();
		$(this).parents(".card").find('.edit-box').toggle('fast');
	},
	collapseCard:function(e){
		e.stopPropagation();
		e.preventDefault();
		$(this).parents(".card").find('.edit-box').toggle('fast');
	},
	makeSortable : function () {
        var Card = this,
            $ = this.jQuery,
            settings = this.settings,
            $sortableItems = $('.card',$('.state'));
        $sortableItems.find(settings.handleSelector).css({
            cursor: 'move'
        }).mousedown(function (e) {
            $sortableItems.css({width:''});
            $(this).parent().css({
                width: $(this).parent().width() + 'px'
            });
        }).mouseup(function () {
			
            if(!$(this).parent().hasClass('dragging')) {
                $(this).parent().css({width:''});
            } else {
                $(settings.states).sortable('disable');
            }
        });

        $(settings.states).sortable({
            items: $sortableItems,
            connectWith: $(settings.states),
            handle: settings.handleSelector,
            placeholder: 'card-placeholder',
            forcePlaceholderSize: true,
            revert: 300,
            delay: 100,
            opacity: 0.8,
            containment: 'document',
            start: function (e,ui) {
                $(ui.helper).addClass('dragging');
            },
            stop: function (e,ui) {
                $(ui.item).css({width:''}).removeClass('dragging');
                $(settings.states).sortable('enable');
            },
  	        update: function(){
  	         var data = {};
  	         data['state']   = $(this).attr('id');
  	         data['cards'] = $(this).sortable('toArray');
			 //console.log(data['state']);
			 //console.log(data['cards']);
			 
			 $.ajax({
  	          type: 'post',
  	          data: data,
  	          dataType: 'script',
  	          url: '/cards/sort'
  	         });
			 
  	      }
        });
    }
  
};
$(Card.setup());
