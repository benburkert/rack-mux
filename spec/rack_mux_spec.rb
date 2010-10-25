require 'spec_helper'

describe Rack::Mux do
  it 'adds the "X-Mux-Uri" header' do
    env = JSON.parse(@client.get('/').body)
    env['X-Mux-Uri'].should =~ %r{^http://}
  end

  it 'boots a rack server' do
    uri = JSON.parse(@client.get('/').body)['X-Mux-Uri']
    new_client = Rack::Client.new(uri)
    new_response = new_client.get('/')
    new_uri = JSON.parse(new_client.get('/').body)['X-Mux-Uri']
    new_uri.should == uri
  end
end
