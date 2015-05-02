$(function(){
  $("#category_select").change(function(){
    var category_id = $(this).val(),
        current_path = location.pathname,
        params = $.param({category: category_id}),
        new_path = current_path + "?" + params;

    window.location = new_path;
  });
});
