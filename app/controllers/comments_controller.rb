class CommentsController < ApplicationController
  
  def create 
    @context = context
    @comment = @context.comments.new(comment_params)
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.commentable, notice: 'Comment was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @comment }
        # redirect_to context_url(context, @contribution), flash: { success: 'Your Contribution was Successfully created!' }
      else 
        format.html { render :new }
      end
    end
  end
  
  
  
  private 
  
    def comment_params
      params.require(:comment).permit(:body, :user_id)
    end
    
    def context
      if params[:event_id]
        id = params[:event_title]
        Event.find_by_title(params[:event_id])
      elsif params[:pledge_page_id]
        id = params[:pledge_page_id]
        PledgePage.find(params[:pledge_page_id])
      else
        id = params[:team_id]
        Team.find(params[:team_id])
      end
    end
end