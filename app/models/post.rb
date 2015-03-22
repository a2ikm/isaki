class Post < ActiveRecord::Base
  validates :name, presence: true

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

  private

    def create_repository
      repository.create!
    end

    def commit_entries
      repository.commit(entries)
    end
end
