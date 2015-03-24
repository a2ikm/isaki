class Post < ActiveRecord::Base
  before_create :initialize_name
  before_create :create_repository
  after_save :commit_entries

  def to_param
    name
  end

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
    }
  end

  def title
    if entry = entries.find { |e| e.path.present? }
      entry.path
    else
      "post:#{name}"
    end
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
