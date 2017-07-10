class PostsController < ApplicationController
  authorization_policy do
    update  { record.user == user }
    destroy { false }
    show    { true }

    permitted_attributes do
      if record.user == user
        [:title, :votes]
      else
        [:votes]
      end
    end
  end
end
