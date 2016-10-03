require "rake"

task :default do
  system('rake -T')
end

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end

require 'jars/installer'
task :install_jars do
  # If we don't have these env variables set, jar-dependencies will
  # download the jars and place it in $PWD/lib/. We actually want them in
  # $PWD/vendor
  ENV['JARS_HOME'] = Dir.pwd + "/vendor/jar-dependencies/runtime-jars"
  ENV['JARS_VENDOR'] = "false"
  Jars::Installer.vendor_jars!
end