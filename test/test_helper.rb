# Load the Redmine helper
require File.expand_path(File.dirname(__FILE__) + '/../../../test/test_helper')

class RedmineWarehouse::TestCase
  include ActionDispatch::TestProcess
  def self.plugin_fixtures(plugin, *fixture_names)
    plugin_fixture_path = "#{Redmine::Plugin.find(plugin).directory}/test/fixtures"
    if fixture_names.first == :all
      fixture_names = Dir["#{plugin_fixture_path}/**/*.{yml}"]
      fixture_names.map! { |f| f[(plugin_fixture_path.size + 1)..-5] }
    else
      fixture_names = fixture_names.flatten.map { |n| n.to_s }
    end

    ActiveRecord::Fixtures.create_fixtures(plugin_fixture_path, fixture_names)
  end

  def self.is_arrays_equal(a1, a2)
    (a1 - a2) - (a2 - a1) == []
  end

  def self.create_fixtures(fixtures_directory, table_names, class_names = {})
    if ActiveRecord::VERSION::MAJOR >= 4
      ActiveRecord::FixtureSet.create_fixtures(fixtures_directory, table_names, class_names)
    else
      ActiveRecord::Fixtures.create_fixtures(fixtures_directory, table_names, class_names)
    end
  end

  def self.prepare
    # User 2 Manager (role 1) in project 1, email jsmith@somenet.foo
    # User 3 Developer (role 2) in project 1

    Role.where(:id => [1, 2, 3, 4]).each do |r|
      r.permissions << :view_goods
      r.save
    end

    Role.where(:id => [1, 2]).each do |r|
      #user_2, user_3
      r.permissions << :add_goods
      r.save
    end

    Role.where(:id => [1, 2]).each do |r|
      r.permissions << :edit_goods
      r.save
    end

    Project.where(:id => [1, 2, 3, 4, 5]).each do |project|
      EnabledModule.create(:project => project, :name => 'redmine_warehouse')
    end
  end
end
