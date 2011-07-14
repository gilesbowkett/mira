module Mira
  class ViddlerClient

    # there's a certain amount of stupidity in this code, because I built it
    # against specs cribbed from the official Viddler gem, which supports a
    # much broader range of functionality, so this code uses a slightly bloated
    # set of assumptions. however, working against those Ruby specs to create
    # a slightly bloated implementation seemed less painful than sorting out
    # their API. I don't think they've heard of REST, to be honest with you.

    def upload(file, params)
      json = self.get('viddler.videos.prepareUpload')
      endpoint = json["upload"]["endpoint"]
      uploaded = RestClient.post(endpoint, params.merge(:file => file,
                                                        :sessionid => auth,
                                                        :api_key => @api_key))
      JSON.parse uploaded
    end
    def get(api_method, params)
      auth
      upload_base = 'http://api.viddler.com/api/v2/'
      JSON.parse RestClient.get(upload_base, :params => params)
    end
    def auth
      # FIXME: use VIDDLER_CREDENTIALS, but make it a hash, not a fucking array (wtf)
      # RestClient.get(url) # url is defined in the comment on the pending spec for this
    end
    def initialize(credentials)
      @username = credentials[:username]
      @password = credentials[:password]
      @api_key = credentials[:api_key]
    end
  end
end

