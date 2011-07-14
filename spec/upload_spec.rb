require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# attribution: these specs very, very closely adapted from the official Viddler gem.
# however the implementation is a good deal looser.

describe Mira::ViddlerClient, "upload" do
  before(:each) do
    @file = mock(File)
    @endpoint = "http://upload.viddler.com/upload.json"
    @viddler_client = Mira::ViddlerClient.new(:username => "user",
                                              :password => "s3kr3t",
                                              :api_key => "12345")

    RestClient.stub!(:post).and_return('{"response":["hello","howdy"]}')
    @viddler_client.stub!(:get).and_return({"upload" => {"endpoint" => @endpoint}})
  end
  
  it "calls get with viddler.videos.prepareUpload" do
    @viddler_client.should_receive(:auth).and_return('some_session')
    @viddler_client.should_receive(:get).with('viddler.videos.prepareUpload')
    @viddler_client.upload @file,
                           :param1 => 'asdf',
                           :param2 => true # FIXME: WTF
  end
  
  it "calls RestClient.post with endpoint, params, and file" do
    @viddler_client.should_receive(:auth).and_return('some_session')
    RestClient.should_receive(:post).with(@endpoint,
                                          hash_including(:param1 => 'asdf',
                                                         :param2 => true,
                                                         :file => @file))
    @viddler_client.upload @file, :param1 => 'asdf', :param2 => true
  end
  
  it "gets the session id from the Viddler API" do
    json = '{"auth":{"sessionid":"15e3c113126b488654849545245434f52444b"}}'
    RestClient.should_receive(:get).with(anything, anything).and_return(json)
    @viddler_client.auth.should eq("15e3c113126b488654849545245434f52444b")
  end

  it "includes sessionid" do
    @viddler_client.should_receive(:auth).and_return('some_session')
    RestClient.should_receive(:post).with(anything, hash_including(:sessionid => 'some_session'))
    @viddler_client.upload @file, :param1 => 'asdf', :param2 => true
  end
  
  it "includes API key" do
    @viddler_client.should_receive(:auth).and_return('some_session')
    RestClient.should_receive(:post).with(anything, hash_including(:api_key => '12345'))
    @viddler_client.upload @file, :param1 => 'asdf', :param2 => true
  end
  
  it "returns result of JSON.parse" do
    @viddler_client.should_receive(:auth).and_return('some_session')
    JSON.stub!(:parse).and_return('asdfasdf')
    @viddler_client.upload(@file, :param1 => 'asdf').should == 'asdfasdf'
  end
  
end
