module Api
  class PublicationTypesController < ApplicationController
    def index
      @publication_types = PublicationType.active

      requested_attributes = params[:fields].split(",").map(&:to_sym)
      
      render json: {
        publication_types:
          @publication_types
            .as_json(
                only: requested_attributes.intersection(PublicationType.attribute_names.map(&:to_sym)),
                methods: requested_attributes.intersection(PublicationType.instance_methods(false)),
              )
      }
    end
  end
end