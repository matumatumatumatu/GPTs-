class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :guest_user?
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :first_name, :last_name, :birthdate])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :first_name, :last_name, :birthdate])
  end

  # ゲストユーザーかどうか判断するメソッド
  def guest_user?
    current_member&.email == 'guest@example.com'
  end

  # ゲストユーザーのアクセスを制限するメソッド
  def restrict_guest_user_access
    if guest_user?
      redirect_to root_path, alert: "ゲストユーザーではこの操作はできません。"
    end
  end

  # ユーザーがログインに成功した後にリダイレクトされるパスを定義
  def after_sign_in_path_for(resource)
    # resourceがMemberのインスタンスであると想定し、members#showへのパスを返す
    member_path(resource)
  end
end