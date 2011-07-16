require 'rubygems'
require 'lib/mira'
require 'yaml'

test_run = "beta"
20.times do |iteration|
  description = <<-DESCRIPTION
    Sorry Viddler, your API v1 servers are sufficiently unstable that I need to
    load test your v2 servers. Please contact me directly if this is a problem.
    My name's Giles Bowkett, my e-mail address is gilesb@gmail.com, and my cell
    number is 213-247-9477. I have limited my script to only perform one test
    upload every 2 seconds, to accomodate your request of one API call per second
    as documented here: http://developers.viddler.com/documentation/api/

    Upload test attempt number #{test_run}-#{iteration}.
  DESCRIPTION
  viddler = Mira::ViddlerClient.new(YAML.load(File.open("viddler.credentials")))
  result = viddler.upload(File.new("sample.mov"),
                          :title => "upload #{iteration}",
                          :tags => "upload load test",
                          :description => description,
                          :make_public => "0")
  puts result.inspect
  sleep 2
end

