var initializeMap = function () {
  var $container = $('.map')[0];

  var mapOptions = {
    zoom: 8,
    center: new google.maps.LatLng(-34.397, 150.644)
  }
  var map = new google.maps.Map($container, mapOptions);
};

var historiaApp = {
  likePlace: function (event) {
    event.preventDefault();
    console.log('like');

    var id = this.id;
    var $that = $(this)
    // debugger;
    $.ajax('/places/' + id + '/like', {
      type: 'POST',
      data: {
        type: 'like'
      }
    }).done(function(){
      $that.removeClass('fa-heart-o unlike').addClass('fa-heart like');
    });
  },

  unlikePlace: function (event) {
    event.preventDefault();
    console.log('unlike');

    var id = this.id;
    var $that = $(this)
    // debugger;
    $.ajax('/places/' + id + '/like', {
      type: 'DELETE',
      data: {
        _method: 'DELETE',
        type: 'unlike'
      }
    }).done(function(){
      $that.removeClass('fa-heart like').addClass('fa-heart-o unlike');
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

  $('.like').on('click', historiaApp.likePlace);
  $('.unlike').on('click', historiaApp.unlikePlace);
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

