require "rails_helper"

feature "A visitor signs up to the site" do
  scenario "by selecting a plan from the homepage" do
    visit root_path
    first(:link, "Get Started").click

    expect(find("#registration_plan_id").value).not_to be_empty

    fill_in "registration_company_name", with: "Billy Zanes Company"
    fill_in "registration_first_name", with: "Billy"
    fill_in "registration_last_name", with: "Zane"
    fill_in "registration_email", with: "billyzane@example.com"
    fill_in "registration_password", with: "asdf1234"
    fill_in "registration_password_confirmation", with: "asdf1234"

    click_on("Create Registration")

    expect(current_path).to eq company_tasks_path(created_company)
  end

  def created_company
    @company = Company.last
  end
end
