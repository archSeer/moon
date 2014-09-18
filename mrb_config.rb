MRuby::Build.new do |conf|
  toolchain :gcc

  # include the default GEMs
  conf.gembox 'default'

  conf.gem core: 'mruby-string-utf8'
  conf.gem core: 'mruby-eval'

  # Temporary custom solution. If we end up
  # creating a custom gem, make a gem folder
  # in moon root and put it there.
  # because Speedy won't update his Fork
  #conf.gem github: 'archSeer/mruby-require'
  # We will use IceDragon's Spoon!
  conf.gem github: 'IceDragon200/mruby-require'

  # so we can have nice things
  #conf.gem github: "AndrewBelt/mruby-yaml"
  # Due to an upstream error in the YAML.load when given an empty string:
  conf.gem github: 'IceDragon200/mruby-yaml'

  conf.gem github: "iij/mruby-io"
  conf.gem github: "iij/mruby-dir"
  conf.gem github: "iij/mruby-regexp-pcre"
end
