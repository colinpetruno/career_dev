//= require ./namespace
//= require jquery
//= require jquery_ujs
//
//= require cloudinary
//= require attachinary
//
//= require_tree ./shared
//= require_tree ./application
//


// TODO: Find better location for this
$(function(){
  $('.attachinary-input').attachinary(window.Careers.config.attachinary);
});
