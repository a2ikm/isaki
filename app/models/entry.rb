class Entry
  include ActiveModel::Model

  attr_accessor :path, :content

  def initialize(attributes = {})
    super
    @path ||= nil
    @content ||= nil
  end

  def present?
    path.present?
  end
end
