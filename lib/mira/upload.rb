module Mira
  class ViddlerClient

    # there's a certain amount of stupidity in this code, because I built it
    # against specs cribbed from the official Viddler gem, which supports a
    # much broader range of functionality, so this code uses a slightly inflated
    # set of assumptions.

    # that being said, here's documentation mostly copied from viddler-ruby...

    # Upload a video to the Viddler API.
    #
    # file      - The File you are uploading
    # arguments - The Hash of arguments for the video
    #             :title       - The String title of the video
    #             :tags        - The String of tags for the video
    #             :description - The String description of the video
    #             :make_public - The Boolean to make the video public on
    #                            upload. Please note that if set to false, it
    #                            will not make your video private.
    #
    # Examples
    #
    #   viddler.upload File.open('myvideo.avi'), :title       => "My Video",
    #                                            :tags        => "viddler, ruby",
    #                                            :description => "This is cool"
    #
    # Returns a Hash containing the API response.

    def upload(file, params = {})
      json = self.get('viddler.videos.prepareUpload')
      endpoint = json["upload"]["endpoint"]
      token = json["upload"]["token"]
      uploaded = RestClient.post(endpoint,
                                 upload_params(file,
                                               params.merge!(:token => token)))
      JSON.parse uploaded
    end

    def get(api_method, params = {})
      url = 'http://api.viddler.com/api/v2/' + api_method + '.json'
      JSON.parse RestClient.get(url,
                                :params => params.merge!(:sessionid => auth,
                                                         :method => api_method,
                                                         :api_key => @api_key))
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

    def upload_params(file, params = {})
      raise "file argument must be a File" unless file.is_a? File
      ordered_arguments = ActiveSupport::OrderedHash.new

      params.each {|k,v| ordered_arguments[k] = v}

      ordered_arguments[:api_key]   = @api_key
      ordered_arguments[:sessionid] = auth
      ordered_arguments[:file]      = file

      ordered_arguments
    end

  end
end

