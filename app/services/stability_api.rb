class StabilityAPI
  def initialize(stability_api_key)
    @stability_api_key = stability_api_key
  end

  def remove_background
    url = 'https://api.stability.ai/v2beta/stable-image/edit/remove-background'

    data = File.open(cloth_image).read
    response = HTTParty.post(url, {
      headers: {
        "authorization": "#{stability_api_key}",
        "accept": "image/*"
      },
      files={
        "image": open("./husky-in-a-field.png", "rb")
    },
    data={
        "output_format": "webp"
    },
})

    if response.status_code == 200:
        with open("./husky.webp", 'wb') as file:
          file.write(response.content)
    else:
      raise Exception(str(response.json()))
end
