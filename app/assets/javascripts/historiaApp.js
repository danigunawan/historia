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
    // var $a = (this).attributes;
    // var id = $a.data.value;
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
      console.log('Like done?')
    });
  },
  unlikePlace: function (event) {
    event.preventDefault();
        // debugger;
    console.log('unlike');
    var id = this.id;
    var $that = $(this)
    $.ajax('/places/' + id + '/like', {
      type: 'DELETE',
      data: {
        _method: 'DELETE',
        type: 'unlike'
      }
    }).done(function(){
      $that.removeClass('like').addClass('unlike');
      $that.removeClass('fa-heart').addClass('fa-heart-o');
      console.log('Unlike done?')
    });
  }
};

$(document).ready(function() {

  $('.like').on('click', historiaApp.likePlace);
  $('.unlike').on('click', historiaApp.unlikePlace);

  // $('.unlike').on('click', function(event) {
  //   event.preventDefault();
  //   console.log('unlike click');
  //   var $a = (this).attributes;
  //   var id = $a.data.value;
  //   historiaApp.unlikePlace(id);
  // });

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

