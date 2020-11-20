class Article < ApplicationRecord
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings

  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(", ")
  end

  def tag_list=(tags_string) #tags_string = "ruby, technology"
     tag_names_array = tags_string.split(",").collect{|ele| ele.strip.downcase}.uniq

     new_or_found = tag_names_array.collect {|name| Tag.find_or_create_by(name: name)}

     self.tags = new_or_found     
  end
end
