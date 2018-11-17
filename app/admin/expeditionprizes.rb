ActiveAdmin.register ExpeditionPrize do
  permit_params :name, :prize, :expedition_type_id, :resource_type_id
end
