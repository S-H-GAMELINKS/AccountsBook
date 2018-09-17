class Api::AccountsController < ActionController::API
    before_action :set_account, only: [:show, :edit, :update, :destroy]
  
    # GET /accounts
    # GET /accounts.json
    def index
      @accounts = Account.all
      render json: @accounts
    end
  
    # GET /accounts/1
    # GET /accounts/1.json
    def show
        render json: @account
    end
  
    # GET /accounts/new
    def new
        @account = Account.new
        render json: @account
    end
  
    # GET /accounts/1/edit
    def edit
        render json: @account
    end
  
    # POST /accounts
    # POST /accounts.json
    def create
      @account = Account.new(account_params)
  
        if @account.save
            format.html { redirect_to @account, notice: 'Account was successfully created.' }
            format.json { render :show, status: :created, location: @account }
        else
            format.html { render :new }
            format.json { render json: @account.errors, status: :unprocessable_entity }
        end
    end
  
    # PATCH/PUT /accounts/1
    # PATCH/PUT /accounts/1.json
    def update
        if @account.update(account_params)
          format.html { redirect_to @account, notice: 'Account was successfully updated.' }
          format.json { render :show, status: :ok, location: @account }
        else
          format.html { render :edit }
          format.json { render json: @account.errors, status: :unprocessable_entity }
        end
    end
  
    # DELETE /accounts/1
    # DELETE /accounts/1.json
    def destroy
        @account.destroy
        format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
        format.json { head :no_content }
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_account
        @account = Account.find(params[:id])
      end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def account_params
        params.require(:account).permit(:date, :money, :category, :about, :income)
      end
  end
  