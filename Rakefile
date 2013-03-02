#!/usr/bin/env rake
require 'rake/packagetask'
require 'rake/clean'

CLEAN.include(["pkg"])

version = "1.0.0"

task :zip do
  mkdir_p "pkg/files"
  rm_f "pkg/mia.#{version}.zip"

  cp_r "app/*", "pkg/files"

  chdir("pkg/files") do
    sh %{zip ../mia.#{version}.zip *}
  end

  rm_r "pkg/files"
end
