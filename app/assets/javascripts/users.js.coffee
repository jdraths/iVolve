# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  Morris.Donut
    element: 'social-connections'
    data: [
        {label: "Twitter", value: $('#social-connections').data('twitter')}
        {label: "Facebook", value: $('#social-connections').data('facebook')}
        {label: "Instagram", value: $('#social-connections').data('instagram')}
        {label: "Foursquare", value: $('#social-connections').data('foursquare')}
    ]
  Morris.Donut
    element: 'ivolve-connections'
    data: [
        {label: "Twitter", value: $('#ivolve-connections').data('twitter')}
        {label: "Facebook", value: $('#ivolve-connections').data('facebook')}
        {label: "Instagram", value: $('#ivolve-connections').data('instagram')}
        {label: "Foursquare", value: $('#ivolve-connections').data('foursquare')}
    ]
  Morris.Donut
    element: 'social-engagement'
    data: [
        {label: "Twitter", value: $('#social-engagement').data('twitter')}
        {label: "Facebook", value: $('#social-engagement').data('facebook')}
        {label: "Instagram", value: $('#social-engagement').data('instagram')}
        {label: "Foursquare", value: $('#social-engagement').data('foursquare')}
    ]
  Morris.Donut
    element: 'ivolve-engagement'
    data: [
        {label: "Twitter", value: $('#ivolve-engagement').data('twitter')}
        {label: "Facebook", value: $('#ivolve-engagement').data('facebook')}
        {label: "Instagram", value: $('#ivolve-engagement').data('instagram')}
        {label: "Foursquare", value: $('#ivolve-engagement').data('foursquare')}
    ]
  Morris.Bar
    element: 'wellness-bar'
    data: [
        { y: 'Social', a: $('#wellness-bar').data('youso'), b: $('#wellness-bar').data('ivolveso') },
        { y: 'Creative', a: $('#wellness-bar').data('youcr'), b: $('#wellness-bar').data('ivolvecr') },
        { y: 'Physical', a: $('#wellness-bar').data('youph'), b: $('#wellness-bar').data('ivolveph') }
    ]
    xkey: 'y',
    ykeys: ['a', 'b'],
    labels: ['Me', $('#wellness-bar').data('who')]