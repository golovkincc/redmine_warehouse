require File.expand_path('../../test_helper', __FILE__)

class GoodsControllerTest < ActionController::TestCase
  fixtures :projects,
           :users,
           :roles,
           :members,
           :member_roles,
           :issues,
           :issue_statuses,
           :versions,
           :trackers,
           :projects_trackers,
           :issue_categories,
           :enabled_modules,
           :enumerations,
           :attachments,
           :workflows,
           :custom_fields,
           :custom_values,
           :custom_fields_projects,
           :custom_fields_trackers,
           :time_entries,
           :journals,
           :journal_details,
           :queries

  RedmineWarehouse::TestCase.create_fixtures(Redmine::Plugin.find(:redmine_warehouse).directory + '/test/fixtures/', [:goods])

  def setup
    RedmineWarehouse::TestCase.prepare

    @controller = GoodsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    User.current = nil
  end

  test "should get index in project" do
    @request.session[:user_id] = 1
    Setting.default_language = 'ru'

    get :index, :project_id => 1
    assert_response :success
    assert_template :index
    assert_not_nil assigns(:goods)
    assert_not_nil assigns(:project)
  end

  test "should get show in project" do
    @request.session[:user_id] = 1
    Setting.default_language = 'ru'

    get :show, :id => 1, :project_id => 1
    assert_response :success
    assert_template :show
    assert_not_nil assigns(:good)
    assert_not_nil assigns(:project)
    assert_select 'h2', :html => /iPhone #1/
  end
end
