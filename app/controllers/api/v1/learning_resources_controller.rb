class Api::V1::LearningResourcesController < ApplicationController
  def index
    country = params[:country] 

    video_resource = VideoResourceService.new
    video_data = video_resource.video_resource(country)

    image_resource = ImageResourceService.new
    image_data = image_resource.images(country)

    response_data = {
      id: nil,
      type: "learning_resource",
      attributes: {
        country: country,
        video: video_data || {},
        images: image_data || []
      }
    }

    render json: { data: response_data }
  end
end