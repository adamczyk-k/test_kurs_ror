ActiveAdmin.register Resource do
  permit_params :user_id, :resource_type_id, :quantity

  form do |resource|
    resource.inputs 'Details' do
      resource.input :user_id, as: :select, collection: User.all.collect { |user| [user.email, user.id] }
      resource.input :resource_type_id, as: :select, collection: ResourceType.all.collect { |resourcetype| [resourcetype.name, resourcetype.id] }
      resource.input :quantity
    end
    resource.actions
  end
end
