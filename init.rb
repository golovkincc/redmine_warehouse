require 'redmine'
require 'redmine_warehouse/redmine_warehouse'

Redmine::Plugin.register :redmine_warehouse do
  name 'Redmine Warehouse plugin'
  author 'Sergey Golovkin'
  description 'Redmine Warehouse plugin for managing issue goods'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'https://golovkin.cc/about'

  project_module :redmine_warehouse do
    permission :add_goods, :goods => [:new, :create]
    permission :view_goods, :goods => [:index, :show]
    permission :edit_goods, :goods => [:update, :edit]
    permission :delete_goods, :goods => :destroy
  end
  menu :project_menu, :goods, { :controller => 'goods', :action => 'index' },
       :caption => :warehouse_title, :param => :project_id
end
