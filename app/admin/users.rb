ActiveAdmin.register User do
  permit_params :email, :username
end
