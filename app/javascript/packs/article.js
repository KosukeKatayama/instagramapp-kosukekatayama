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

      axios.get(`/api/articles/${articleId}/like`)
      .then((response) => {
        const hasLiked = response.data.hasLiked
        handleHeartDisplay(hasLiked)
      })
  })

  $('.inactive-heart').on('click', function(){
    const articleId = $(this).attr('id')
    axios.post(`/api/articles/${articleId}/like`)
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
    axios.delete(`/api/articles/${articleId}/like`)
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

  // comment--------------------------------------------------------------------------------------------------

  const dataset = $('#comment').data()
  const articleId = dataset.articleId

  axios.get(`/api/articles/${articleId}/comments`)
  .then((res) => {
    const comment = res.data
    comment.forEach((comment) => {
      $('.comment-container').append(
        `<div class="comment-page">
          <img class="avatar-tertiary" src="${comment.user.comment_avatar_image}">
          <div>
            <div class="article-comment"><p class="comment-page_username">${comment.user.username}</p></div>
            <div class="article-comment"><p class="comment-page_content">${comment.content}</p></div>
          <div/>
        </div>`
      )
    })
  })

  $('.comment-btn').on('click', () => {
    const content = $('#comment_content').val()
    if (!content) {
      window.alert('コメントを入力してください')
    } else {
      axios.post(`/api/articles/${articleId}/comments`, {
        comment: {content: content}
      })
        .then((res) => {
          const comment = res.data
          $('.comment-container').append(
            `<div class="comment-page">
              <img class="avatar-tertiary" src="${comment.user.comment_avatar_image}">
              <div>
                <div class="article-comment"><p class="comment-page_username">${comment.user.username}</p></div>
                <div class="article-comment"><p class="comment-page_content">${comment.content}</p></div>
              <div/>
            </div>`
          )
          console.log(res)
          $('#comment_content').val('')
        })
        .catch((e) => {
          console.log(e)
        })
    }
  })
})

