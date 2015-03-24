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

  def commit(entries)
    index = repository.index

    entries.each do |entry|
      entry.__send__ :before_commit

      oid = repository.write(entry.content, :blob)
      index.add(path: entry.path, oid: oid, mode: 0100644)
    end

    options = {
      tree:       index.write_tree(repository),
      author:     { email: "foo@example.com", name: "foo", time: Time.now },
      comittor:   { email: "foo@example.com", name: "foo", time: Time.now },
      message:    "Hello, commit!",
      parents:    (repository.empty? ? [] : [repository.head.target].compact),
      update_ref: "HEAD",
    }

    Rugged::Commit.create(repository, options)
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
