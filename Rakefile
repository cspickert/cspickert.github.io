require 'nanoc3/tasks'

require 'active_support/inflector'
require 'i18n'
require 'json'
require 'shellwords'

task :new_article do |t|
  # Get title and slug.
  title = (print "Title: "; STDIN.gets).chomp
  default_slug = title.parameterize
  slug = (print "Slug [#{default_slug}]: "; STDIN.gets).chomp
  slug = default_slug if slug.empty?

  # Create the article file.
  now = Time.now
  datestring = now.strftime("%Y/%m/%d")
  filename = "content/articles/#{datestring}/#{slug}.md"
  FileUtils.mkdir_p(File.dirname(filename))
  File.open(filename, "w+") do |f|
    f.write(<<END)
---
created_at: #{datestring.gsub("/", "-")}
kind: article
title: #{title.to_json}
---

END
  end

  # Edit the file.
  Kernel.exec ["mate", filename].shelljoin
end

### Git deployer

require 'git'

module Nanoc3::Extra::Deployers
  
  class Git
    
    def initialize
      error 'No site configuration found' unless File.file?('config.yaml')
      @site = Nanoc3::Site.new('.')
    end
    
    def run(params={})
      config_name = params.has_key?(:config_name) ? params[:config_name].to_sym : :default

      # Validate config
      error 'No deploy configuration found'                    if @site.config[:deploy].nil?
      error "No deploy configuration found for #{config_name}" if @site.config[:deploy][config_name].nil?
      
      src_branch = @site.config[:deploy][config_name][:src_branch]
      dst_branch = @site.config[:deploy][config_name][:dst_branch]
      dst_remote = @site.config[:deploy][config_name][:dst_remote]
      
      error 'No source branch found in deployment configuration' if src_branch.nil?
      error 'No destination branch found in deployment configuration' if dst_branch.nil?
      error 'No destination remote found in deployment configuration' if dst_remote.nil?
    
      git = ::Git::Base.open('.')
      
      # Remove the existing output directory (Nanoc3::Tasks::Clean currently only
      # removes the items, not the directories)
      puts "Removing output directory."
      FileUtils.rm_rf(@site.config[:output_dir])
      
      # Check out the source branch
      puts "Checking out #{src_branch}."
      git.checkout(src_branch)
      
      # Compile the site from scratch
      puts "Compiling site."
      @site.load_data
      @site.compiler.run
      
      # Check out the destination branch
      puts "Checking out destination branch."
      git.checkout(dst_branch)
      
      # Copy output files recursively into the current directory
      puts "Copying files."
      FileUtils.cp_r(@site.config[:output_dir].chomp('/') + '/.', '.')
      
      # Automatically add and commit changes
      puts "Committing changes."
      git.add
      git.commit("updated #{Time.now.to_s}", :add_all => true)
      
      # Push changes to the destination repo/branch
      puts "Pushing to #{dst_remote} #{dst_branch}."
      git.push(dst_remote, dst_branch)
      
      # Switch back to the source branch
      puts "Checking out #{src_branch}."
      git.checkout(src_branch)
    end
    
  private

    # Prints the given message on stderr and exits.
    def error(msg)
      raise RuntimeError.new(msg)
    end

    # Runs the given shell command. This is a simple wrapper around Kernel#system.
    def run_shell_cmd(args)
      system(*args)
      raise "command exited with a nonzero status code #{$?.exitstatus} (command: #{args.join(' ')})" if !$?.success?
    end

  end
  
end

namespace :deploy do
  
  desc 'Upload the compiled site using git'
  task :git do
    config_name = ENV['config'] || :default
    
    deployer = Nanoc3::Extra::Deployers::Git.new
    deployer.run(:config_name => config_name)
  end

end
