require 'rails_helper'

describe TaskDecorator do
  before { StripeMock.start }

  let(:company) { FactoryGirl.create(:company, :with_tasks) }
  let(:company_admin) { FactoryGirl.create(:company_admin, company: company) }
  let(:prerequisite) { task.prerequisites.first.decorate }
  let(:task) { build_task_with_prerequisites }
  let(:user) { FactoryGirl.create(:user, company: company) }


  describe "#task_link" do
    it "should be text only when there its not completable" do
      sign_in(user)
      expect(task.task_link).
        to eql(task.title)
    end

    it "should be a link when it is completable" do
      sign_in(user)
      expect(prerequisite.task_link).
        to eql(
          link_to(
            prerequisite.title,
            company_task_path(company, prerequisite)
          )
        )
    end

    it "should be a link when the user is a company admin" do
      sign_in(company_admin)

      expect(task.task_link).
        to eql(
          link_to(
            task.title,
            company_task_path(company, task)
          )
        )
    end
  end

  #describe "#interest" do
    #it "should render a form if it hasn't been accepted" do
      #sign_in(user)
      #expect(prerequisite.interest).to include("<form")
    #end

    #it "should render text if it has been accepted" do
      #sign_in(user)
      #create(:offer, user: user, task: prerequisite)

      #expect(prerequisite.interest).
        #to include(I18n.t("tasks.offers.expressed_interest.message"))
    #end
  #end

  def build_task_with_prerequisites

    task = company.tasks.last
    task.prerequisites = company.tasks.first(3)
    task.save
    task.decorate
  end
end
