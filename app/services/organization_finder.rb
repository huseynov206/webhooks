# frozen_string_literal: true

# To find organization by ID.
class OrganizationFinder < ApplicationService
  def initialize(organization_id)
    super()
    @organization_id = organization_id
  end

  def call
    Organization.find(@organization_id)
  end
end
