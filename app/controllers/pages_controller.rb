require "base64"

class PagesController < ApplicationController
  protect_from_forgery with: :null_session

  def upload_image
    uploaded_io = params[:cloth_image]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    # Redirect or render success message
  end

  def generate
    puts "it reached controller"

    cloth_image = params[:cloth_image].tempfile

   api_key = ENV['PEBBLELY_API_KEY']
   client = PebblelyApi.new(api_key)
   stability_api_key = ENV['STABILITY_API_KEY']
   client2 = StabilityApi.new(stability_api_key)

   no_background = client2.remove_background(cloth_image)

   response = client.generate_image(
     no_background,
     params['style'],
     params['prompt']
   )
    render json: response, status: :ok
  end
end
