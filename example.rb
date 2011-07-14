require 'rubygems'
require 'lib/mira'
require 'yaml'

viddler = Mira::ViddlerClient.new(YAML.load(File.open("viddler.credentials")))
result = viddler.upload(File.new("sample.mov"),
                        :title => "sample",
                        :tags => "your mom",
                        :description => "whatever")
puts Mira::Viddler.embed_code(:id => result["video"]["id"])

