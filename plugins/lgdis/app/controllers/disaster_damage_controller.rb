# encoding: utf-8
class DisasterDamageController < ApplicationController
  unloadable
  
  before_filter :find_project, :authorize
  before_filter :init
  
  # 共通初期処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def init
    @disaster_damage_const = Constant::hash_for_table(DisasterDamage.table_name)
  end
  
  # 災害被害情報（第４号様式）画面
  # 初期表示処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def index
    @disaster_damage = DisasterDamage.first_or_create
  end
  
  # 災害被害情報（第４号様式）画面
  # チケット登録処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def ticket
    # 災害被害情報が存在しない場合、処理しない
    if DisasterDamage.first.present?
      begin
        issues = DisasterDamage.create_issues(@project)
        links = []
        issues.each do |issue|
          links << view_context.link_to("##{issue.id}", issue_path(issue), :title => issue.subject)
        end
        flash[:notice] = l(:notice_issue_successful_create, :id => links.join(","))
      rescue ActiveRecord::RecordInvalid => e
        flash[:error] = e.message
      end
    else
      flash[:error] = l(:error_not_exists_disaster_damage)
    end
    redirect_to :action => :index
  end
  
  # 災害被害情報（第４号様式）画面
  # 保存処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def save
    @disaster_damage = DisasterDamage.first_or_create
    @disaster_damage.assign_attributes(params[:disaster_damage], :as => :shelter)
    if @disaster_damage.save
      flash[:notice] = l(:notice_disaster_damage_successful_save)
      redirect_to :action  => :index, :id => @disaster_damage.id
    else
      render :action  => :index
    end
  end
  
  private
  
  # プロジェクト情報取得
  # ==== Args
  # ==== Return
  # ==== Raise
  def find_project
    # authorize filterの前に、@project にセットする
    @project = Project.find(params[:project_id])
  end
  
end