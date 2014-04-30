function disableEndMoveButtons() {
  var upArrows = $('.cp-build-file-field-row .cp-move-up'),
      downArrows = $('.cp-build-file-field-row .cp-move-down');

  upArrows.removeClass('disabled').find('i').removeClass('fa-ban').addClass('fa-arrow-up');
  upArrows.first().addClass('disabled').find('i').removeClass('fa-arrow-up').addClass('fa-ban');

  downArrows.removeClass('disabled').find('i').removeClass('fa-ban').addClass('fa-arrow-down');
  downArrows.last().addClass('disabled').find('i').removeClass('fa-arrow-down').addClass('fa-ban');
}

function loadPreview() {
  var params = {};
  $('form').find('input').each(function() {
    var name = $(this).prop('name');
    if (name.match(/^build\[/)) params[name] = $(this).val();
  });
  $.get($('#cp-preview-build').data('url'), params).done(function(data) {
    $('#cp-build-preview').html(data);
  })
}

$(function() {
  $('#cp-preview-build').on('click', function() {
    loadPreview();
    event.preventDefault();
  });

  $('.cp-expand-build').on('click', function() {
    $('#cp-build-' + $(this).data('build-id') + '-preview').fadeToggle();
    event.preventDefault();
  });

  // Event is fired by clicks on .cp-move-up, but is attached to the document so 
  $(document).on('click', '.cp-move-up', function() {
    var thisRow      = $(this).closest('.cp-build-file-field-row'),
        prevRow      = thisRow.prevAll('.cp-build-file-field-row').first(),
        thisPosField = thisRow.find('[name*="[position]"]'),
        prevPosField = prevRow.find('[name*="[position]"]'),
        thisPos      = thisPosField.val(),
        prevPos      = prevPosField.val();
    thisPosField.val(prevPos);
    prevPosField.val(thisPos);
    thisRow.detach().insertBefore(prevRow);
    disableEndMoveButtons();
    event.preventDefault();
  });

  $(document).on('click', '.cp-move-down', function() {
    var thisRow      = $(this).closest('.cp-build-file-field-row'),
        nextRow      = thisRow.nextAll('.cp-build-file-field-row').first(),
        thisPosField = thisRow.find('[name*="[position]"]'),
        nextPosField = nextRow.find('[name*="[position]"]'),
        thisPos      = thisPosField.val(),
        nextPos      = nextPosField.val();
    thisPosField.val(nextPos);
    nextPosField.val(thisPos);
    thisRow.detach().insertAfter(nextRow);
    disableEndMoveButtons();
    event.preventDefault();
  });

  $('#cp-add-build-file').on('cocoon:after-insert', function() {
    var newPos = 0
    $("[name*='[position]']").each(function() {
      var thisPos = Number($(this).val());
      if (thisPos > newPos) newPos = thisPos;
    });
    $(this).prevAll('.cp-build-file-field-row').first().find("[name*='[position]']").val(newPos + 1);
    disableEndMoveButtons();
  });

  $('#content').on('cocoon:after-remove', function() {
    disableEndMoveButtons();
  });
  
  disableEndMoveButtons();
})
