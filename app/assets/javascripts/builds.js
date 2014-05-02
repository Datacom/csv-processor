function runAfterFilesChange() {
  var upArrows   = $('.cp-input-file-field-row .cp-move-up:visible'),
      downArrows = $('.cp-input-file-field-row .cp-move-down:visible');

  // Enable all up arrows, disable the first one
  upArrows.removeClass('disabled').find('i').removeClass('fa-ban').addClass('fa-arrow-up');
  upArrows.first().addClass('disabled').find('i').removeClass('fa-arrow-up').addClass('fa-ban');

  // Enable all down arrows, disable the last one
  downArrows.removeClass('disabled').find('i').removeClass('fa-ban').addClass('fa-arrow-down');
  downArrows.last().addClass('disabled').find('i').removeClass('fa-arrow-down').addClass('fa-ban');

  // Show the field headers iff there are any rows
  $('#field-headers').toggle(!!$('.cp-input-file-field-row:visible').length);
}

// Attach events
$(function() {
  $(document).on('click', '.cp-expand-build', function() {
    $('#cp-build-' + $(this).data('build-id') + '-preview').fadeToggle();
    event.preventDefault();
  });

  // Event is fired by clicks on .cp-move-up, but is attached to the document so new .cp-move-ups also respond
  $(document).on('click', '.cp-move-up', function() {
    var thisRow      = $(this).closest('.cp-input-file-field-row'),
        prevRow      = thisRow.prevAll('.cp-input-file-field-row').first(),
        thisPosField = thisRow.find('[name*="[position]"]'),
        prevPosField = prevRow.find('[name*="[position]"]'),
        thisPos      = thisPosField.val(),
        prevPos      = prevPosField.val();
    thisPosField.val(prevPos);
    prevPosField.val(thisPos);
    thisRow.detach().insertBefore(prevRow);
    runAfterFilesChange();
    event.preventDefault();
  });

  $(document).on('click', '.cp-move-down', function() {
    var thisRow      = $(this).closest('.cp-input-file-field-row'),
        nextRow      = thisRow.nextAll('.cp-input-file-field-row').first(),
        thisPosField = thisRow.find('[name*="[position]"]'),
        nextPosField = nextRow.find('[name*="[position]"]'),
        thisPos      = thisPosField.val(),
        nextPos      = nextPosField.val();
    thisPosField.val(nextPos);
    nextPosField.val(thisPos);
    thisRow.detach().insertAfter(nextRow);
    runAfterFilesChange();
    event.preventDefault();
  });

  $(document).on('cocoon:after-insert', '#cp-add-input-file', function() {
    var newPos = 0
    $("[name*='[position]']").each(function() {
      var thisPos = Number($(this).val());
      if (thisPos > newPos) newPos = thisPos;
    });
    $(this).prevAll('.cp-input-file-field-row').first().find("[name*='[position]']").val(newPos + 1);
    runAfterFilesChange();
  });

  $(document).on('cocoon:after-remove', '#content', function() {
    runAfterFilesChange();
  });
  
  $(document).on('page:load', function() {
    runAfterFilesChange();
  });

  runAfterFilesChange();
})
