module API
  class LinksController < ActionController::API
    before_action :authenticate!

    def create
      @link = authenticated_user.links.new(link_params)

      if @link.save
        render json: {
          url: short_url(@link.slug),
        }
      else
        render json: {
                 errors: @link.errors,
               }
      end
    end

    private

    def link_params
      params.permit(:url, :slug, :label)
    end

    def authenticate!
      head :unauthorized unless authenticated_user
    end

    def authenticated_user
      @authenticated_user ||= begin
        token = request.headers["Authorization"]&.split(" ")&.last
        User.from_api_key(token) if token
      end
    end
  end
end
