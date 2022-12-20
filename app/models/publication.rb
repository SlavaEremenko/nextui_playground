class Publication < ApplicationRecord
  scope :active, ->(d=Date.current) { not_ended(d) }

  def self.not_ended(date = nil)
    date ||= Date.current

    where("end_on IS NULL OR end_on > ?", date)
  end

  def publication_type_display
    PublicationType.find_by(name: publication_type)&.display
  end
end
