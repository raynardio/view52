$ ->
  window.search = (term) ->
    $.ajax "/search?term=#{encodeURIComponent(term)}"
    ,
      method: 'get'
      dataType: 'json'
      success: (result) ->
        console.log result
      error: (err) ->
        console.error err
