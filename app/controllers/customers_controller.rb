class CustomersController < ApplicationController
=begin
A frequent practice is to place the standard CRUD actions in each controller 
in the following order: index, show, new, edit, create, update and destroy. 
You may use any order you choose, but keep in mind that these are public methods; 
and they must be placed before any private or protected method in the 
controller in order to work.	
=end
	def test()
		# /customer/test/?phone_number=072888888&email=dhh@email.com
		render plain: params[:phone_number].inspect
	end
	# GET
	def index
	    @customers = Customer.all
	end

	# GET
	def edit
		@customer = Customer.find(params[:id])
	end

	# GET
	def show()
		# get the :id parameter from the request
		# We use an instance variable (prefixed with @) to hold a reference 
		# to the customer object. We do this because Rails will pass all 
		# instance variables to the view.
    	@customer = Customer.find(params[:id])
  	end

	# GET
	def new
		@customer = Customer.new
	end
 
	# POST
	def create
		# render plain: params[:customer].inspect
		# name"=>"", "phone_number"=>""
		# render plain: params[:phone_number].inspect
		# @customer = Customer.new(params[:customer])

		# whitelist our controller parameters to prevent wrongful mass assignment. 
		# @customer = Customer.new(params.require(:customer).permit(:name, :phone_number))

		@customer = Customer.new(customer_params)

		# save is responsible for saving the model in the database
		# @customer.save returns a boolean indicating whether the customer was saved or not.
		# @customer.save
		# redirect the user to the show action
		# redirect_to @customer
		if @customer.save
			# redirect_to tells the browser to issue another request.
		    redirect_to @customer
		else
			# The render method is used so that the @customer object 
			# is passed back to the new template when it is rendered. 
			# This rendering is done within the same request as the form submission
		    render 'new'
		end
	end



	# PUT/PATCH
	def update
		@customer = Customer.find(params[:id])
 
 		# @customer.update(name: 'Updated name')
		if @customer.update(customer_params)
			redirect_to @customer
		else
			render 'edit'
		end
	end

	# DELETE
	
	def destroy
	  	@customer = Customer.find(params[:id])
	  	@customer.destroy
	 
	  	redirect_to customers_path
	end
	# private to make sure it can't be called outside its intended context.
	private
	  def customer_params
	    params.require(:customer).permit(:name, :phone_number)
	  end


end
