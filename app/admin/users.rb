ActiveAdmin.register User do
  permit_params :email, :username, :level, :experience
end
