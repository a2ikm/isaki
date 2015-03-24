class Entry
  include ActiveModel::Model

  attr_accessor :path, :content

  def initialize(attributes = {})
    super
    @path ||= nil
    @content ||= nil
  end

  def to_h
    {
      "path"    => path,
      "content" => content,
    }
  end

  private

    def before_commit
      self.path = SecureRandom.hex + ".txt" if path.blank?
    end
end
