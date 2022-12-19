class Publication < ApplicationRecord
  scope :active, ->(d=Date.current) { not_ended(d) }

  def self.not_ended(date = nil)
    date ||= Date.current

    where("end_on IS NULL OR end_on > ?", date)
  end
end
