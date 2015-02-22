# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $(".new").hide()
  $(".edit-option").hide()
  $(".options").each ->
    $(this).find(".new").first().show()
    return
  $(".new input").focus ->
    event.preventDefault()
    blankInputs = $(this).parent().parent().parent().parent().find(".new input").filter ->
      return $(this).val() == ""
    blankInputs.first().parent().parent().parent().show()
    $(this).parent().parent().parent().next().show()
    return
  $(".view-option a").click ->
    event.preventDefault()
    $(this).parent().hide()
    $(this).parent().parent().find(".edit-option").show()
    return
  $(".delete a").click ->
    event.preventDefault()
    $(this).parent().parent().hide()
    blankInputs = $(this).parent().parent().parent().find(".new input").filter ->
      return $(this).val() == ""
    blankInputs.parent().parent().parent().hide()
    blankInputs.first().parent().parent().parent().show()
    $(this).parent().parent().find("input").val("")
    return
  return
