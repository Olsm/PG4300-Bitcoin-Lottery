require 'test_helper'

class StaticPageTest < ActiveSupport::TestCase

  def setup
    @staticPage = StaticPage.new
  end

  test "getFAQ" do
    expected = "<div class='panel panel-default'>\n    <div class='panel-heading'>\n    <h4 class='panel-title'>\n    " +
        "<a class='accordion-toggle collapsed' data-toggle='collapse' data-parent='#accordion' href='#collapse1'>What are the fees?</a>\n" +
        "        </h4>\n    </div>\n      <div id='collapse1' class='panel-collapse collapse'>\n        <div class='panel-body'>\n" +
        "          1% fee is donated to <a href=\"https://thewaterproject.org/\">The Water Project</a><br>\n" +
        "                                There is also the mandatory bitcoin transaction fee of 0.0001 BTC.<br>\n" +
        "                                These fees are deducted from the prize when sent to the winner.\n        </div>\n      </div>\n    </div>"
    actual = @staticPage.getFAQ 'What are the fees?',
                                '1% fee is donated to <a href="https://thewaterproject.org/">The Water Project</a><br>
                                There is also the mandatory bitcoin transaction fee of 0.0001 BTC.<br>
                                These fees are deducted from the prize when sent to the winner.'
    assert_equal expected, actual
  end

  test "getAbout" do
    expected = "<div class='col-md-6'>\n    <div class='panel panel-default'>\n    <div class='panel-heading'>\n    " +
        "<h4><i class='glyphicon glyphicon-ok'></i> Automated lottery</h4>\n    </div>\n        <div class='panel-body'>\n          " +
        "<p>Our systems are fully automated. This means you never have to worry about the entry or payout!\n                                  " +
        "Winners and participants are published to ensure legitimacy.</p><a class=\"btn btn-default\" href=\"http://test.com/\">View lotteries</a></div>\n      "+
        "</div>\n    </div>"
    actual = @staticPage.getAbout 'glyphicon glyphicon-ok', 'Automated lottery', 'View lotteries', "http://test.com/",
                                 'Our systems are fully automated. This means you never have to worry about the entry or payout!
                                  Winners and participants are published to ensure legitimacy.'
    assert_equal expected, actual
  end

end
