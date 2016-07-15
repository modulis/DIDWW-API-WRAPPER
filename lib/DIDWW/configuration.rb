module DIDWW
  class Configuration
    attr_accessor :api_username, :api_key, :sandbox

    def initialize(params = {})
      @api_username = params[:api_username]
      @api_key = params[:api_key]
      @sandbox = params[:sandbox] || true
    end
  end
end
