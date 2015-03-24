class Post < ActiveRecord::Base
  before_create :initialize_name

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
end
