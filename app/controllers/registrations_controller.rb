class RegistrationsController < Devise::RegistrationsController

	#not sure if necessary
	def new
 		super
	end

	def create 
		super
		if params[:invite_token] && resource.save
			@token = params[:invite_token]
			begin
				@group = Invite.find_by(token: @token).group

			rescue NoMethodError
				flash[:error] = 'Invalid token. unable to join group'
				return #early return
			end
			resource.groups << @group

			flash[:alert] = "Successfully joined group"
			
		elsif resource.save
			g = Group.find_by(name: "Public")
			if g
				resource.groups << g
			end
		end


    end 

	helper DeviseMailerUrlHelper
	protected

	def update_resource(resource, params)
		if params['password']
			resource.update_with_password(params)
		else
			resource.update_without_password(params)
		end
	end
end
