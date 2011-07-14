module Mira
  module Viddler
    # attribution: this code is based very heavily on the original `viddler` gem

    # Returns proper HTML code for embedding
    #
    # <tt>options</tt> hash could contain:
    # * <tt>id:</tt> Viddler ID of the video to display (required);
    # * <tt>player_type:</tt> The type of player to embed, either "simple" or "player" (default);
    # * <tt>width:</tt> The width of the player (default is 437);
    # * <tt>height:</tt> The height of the player (default is 370);
    # * <tt>autoplay:</tt> Whether or not to autoplay the video, either
    #       "t" or "f" (default is "f");
    # * <tt>playAll:</tt> Set to "true" to enable play all player (requires
    #       player_type to be "player");
    #
    # Any additional options passed to the method will be added as flashvars
    #
    # Example:
    #
    #  Mira::Viddler.embed_code(:player_type => 'simple',
    #                           :width => 300,
    #                           :height => 300,
    #                           :autoplay => 't',
    #                           :id => "e75e65b2")
    #
    # Returns embed code for auto playing video e75e65b2 in simple player with 300px width and height
    #
    def self.embed_code(options={})
      raise "hell" unless options[:id]
      options = {
                  :player_type => 'player',
                  :width => 437,
                  :height => 370,
                  :autoplay => 'f',
                  :wmode => 'transparent'
                }.merge(options)

      # get non flashvars from options
      player_type = options.delete(:player_type)
      width       = options.delete(:width)
      height      = options.delete(:height)
      wmode       = options.delete(:wmode)
      id          = options.delete(:id)

      flashvars = options.collect{|key,value| "#{key}=#{value}"}.join('&')

      html = <<-CODE
      <!--[if IE]>
        <object width="#{width}" height="#{height}" id="viddlerOuter-#{id}" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000">
          <param name="movie" value="http://www.viddler.com/#{player_type}/#{id}/">
          <param name="allowScriptAccess" value="always">
          <param name="allowNetworking" value="all">
          <param name="allowFullScreen" value="true">
          <param name="wmode" value="#{wmode}" />
          <param name="flashVars" value="#{flashvars}">
          <object id="viddlerInner-#{id}">
            <video id="viddlerVideo-#{id}" src="http://www.viddler.com/file/#{id}/html5mobile/" type="video/mp4" width="#{width}" height="#{height}" poster="http://www.viddler.com/thumbnail/#{id}/" controls="controls"></video>
          </object>
        </object>
      <![endif]-->
      <!--[if !IE]> <!-->
        <object width="#{width}" height="#{height}" id="viddlerOuter-#{id}" type="application/x-shockwave-flash" data="http://www.viddler.com/player/#{id}/"> 
          <param name="movie" value="http://www.viddler.com/#{player_type}/#{id}/"> 
          <param name="allowScriptAccess" value="always">
          <param name="allowNetworking" value="all">
          <param name="allowFullScreen" value="true">
          <param name="wmode" value="#{wmode}" />
          <param name="flashVars" value="#{flashvars}">
          <object id="viddlerInner-#{id}">
            <video id="viddlerVideo-#{id}" src="http://www.viddler.com/file/#{id}/html5mobile/" type="video/mp4" width="#{width}" height="#{height}" poster="http://www.viddler.com/thumbnail/#{id}/" controls="controls"></video>
          </object>
        </object>
      <!--<![endif]-->
    CODE
    end
  end
end
