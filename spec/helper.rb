require 'simplecov'

if ENV['COVERAGE']
  SimpleCov.start do
    add_filter "/spec"
  end
end

require 'invoicexpress'
require 'rspec'
require 'webmock/rspec'

def stub_get(url)
  stub_request(:get, invoicexpress_url(url))
end

def stub_post(url)
  stub_request(:post, invoicexpress_url(url))
end

def stub_put(url)
  stub_request(:put, invoicexpress_url(url))
end

def stub_delete(url)
  stub_request(:delete, invoicexpress_url(url))
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + "/" + file)
end

def empty_xml_response
  {
    :body => "",
    :headers => {
      :content_type => "application/xml; charset=utf-8"
    }
  }
end

def xml_response(file)
  {
    :body => fixture(file),
    :headers => {
      :content_type => "application/xml; charset=utf-8"
    }
  }
end

def invoicexpress_url(url)
  if url =~ /^http/
    url
  else
    "https://thinkorangeteste.invoicexpress.net#{url}"
  end
end

