module Api
  class PublicationsController < ApplicationController
    def index
      @publications = Publication.active

      # Filter
      @publications = @publications.where("name LIKE ?", "%#{params[:search]}%") if params[:search].present?
      @publications = @publications.where(publication_type: publicaiton_type) if params[:publicaiton_type].present?

      # Paginate
      per_page = 10
      total_pages = (@publications.count.to_f / per_page).ceil
      page = [params[:page].to_i, total_pages].min
      items, total_pages = paginate(@publications, per_page, page)
      
      render json: {
        publications: items.as_json(only: params[:fields].split(",").map(&:to_sym)),
        total_pages: total_pages,
        page: [page, total_pages].min,
      }
    end

    private

    def paginate(collection, per_page, page)
      offset = per_page * ((page || 1) - 1)
      total = collection.count
      items = @publications.limit(per_page).offset(offset)
      total_pages = (total.to_f / per_page).ceil
      return [items, total_pages]
    end
  end

end