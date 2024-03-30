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
    puts params["style"]
    puts params["prompt"]
    puts params["cloth_image"]

    cloth_image = params[:cloth_image].tempfile.read
    # if !params['cloth_image'].present? || !params['theme'].present? || !params['prompt'].present?
    #   redirect_to pages_path
    # end

   api_key = ENV['PEBBLELY_API_KEY']
   client = PebblelyApi.new(api_key)
   response = client.generate_image(
     params['cloth_image'],
     params['style'],
     params['prompt']
   )
    render json: response, status: :ok
   puts response
  end
end
