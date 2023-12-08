// Image Preview
function triggerFileInput() {
    document.getElementById('imageUpload').click();
  }

var preview = document.getElementById('imagePreview');
var current = document.getElementById('current');
var form = document.getElementById('form-btn');

function previewImage(input) {
  var file = input.files[0];
  var reader = new FileReader();

  reader.onloadend = function () {
    preview.src = reader.result;
    current.classList.add('d-none');
    preview.classList.remove('d-none');
    form.classList.remove('d-none');
  };

  if (file) {
    reader.readAsDataURL(file);
  }
}

// Discard Image
function discard() {
    preview.classList.add("d-none");
    current.classList.remove("d-none");
    form.classList.add('d-none');
}

// Load Modal
function loadUsernameModal(condition) {
  if(condition) {
    document.getElementById('editUsernameBtn').click();
  }
}

function loadPasswordModal(condition) {
  if(condition) {
    document.getElementById('changePasswordBtn').click();
  }
}