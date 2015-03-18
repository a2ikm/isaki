class Repository
  attr_reader :post

  AlreadyCreated = Class.new(StandardError)

  def self.path
    @path ||= Rails.root.join("repositories").tap do |dir|
      require "fileutils"
      FileUtils.mkdir_p(dir.to_s)
    end
  end

  def initialize(post)
    @post = post
    @repository = Rugged::Repository.new(path.to_s) if exist?
  end

  def path
    @path ||= self.class.path.join(post.name + ".git")
  end

  def exist?
    path.exist?
  end

  def create!
    raise AlreadyCreated if exist?

    @repository = Rugged::Repository.init_at(path.to_s, :base)
    self
  end
end
