class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  private

  def generate_sourcedId
    return if self.sourcedId.present?

    self.sourcedId = loop do
      uuid = SecureRandom.uuid
      break uuid unless self.class.exists?(sourcedId: uuid)
    end
  end
end
