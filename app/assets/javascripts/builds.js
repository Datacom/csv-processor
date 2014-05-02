function runAfterFilesChange() {
  var upArrows   = $('.cp-build-file-field-row .cp-move-up:visible'),
      downArrows = $('.cp-build-file-field-row .cp-move-down:visible');

  // Enable all up arrows, disable the first one
  upArrows.removeClass('disabled').find('i').removeClass('fa-ban').addClass('fa-arrow-up');
  upArrows.first().addClass('disabled').find('i').removeClass('fa-arrow-up').addClass('fa-ban');

  // Enable all down arrows, disable the last one
  downArrows.removeClass('disabled').find('i').removeClass('fa-ban').addClass('fa-arrow-down');
  downArrows.last().addClass('disabled').find('i').removeClass('fa-arrow-down').addClass('fa-ban');

  // Show the field headers iff there are any rows
  $('#field-headers').toggle(!!$('.cp-build-file-field-row:visible').length);
}

function loadPreview() {
  // Load parameters from form
  var params = {},
      readers = [];

  $('form').find("input[name^='build[']").each(function() {
    var name = $(this).prop('name');

    if (name.match(/\[file\]$/)) {
      // This is a new file. We need to pass its contents back to the server
      var file   = $(this)[0].files[0],
          reader = new FileReader;
      readers.push(reader);

      params[name.replace('[file]', '[filename]')] = file.name;

      // FileReader is asynchronous. This is what to do when it finishes
      reader.onload = function(e) { 
        params[name.replace('[file]', '[raw]')] = reader.result;
        console.log(reader.result);
      };

      reader.readAsText(file); 
    } else
      // Other params can be passed back quite simply
      params[name] = $(this).val();
  });

  $('#cp-build-preview').load($('#cp-preview-build').data('url'), params);
}

// Attach events
$(function() {
  // Events are fired by clicks on specific elements, but because we're using turbolinks, they have to be attached to the
  // document.
  $(document).on('click', '#cp-preview-build', function() {
    $(this).find('i').addClass('fa-spinner fa-spin').removeClass('fa-search');
    loadPreview();
    $(this).find('i').removeClass('fa-spinner fa-spin').addClass('fa-search');
    event.preventDefault();
  });

  $(document).on('click', '.cp-expand-build', function() {
    $('#cp-build-' + $(this).data('build-id') + '-preview').fadeToggle();
    event.preventDefault();
  });

  // Event is fired by clicks on .cp-move-up, but is attached to the document so new .cp-move-ups also respond
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
    runAfterFilesChange();
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
    runAfterFilesChange();
    event.preventDefault();
  });

  $(document).on('cocoon:after-insert', '#cp-add-build-file', function() {
    var newPos = 0
    $("[name*='[position]']").each(function() {
      var thisPos = Number($(this).val());
      if (thisPos > newPos) newPos = thisPos;
    });
    $(this).prevAll('.cp-build-file-field-row').first().find("[name*='[position]']").val(newPos + 1);
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
