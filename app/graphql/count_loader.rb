# frozen_string_literal: true

class CountLoader < AssociationLoader
  private

  def read_association(record)
    record.public_send(@association_name).count
  end
end
