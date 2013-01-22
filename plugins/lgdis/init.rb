# encoding: utf-8
require 'redmine'

# 非同期処理
# lgdis/controller_hooks で参照する為
# その前にload する必要がある
ActiveSupport::Dependencies.autoload_paths += %W(#{Rails.root}/plugins/lgdis/config/initializers)
ActiveSupport::Dependencies.autoload_paths += %W(#{Rails.root}/plugins/lgdis/lib/tasks)
ActiveSupport::Dependencies.autoload_paths += %W(#{Rails.root}/plugins/lgdis/app/workers)

require_dependency 'lgdis/issue_patch'
require_dependency 'lgdis/issues_helper_patch' # issues_controller_patch より先にload する必要あり
require_dependency 'lgdis/issues_controller_patch'
require_dependency 'lgdis/view_hooks'
require_dependency 'lgdis/controller_hooks'
#require_dependency 'lgdis/show_view_hooks' # Viewホックポイントの確認用
require_dependency 'lgdis/ext_out/twitter'
require_dependency 'lgdis/ext_out/facebook'

require_dependency 'lgdis/ext_out/smtp_jichi_shokuin'  #k-takami
require_dependency 'lgdis/ext_out/smtp_auth.rb'       #k-takami
require_dependency 'lgdis/ext_out/atom_digi_signage.rb'#k-takami
require_dependency 'lgdis/ext_out/soap_kj_commons.rb'  #k-takami
require_dependency 'lgdis/ext_out/if_common.rb'       #k-takami
require_dependency 'lgdis/ext_out/mailer.rb'          #k-takami


Redmine::Plugin.register :lgdis do
  name 'LGDIS (Local Government Disaster Information System) plugin'
  author '作成者XXX'
  description '災害発生時における地方公共団体向けの包括的メッセージング:LGDIS (Local Government Disaster Information System) をRedmineに追加するプラグインです。'
  version '0.0.1'

  project_module :shelters do
    permission :view_shelters, :shelters => [:index, :edit]
    permission :manage_shelters, :shelters => [:new, :create, :update, :destroy, :bulk_update, :ticket, :summary]
  end
  menu :project_menu, :shelters, { :controller => 'shelters', :action => 'index' }, :caption => :label_shelter, :after => :new_issue, :param => :project_id

  project_module :deliver_issues do
    permission :request_delivery, :deliver_issues => [:request_delivery]
    permission :allow_delivery, :deliver_issues => [:request_delivery, :allow_delivery]
  end

  ActiveSupport::Dependencies.autoload_paths += %W(#{Rails.root}/plugins/lgdis/lib/validators)

  # API キー設定ファイルロード
  API_KEY  = YAML.load_file("#{Rails.root}/plugins/lgdis/config/api_key.yml")
  DST_LIST = YAML.load_file("#{Rails.root}/plugins/lgdis/config/destination_list.yml")
  CF_DEFAULT_VALUES = YAML.load_file("#{Rails.root}/plugins/lgdis/config/custom_field_default_multiple_values.yml")
end