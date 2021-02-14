class TicketsController < ApplicationController

  def create
    @ticket = Ticket.new(ticket_params)

    render json: "Invalid Tag Names", status: :unprocessable_entity and return unless
            Tag.valid_tag_names?(params[:tags])

    respond_to do |format|
     if @ticket.save
       Tag.increment_count_for_names(params[:tags])
       format.json { render json: @ticket, status: :created }
     else
       format.json { render json: @ticket.errors, status: :unprocessable_entity }
     end
    end
  end

  private

    def ticket_params
      params.permit(:user_id, :title)
    end
end
