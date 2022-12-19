module Api
  class PublicationsController < ApplicationController
    def index
      @publications = [
        { name: "Pub 1", type: "123" },
        { name: "Pub 2", type: "234" },
      ]
      
      render json: {
        items: @publications
      }
    end
  end
end