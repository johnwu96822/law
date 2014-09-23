class ArticlesController < ApplicationController
  include Permission
  before_action :authenticate_user!
  before_action :set_article, only: [:show, :edit, :update, :destroy, :children, :all]
  # before_action only: [:show, :edit, :update, :destroy, :children] do
    # owner_and_admin_only(@article)
  # end 
  
  def children
    children = @article.children.order(:priority)
    temp = []
    children.each do |child|
      temp << {id: child.id, content: child.content,
          has_children: child.has_children?, child_ids: child.child_ids}
    end
    render json: {children: temp}
  end
  
  def roots
    render json: {articles: Article.roots}
  end

  # GET /articles
  # GET /articles.json
  def index
    #@articles = Article.all
    @articles = Article.roots.order(:priority)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    respond_to do |format|
      format.html {}
      format.json {}
    end
  end
  
  # GET /articles/1/all
  def all
    render :show
  end

  # GET /articles/new
  def new
    @article = Article.new
    if params[:par]
      parent = Article.find(params[:par])
      @article.priority = parent.children.size
      @article.parent = parent
    end
    articles_for_select
  end

  # GET /articles/1/edit
  def edit
    articles_for_select(@article.id)
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    @article.ancestry = nil if @article.ancestry.blank?
    respond_to do |format|
      if @article.save
        format.html { redirect_to all_article_path(@article.root), notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html {
          articles_for_select()
          render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    params[:article][:ancestry] = nil if params[:article][:ancestry].blank?
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to all_article_path(@article.root), notice: 'Article was successfully updated.' }
        format.js {}
        format.json { render :show, status: :ok, location: @article }
      else
        format.html {
          articles_for_select(@article.id)
          render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:content, :ancestry, :priority)
    end
    
    def articles_for_select(id = nil)
      if id
        @for_select = Article.order(:ancestry).where("NOT id = #{id}").all.collect{|ar| 
          ["#{ar.ancestry.blank? ? '' : ar.ancestry + '/'}#{ar.id}:#{ar.content[0..10]}", 
          "#{ar.ancestry.blank? ? '' : ar.ancestry + '/'}#{ar.id}"]}
      else
        @for_select = Article.order(:ancestry).all.collect{|ar| 
          ["#{ar.ancestry.blank? ? '' : ar.ancestry + '/'}#{ar.id}:#{ar.content[0..10]}", 
          "#{ar.ancestry.blank? ? '' : ar.ancestry + '/'}#{ar.id}"]}
      end
    end
    
end
