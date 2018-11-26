namespace :view52 do
  desc "Index all searchable items into elasticsearch"
  task global_index: :environment do
    to_index = [:goals, :roles, :role_categories, :notes, :tags]
    gs = GlobalSearch.new
    User.all.find_each do |user|
      to_index.each do |attr|
        user.send(attr).find_each do |item|
          gs.put_global_item item
        end
      end
    end
  end

  desc 'Fetch Google Calendar events'
  task fetch_calendar: :environment do
    user = User.find ENV['USER_ID']
    gc = GoogleCalendar.new user
    cals = gc.calendars
    cals.items.each do |cal|
      puts "#{cal.summary}:"
      gc.events(cal.id).items.each do |event|
        puts "  -> #{event.summary}"
        user.calendar_events.create!({
            event_type: 'google',
            event_id: event.id,
            title: event.summary,
            description: event.description,
            start_date: event.start.date_time,
            end_date: event.end.date_time,
            html_link: event.html_link
        })
      rescue ActiveRecord::RecordNotUnique
        puts '  **  Already added'
      end
    end
  end
end
