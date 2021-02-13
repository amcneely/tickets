class TicketsController < ApplicationController

  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
     if @ticket.save
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
