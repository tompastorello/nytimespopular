class SectionsController < ApplicationController
  def index
    
      @sections = Section.all
      Article.delete_all 
      Author.delete_all

      i = 1
      while i <= 5 do
     
	   @section = Section.find(i)

     @url = "http://api.nytimes.com/svc/mostpopular/v2/mostemailed/#{@section.timessection}/30.json?api-key=23e624e268b33cd42434de53d3b33b66:8:66435750"
     response = RestClient.get(@url)
     @parsed_response = JSON.parse(response)
     @number_results = @parsed_response["num_results"]
	   @most_emailed = []
     
  	 n = 0
      while n < @number_results do
       @most_emailed[n] = @parsed_response["results"][n]
       n += 1 
      end

     @most_emailed.each do |most_emailed|
      if most_emailed != nil

        @author = Author.create(
        authorname: most_emailed["byline"])

      	@article = Article.create(
    
  		  title: most_emailed["title"], 
        articledate: most_emailed["published_date"],
        urllink: most_emailed["url"],
        description: most_emailed["abstract"],
        section:@section,
        author:@author) 

        end
     end

     i += 1 

    end

   end

 
  def show
  @section = Section.find(params[:id])
  @articlessection = Article.where(section_id: params[:id])

  end
  	
      
end
