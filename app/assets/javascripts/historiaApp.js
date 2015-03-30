$(document).ready(function() {
  // return HistoriaApp.initialize();

  // Display signin/signup popup 
  $('.fa-bars').on('click', function() {
    $('.fa-bars').addClass('hide');
    $('.login-overlay').addClass('show');
  });

  // Hide signin/signup popup 
  $('.fa-close').on('click', function() {
    $('.login-overlay').removeClass('show');
    $('.fa-bars').removeClass('hide');
  });

});

