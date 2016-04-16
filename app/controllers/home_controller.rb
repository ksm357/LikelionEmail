require 'mailgun'
class HomeController < ApplicationController
    def index
    end
    
    def email
        @title=params[:title]
        @address=params[:address]
        @content=params[:content]
        
        mg_client = Mailgun::Client.new("key-db3c1e54124ed4e823f8a3ecc3fdba29")

        message_params =  {
                   from: 'ksm3725@naver.com',
                   to: @address,
                   subject: @title,
                   text: @content
                  }

        result = mg_client.send_message('sandbox787f016c83674e2182979f1a2978b123.mailgun.org', message_params).to_h!
        message_id = result['id']
        message = result['message']
        
        new_post = Post.new
        new_post.title = @title
        new_post.address = @address
        new_post.content = @content
        new_post.save
        
        redirect_to "/list"

    end
    def list
        @email_post = Post.all.order("id desc")
    end
end 
