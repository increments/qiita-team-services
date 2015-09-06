require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"
require "yard"

YARD_DIR = ".publish"

RuboCop::RakeTask.new
RSpec::Core::RakeTask.new
YARD::Rake::YardocTask.new do |t|
  t.options = ["--output-dir=#{YARD_DIR}"]
end

task default: [:rubocop, :spec]

task "deploy-gh-pages" => :yard do
  Dir.chdir YARD_DIR do
    sh "git init"
    sh "git config user.name qiitan"
    sh "git config user.email info@qiita.com"
    sh "git add ."
    sh "git commit -m 'Deployed to GitHub pages'"
    sh "git remote add origin \"https://${GH_TOKEN}@${GH_REF}\""
    sh "git push -f -q origin master:gh-pages > /dev/null 2>&1"
  end
end
