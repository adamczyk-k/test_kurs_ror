ActiveAdmin.register Expedition do
  permit_params :user_id, :dragon_id, :expedition_type_id, :start_time

  form do |expedition|
    expedition.inputs 'Details' do
      expedition.input :user_id, as: :select, collection: User.all.collect { |user| [user.email, user.id] }
      expedition.input :dragon_id, as: :select, collection: Dragon.all.collect { |dragon| [[dragon.user.email, dragon.name], dragon.name, dragon.id] }
      expedition.input :expedition_type_id, as: :select, collection: ExpeditionType.all.collect { |expeditiontype| [expeditiontype.name, expeditiontype.id] }
      expedition.input :start_time, as: :date_time_picker, datepicker_options: { min_date: 3.days.ago.to_date, max_date: '+1W +5D' }
    end
    expedition.actions
  end
end
