# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $(".new").hide()
  $(".view-option").show()
  $(".edit-option").hide()
  $(".options").each ->
    $(this).find(".new").first().show()
    return
  $(".new-option input").focus ->
    event.preventDefault()
    blankInputs = $(this).closest(".options").find(".new.new-option input").filter ->
      return $(this).val() == ""
    blankInputs.first().closest(".new").show()
    $(this).closest(".new").next().show()
    return
  $(".view-option a").click ->
    event.preventDefault()
    $(this).parent().hide()
    $(this).closest(".existing").find(".edit-option").show()
    return
  $(".delete label").click ->
    event.preventDefault()
    $(this).parent().parent().hide()
    blankInputs = $(this).closest(".options").find(".new.new-option input").filter ->
      return $(this).val() == ""
    blankInputs.closest(".new").hide()
    blankInputs.first().closest(".new").show()
    $(this).parent().parent().find("input").val("")
    return
  return
