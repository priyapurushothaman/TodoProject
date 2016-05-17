
//Ripple Effect
jQuery(document).ready(function($) { 
	
// FORMS

         // toggle action
          $(document).on('click', ".toggle-opt i", function(){

              if ($(this).parent().hasClass('on')){
                $(this).parent().removeClass('on');
                $(this).parent().prev().removeClass('on').addClass('off');
                $(this).html('OFF' + '<cite></cite>')
              }
              else {
                $(this).parent().addClass('on'); 
                $(this).parent().prev().removeClass('off').addClass('on');
                $(this).html('ON' + '<cite></cite>')                
              }
          });

         // checklist action
            $(document).on('click', ".check-list li b", function(){

                if ($(this).parent().hasClass('selected')) {
                    $(this).parent().removeClass('selected');
                    $(this).find('cite').removeClass('icon-check').addClass('icon-plus');
                    $(this).parent().find('span').removeClass('selected');
                    $(this).parent().find('span i').removeClass('icon-check');
                }
                else {
                    $(this).parent().addClass('selected');
                    $(this).find('cite').removeClass('icon-plus').addClass('icon-check');                    
                }
            });

            $(document).on('click', ".check-list li span", function(){
              if ($(this).hasClass('selected')) {
                    $(this).removeClass('selected');
                    $(this).find('i').removeClass('icon-check');
                }
                else {
                    $(this).addClass('selected');
                    $(this).find('i').addClass('icon-check');                    
                }
            });

        //opt action

            $(document).on('click', ".opt-list li", function(){
              $(this).siblings().removeClass('selected');
              $(this).addClass('selected');
            });    

         // dropdown action
            $(document).on('click', ".dropdown button", function(e){
                e.stopPropagation();
                $('.dropdown .dropdown-list').hide();
                $('.dropdown').removeClass('focus');
                $(this).parent().addClass('focus');
                $(this).next().show();
                $(this).find('i').removeClass('icon-down-arrow').addClass('icon-arrow-up-right');

                if(e.keyCode == 38) {
                  var selected = $(".selected");
                  $('.dropdown-list li').removeClass('selected');
                  if(selected.prev().length == 0) {
                    selected.siblings().last().addClass('selected');
                  }
                  else {
                    selected.prev().addClass('selected');
                  }
                }
            });

            $(document).on('click', ".dropdown-list li", function(){
                var li_val = $(this).text() + '<i class="icon-down-arrow"></i>';
                $(this).parent().parent().find('button').html(li_val);
                $('.dropdown .dropdown-list').hide();
                console.log($(this).length);
             });

  
            $(document).mouseup(function(e){
              if ($(e.target).parents('.dropdown').size() ===0){
                $('.dropdown .dropdown-list').hide();
                $('.dropdown').removeClass('focus');
                $('.dropdown button i').removeClass('icon-arrow-up-right').addClass('icon-down-arrow');
              }
            });	
	
	
	
	
	
	
	
	
});