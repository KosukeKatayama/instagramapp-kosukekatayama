import $ from 'jquery'
import axios from 'axios'
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken ()

document.addEventListener('turbolinks:load', () => {

  $('.active-heart').each(function(){
    const articleId = $(this).attr('id')
      const handleHeartDisplay = (hasLiked) => {
        if (hasLiked) {
          $(`#${articleId}.active-heart`).removeClass('hidden')
        } else {
          $(`#${articleId}.inactive-heart`).removeClass('hidden')
        }
      }

      axios.get(`/articles/${articleId}/like`)
      .then((response) => {
        const hasLiked = response.data.hasLiked
        handleHeartDisplay(hasLiked)
      })
  })

  $('.inactive-heart').on('click', function(){
    const articleId = $(this).attr('id')
    axios.post(`/articles/${articleId}/like`)
      .then((response) => {
        if (response.data.status === 'ok') {
          $(`#${articleId}.active-heart`).removeClass('hidden')
          $(`#${articleId}.inactive-heart`).addClass('hidden')
        }
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })

  $('.active-heart').on('click', function(){
    const articleId = $(this).attr('id')
    axios.delete(`/articles/${articleId}/like`)
      .then((response) => {
        if (response.data.status === 'ok') {
          $(`#${articleId}.inactive-heart`).removeClass('hidden')
          $(`#${articleId}.active-heart`).addClass('hidden')
        }
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })
})
