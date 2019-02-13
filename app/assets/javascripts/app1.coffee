window.editNoteModal = (id) ->
  ajax
    url: "/note/#{id}"
    method: 'GET'
    success: (data) ->
      $('#modal-note-edit').html data
      initNoteModal id
      $('#modal-note').modal 'show'
    error: alert

window.editGoalModal = (id) ->
  ajax
    url: "/goal/#{id}"
    method: 'GET'
    success: (data) ->
      $('#modal-goal-edit').html data
      initGoalModal id
      $('#modal-goal').modal 'show'
    error: alert

$ ->
  $('a.note').click ->
    editNoteModal($(this).data 'id')
  $('a.goal').click ->
    editGoalModal($(this).data 'id')
