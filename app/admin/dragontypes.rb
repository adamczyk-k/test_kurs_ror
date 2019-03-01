ActiveAdmin.register DragonType do
  permit_params :name, :description, :thumbnail

  form partial: 'form'
end
