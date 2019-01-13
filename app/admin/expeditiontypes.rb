ActiveAdmin.register ExpeditionType do
  permit_params :name, :description, :longevity, :experience, :user_level, :dragon_level
end
