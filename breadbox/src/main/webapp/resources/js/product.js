// Image Preview
function triggerFileInput() {
    document.getElementById('upload').click();
 }

function previewImage(input) {
  var preview = document.getElementById('imagePreview');
  var cta = document.getElementById('cta');
  var file = input.files[0];
  var reader = new FileReader();

  reader.onloadend = function () {
    preview.src = reader.result;
    cta.classList.add('d-none');
    preview.classList.remove('d-none');
  };

  if (file) {
    reader.readAsDataURL(file);
  }
}
  
// Remove Image
function removeImage() {
  var removeBtn = document.getElementById('imgRemove');
  var preview = document.getElementById('imagePreview');
  document.getElementById('upload').value = '';
  document.getElementById('image').value = '';
  preview.src = '';
  preview.classList.add('d-none');
  cta.classList.remove('d-none');
}

// Add Listeners to increment buttons
var incrementButtons = document.getElementsByClassName('increment-button');
for (var i = 0; i < incrementButtons.length; i++) {
  incrementButtons[i].addEventListener('click', function() {
    var input = this.previousElementSibling;
    var count = parseInt(input.value);
    count += 1;
    input.value = count;
  });
}

// Add Listeners to decrement buttons
var decrementButtons = document.getElementsByClassName('decrement-button');
for (var i = 0; i < decrementButtons.length; i++) {
  decrementButtons[i].addEventListener('click', function() {
    var input = this.nextElementSibling;
    var count = parseInt(input.value);
    if (count > 1) {
      count -= 1;
      input.value = count;
    }
  });
}