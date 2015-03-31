
// GET LAT AND LONG BY ADDING THEM AS DATA ATTR TO THE PAGE SOMEWHERE..

var initializeMap = function () {
  var latitude = $('.map').attr('data-latitude');
  var longitude = $('.map').attr('data-longitude');
  var $container = $('.map')[0];

  var mapOptions = {
    zoom: 8,
    center: new google.maps.LatLng(latitude, longitude)
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
  },

  fetchWikipediaContent: function(place) {
    var $fullPlaceName = $('.content').attr('id');
    console.log(placeName);
    var placeName = $fullPlaceName.split(',')[0];

    console.log('Fetching wikipedia content');
    // debugger;
    $.ajax({
      url: 'http://en.wikipedia.org/w/api.php', 
      data: {
        action: 'parse',
        page: placeName,
        format: 'json',
        prop: 'text',
        section: 0
      },
      dataType: 'jsonp',
    }).done(historiaApp.processWikipediaContent);
  },

  processWikipediaContent: function (content) {
    console.log('Processing wikipedia content')
    var fetchedRawContent = content.parse.text['*'];
    var $createElement = $('<div>').html(fetchedRawContent);
    var $introContent = $createElement.find('p');
    // (/\[\d+\]/, '');
    $('.wiki-container').append($introContent);
  }
};

$(document).ready(function() {

  $('.current-place').on('click', historiaApp.sortLike);

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

  // Wikipedia Event
  historiaApp.fetchWikipediaContent();


});

