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

  def upload_image
    uploaded_io = params[:cloth_image]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    # Redirect or render success message
  end

  def generate
    if !params['cloth_image'].present? || !params['theme'].present? || !params['prompt'].present?
      redirect_to pages_path
    end

    #api_key = ENV['PEBBLELY_API_KEY']
    client = PebblelyApi.new("1bfbfc20-a085-40d1-9154-c26f297d0ca6")
    response = client.generate_image(cloth_image, theme, prompt)
    # use response here
  end
end
