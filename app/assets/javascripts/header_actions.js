$(document).ready(function(){

  $(".nav-tabs li").click(function(e){
    e.preventDefault();
    $(".nav-tabs li").removeClass("active");
    $(this).addClass("active");
  });
});