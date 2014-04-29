function previewBuild(buildId) {
  $('#cp-build-' + buildId + '-preview').fadeToggle();
}

function disableLastMoveButtons() {
  var upArrows = $('.cp-build-file-fields .cp-move-up'),
      downArrows = $('.cp-build-file-fields .cp-move-down');

  upArrows.removeClass('disabled').find('i').removeClass('fa-ban').addClass('fa-arrow-up');
  upArrows.first().addClass('disabled').find('i').removeClass('fa-arrow-up').addClass('fa-ban');

  downArrows.removeClass('disabled').find('i').removeClass('fa-ban').addClass('fa-arrow-down');
  downArrows.last().addClass('disabled').find('i').removeClass('fa-arrow-down').addClass('fa-ban');
}

$(function() {
  $('.cp-move-up').on('click', function() {
    var thisRow = $(this).closest('.cp-build-file-fields'),
        prevRow = thisRow.prevAll('.cp-build-file-fields').first(),
        thisPosField = thisRow.find('[name*="[position]"]'),
        prevPosField = prevRow.find('[name*="[position]"]'),
        thisPos = thisPosField.val(),
        prevPos = prevPosField.val();
    thisPosField.val(prevPos);
    prevPosField.val(thisPos);
    thisRow.detach().insertBefore(prevRow);
    disableLastMoveButtons();
  })

  $('.cp-move-down').on('click', function() {
    var thisRow = $(this).closest('.cp-build-file-fields'),
        nextRow = thisRow.nextAll('.cp-build-file-fields').first(),
        thisPosField = thisRow.find('[name*="[position]"]'),
        nextPosField = nextRow.find('[name*="[position]"]'),
        thisPos = thisPosField.val(),
        nextPos = nextPosField.val();
    thisPosField.val(nextPos);
    nextPosField.val(thisPos);
    thisRow.detach().insertAfter(nextRow);
    disableLastMoveButtons();
  })

  disableLastMoveButtons();
})
