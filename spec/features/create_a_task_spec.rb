require "rails_helper"

feature "A user creates a task" do
  scenario "with no prerequisites it displays a message to create tasks" do
    user = create(:company_admin)
    login_as(user)

    visit company_tasks_path(user.company)

    expect(page).to have_content("Tasks")
    expect(page).to have_content("Get Started Creating Tasks")
  end

  scenario "with no prerequisites" do
    user = create(:company_admin)
    create(:category, company: user.company)

    login_as(user)

    visit company_tasks_path(user.company)
    first(:link, "New Task").click

    expect(page).to have_content("New task")
    fill_in "task_title", with: "Feature Test Task"
    fill_in "task_description", with: "A description"
    find("#task_category_id").find(:xpath, "option[2]").select_option

    click_on("Create Task")

    expect(current_path).to eq(company_task_path(user.company, Task.last))
    expect(page).to have_content(Task.last.title)
    expect(page).to have_content(Task.last.description)
  end

end
