# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


BillingPlan.create([
  { name: "Small", users: 0, tasks: 50, monthly_cost: 25, yearly_cost: 250, active: true },
  { name: "Medium", users: 0, tasks: 200, monthly_cost: 50, yearly_cost: 500, active: true },
  { name: "Large", users: 0, tasks: 500, monthly_cost: 100, yearly_cost: 1000, active: true },
  { name: "Unlimited", users: 0, tasks: 0, monthly_cost: 250, yearly_cost: 2500, active: true }
])
