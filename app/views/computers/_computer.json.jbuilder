json.extract! computer, :id, :name, :status, :user, :manufacturer, :model, :serial, :product, :space, :processor, :ram, :created_at, :updated_at, :comments, :wired_mac, :wireless_mac
json.url computer_url(computer, format: :json)
