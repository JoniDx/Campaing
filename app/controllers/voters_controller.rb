class VotersController < ApplicationController
  before_action :set_voter, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :check_campaing, only: %i[ index ]
  before_action :check_permins, only: %i[ show edit update destroy ]

  

  # GET /voters or /voters.json
  def index
    @voters = Voter.all
    @voters_name = Voter.where(campaign_id: params[:c])
                        .ransack(name_cont: params[:q])
                        .result(distinct: true)
                        .order(created_at: :desc)                       
                        .paginate(page: params[:page], per_page: 6)


    @voters_seccion = Voter.where(campaign_id: params[:c])
                          .ransack(seccion_cont: params[:q])
                          .result(distinct: true)
                          .order(created_at: :desc)                       
                          .paginate(page: params[:page], per_page: 6)


    @voters_clave_elector = Voter.where(campaign_id: params[:c])
                                  .ransack(clave_elector_cont: params[:q])
                                  .result(distinct: true)
                                  .order(created_at: :desc)                       
                                  .paginate(page: params[:page], per_page: 6)
                                  
    if current_user.rol == 'lider'            
      @voters_name = Voter.where(campaign_id: params[:c], user_id: current_user.id)
                          .ransack(name_cont: params[:q])
                          .result(distinct: true)
                          .order(created_at: :desc)                       
                          .paginate(page: params[:page], per_page: 6)


      @voters_seccion = Voter.where(campaign_id: params[:c], user_id: current_user.id)
                              .ransack(seccion_cont: params[:q])
                              .result(distinct: true)
                              .order(created_at: :desc)                       
                              .paginate(page: params[:page], per_page: 6)


      @voters_clave_elector = Voter.where(campaign_id: params[:c], user_id: current_user.id)
                                  .ransack(clave_elector_cont: params[:q])
                                  .result(distinct: true)
                                  .order(created_at: :desc)                       
                                  .paginate(page: params[:page], per_page: 6)

    end   

  end

  # GET /voters/1 or /voters/1.json
  def show
  end

  # GET /voters/new
  def new
    @voter = Voter.new
  end

  # GET /voters/1/edit
  def edit
    @edit = true
  end

  # POST /voters or /voters.json
  def create
    @voter = Voter.new(voter_params)
    voter = Voter.where(clave_elector:@voter.clave_elector, campaign_id: @voter.campaign_id)
    respond_to do |format|

      if voter.blank?
        if @voter.save
          format.html { redirect_to new_voter_path, notice: "Votante creado" }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @voter.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to new_voter_path, notice: "Votante ya existente" }
        format.json { render json: @voter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /voters/1 or /voters/1.json
  def update
    respond_to do |format|
      if @voter.update(voter_params)
        format.html { redirect_to voter_url(@voter), notice: "Votador actualizado." }
        format.json { render :show, status: :ok, location: @voter }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @voter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /voters/1 or /voters/1.json
  def destroy
    @voter.destroy

    respond_to do |format|
      format.html { redirect_to voters_url, notice: "Voter was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def check_permins
      if current_user.rol == "lider"
        unless  @voter.user_id == current_user.id
          redirect_to root_path
        end
      elsif current_user.rol == "administrador"
        if Campaign.where(user_id:current_user.id, id: @voter.campaign_id).blank?
          redirect_to root_path
        end
      end
    end
    
    def check_campaing
      if current_user.rol == "lider"
        if CampaingsUser.where(user_id:current_user.id, campaign_id: params[:c]).blank?
          redirect_to root_path
        end
      elsif current_user.rol == "administrador"
        if Campaign.where(user_id:current_user.id, id: params[:c]).blank?
          redirect_to root_path
        end
      end
      
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_voter
      @voter = Voter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def voter_params
      params.require(:voter).permit(:name, :last_name_f, :last_name_m, :date_born, :domicilio, :clave_elector, :estado, :municipio, :seccion, :localidad, :user_id, :campaign_id)
    end
end
