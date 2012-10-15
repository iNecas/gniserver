require 'sinatra/base'
require 'json'

class GniServer < Sinatra::Base

  BASIC_BUILD_DEPS = {
    "yum" => %w[gcc ruby-devel]
  }

  get '/gems/:gem/sysdeps' do
    provider = params[:provider] || "yum"
    basic_build_deps = BASIC_BUILD_DEPS["yum"]
    build_deps = basic_build_deps + case params[:gem]
    when 'nokogiri'
      %w[libxml2-devel libxslt-devel]
    when 'sqlite3'
      %w[sqlite-devel]
    else
      raise Sinatra::NotFound
    end

    build_deps.to_json
  end

  run! if app_file == $0
end
