Rails.application.config.middleware.insert_after ActionDispatch::Session::CookieStore, Warden::Manager do |manager|
  manager.failure_app = GraphqlController

  manager.serialize_into_session do |user|
    user.id
  end

  manager.serialize_from_session do |id|
    User.find_by(id: id)
  end
end
