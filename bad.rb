require 'rack'
require 'yaml'
require 'openssl'


req = Rack::Request.new(env)
password = req.params['password']

# BAD: Inbound authentication made by comparison to string literal
if password == 'myPa55word'
  [200, {'Content-type' => 'text/plain'}, ['OK']]
else
  [403, {'Content-type' => 'text/plain'}, ['Permission denied']]
end

input_url = gets.chomp
system("wget #{input_url}") # NOT OK
