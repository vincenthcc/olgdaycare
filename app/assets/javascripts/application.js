// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require_tree .
// require turbolinks

// toastr defaults
  toastr.options = {
    "closeButton": true,
    "extendedTimeOut": "1000",
    "hideDuration": "1000",
    "hideEasing": "linear",
    "hideMethod": "fadeOut",
    "showDuration": "5000",
    "showEasing": "swing",
    "showMethod": "fadeIn",
    "timeOut": "5000"
  }

// confirmation popups
  $( 'body' ).on( 'click', '[data-confirm-pop]', function(e){
    if( this.confirmed ){ return true; }
    var $this = $( this ),
        btn_text = $this.data( 'confirm-btn' );
    if( btn_text == '' ){ btn_text = 'Yes'; }
    swal(
      {
        title: $this.data( 'confirm-pop' ),
        icon: "warning",
        dangerMode: true,
        buttons: [
          true,
          {
            text: btn_text,
            closeModal: false
          },
        ],
        closeOnClickOutside: true,
        closeOnEsc: true
      }
    ).then(( value ) => {
      if( value === true ){
        $this[0].confirmed = true;
        $this[0].click();
      }
    })
    return false;
  })
