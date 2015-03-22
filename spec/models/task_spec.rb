require "rails_helper"

describe Task do
  before { StripeMock.start }

  describe "#test" do
    it "should pass" do
      task = create(:task)

      expect(1).to eql(1)
    end
  end
end
