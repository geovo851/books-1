ActiveAdmin.register Book do
  permit_params :user_id, :title, :photo, :content, :draft, :author_id
end
