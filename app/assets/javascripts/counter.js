$(function() {  
  var cont = 0;
  var counting_days = setInterval(counter_days, 1000);
  clearInterval(counting_days);
  var counting_week = setInterval(counter_week, 1000);
  clearInterval(counting_week);

  
  $(".add-item").click(function() {
    $(".add-item-form").show();
    $(".add-item").hide();
    $(".hide-item").show();
  });
  
  $(".hide-item").click(function(){
    $(".add-item-form").hide();
    $(".add-item").show();
    $(".hide-item").hide();
  });
  
  function counter_days(){
    // si cambio de dia poner $("#today-seconds").html("0")
    var secs = parseInt($("#today-seconds").text())+1;
    $("#today-seconds").html(secs);

    var hours = parseInt(secs / 3600);
    secs = secs%3600;
    var mins = parseInt(secs / 60);
    secs = secs % 60;
    
    if(mins+secs == 0){
      $("#today-time").html(hours + "h");
    }else if(secs == 0){
      $("#today-time").html(hours + "h/" + mins + "m");
    }else if(mins == 0){
      $("#today-time").html(hours + "h/" + secs + "s");      
    }else{
      $("#today-time").html(hours + "h/" + mins + "m/" + secs + "s");
    }
  }
  
  function counter_week(){
    // si cambio de semana poner $("#week-seconds").html("0")
    var secs = parseInt($("#week-seconds").text())+1;
    $("#week-seconds").html(secs);

    var hours = parseInt(secs / 3600);
    secs = secs%3600;
    var mins = parseInt(secs / 60);
    secs = secs % 60;
    
    if(mins+secs == 0){
      $("#week-time").html(hours + "h");
    }else if(secs == 0){
      $("#week-time").html(hours + "h/" + mins + "m");
    }else if(mins == 0){
      $("#week-time").html(hours + "h/" + secs + "s");      
    }else{
      $("#week-time").html(hours + "h/" + mins + "m/" + secs + "s");
    }
  }
  
  $(".record").click(function(){
    item_id = $(this).attr("id").split("-")[1];

    // here the ajax call for create a new RecordingItem
    $.ajax({
      type: "POST",
      url: "/record",
      data: { item: item_id }
    }).done(function( data ) {
      if(data!="OK"){
        alert( "The system it's going to enter in panic, please try again: " + data );
      }
    });
    
    counting_days = setInterval(counter_days, 1000);
    counting_week = setInterval(counter_week, 1000);
    
    $(this).hide();
    $("#stop-record-"+item_id).show();
  });

  $(".stop-record").click(function(){
    item_id = $(this).attr("id").split("-")[2];
    
    // here the ajax call for delete RecordingItem and create a new commit
    $.ajax({
      type: "POST",
      url: "/stop-record",
      data: { item: item_id }
    }).done(function( data ) {
      if(data!="OK"){
        alert( "The system it's going to enter in panic, please try again: " + data );
      }
    });

    clearInterval(counting_days);
    clearInterval(counting_week);

    $(this).hide();
    $("#record-"+item_id).show();
  });

})