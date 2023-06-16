# fluent-plugin-logplex-splitter

[Fluentd](fluentd.org) output plugin to process [HTTPS drained logs from Heroku Logplex](https://devcenter.heroku.com/ja/articles/log-drains#https-drains).  


The logs obtained from the Logplex HTTPS dorain are not sent line-by-line; rather, multiple logs are transmitted in batches. To transform these batches into a single log entry per line, some processor is needed, and this plugin is the processor.  

## Installation


### Bundler

Add following line to your Gemfile:

```ruby
gem "fluent-plugin-logplex-splitter", git: 'https://github.com/rnitta/fluent-plugin-logplex-splitter'
```

And then execute:

```
$ bundle i
```

## Configuration
`@type logplex_splitter` as output plugin.

To change tag, you can use `<add|remove>_tag_<pre|suf>fix` or `tag`.
With `tag` directive, you can [use placeholders](https://github.com/y-ken/fluent-mixin-rewrite-tag-name#placeholders). 

## Example

working example (2023/06)

```
<source>
  @type http
  port "#{ENV['PORT']}"
  keepalive_timeout 10s
  <parse>
    @type none
  </parse>
</source>

<match logplex.example.**>
  @type logplex_splitter
  remove_tag_prefix logplex.
  input_key message
</match>


<match example.**>
  @type stdout
</match>
```

## Copyright

* Copyright(c) 2023- rnitta
* License
  * Apache License, Version 2.0
