module ApplicationHelper
  def modal_options(title, partial, id=nil, dismiss_text=nil, okay_text=nil)
    {
      options: {
        title: title,
        partial: partial,
        id: id,
        dismiss_text: dismiss_text,
        okay_text: okay_text
      }
    }

  end

  def note_modal_options
    modal_options(
      title = I18n.t(:create_note),
      partial = 'shared/modal_text_form',
      id = 'note-modal',
      dismiss_text = I18n.t(:cancel),
      okay_text = I18n.t(:save)
    )
  end
end
