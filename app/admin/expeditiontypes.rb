ActiveAdmin.register ExpeditionType do
  permit_params :name, :description, :longevity, :experience
end
