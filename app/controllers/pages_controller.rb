require "base64"

class PagesController < ApplicationController

  # def api_request(cloth_image, theme, prompt)
  #   api_key = ENV['PEBBLELY_API_KEY']
  #   url = 'https://fashion-api.pebblely.com/api_v1/generate/virtual_pose'

  #   data = File.open(cloth_image).read
  #   response = HTTParty.post(url, {
  #     headers: {
  #       'Content-Type' => 'application/json',
  #       'Accept' => '*/*',
  #       'X-Pebblely-Access-Token' => "#{api_key}"
  #     },
  #     body: {
  #       cloth_image: Base64.encode64(data),
  #       theme: theme,
  #       prompt: prompt,
  #     }.to_json
  #   })

  #   if response.code == 200
  #     render json: JSON.parse(response.body), status: :ok
  #   else
  #     render json: { error: "API request failed: #{response.code} - #{response.message} #{response.body}" }, status: :unprocessable_entity
  #   end
  # end

  def generate
    if !params['cloth_image'].present? || !params['theme'].present? || !params['prompt'].present?
      redirect_to pages_path
    end

    api_key = ENV['PEBBLELY_API_KEY']
    client = PebblelyApi.new(api_key)
    response = client.api_request
    # use response here
  end
end
