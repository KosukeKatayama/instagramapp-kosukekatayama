import $ from 'jquery'
import axios from 'axios'

// document.addEventListener('turbolinks:load', () => {
//   axios.put(`/profile/edit`)
//     .then((response) => {

//     })
// })

$(".profile-avatar").on("click", function(){
  $(".popup-overlay, .popup-content").addClass("active");
});

$(".close").on("click", function(){
  $(".popup-overlay, .popup-content").removeClass("active");
});