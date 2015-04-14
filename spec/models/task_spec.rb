require "rails_helper"

describe Task do
  before { StripeMock.start }

  describe "#after_create" do
    it "should queue a job to send notifications" do
      @company = create(:company)
      @user = create(:user, company: @company)

      # need to stub this so it doesnt call resque on creating the company
      allow_any_instance_of(Subscription).
        to receive(:queue_update_plan).
        and_return(true)

      expect(Resque).
        to receive(:enqueue).
        with(TaskNotifier, kind_of(Numeric))

      create(:task, company: @company, user: @user)
    end
  end
end
