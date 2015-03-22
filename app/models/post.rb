class Post < ActiveRecord::Base
  validates :name, presence: true

  before_create :create_repository

  def repository
    @repository ||= Repository.new(self)
  end

  def entries
    @entries ||= repository.head_entries
  end

  private

    def create_repository
      repository.create!
    end
end
