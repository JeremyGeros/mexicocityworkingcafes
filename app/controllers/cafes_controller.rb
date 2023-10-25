class CafesController < ApplicationController
  before_action :set_cafe, only: [:show, :edit, :update]
  before_action :filters, only: [:index]

  # before_action :basic_auth, only: [:edit, :update]

  def index
    params[:no_header] = true
    @cafes = Cafe.reviewed.order(:name)

    if params[:needs_review].present?
      @cafes = Cafe.where(needs_review: true).order(:name)
    end

    if params[:wifi].present?
      @cafes = @cafes.where(wifi: params[:wifi])
    end

    if params[:ultra_wifi].present?
      @cafes = @cafes.where(download_speed: 100..Float::INFINITY)
    end

    if params[:coffee].present?
      @cafes = @cafes.where(coffee: params[:coffee])
    end

    if params[:plugs].present?
      @cafes = @cafes.where(plugs: true)
    end

    if params[:outdoor].present?
      @cafes = @cafes.where('outdoor not iliKE ?', '%no%')
    end

    if params[:other_people_working].present?
      @cafes = @cafes.where('other_people_working not iliKE ?', '%no%')
    end

    if params[:full_food_menu].present?
      @cafes = @cafes.where('food iliKE ?', '%menu%')
    end

    if params[:calls].present?
      @cafes = @cafes.where('calls_rating >= ?', params[:calls].to_i)
    end

    if params[:random].present?
      @cafes = [@cafes.all.sample]
    end

    if params[:location].present?
      @cafes = @cafes.where(area: params[:location])
    end

    @cafes_by_area = @cafes.group_by(&:area)
  end

  def show

  end

  def new
  end

  def create
    @cafe = Cafe.new(cafe_params)
    @cafe.needs_review = true
    @cafe.save!

    redirect_to root_path
  end

  def destroy
    @cafe = Cafe.find(params[:id])
    if @cafe.needs_review
      @cafe.destroy
    end

    redirect_to root_path(needs_review: true)
  end

  private
    def set_cafe
      @cafe = Cafe.reviewed.find(params[:id])
    end

    def filters
      @filters = {
        wifi: {
          name: 'Fast Wifi',
          icon: 'wifi',
          icon_color: '#fff',
          param: :wifi_good,
        },

        ultra_wifi: {
          name: 'Ultra Fast Wifi',
          icon: 'ultra_wifi',
          icon_color: '#fff',
          param: true,
        },

        coffee: {
          name: 'Great Coffee',
          icon: 'coffee',
          icon_color: '#fff',
          param: :coffee_great,
        },

        plugs: {
          name: 'Plugs',
          icon: 'plugs',
          icon_color: '#fff',
          param: true,
        },

        outdoor: {
          name: 'Outdoor Seating',
          icon: 'outdoor',
          icon_color: '#fff',
          param: true,
        },

        other_people_working: {
          name: 'Other People Working',
          icon: 'computer',
          icon_color: '#fff',
          param: true,
        },

         calls: {
          name: 'Perfect for Calls',
          icon: 'calls',
          icon_color: '#fff',
          param: 3,
        },

        full_food_menu: {
          name: 'Full food menu',
          icon: 'cake',
          icon_color: '#fff',
          param: true,
        },

        random: {
          name: 'Random Cafe', 
          icon: 'boiler',
          icon_color: '#fff',
          param: true,
        },
      }

      @location_filters = {
        roma_norte: {
          name: 'Roma Norte',
          icon: '',
          icon_color: '#fff',
          param: :area_roma_norte,
        },

        condesa: {
          name: 'Condesa',
          icon: '',
          icon_color: '#fff',
          param: :area_condesa,
        }
      }

      @filtered_params = params.permit(@filters.keys + [:location])
    end



    def cafe_params
      params.require(:cafe).permit(
        :name, :wifi, :wifi_name, :wifi_password, :cdmx_wifi, :coffee, :plugs, 
        :seating, :outdoor, :food, :other_people_working, :calls, :overall_rating, 
        :google_link,
        :notes, :address, :area, :hero_image, :speed_test, images: []
      )
    end

    def basic_auth
      # authenticate_or_request_with_http_basic do |username, password|
      #   username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
      # end
    end

end
