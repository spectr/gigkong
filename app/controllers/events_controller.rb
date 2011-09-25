class EventsController < ApplicationController
  # GET /events
  # GET /events.xml
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  def getcity
    
  end

  def getevents
	  @created_at = Time.now
    request_ip = request.remote_ip
    city = params[:city]


    nest = Nestling.new("SZWVLCI8NOX8MA1DG")
    songkick = Songkickr::Remote.new("DodBx8CUdmEW6vg8")
   

    if city
      city_result = songkick.location_search(:query => city).results.first 
      if city_result.lat && city_result.lng
        @sk = songkick.events(:location  => "geo:#{city_result.lat},#{city_result.lng}", :type => "concert", :page => "1", :per_page => "20")
        @city_name = city_result.city

      else
        if Rails.env.production?
          @sk = songkick.events(:location  => "ip:#{request_ip}", :type => "concert", :page => "1", :per_page => "20") 
        else       
          @sk = songkick.events(:location  => "ip:66.130.248.88", :type => "concert", :page => "1", :per_page => "20")
        end 
      end
    else 
      if Rails.env.production?
 p "11111111111111111111"
        @sk = songkick.events(:location  => "ip:#{request_ip}", :type => "concert", :page => "1", :per_page => "20") 
      else       
        @sk = songkick.events(:location  => "ip:66.130.248.88", :type => "concert", :page => "1", :per_page => "20")
      end    
    end

    @sk.results.each do |e|
      headliner = false
      other_performers_names = ""
      headliner_name = ""

      
      if Event.find_by_sk_id(e.id)

      else
        e.performances.each do |p|
          if headliner == false
			      headliner = true
            headliner_name = p.display_name.gsub(/\\/, '\&\&').gsub(/'/, "''")
          else
            other_performers_names << "#{p.display_name.gsub(/\\/, '\&\&').gsub(/'/, "''")}  "
          end
        end

        venue_name = e.venue.display_name.gsub(/\\/, '\&\&').gsub(/'/, "''")
        start_date = e.start
        sk_id = e.id
        
        begin
          video = nest.artist(headliner_name).video.first.url
        rescue
        end

        begin
          image = nest.artist(headliner_name).images.first.url
        rescue
        end

	      @event = Event.create(:headliner => headliner_name, :other_performers_names => other_performers_names, :start_date => start_date, :venue_name => venue_name, :video => video, :sk_id => e.id, :city => @city_name, :image => image)   
          
      end 
    end
    
    @events = Event.where("city = ?", @city_name)
	  

    #redirect_to "/"
	  #render 'pages/home'
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to(@event, :notice => 'Event was successfully created.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end
end
