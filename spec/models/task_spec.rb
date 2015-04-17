require "rails_helper"

describe Task do
  before { StripeMock.start }

  describe "#after_create" do
    it "should queue a job to send notifications" do
      @company = create(:company)
      @user = create(:user, company: @company)

      expect(Resque).
        to receive(:enqueue).
        with(TaskNotifier, kind_of(Numeric))

      create(:task, company: @company, user: @user)
    end
  end
end
