class SearchesController < ApplicationController
  def search
    @value = params[:value]
    @model = params[:model]
    @how = params[:how]
    @dates = search_for(@how, @value, @model)
  end
  
  private
  # 受け取った値によって処理を振り分ける
  def search_for(how, value, model)
    case how
    when 'match'
      match(model, value)
    when 'forward'
      forward(model, value)
    when 'backward'
      backword(model, value)
    when 'partical'
      partical(model, value)
    end
  end
  
  # howの値がmatchだった時の処理
  def match(model, value)
    if model == "user"
      User.where(name: value)
    else
      Book.where(title: value)
    end
  end
  
  # howの値がforwardだった時の処理
  def forward(model, value)
    if model == "user"
      User.where("name LIKE ?", "#{value}%")
    else
      Book.where("title LIKE ?", "#{value}%")
    end
  end
  
  # howの値がbackwordだった時の処理
  def backword(model, value)
    if model == "user"
      User.where("name LIKE ?", "%#{value}")
    else
      Book.where("title LIKE ?", "%#{value}")
    end
  end
  # howの値がparticalだった時の処理
  def partical(model, value)
    if model == "user"
      User.where("name LIKE ?", "%#{value}%")
    else
      Book.where("title LIKE ?", "%#{value}%")
    end
  end
  
end
