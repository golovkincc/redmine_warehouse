class Good < ActiveRecord::Base
  unloadable
  include Redmine::SafeAttributes

  belongs_to :issue

  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  validates_uniqueness_of :name
  validates_numericality_of :price
  validates_numericality_of :count

  scope :search, lambda {|name| where('name LIKE ?', "%#{name}%")}

  safe_attributes 'issue_id',
                  'name',
                  'price',
                  'count',
                  'manufacture_date'

  def safe_attributes=(attrs, user=User.current)
    return unless attrs.is_a?(Hash)

    attrs = attrs.deep_dup
    attrs = delete_unsafe_attributes(attrs, user)
    return if attrs.empty?

    # mass-assignment security bypass
    assign_attributes attrs, :without_protection => true
  end

  def self.visible?(project)
    self.allowed_to?(:view_goods, project)
  end

  def self.addable?(project)
    self.allowed_to?(:add_goods, project)
  end

  def self.editable?(project)
    self.allowed_to?(:edit_goods, project)
  end

  def self.deletable?(project)
    self.allowed_to?(:delete_goods, project)
  end

  def self.allowed_to?(action, project)
    User.current.allowed_to?(action, project)
  end
end
