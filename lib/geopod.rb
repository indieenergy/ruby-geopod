require 'json'
require 'oauth'
require 'uri'


API_HOST = "indiegeopod.com"
API_PORT = 80
API_VERSION = "v1"


class GeopodClientError < RuntimeError
end


class Client
    
    def initialize(token_key, token_secret, consumer_key, consumer_secret, host=API_HOST, port=API_PORT)
        @host = host
        @port = port
        @consumer = OAuth::Consumer.new(consumer_key, consumer_secret)
        @token = OAuth::AccessToken.new(@consumer, token_key, token_secret)
    end
    
    def request(url, params=nil)
        response = @token.get build_url(url, params)
        return parse_response(response)
    end
    
    def parse_response(response)
        if response.kind_of?(Net::HTTPServerError)
            raise GeopodClientError.new("Invalid response #{response}\n#{response.body}")
        elsif not response.kind_of?(Net::HTTPSuccess)
            return response
        end
        
        begin
            return JSON.parse(response.body)
        rescue JSON::ParserError
            return response.body
        end
    end
    
    def build_url(url, params=nil)
        versioned_url = "/api/#{API_VERSION}#{url}"
        target = URI::Generic.new("http", nil, @host, @port, nil, versioned_url, nil, nil, nil)
        
        if params
            target.query = _urlencode(params)
        end
        
        return target.to_s
    end
    
    def _urlencode(params)
        query = []
        params.each_pair do |key, value|
            if value.class == Array
                value.each do |v|
                    query.push(URI.escape(key+"[]") + "=" + URI.escape(v))
                end
            else
                query.push(URI.escape(key) + "=" + URI.escape(value))
            end
        end
        return query.join("&")
    end
  
end

class UserClient < Client
    
    def geopods()
        return request("/geopods/")
    end
    
end

class GeopodClient < Client
    
    def initialize(geopod, token_key, token_secret, consumer_key, consumer_secret, host=API_HOST, port=API_PORT)
        super(token_key, token_secret, consumer_key, consumer_secret, host, port)
        @geopod = geopod
    end
    
    def build_url(url, params=nil)
        versioned_url = "/api/#{API_VERSION}#{url}"
        target = URI::Generic.new("http", nil, "#{@geopod}.#{@host}", @port, nil, versioned_url, nil, nil, nil)
        
        if params
            target.query = _urlencode(params)
        end
        
        return target.to_s
    end
    
    def info()
        return request("/")
    end
    
end