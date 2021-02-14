class TicketsController < ApplicationController

  def create
    @ticket = Ticket.new(ticket_params)

    unless Tag.valid_tag_names?(params[:tags])
      @ticket.valid?
      @ticket.errors.add(:base, :invalid_tags,
          message: "tags, if present, must be an array of fewer than 5 strings")
      render json: @ticket.errors, status: :unprocessable_entity and return
    end

    if @ticket.save
      Tag.increment_count_for_names(params[:tags])
      Tag.send_most_active
      render json: @ticket, status: :created
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  private

    def ticket_params
      params.permit(:user_id, :title)
    end
end
