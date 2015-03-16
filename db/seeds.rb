# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#Registration.new(
  #company_name: "Company One",
  #first_name: "Colin",
  #last_name: "Petruno",
  #email: "cpetruno@example.com",
  #password: "test1234",
  #password_confirmation: "test1234"
#).register

BillingPlan.create([
  {
    name: "Small",
    users: 0,
    tasks: 50,
    monthly_cost: 2500,
    yearly_cost: 25000,
    active: true
  },
  {
    name: "Medium",
    users: 0,
    tasks: 200,
    monthly_cost: 5000,
    yearly_cost: 50000,
    active: true
  },
  {
    name: "Large",
    users: 0,
    tasks: 500,
    monthly_cost: 10000,
    yearly_cost: 100000,
    active: true
  },
  {
    name: "Unlimited",
    users: 0,
    tasks: 0,
    monthly_cost: 25000,
    yearly_cost: 250000,
    active: true
  }
])
