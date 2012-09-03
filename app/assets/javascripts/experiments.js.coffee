# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.remaining = 0

jQuery ->
  $('#experiment_description').change(updateCountdown)
  $('#experiment_description').keyup(updateCountdown)
  $('#experiment_description').change(updateCreateButton)
  $('#experiment_description').keyup(updateCreateButton)

updateCountdown = ->
  window.remaining = 40 - $('#experiment_description').val().length;
  $('.countdown').text(window.remaining + ' characters left')
  if window.remaining < 0
    $('.countdown').addClass('beyond_length')
  else
    $('.countdown').removeClass('beyond_length')

updateCreateButton = ->
  if window.remaining < 0
    $('input[name=commit]').attr('disabled', 'disabled')
  else
    $('input[name=commit]').removeAttr('disabled')
