class RegistrationsController < Devise::RegistrationsController
	def create
		super
		if resource.save
			puts 'custom logic!' 
		end
	end
	protected

	def update_resource(resource, params)
		if params['password']
			resource.update_with_password(params)
		else
			resource.update_without_password(params)
		end
	end
end

