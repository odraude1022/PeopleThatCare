$(document).on("ready turbolinks:load", function(){
  $('.category_check_box').on('click', function(){
    var checked_count = $('.category_check_box:checked').length
    if (checked_count >= 3) {
      var unchecked = $('.category_check_box:not(:checked)')
      $.each(unchecked, function(index, checkbox){
        $(checkbox).attr("disabled", true)
      })
    }else{
      var checkboxes = $('.category_check_box')
      $.each(checkboxes, function(index, checkbox){
        $(checkbox).removeAttr("disabled")
      })
    }
  })
})
