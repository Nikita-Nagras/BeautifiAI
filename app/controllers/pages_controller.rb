class PagesController < ApplicationController


require "base64"

class PagesController < ApplicationController
  def index
  end

  def api_request
    api_key = ENV['PEBBLELY_API_KEY']
    url = 'https://fashion-api.pebblely.com/api_v1/generate/virtual_pose'

    data = File.open('/home/gabriel/redcoat.png').read
    response = HTTParty.post(url, {
      headers: {
        'Content-Type' => 'application/json',
        'Accept' => '*/*',
        'X-Pebblely-Access-Token' => "#{api_key}"
      },
      body: {
        cloth_image: Base64.encode64(data),
        theme: "Streets",
        prompt: "Blue hair Japanese female model",
      }.to_json
    })

    if response.code == 200
      render json: JSON.parse(response.body), status: :ok
    else
      render json: { error: "API request failed: #{response.code} - #{response.message} #{response.body}" }, status: :unprocessable_entity
    end
  end
end

end
