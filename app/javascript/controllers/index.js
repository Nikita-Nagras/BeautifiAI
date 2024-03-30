// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
//

console.log("works")
document.addEventListener('DOMContentLoaded', function() {
  document.getElementById('generate-image').addEventListener('click', function(event) {
    console.log("generate btn was clicked")
    event.preventDefault(); // Prevent default form submission
    const cloth_image = document.getElementById('cloth_image');
    const style = document.getElementById('style').value;
    const prompt = document.getElementById('prompt').value;


    var data = new FormData()
    data.append('cloth_image', cloth_image.files[0])
    data.append('style', style)
    data.append('prompt', prompt)


    fetch(`pages/generate`, {
        "method": "POST",
        "body": data,
       })
      .then(response => response.json())
      .then(function(data){
          console.log(data)
        const img = document.createElement('img');
        img.setAttribute("src", "data:image/jpeg;base64, " + data.data)
        document.getElementById('result').append(img)
      }) // Handle the response data here
      .catch(error => console.error('Error:', error));
  });
});
