#!/usr/bin/ruby

require 'yaml'
outfile = "fedora_srpm_deps.yml"

def repoquery(args)
  `repoquery --qf "%{name}" --enablerepo fedora-source,updates-source #{args}`.lines.map(&:chomp).uniq
end

common_deps = %w[ruby-devel rubygems-devel]

rubygems = repoquery('rubygem-*')

out = {}

rubygems.each_with_index do |rubygem, i|
  next if rubygem =~ /-doc\Z/
  gem = rubygem.sub(/\Arubygem-/,"")
  deps = repoquery("--srpm --requires #{rubygem}").find_all do |dep|
    dep =~ /-devel\Z/
  end - common_deps

  puts "#{i}/#{rubygems.length}"
  unless deps.empty?
    puts "gem #{gem} requires #{deps.join(", ")}"
    out[gem] = deps
  end
end

File.open(outfile, "w") { |f| f << YAML.dump(out) }
