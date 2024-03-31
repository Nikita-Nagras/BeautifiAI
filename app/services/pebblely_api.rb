require "base64"

class PebblelyApi

  def initialize(api_key)
    @api_key = api_key
  end

  def generate_image(cloth_image, theme, prompt)
    url = 'https://fashion-api.pebblely.com/api_v1/generate/virtual_pose'
    data = File.open(cloth_image).read
    response = HTTParty.post(url, {
      headers: {
        'Content-Type' => 'application/json',
        'Accept' => '*/*',
        'X-Pebblely-Access-Token' => "#@api_key"
      },
      body: {
        cloth_image: Base64.encode64(data),
        theme: theme,
        prompt: prompt,
      }.to_json
    })

    if response.code == 200
      return response.body
    end
  end

  
end
