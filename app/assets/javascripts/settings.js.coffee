# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  max_fields = 10
  wrapper = $('.form')
  add_button = $('.add_field_button')
  x = 1

  $(add_button).click (e) ->
    e.preventDefault()
    if x < max_fields
      x++
      $(this).parent('div').parent('div').append '
        <div class="removable_item">
          <div class="removable_item_button">
            <a href="#" class="remove_field">[X]</a>
          </div>
          <div class="removable_item_field">
            <input type="text" id="new_' + $(this).parent('div').parent('div').attr('class') + '" />
          </div>
        </div>'
    return

  $(wrapper).on 'click', '.remove_field', (e) ->
    e.preventDefault()
    $(this).parent('div').parent('div').remove()
    x--
    return
  return
