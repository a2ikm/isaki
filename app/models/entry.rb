class Entry
  include ActiveModel::Model

  attr_accessor :path, :content

  def present?
    path.present?
  end
end
