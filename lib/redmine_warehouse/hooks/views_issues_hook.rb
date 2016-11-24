module RedmineWarehouse
  module Hooks
    class ViewsIssuesHook < Redmine::Hook::ViewListener
      render_on :view_issues_show_details_bottom, :partial => "issues/goods"
    end
  end
end
