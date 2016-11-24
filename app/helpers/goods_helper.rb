module GoodsHelper
  include IssuesHelper

  def project_issue_options_for_select project
    Issue.where(:project_id => project).collect { |p| [ p.subject, p.id ] }
  end
end
