$(document).on('submit', '#comment-form', function(event) {
  event.preventDefault();
  $.ajax({
    type: 'POST',
    url: $(this).attr('action'),
    data: $(this).serialize(),
    dataType: 'script'
  });
});
