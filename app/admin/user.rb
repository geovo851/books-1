ActiveAdmin.register User do
  permit_params :name, :role_id
end
