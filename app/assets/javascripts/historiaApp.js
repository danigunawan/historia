var initializeMap = function () {
  var $container = $('.map')[0];

  var mapOptions = {
    zoom: 8,
    center: new google.maps.LatLng(-34.397, 150.644)
  }
  var map = new google.maps.Map($container, mapOptions);
};

var historiaApp = {
  sortLike: function (event) {
    event.preventDefault();
    var $currentEl = $(this);
    if ( $currentEl.hasClass("like") ) {
      historiaApp.likePlace($currentEl);
    } else {
      historiaApp.unlikePlace($currentEl);
    }
  },

  likePlace: function ($element) {
    console.log('Like called.');
    var id = $element.attr("id");
    $.ajax('/places/' + id + '/like', {
      type: 'POST',
      data: {
        type: 'like'
      }
    }).done(function(){
      $element.removeClass('fa-heart-o like').addClass('fa-heart unlike');
    });
  },

  unlikePlace: function ($element) {
    console.log('Unlike called.');
    var id = $element.attr("id");
    $.ajax('/places/' + id + '/like', {
      type: 'DELETE',
      data: {
        _method: 'DELETE',
        type: 'unlike'
      }
    }).done(function(){
      $element.removeClass('fa-heart unlike').addClass('fa-heart-o like');
      console.log('Unlike done?')
    });
  // },
  // retrieveWikiContent: function() {
  //   $.getJSON('http://en.wikipedia.org/w/api.php?action=parse&page=google&prop=text&format=json&callback=?', 
  //     function(json) {
  //       $('.content').html(json.parse.text); 
  //   });
  }
};

$(document).ready(function() {

  $('.current-place').on('click', historiaApp.sortLike);
  // $('.unlike').on('click', historiaApp.unlikePlace);
  // $('.fa-heart').hover(function() {
  //   $( this ).addClass('fa-heart').removeClass('fa-heart-o');
  // }, function() {
  //   $( this ).removeClass('fa-heart').addClass('fa-heart-o');
  // }
  // );

  // Display signin/signup popup 
  $('.fa-bars').on('click', function() {
    $('.fa-bars').addClass('hide');
    $('.login-overlay').addClass('show');
    $('.logged-overlay').addClass('show');
  });

  // Hide signin/signup popup 
  $('.fa-close').on('click', function() {
    $('.login-overlay').removeClass('show');
    $('.logged-overlay').removeClass('show');
    $('.fa-bars').removeClass('hide');
  });

  initializeMap();
  // historiaApp.retrieveWikiContent();

});

