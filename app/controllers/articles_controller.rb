class ArticlesController < ApplicationController
  #before_action :checkc
  #skip_before_action :checkc, only: [ :show, :new ]
  #before_action :digest_authenticate
  #rescue_from ActionController::RedirectBackError, with: :redirect_to_default
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  USERS = { 'wahab'=> 'admin' }
  def index
    @articles = Article.all
    flash.keep[:notice] = "Welcome to homepage!"
    flash.keep[:alert] = "Please don't forge articles"
  end

  def default_url_options
    { locale: I18n.locale, host: 'abc.com' }
  end

  def not_show
    @article = Article.find(params[:id])
  end

  def show
    @article = Article.find(params[:id])
    #render json: @article
    #render js: "alert('Hello');"
    #render body: "raw"
    #render layout: 'articles'
    redirect_back(fallback_location: root_path)

  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def edit 
    @article = Article.find(params[:id])
    head :bad_request
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else 
      render :edit, status: :unprocessable_entity
    end 
  end

  def destroy 
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path, status: :see_other
  end

  private
  def article_params
    params.require(:article).permit(:title, :body, :status)
  end 

  # def checkc
  #   byebug
  # end

  def digest_authenticate 
    authenticate_or_request_with_http_digest do |username|
      USERS[username]
    end
  end

  def redirect_to_default
    redirect_to root_path
  end

  def record_not_found
    puts 'record not found.'
    @articles = Article.all
    flash.now[:alert] = "Article not found"
    render :index
  end
end
