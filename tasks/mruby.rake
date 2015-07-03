require 'fileutils'

namespace :mruby do
  rootdir = File.expand_path('../', File.dirname(__FILE__))
  dir = File.expand_path('vendor/mruby', rootdir)

  task :clean do
    sh %(make -C "#{dir}" clean)
  end

  task :clean_gems do
    FileUtils::Verbose.rm_rf(File.join(dir, 'build/mrbgems'))
  end

  task :deep_clean do
    FileUtils::Verbose.rm_rf(File.join(dir, 'build'))
  end

  task hard_clean: :deep_clean

  task :test do
    Dir.chdir dir do
      cmd = [%(MRUBY_CONFIG="#{rootdir}/mrb_config.rb"), "test"]
      cmd.unshift("--verbose") if Rake.verbose
      cmd.unshift("rake")
      sh cmd.join(" ")
    end
  end
end
