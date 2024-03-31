class StabilityAPI
  def initialize(stability_api_key)
    @stability_api_key = stability_api_key
  end

  def remove_background(cloth_image)
    url = 'https://api.stability.ai/v2beta/stable-image/edit/remove-background'
    response = HTTParty.post(url, {
      headers: {
        'Content-Type' => 'multipart/form-data',
        'Accept' => 'application/json',
        'Authorization' => "#@stability_api_key"
      },
      body: {
        cloth_image: Base64.encode64(data),
      }.to_json
    })

    if response.code == 200
      return response.body
    end
end
