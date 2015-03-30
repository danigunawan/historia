// var initializeMap = function () {
//   var $container = $('.map')[0];

//   var mapOptions = {
//     zoom: 8,
//     center: new google.maps.LatLng(-34.397, 150.644)
//   }
//   var map = new google.maps.Map($container, mapOptions);
// };

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
  }
};

$(document).ready(function() {

  $('.like').on('click', historiaApp.likePlace);
  $('.unlike').on('click', historiaApp.unlikePlace);

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


  // initializeMap();

});

