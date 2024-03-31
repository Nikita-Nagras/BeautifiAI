class StabilityApi
  def initialize(stability_api_key)
    @stability_api_key = stability_api_key
  end

  def remove_background(cloth_image)
    puts "calling remove background"
    url = 'https://api.stability.ai/v2beta/stable-image/edit/remove-background'
    response = HTTParty.post(url, {
      headers: {
        'Accept' => 'application/json',
        'Authorization' => "#@stability_api_key"
      },
      body: {
        image: cloth_image,
      }
    })

    if response.code == 200
      res = JSON.parse(response.body).with_indifferent_access
      return res["image"]
    else
      puts "stability error"
      puts response.code
      puts response.body
    end
  end
end
