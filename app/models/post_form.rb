class PostForm
  include ActiveModel::Model

  Invalid = Class.new(StandardError)

  attr_accessor :post, :description, :entries

  validates :entries, presence: true
  validate :entries_cant_be_empty

  class <<self
    def build_from_post(post)
      attributes = {
        post:         post,
        description:  post.description,
        entries:      post.entries,
      }

      new(attributes)
    end
  end

  def initialize(attributes = {})
    super(attributes)

    self.post ||= Post.new
    self.entries ||= new_record? ? [Entry.new] : []
  end

  def new_record?
    post.new_record?
  end

  def to_param
    post.to_param
  end

  def to_hash
    {
      description:  description,
      entries:      entries,
    }
  end

  def to_json
    to_hash.to_json
  end

  def entries_attributes=(attributes = {})
    self.entries = attributes.map do |(i, attrs)|
      Entry.new(attrs)
    end
  end

  concerning :Persistence do
    def update!(attributes = {})
      attributes.each do |attr, value|
        self.public_send("#{attr}=", value)
      end if attributes

      save!
    end

    def save!
      Post.transaction do
        validate!
        new_record? ? _create : _update
      end
    end

    private

      def _create
        save_post_record
        create_repository
        commit_entries
        true
      end

      def _update
        save_post_record
        commit_entries
        true
      end

      def save_post_record
        post.description = description
        post.save!
      end

      def create_repository
        post.repository.create!
      end

      def commit_entries
        post.repository.commit(entries)
      end
  end

  concerning :Validations do
    def validate!
      post.valid? && self.valid? || raise(Invalid)
    end

    private

      def entries_cant_be_empty
        if entries.any?(&:empty?)
          errors.add(:base, "Files can't be blank.")
        end
      end
  end
end
