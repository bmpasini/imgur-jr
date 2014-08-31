class VotesController < ApplicationController

  def create
    10.times { puts "This is params:  #{params}"}
    @context = context_obj
    p "Votable is photo?  #{votable_is_photo?}"
    p "Context type:  #{context_type}"
    p "Context.inspect:  #{@context.inspect}"
    @vote = Vote.new(user_id: current_user.id, votable_id: @context.id, votable_type: context_type)
    if current_user.already_voted_this?(@context, context_type)
      redirect_to context_path
    else
      @vote.save
      @context.update(vote_count: @context.vote_count + 1)
      redirect_to context_path
    end
  end

private
  def vote_params
    params.require(:vote).permit(:user_id, :votable_id)
  end

  def votable_is_photo?
    params[:comment_id] ? false : true
  end

  def context_obj
    votable_is_photo? ? Photo.find(params[:photo_id]) : Comment.find(params[:comment_id])
  end

  def context_type
    p "from context_type method::::::  #{votable_is_photo?}"
    votable_is_photo? ? "Photo" : "Comment"
  end

def context_path
    votable_is_photo? ? photo_path(context_obj) : photo_path(context_obj.photo)
end



end
