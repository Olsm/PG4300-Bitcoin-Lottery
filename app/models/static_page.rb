class StaticPage

  def initialize
    @count = 0
  end
  
  def getFAQ question, answer
    @count = @count + 1
    "<div class='panel panel-default'>
    <div class='panel-heading'>
    <h4 class='panel-title'>
    <a class='accordion-toggle collapsed' data-toggle='collapse' data-parent='#accordion' href='#collapse#{@count}'>#{question}</a>
        </h4>
    </div>
      <div id='collapse#{@count}' class='panel-collapse collapse'>
        <div class='panel-body'>
          #{answer}
        </div>
      </div>
    </div>".html_safe
  end

  def getAbout icon, title, linkTitle, linkUrl, description
    ("<div class='col-md-6'>
    <div class='panel panel-default'>
    <div class='panel-heading'>
    <h4><i class='#{icon}'></i> #{title}</h4>
    </div>
        <div class='panel-body'>
          <p>#{description}</p>" +
        (ActionController::Base.helpers.link_to linkTitle, linkUrl, class:'btn btn-default') +
        "</div>
      </div>
    </div>").html_safe
  end

end