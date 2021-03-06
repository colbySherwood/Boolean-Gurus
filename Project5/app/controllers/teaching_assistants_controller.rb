class TeachingAssistantsController < ApplicationController




	def new
		@ta = TeachingAssistant.new
	end 

	def index 
		@tas = TeachingAssistant.all			
	end	

	def edit
		@ta = TeachingAssistant.find(params[:id])
	end

	def update
		@ta = TeachingAssistant.find(params[:id])
		@ta.update(ta_params)
		redirect_to teaching_assistants_path
	end

	def destroy
		TeachingAssistant.find(params[:id]).destroy

		redirect_to teaching_assistants_path
	end

	def show


	end

	def create
		@ta = TeachingAssistant.create(ta_params)
		redirect_to teaching_assistants_path
	end

	private
		def ta_params
			params.require(:teaching_assistant).permit(:course_number, :section_number, :user_id)
		end


end
