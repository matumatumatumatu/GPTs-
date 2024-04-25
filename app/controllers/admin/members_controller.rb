module Admin
  class MembersController < ApplicationController
    before_action :set_member, only: [:show, :edit, :update, :destroy]

    # すべてのメンバーを表示
    def index
      @members = Member.all
    end

    # 個々のメンバーの詳細を表示
    def show
    end

    # メンバー編集用のフォームを表示
    def edit
    end

    # メンバー情報を更新
    def update
      if @member.update(member_params)
        redirect_to admin_member_path(@member), notice: 'メンバー情報が更新されました。'
      else
        render :edit
      end
    end

    # メンバーを削除
    def destroy
      @member.destroy
      redirect_to admin_members_path, notice: 'メンバーが削除されました。'
    end

    private

    # メンバーを特定
    def set_member
      @member = Member.find(params[:id])
    end

    # パラメータの許可
    def member_params
      params.require(:member).permit(:email, :password, :password_confirmation)
    end
  end
end