module ApplicationHelper

  # return logo
  def logo
    image_tag('logo.png', :alt => "HCMMW", :class => "round")
  end

  # return a title on a per-page basis.
  def title
    base_title = " | HCMMW"
    if @title.nil?
      base_title
    else
      "#{@title}#{base_title}"
    end
  end
end
