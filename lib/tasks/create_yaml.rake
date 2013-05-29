namespace :kanban do
  desc "set up database yaml"
  task :create_yml do
    db = ENV["DB"] || 'mysql'
    template_database_config = Rails.root.join("config","datbase.yml.#{db}")
    datbase_config = Rails.root.join("config","datbase.yml")
    if !File.exists?(datbase_config)
      cp template_database_config,datbase_config
    else
      puts "#{database_config} already exists"
    end
  end
end