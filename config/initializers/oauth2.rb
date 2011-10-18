# Monkey patch to correct the Authorization header
class OAuth2::AccessToken
  def request(verb, path, opts = {}, &block)
    opts_mod = opts
    if opts_mod[:headers].nil?
      opts_mod[:headers] = {}
    end
    opts_mod[:headers] = opts[:headers].merge('Authorization' => "OAuth #{@token}")
    @client.request(verb, path, opts_mod, &block)
  end
end