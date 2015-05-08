$(document).ready ->
  $(".field .delete").on 'click', (event) ->
    $(this).parent().hide()
    $(this).parent().find("#del_resume").val("1")
    event.preventDefault()
    return false
  return
