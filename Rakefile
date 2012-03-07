task :default => :build_all

def run_command(cmd)
  cmdrun = IO.popen(cmd)
  output = cmdrun.read
  cmdrun.close
  if $?.to_i > 0
    puts "count not run #{cmd}, it returned an error #{output}"
    exit 2
  end
  puts "OK: ran command #{cmd}"
end

desc 'clean the gem'
task :clean_gem do
  run_command("rm -f pupstats*.gem")
end

desc 'build the gem'
task :build_gem do
  run_command("gem build pupstats.gemspec")
end

desc 'bundle for deployment'
task :bundle do
  run_command("bundle install")
end


desc 'vendorize for deployment'
task :vendorize do
  run_command("bundle install --deployment")
end

desc 'clean out vendor folder'
task :clean_vendor do
  run_command("rm -rf vendor")
end

desc 'TODO: get bundler working'
task :build_bundle => [:clean_gem, :bundle, :vendorize, :build_gem, :clean_vendor] do
  puts "Getting bundler ready"
end

desc 'build everything for deploy'
task :build_all => [:clean_gem, :build_gem, :clean_vendor] do
  puts "Doing everything necessary"
end
