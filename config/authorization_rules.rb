authorization do
  role :guest do
    has_permission_on :books_online, to: [:index, :about, :contact, :search_books]
    has_permission_on :books, to: [:show]
  end

  role :author do
    has_permission_on :books_online, to: [:index, :about, :contact, :search_books]
    has_permission_on :books, to: [:show]

    has_permission_on :books, to: [:create, :edit, :update, :delete, :change_draft] do
      if_attribute user_id: is {user.id}
    end
  end

  role :admin do
    has_permission_on :books_online, to: [:index, :about, :contact, :search_books]
    has_permission_on :books, to: [:show, :change_draft, :create, :edit, :update, :delete]
    has_permission_on [:genres, :users], to: :manage
    has_permission_on :dashboard, to: :index
  end
end

privileges do
  # default privilege hierarchies to facilitate RESTful Rails apps
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
