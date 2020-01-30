class SearchesController < ApplicationController

  def search(target, method, word)
  	if target == "Users"

  	  model = User.all

      if method == "forward_match"
              @result = model.where("name LIKE? OR introduction LIKE?", "#{word}%", "#{word}%")
      elsif method == "backward_match"
              @result = model.where("name LIKE? OR introduction LIKE?", "%#{word}", "%#{word}")
      elsif method == "perfect_match"
              @result = model.where(name: "#{word}")
      elsif method == "partial_match"
              @result = model.where("name LIKE? OR introduction LIKE?", "%#{word}%", "%#{word}%")
      else
        redirect_to searches_path
      end

    elsif target == "Books"

  	  model = Book.all

      if method == "forward_match"
              @result = model.where("title LIKE? OR body LIKE?", "#{word}%", "#{word}%")
      elsif method == "backward_match"
              @result = model.where("title LIKE? OR body LIKE?", "%#{word}", "%#{word}")
      elsif method == "perfect_match"
              @result = model.where(title: "#{word}")
      elsif method == "partial_match"
              @result = model.where("title LIKE? OR body LIKE?", "%#{word}%", "%#{word}%")
      else
        redirect_to searches_path
      end

    end

  end

  def index
  	@target = params[:search_target]
    method = params[:search_method]
    word = params[:search_word]
    search(@target, method, word)
  end

end
