#!/usr/bin/env rake
require 'rake/packagetask'
require 'rake/clean'

CLEAN.include(["pkg"])

version = "1.0.0"

task :default do
  puts "Must run with bundle exec"
end

task :zip do
  mkdir_p "pkg/files"
  rm_f "pkg/mia.#{version}.zip"

  cp_r FileList["app/*"], "pkg/files", :verbose => true

  chdir("pkg/files") do
    sh %{zip ../mia.#{version}.zip *}
  end

  rm_r "pkg/files"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:test)
