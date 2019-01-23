ActiveAdmin.register ResourceType do
  permit_params :name, :description, :thumbnail

  form partial: 'form'
end
