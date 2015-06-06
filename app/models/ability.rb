class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is? :admin
      can :manage, :all
    elsif user.is? :company_admin
      can :manage, Task, company_id: user.company_id
      can :manage, Company, id: user.company_id
      can :manage, User, company_id: user.company_id
      can :manage, BillingPlan
      can :manage, FundingInstrument, company_id: user.company_id
      can :manage, BankAccount, company_id: user.company_id
      can :manage, CreditCard, company_id: user.company_id
    else user.is? :employee
      can :create, Task
      can :update, Task, user_id: user.id
      can :manage, Submission, company_id: user.company_id, user_id: user.id
      can :manage, User, company_id: user.company_id, id: user.id
    end
  end
end
