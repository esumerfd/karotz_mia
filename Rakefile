#!/usr/bin/env rake
require 'rake/packagetask'
require 'rake/clean'

CLEAN = ["pkg"]

Rake::PackageTask.new("mia", "1.0.0") do |p|
  p.need_zip = true
  p.package_files.include("config/descriptor.xml")
end

task :zip do
  mkdir_p "pkg/files"

  cp "config/descriptor.xml", "pkg/files"

  chdir("pkg/files") do
    sh %{zip ../mia.zip descriptor.xml}
  end

  rm_r "pkg/files"
end
