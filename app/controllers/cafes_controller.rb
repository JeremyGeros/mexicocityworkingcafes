class CafesController < ApplicationController
  before_action :set_cafe, only: [:show, :edit, :update]
  before_action :filters, only: [:index]

  def index
    params[:no_header] = true
    @cafes = Cafe.order(:name)
    if params[:wifi].present?
      @cafes = @cafes.where(wifi: params[:wifi])
    end
    if params[:coffee].present?
      @cafes = @cafes.where(coffee: params[:coffee])
    end

    @cafes_by_area = @cafes.group_by(&:area)
  end

  def show

  end

  def edit
  end

  def update
    @cafe.update(cafe_params)
    redirect_to cafes_path
  end

  private
    def set_cafe
      @cafe = Cafe.find(params[:id])
    end

    def filters
      @filters = {
        wifi: {
          name: 'Fast Wifi',
          icon: 'wifi',
          icon_color: '#fff',
          param: :wifi_good,
        },

        coffee: {
          name: 'Great Coffee',
          icon: 'coffee',
          icon_color: '#fff',
          param: :coffee_great,
        }
      }

      @filtered_params = params.permit(@filters.keys)
    end



    def cafe_params
      params.require(:cafe).permit(
        :name, :wifi, :wifi_name, :wifi_password, :cdmx_wifi, :coffee, :plugs, 
        :seating, :outdoor, :food, :other_people_working, :calls, :overall_rating, 
        :notes, :address, :area, :hero_image, :speed_test, images: []
      )
    end

end
