class LotteryEntriesController < ApplicationController
  before_action :set_lottery_entry, only: [:show, :edit, :update, :destroy]

  # GET /lottery_entries
  # GET /lottery_entries.json
  def index
    @lottery_entries = LotteryEntry.page(params[:page]).per(5)
  end

  # GET /lottery_entries/1
  # GET /lottery_entries/1.json
  def show
  end

  # GET /lottery_entries/new
  def new
    @lottery_entry = LotteryEntry.new
  end

  # GET /lottery_entries/1/edit
  def edit
  end

  # POST /lottery_entries
  # POST /lottery_entries.json
  def create
    @lottery_entry = LotteryEntry.new(lottery_entry_params)

    respond_to do |format|
      if @lottery_entry.save
        format.html { redirect_to @lottery_entry, notice: 'Lottery entry was successfully created.' }
        format.json { render :show, status: :created, location: @lottery_entry }
      else
        format.html { render :new }
        format.json { render json: @lottery_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lottery_entries/1
  # PATCH/PUT /lottery_entries/1.json
  def update
    respond_to do |format|
      if @lottery_entry.update(lottery_entry_params)
        format.html { redirect_to @lottery_entry, notice: 'Lottery entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @lottery_entry }
      else
        format.html { render :edit }
        format.json { render json: @lottery_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lottery_entries/1
  # DELETE /lottery_entries/1.json
  def destroy
    @lottery_entry.destroy
    respond_to do |format|
      format.html { redirect_to lottery_entries_url, notice: 'Lottery entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lottery_entry
      @lottery_entry = LotteryEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lottery_entry_params
      params.require(:lottery_entry).permit(:email, :bitcoin_address, :amount_charged)
    end
end
