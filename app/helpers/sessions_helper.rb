module SessionsHelper
  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token # ||= ("or-equals") is equivalent
      # to @current_user = @current_user || user_from_remember_token, equivalent
      # to if current_user == NULL { current_user = ... } in C++, etc.
      # i.e. Set @current_user on if it's not already set.
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  
  private
  
    def user_from_remember_token
      User.authenticate_with_salt(*remember_token) # *-operator "dereferences" a
        # list/array turning the elements into the function's arguments.
        # i.e foo(1,2) is equivalent to foo(*[1,2])
    end
    
    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
end
