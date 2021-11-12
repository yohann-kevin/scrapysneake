class AboutController < ApplicationController
  skip_before_action :authorized

  def initialize
    @img_link = ENV.fetch("IMG_API_LINK")
    @data = [
      {
        title: "Lorem ipsum dolor sit amet consectetur adipisicing elit.",
        content: "Nulla velit consequat nulla cupidatat aliquip dolor adipisicing. Ad commodo minim tempor qui enim ut deserunt irure proident amet. Commodo officia nostrud sint deserunt aliqua aute. Do eu laborum sit est in exercitation aliquip occaecat est minim consectetur laboris aliqua sint. Enim minim excepteur laborum mollit aute esse. Amet veniam anim quis excepteur irure.",
        image_path: "#{@img_link}about/about.png"
      },
      {
        title: "Lorem ipsum dolor sit amet consectetur adipisicing elit.",
        content: "Nulla velit consequat nulla cupidatat aliquip dolor adipisicing. Ad commodo minim tempor qui enim ut deserunt irure proident amet. Commodo officia nostrud sint deserunt aliqua aute. Do eu laborum sit est in exercitation aliquip occaecat est minim consectetur laboris aliqua sint. Enim minim excepteur laborum mollit aute esse. Amet veniam anim quis excepteur irure.",
        image_path: "#{@img_link}logo/sneake-toi-bien-white.png"
      }
    ]
  end

  def send_about
    render json: @data
  end
end
