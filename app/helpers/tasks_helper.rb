module TasksHelper
  def rating_for(rating)
    output = ""
    (1..5).each do |star_number|
      if star_number <= rating
        output += icon("star")
      else
        output += icon("star-o")
      end
    end
    output.html_safe
  end
end
