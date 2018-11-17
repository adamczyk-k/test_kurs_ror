ActiveAdmin.register Expedition do
  permit_params :user_id, :dragon_id, :expedition_type_id

  form do |expedition|
    expedition.inputs 'Details' do
      expedition.input :user_id, as: :select, collection: User.all.collect { |user| [user.email, user.id] }
      expedition.input :dragon_id, as: :select, collection: Dragon.all.collect { |dragon| [dragon.name, dragon.id] }
      expedition.input :expedition_type_id, as: :select, collection: ExpeditionType.all.collect { |expeditiontype| [expeditiontype.name, expeditiontype.id] }
    end
    expedition.actions
  end
end
