class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :favorites]

  def show
    # 既にset_memberで@memberを設定しているため、ここには追加のコードは不要
  end

  def edit
    # 編集に関するアクション（必要に応じてコードを追加）
  end

  def update
    if @member.update(member_params)
      # 更新に成功した場合は、メンバーの詳細ページにリダイレクトします。
      redirect_to @member, notice: 'Member was successfully updated.'
    else
      # 更新に失敗した場合は、編集ページを再表示します。
      render :edit
    end
  end

def guest_sign_in
    # ゲストログイン機能（変更なし）
  member = Member.find_or_create_by!(email: 'guest@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
  end
    sign_in member
    redirect_to root_path, notice: 'You have logged in as a guest user.'
end

def favorites
  # 現在ログインしているメンバーのお気に入りに登録した製品の一覧を取得
  @favorites = current_member.favorites.includes(:product)
end

  private

  def set_member
    @member = Member.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Member not found.'
  end

  # Only allow a list of trusted parameters through.
  def member_params
    params.require(:member).permit(:email, :name, :first_name, :last_name, :birthdate)
  end
end