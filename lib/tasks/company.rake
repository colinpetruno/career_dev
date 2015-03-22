namespace :companies do 
  task :populate_tasks, [:company_id] => [:environment] do |t, args|
    if args[:company_id].present? 
      company = Company.find(args[:company_id])

      company.categories.each do |category|
        number_of_tasks = rand((5..20))
        
        puts "Creating #{number_of_tasks} for #{category.name}"
        number_of_tasks.times do
          company.tasks.build(
            difficulty: rand((1..5)),
            size: rand((1..5)),
            fun_factor: rand((1..5)),
            title: "This is a sample task #{rand((1..100000))}",
            description: "This is a sample description #{rand((1..100000))}",
            category_id: category.id,
            user_id: company.users.first.id,
            company_id: args[:company_id]
          )
        end
      end

      puts "Saving Company"
      if company.save
        puts "Completed"
      else
        puts "Failed"
      end
    end
  end
end

