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
    } else {
      preview.src = "";
      preview.classList.add('d-none');
      cta.classList.remove('d-none')
    }
  }