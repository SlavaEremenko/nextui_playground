module Api
  class PublicationsController < ApplicationController
    def index
      @publications = Publication.active.where("name IS NOT NULL and name <> ''")
      @publications = @publications.where("name LIKE ?", "%#{params[:search]}%") if params[:search].present?

      # Get counts per pub_type AND ONLY THEN filter by pub_type (for dropdown usability)
      publication_type_counts = @publications.group(:publication_type).count if params[:publication_type_counts].present?
      @publications = @publications.where(publication_type: params[:publication_type]) if params[:publication_type].present?

      # Paginate
      per_page = 10
      total_pages = (@publications.count.to_f / per_page).ceil
      page = [params[:page].to_i, total_pages].min
      items, total_pages = paginate(@publications, per_page, page)
      
      requested_attributes = params[:fields].split(",").map(&:to_sym)

      render json: {
        publications: items.as_json(
            only: requested_attributes.intersection(Publication.attribute_names.map(&:to_sym)),
            methods: requested_attributes.intersection(Publication.instance_methods(false)),
          ),
        total_pages: total_pages,
        total: @publications.count,
        page: [page, total_pages].min,
      }.tap {|json|
        json[:publication_type_counts] = publication_type_counts if params[:publication_type_counts].present?
      }
    end

    private

    def paginate(collection, per_page, page)
      offset = per_page * ((page || 1) - 1)
      total = collection.count
      items = @publications.limit(per_page).offset([offset, 0].max)
      total_pages = (total.to_f / per_page).ceil
      return [items, total_pages]
    end
  end

end