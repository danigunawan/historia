window.HistoriaApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {}
};

$(document).ready(function() {
  // return HistoriaApp.initialize();
  $('.fa-bars').on('click', function() {
    // event.preventDefault();
    console.log('clicked bars')
    $('.fa-bars').addClass('hide')
    $('.login-overlay').addClass('show');
  });
  $('.fa-close').on('click', function() {
    // event.preventDefault();
    console.log('clicked');
    $('.login-overlay').removeClass('show');
    $('.fa-bars').removeClass('hide')
  });
});
