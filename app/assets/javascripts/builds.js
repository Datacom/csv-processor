function previewBuild(buildId) {
  $('#build-' + buildId + '-preview').fadeToggle();
}

function moveUpBuildFile(buildFileIndex) {
  alert('Move up build file ' + buildFileIndex);
}

function moveDownBuildFile(buildFileIndex) {
  alert('Move down build file ' + buildFileIndex);
}

function removeBuildFile(buildFileIndex) {
  alert('Remove build file ' + buildFileIndex);
}

function addBuildFile() {
  alert('Add build file');
}
