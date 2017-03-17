module ApplicationHelper
  def title(text)
    content_for :title, text
  end
  
  def og_image(image)
    content_for :og_image, image
  end
end
