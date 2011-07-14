Mira
====

Mira is a minimal Viddler client. I named it Mira because I had just created another gem with a Spanish name (buscando_el_viento) and I figured I might as well keep the momentum going. "Mira" in Spanish means "look."

I created Mira because the official Viddler gem `viddler-ruby` didn't work out of the box, and fixing whatever was wrong with it seemed like a lot more work than just writing my own.

Mira supports only a tiny subset of the Viddler API's functionality - namely the ability to upload a video, and the ability to obtain an existing video's Flash video player embed code.

code copying
------------

embed code copied from the original `viddler` gem (which was not actually written by Viddler); upload functionality and specs adapted from Viddler's official `viddler-ruby` gem.

test it out
-----------

create a `viddler.credentials` yaml file:

    :api_key: 1234123412341234
    :username: your_username
    :password: your_password

use the `example.rb` script, or, to see every single step, pop into IRB and do this manually:

    # setup
    require 'yaml'
    viddler = Mira::ViddlerClient.new(YAML.load(File.open("viddler.credentials")))

    # optional, just if you want to see everything happen
    viddler.auth
    viddler.get('viddler.videos.prepareUpload')

    # money shot
    viddler.upload(File.new("sample.mov"),
                   :title => "sample",
                   :tags => "your mom",
                   :description => "whatever")

some or all of `:title`, `:tags`, and `:description` are required. API docs are not forthcoming on the subject and I couldn't care less. just throw them all in there and it'll work.

note that after uploading, Viddler will lag before displaying your video, and will not display any kind of "uploaded but still processing..." message. so you basically have to wait a minute with your dick in your hand.

TODO
====

add specs about that whole requiring title, tags, and/or description shit.

