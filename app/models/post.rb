class Post < ActiveRecord::Base
  validates :name, presence: true

  before_create :create_repository

  private

    def create_repository
      @repository = Repository.new(self).create!
    end
end
