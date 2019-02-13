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

window.editLifeEventModal = (id) ->
  ajax
    url: "/life_event/#{id}"
    method: 'GET'
    success: (data) ->
      $('#modal-life-event-edit').html data
      initLifeEventModal id
      $('#modal-life-event').modal 'show'
    error: alert

$ ->
  $('a.note').click ->
    editNoteModal($(this).data 'id')
  $('a.goal').click ->
    editGoalModal($(this).data 'id')
  $('a.life-event').click ->
    editLifeEventModal($(this).data 'id')
