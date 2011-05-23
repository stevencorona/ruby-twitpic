Gem::Specification.new do |s|
  s.name = %q{twitpic-full}
  s.version = "1.0.0"
  s.date = %q{2011-05-23}
  s.authors = ["Ryan LeFevre"]
  s.email = %q{meltingice8917@gmail.com}
  s.summary = %q{Provides full access to the TwitPic API, including photo uploads}
  s.homepage = %q{https://github.com/meltingice/TwitPic-API-for-Ruby}
  s.description = %q{Provides full and simple to use access to the TwitPic API, including photo uploads}
  s.files = Dir['lib/**/*.rb'].to_a
  s.add_dependency('nestful')
  s.add_dependency('json')
  s.add_dependency('roauth')
end