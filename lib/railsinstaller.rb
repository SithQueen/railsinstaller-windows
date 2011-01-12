module RailsInstaller # Ensure that the RailsInstaller project root is defined.
  Root       = File.expand_path(File.join(File.dirname(__FILE__), ".."))
  Stage      = File.expand_path(File.join(Root, "stage"))
  Archives   = File.expand_path(File.join(Root, "archives"))
  PackageDir = File.expand_path(File.join(Root, "pkg"))
end

%w[ rubygems fileutils ostruct yaml erb uri open-uri open3 zip/zip ].each do |name|
  printf "Loading #{name}...\n" if $Flags[:verbose]
  require name
end

gem "rubyzip2", "~> 2.0.1"

%w[ globals ].each do |name|
  printf "Loading #{name}...\n" if $Flags[:verbose]
  require File.expand_path(File.join(RailsInstaller::Root,"lib", "setup", name +'.rb'))
end

%w[ stdlib ].each do |name|
  printf "Loading #{name}...\n" if $Flags[:verbose]
  require File.expand_path(File.join(RailsInstaller::Root,"lib", "extensions", name +'.rb'))
end

%w[ components methods downloads actions ].each do |name|
  printf "Loading #{name}...\n" if $Flags[:verbose]
  require File.expand_path(File.join(RailsInstaller::Root,"lib", "railsinstaller", name +'.rb'))
end

module RailsInstaller
  extend RailsInstaller::Utilities
  extend RailsInstaller::Downloads
end
