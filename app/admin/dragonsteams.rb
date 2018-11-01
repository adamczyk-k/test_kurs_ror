ActiveAdmin.register Dragon do
  permit_params :name, :user_id, :dragon_type_id, :level, :description

  form do |dragon|
    dragon.semantic_errors *dragon.object.errors.keys

    dragon.inputs 'Details' do
      dragon.input :name
      dragon.input :user_id, as: :select, collection: User.all.collect { |user| [user.email, user.id] }
      dragon.input :dragon_type_id, as: :select, collection: DragonType.all.collect { |dragontype| [dragontype.name, dragontype.id] }
      dragon.input :level
      dragon.input :description
    end
    dragon.actions
  end
end
