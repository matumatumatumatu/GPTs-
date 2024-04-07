class Admin::TagsController < ApplicationController
  def index
    @tags = Tag.all
  end
  
  # 新規作成ページを表示
  def new
    @tag = Tag.new
  end
  
  # フォームから送信されたデータでタグを作成
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to admin_tags_path, notice: 'タグが正常に作成されました。'
    else
      render :new
    end
  end
  
  def edit
    @tag = Tag.find(params[:id])
  end
  
  # フォームから送信されたデータでタグを更新
  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to admin_tags_path, notice: 'タグが正常に更新されました。'
    else
      render :edit
    end
  end
  
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to admin_tags_path, notice: 'タグが削除されました。'
  end
  
  private
  
  def tag_params
    params.require(:tag).permit(:name)
  end
  
end