class DefaultController < ApplicationController
  def homepage
    render template: "layouts/application"
  end
end
