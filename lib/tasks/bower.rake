namespace :bower do
  desc "Run `bower install --production`"
  task :install do
    sh "./node_modules/bower/bin/bower install --production"
  end
end

task "assets:precompile" => ["bower:install"]
