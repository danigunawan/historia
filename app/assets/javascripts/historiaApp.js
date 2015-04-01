// window.onload = function() {
//   var startPos;

//   var geoSuccess = function(position) {
//     startPos = position;
//     var latitude = startPos.coords.latitude;
//     var longitude = startPos.coords.longitude;
//     $('.statLat').text(latitude);
//     $('.statLon').text(longitude);
//   };
//   navigator.geolocation.getCurrentPosition(geoSuccess);
// };

// var FlightRequest = {
//   "request": {
//     "passengers": {
//       "adultCount": 1
//     },
//     "slice": [
//     {
//       "origin": "LAX",
//       "destination": "SYD",
//       "date": "2015-14-07"
//     }
//     ]
//   }
// };

var initializeMap = function () {
  var styles = [{"featureType":"administrative","elementType":"all","stylers":[{"visibility":"on"},{"lightness":33}]},{"featureType":"landscape","elementType":"all","stylers":[{"color":"#f2e5d4"}]},{"featureType":"landscape.natural","elementType":"geometry","stylers":[{"color":"#f3ede3"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#c5dac6"}]},{"featureType":"poi.park","elementType":"labels","stylers":[{"visibility":"on"},{"lightness":20}]},{"featureType":"road","elementType":"all","stylers":[{"lightness":20}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#bfb9aa"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#e4d7c6"}]},{"featureType":"road.local","elementType":"geometry","stylers":[{"color":"#fbfaf7"}]},{"featureType":"water","elementType":"all","stylers":[{"visibility":"on"},{"color":"#97c8c6"}]}];

  var styledMap = new google.maps.StyledMapType(styles,
    {name: "Styled Map"});


  var latitude = $('.map').attr('data-latitude');
  var longitude = $('.map').attr('data-longitude');
  var $container = $('.map')[0];

  var mapOptions = {
    zoom: 8,
    center: new google.maps.LatLng(latitude, longitude),
    mapTypeControlOptions: {
      mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'map_style']
    }
  };
  var map = new google.maps.Map($container, mapOptions);

  map.mapTypes.set('map_style', styledMap);
  map.setMapTypeId('map_style');
}

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
    var $createElement = $('<div/>').html(fetchedRawContent);
    var $introContent = $createElement.find('p');
    $('.wiki-introduction').append($introContent);
  },

  processHistWikipediaContent: function (content) {
    var fetchedRawContent = content.parse.text['*'];
    var $createElement = $('<div/>').html(fetchedRawContent);
    var $histContent = $createElement.find('p');
    $('.wiki-history').append($histContent);
  // },

  // searchFlights: function () {
  //   $.ajax({
  //     url: 'https://www.googleapis.com/qpxExpress/v1/trips/search?key=AIzaSyAvR3BhgABRhezAKkvzbyI3FEjmvJcCfb4',
  //     type: 'POST',
  //     contentType: 'application/json',
  //     dataType: 'json',
  //     data: FlightRequest
  //   }).done(historiaApp.renderFlights);
  // },

  // renderFlights: function(flights) {
  //   console.log(flights);
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

  // Show/Hide social media share buttons
  $('.fa-share-alt').on('click', function() {
    $('.share-options').toggleClass('collapse');
  });

  initializeMap();
  // historiaApp.searchFlights();

  // Wikipedia Event
  historiaApp.fetchIntroWikipediaContent();
  historiaApp.fetchHistWikipediaContent();

});

