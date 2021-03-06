require 'mechanize'
require 'nokogiri'
require 'httparty'

class WebScraper 

  def scraper
    
    url = "https://web.cse.ohio-state.edu/oportal/schedule_display"
  #  agent = Mechanize.new
  #  page = agent.get(url)
    #  i was having issues with mechanize so i used httparty
    #  feel free to try mechanize just comment out httparty and un-comment agent and page for mechanize
    page = HTTParty.get(url)
    noko_page = Nokogiri::HTML(page)
    
    hash_list = [] 
    courses = noko_page.css('div.panel.panel-default')
    courses.each do |course|
      title = course.css('a').text
      sections = course.css('tr.group0') + course.css('tr.group1')
      #loop through sections to get section info
      sections.each do |section|
        a = section.css('td')
       # puts a.text
        #byebug
        section_number = a[0].text
        section_component = a[1].text
        section_location = a[2].text
        section_times = a[3].text
        section_instructor = a[4].text
        section_session = a[5].text
        section_topic = a[6].text
      
        course_info = {
          :title => title,
          :section_number => section_number.to_i,
          :component => section_component,
          :location => section_location,
          :time => section_times,
          :instructor => section_instructor,
          :session => section_session,
          :course_number => title[0,10].split(//).map {|x| x[/\d+/]}.compact.join("").to_i
        }
      hash_list << course_info
      end

    #puts hash_list
    end
    hash_list
  end
end

#scrape = Scraper.new
#scrape.CourseScraper



