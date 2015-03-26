class Entry
  include ActiveModel::Model

  attr_accessor :path, :content, :oid, :filemode, :repository

  validates :content, presence: true

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

  def empty?
    content.blank?
  end

  def language
    @language ||= detect_language
  end

  private

    def before_commit
      self.path = SecureRandom.hex + ".txt" if path.blank?
    end

    def detect_language
      return Linguist::Language["Text"].name unless repository

      Linguist::LazyBlob.new(
        repository,
        oid,
        path,
        filemode
      ).language.name
    end
end
