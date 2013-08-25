$(function() {
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


    $(this).hide();
    $("#record-"+item_id).show();
  });

})