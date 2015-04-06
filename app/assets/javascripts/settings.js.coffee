# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $(".options").sortable()
  $(".options").on 'sortstop', (event, ui) ->
    sortedIDs = $(this).sortable("toArray")
    $(this).find("select").each -> 
      position = sortedIDs.indexOf(this.id) + 1
      $(this).val(position)
      return
    return
  $(".position").hide()
  $(".new").hide()
  $(".view-option").show()
  $(".edit-option").hide()
  $(".options").each ->
    $(this).find(".new").first().show()
    return
  $(".new-option input").on 'focus', (event) ->
    $(this).closest(".new").next().show()
    event.preventDefault()
    return false
  $(".view-option a").on 'click', (event) ->
    $(this).parent().hide()
    $(this).closest(".existing").find(".edit-option").show()
    event.preventDefault()
    return false
  $(".delete label").on 'click', (event) ->
    $(this).parent().parent().hide()
    $(this).parent().parent().find("input").val("")
    $(this).closest(".options").find(".new").first().show()
    event.preventDefault()
    return false
  return
