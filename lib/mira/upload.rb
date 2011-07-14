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
      uploaded = RestClient.post(endpoint,
                                 params.merge(:file => file,
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
      return @session_id if @session_id

      session_request = RestClient.get('http://api.viddler.com/api/v2/viddler.users.auth.json',
                                       :params => {:user => @username,
                                                   :password => @password,
                                                   :api_key => @api_key})
      @session_id = JSON.parse(session_request)["auth"]["sessionid"]
    end
    def initialize(credentials)
      @username = credentials[:username]
      @password = credentials[:password]
      @api_key = credentials[:api_key]
    end
  end
end

