class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  private

  def generate_sourcedId
    return if sourcedId.present?

    self.sourcedId = loop do
      uuid = SecureRandom.uuid
      break uuid unless self.class.exists?(sourcedId: uuid)
    end
  end

  def metadata
    self[:metadata].class == String ? JSON.parse(self[:metadata]) : self[:metadata]
  end
end
