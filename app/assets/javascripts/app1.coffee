window.editNoteModal = (id) ->
  ajax
    url: "/note/#{id}"
    method: 'GET'
    success: (data) ->
      $('#modal-note-edit').html data
      initNoteModal id
      $('#modal-note').modal 'show'
    error: alert
