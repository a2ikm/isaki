class Post < ActiveRecord::Base
  validates :description, presence: true

  before_create :initialize_name
  before_create :create_repository
  after_save :commit_entries

  def repository
    @repository ||= Repository.new(self)
  end

  def entries
    @entries ||= repository.head_entries
  end

  def entries=(entries)
    @entries = entries
  end

  def entries_attributes=(attributes)
    self.entries = attributes.map { |(i, attrs)|
      Entry.new(attrs)
    }.select { |entry|
      entry.present?
    }
  end

  private

    require "securerandom"

    def initialize_name
      self.name = SecureRandom.hex
    end

    def create_repository
      repository.create!
    end

    def commit_entries
      repository.commit(entries)
    end
end
