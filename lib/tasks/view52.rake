namespace :view52 do
  desc "Index all searchable items into elasticsearch"
  task global_index: :environment do
    to_index = [:goals, :roles, :role_categories, :notes, :tags]
    gs = GlobalSearch.new
    User.all.find_each do |user|
      # gs.put_global_item user
      to_index.each do |attr|
        user.send(attr).find_each do |item|
          gs.put_global_item item
        end
      end
    end
  end
end
