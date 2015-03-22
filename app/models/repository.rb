class Repository
  attr_reader :post, :repository

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
    post.persisted? && path.exist?
  end

  def create!
    raise AlreadyCreated if exist?

    @repository = Rugged::Repository.init_at(path.to_s, :base)
    self
  end

  def head_entries
    entries = []
    return entries unless exist?

    repository.head.target.tree.each_blob do |entry|
      entries << Entry.new(
        path:     entry[:name],
        content:  repository.lookup(entry[:oid]).content.force_encoding("UTF-8")
      )
    end

    entries
  end
end
