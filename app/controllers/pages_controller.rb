class PagesController < ApplicationController
  def home
    @articles = Article.roots
  end
end
