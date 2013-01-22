# encoding: utf-8
# システム管理者(admin)ユーザの設定
admin = User.find(1)
# 言語：Japanese(日本語)
admin.update_attributes!(language: "ja")


# 設定/表示
# 既定の言語：Japanese(日本語)
Setting.default_language = "ja"
# ユーザー名の表示書式：姓 名
Setting.user_format = "lastname_firstname"

# 設定/認証
# 認証が必要：true
Setting.login_required = 1
# ユーザーによるアカウント登録：無効
Setting.self_registration = 0
# ユーザーによるアカウント削除を許可：false
Setting.unsubscribe = 0
# パスワードの再発行：false
Setting.lost_password = 0
# RESTによるWebサービスを有効にする：true
Setting.rest_api_enabled = 1

# 設定/プロジェクト
# デフォルトで新しいプロジェクトは公開にする：false
Setting.default_projects_public = 0
# 新規プロジェクトにおいてデフォルトで有効になるモジュール：チケットトラッキング,避難所開設機能
Setting.default_projects_modules = ["issue_tracking", "shelters"]