class PublicationType < ApplicationRecord
  scope :active, -> { where(active: true) }

  def publications_count
    Publication.active.where(publication_type: name).count
  end
end
