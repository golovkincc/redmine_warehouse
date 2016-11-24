Rails.configuration.to_prepare do
  require 'redmine_warehouse/hooks/views_issues_hook'

  require 'redmine_warehouse/patches/issue_patch'
end
