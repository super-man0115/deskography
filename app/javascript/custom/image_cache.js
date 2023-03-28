import $ from "jquery";

$(function() {
  $('input[type="file"]').on('change', function() {
    const file = this.files[0];
    
    if (file) {
      const reader = new FileReader();
      
      reader.onloadend = function () {
        const preview = $('#preview');
        
        if (preview.length) {
          preview.attr('src', reader.result);
        }
      }
      
      reader.readAsDataURL(file);
    }
  });
});
