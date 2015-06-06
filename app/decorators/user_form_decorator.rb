class UserFormDecorator < UserDecorator
  include Draper::LazyHelpers
  decorates User

  # TODO: Tests
  def first_name_field(form)
    if object.is?(:company_admin) || object.is?(:admin)
      form.text_field(:first_name)
    else
      first_name
    end
  end

  def last_name_field(form)
    if object.is?(:company_admin) || object.is?(:admin)
      form.text_field(:last_name)
    else
      last_name
    end
  end

  def role_select_field(form)
    if object.is?(:company_admin) || object.is?(:admin)
      form.select(
        :role,
        User.public_roles.map {|role| [role.to_s.titleize, role]},
        {},
        disabled: @user.id.eql?(current_user.id)
      )
    end
  end

end
