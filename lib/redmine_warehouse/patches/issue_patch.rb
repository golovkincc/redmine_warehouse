require_dependency 'issue'

module RedmineWarehouse
  module Patches

    module IssuePatch
      def self.included(base) # :nodoc:
        base.class_eval do
          unloadable # Send unloadable so it will not be unloaded in development

          if ActiveRecord::VERSION::MAJOR >= 4
            has_many :goods,  lambda { order("#{Good.table_name}.name") }, :class_name => "Good",
                     :dependent => :destroy, :inverse_of => :issue
          else
            has_many :goods, :class_name => "Good", :dependent => :destroy, :inverse_of => :issue,
                     :order => 'name'
          end
        end
      end
    end
  end
end

unless Issue.included_modules.include?(RedmineWarehouse::Patches::IssuePatch)
  Issue.send(:include, RedmineWarehouse::Patches::IssuePatch)
end
