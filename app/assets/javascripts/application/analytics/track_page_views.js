$(function(){

  if ($('meta[name=track-page-views]').attr('content') == 'true') {
    mixpanel.track('PageView', {
      'Page Name': $('meta[name=mixpanel-page]').attr('content'),
      'Url': window.location.pathname
    });
  }

});
