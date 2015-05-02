require "rails_helper"

describe Company do
  before { StripeMock.start }

  describe "#create_default_categories" do
    it "should generate all categories from constant" do
      company = create(:company)
      expect(company.categories.count).
        to eql(Company::DEFAULT_CATEGORIES.length)
    end
  end
end
