class PagesController < ApplicationController
  def show
      if valid_page?
        render template: "pages/#{params[:page]}"
      else
        render file: "public/404.html", status: :not_found
      end
    end

    def letsencrypt
      # use your code here, not mine
      render text: "Ki_x17PcnAoLB_B2S49bkvnsc4Zs70XX9pPxtwL_Hzo.oRrCKQrTcxmGONE248b4unEzXiFcjwPfQUl4bmFyQEU"
    end

    private
    def valid_page?
      File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page]}.html.erb"))
    end
end
