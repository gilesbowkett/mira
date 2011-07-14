require File.dirname(__FILE__) + '/spec_helper'

describe Mira::Viddler do
  it "generates embed code" do
    embed_code = <<-CODE
      <!--[if IE]>
        <object width="437" height="370" id="viddlerOuter-e75e65b2" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000">
          <param name="movie" value="http://www.viddler.com/player/e75e65b2/">
          <param name="allowScriptAccess" value="always">
          <param name="allowNetworking" value="all">
          <param name="allowFullScreen" value="true">
          <param name="wmode" value="transparent" />
          <param name="flashVars" value="autoplay=f">
          <object id="viddlerInner-e75e65b2">
            <video id="viddlerVideo-e75e65b2" src="http://www.viddler.com/file/e75e65b2/html5mobile/" type="video/mp4" width="437" height="370" poster="http://www.viddler.com/thumbnail/e75e65b2/" controls="controls"></video>
          </object>
        </object>
      <![endif]-->
      <!--[if !IE]> <!-->
        <object width="437" height="370" id="viddlerOuter-e75e65b2" type="application/x-shockwave-flash" data="http://www.viddler.com/player/e75e65b2/"> 
          <param name="movie" value="http://www.viddler.com/player/e75e65b2/"> 
          <param name="allowScriptAccess" value="always">
          <param name="allowNetworking" value="all">
          <param name="allowFullScreen" value="true">
          <param name="wmode" value="transparent" />
          <param name="flashVars" value="autoplay=f">
          <object id="viddlerInner-e75e65b2">
            <video id="viddlerVideo-e75e65b2" src="http://www.viddler.com/file/e75e65b2/html5mobile/" type="video/mp4" width="437" height="370" poster="http://www.viddler.com/thumbnail/e75e65b2/" controls="controls"></video>
          </object>
        </object>
      <!--<![endif]-->
    CODE
    Mira::Viddler.embed_code(:id => "e75e65b2").should == embed_code
  end
end

