class PagesController < ApplicationController
  def index
  end

  def api_request
    api_key = ENV['API_KEY']
    url = 'https://api.stability.ai/v1/generation/stable-diffusion-xl-1024-v1-0/image-to-image'

    response = HTTParty.post(url, {
      headers: {
        'Content-Type' => 'multipart/form-data; boundary=<calculated when request is sent>',
        'Content-Length' => '<calculated when request is sent>',
        'Host' => '<calculated when request is sent>',
        'User-Agent' => 'PostmanRuntime/7.37.0',
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip, deflate, br',
        'Connection' => 'keep-alive',
        'Authorization' => "Bearer #{api_key}"
      },
      body: {
        init_image: 'value1',
        init_image_mode: 'IMAGE_STRENGTH',
        image_strength: '0.35',
        text_prompts[0][text]: 'send help',
        cfg_scale: '7',
        samples: '1',
        steps: '30'
      }.to_json
    })

    if response.code == 200
      render json: JSON.parse(response.body), status: :ok
    else
      render json: { error: "API request failed: #{response.code} - #{response.message}" }, status: :unprocessable_entity
    end
  end

end
