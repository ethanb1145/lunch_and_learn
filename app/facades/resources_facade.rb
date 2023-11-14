class ResourcesFacade
  def initialize(country)
    @country = country
  end

  def learning_resources
    video_data = VideoResourceService.new.video_resource(@country)
    image_data = ImageResourceService.new.images(@country)

    format_response(video_data, image_data)
  end

  private

  def format_response(video_data, image_data)
    {
      id: nil,
      type: "learning_resource",
      attributes: {
        country: @country,
        video: video_data || {},
        images: image_data || []
      }
    }
  end
end
