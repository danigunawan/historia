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
    var id = $element.attr("id");
    $.ajax('/places/' + id + '/like', {
      type: 'DELETE',
      data: {
        _method: 'DELETE',
        type: 'unlike'
      }
    }).done(function(){
      $element.removeClass('fa-heart unlike').addClass('fa-heart-o like');
    });
  },

  fetchIntroWikipediaContent: function(place) {
    var $fullPlaceName = $('.content').attr('id');
    var placeName = $fullPlaceName.split(',')[0];

    console.log('Fetching intro wikipedia content');
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
    }).done(historiaApp.processIntroWikipediaContent);
  },
  fetchHistWikipediaContent: function(place) {
    var $fullPlaceName = $('.content').attr('id');
    var placeName = $fullPlaceName.split(',')[0];

    console.log('Fetching history wikipedia content');
    $.ajax({
      url: 'http://en.wikipedia.org/w/api.php', 
      data: {
        action: 'parse',
        page: placeName,
        format: 'json',
        prop: 'text',
        section: 1
      },
      dataType: 'jsonp',
    }).done(historiaApp.processHistWikipediaContent);
  },

  processIntroWikipediaContent: function (content) {
    var fetchedRawContent = content.parse.text['*'];
    var $createElement = $('<div>').html(fetchedRawContent);
    var $introContent = $createElement.find('p');
    // (/\[\d+\]/, '');
    $('.wiki-introduction').append($introContent);
  },
    processHistWikipediaContent: function (content) {
    var fetchedRawContent = content.parse.text['*'];
    var $createElement = $('<div>').html(fetchedRawContent);
    var $histContent = $createElement.find('p');
    // (/\[\d+\]/, '');
    $('.wiki-history').append($histContent);
  }
};

$(document).ready(function() {

  // Like/Unlike a place
  $('.current-place').on('click', historiaApp.sortLike);

  // Display signin/signup popup 
  $('.fa-bars').on('click', function() {
    $('.fa-bars').addClass('hide');
    $('.login-overlay').addClass('show');
    $('.main-nav').addClass('show');
  });

  // Hide signin/signup popup 
  $('.fa-close').on('click', function() {
    $('.login-overlay').removeClass('show');
    $('.main-nav').removeClass('show');
    $('.fa-bars').removeClass('hide');
  });

  $('.fa-share-alt').on('click', function() {
    console.log('toggling????')
    $('.share-options').toggleClass('collapse');
  });

  initializeMap();

  // Wikipedia Event
  historiaApp.fetchIntroWikipediaContent();
  historiaApp.fetchHistWikipediaContent();

});

