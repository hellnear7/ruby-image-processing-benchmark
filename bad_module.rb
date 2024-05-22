require 'rack'
require 'yaml'
require 'openssl'


class RackAppBad
  def call(env)
    req = Rack::Request.new(env)
    password = req.params['password']

    # BAD: Inbound authentication made by comparison to string literal
    if password == 'myPa55word'
      [200, {'Content-type' => 'text/plain'}, ['OK']]
    else
      [403, {'Content-type' => 'text/plain'}, ['Permission denied']]
    end
  end

  def bad(input)
    raise "Bad input" unless input =~ /^[0-9]+$/

    # ....
  end
end

bad = RackAppBad.new
bad.call({'QUERY_STRING' => 'password=myPa55word'})

bad.bad('abc')

input_url = gets.chomp
system("wget #{input_url}") # NOT OK
