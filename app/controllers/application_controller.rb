class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
    before_filter :cors_preflight_check
    after_filter :cors_set_access_control_headers

    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, DELETE, PUT'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization, access-control-allow-methods, access-control-allow-origin'
    end

    def cors_preflight_check
      if request.method == :options
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, DELETE PUT'
        headers['Access-Control-Max-Age'] = '1728000'
      end
    end
end
