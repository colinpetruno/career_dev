require 'rails_helper'

describe TaskDecorator do
  before { StripeMock.start }

  let(:company) { FactoryGirl.create(:company, :with_tasks) }
  let(:user) { FactoryGirl.create(:user, company: company) }
  let(:task) { build_task_with_prerequisites }
  let(:prerequisite) { task.prerequisites.first.decorate }

  before(:each) do
    sign_in(user)
  end

  describe "task_link" do
    it "should be text only when there its not completable" do
      expect(task.task_link).
        to eql(task.title)
    end

    it "should be a link when it is completable" do
      expect(prerequisite.task_link).
        to eql(
          link_to(
            prerequisite.title,
            company_task_path(company, prerequisite)
          )
        )
    end
  end

  def build_task_with_prerequisites
    task = company.tasks.last
    task.prerequisites = company.tasks.first(3)
    task.save
    task.decorate
  end
end
