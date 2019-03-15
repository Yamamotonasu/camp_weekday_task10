class AreasController < ApplicationController
  include AreasHelper

  def index
    @areas = Area.all
  end
  
  def search
  end

  def form
    @area = Area.new
    # 検索結果のzipcodeをget_jsonメソッドの引数として渡して、responseにjsonを格納する。
    response = get_json(params[:zipcode])
    begin
      #jsonをハッシュ形式へ変換。
      result = JSON.parse(response.body)
      # 存在しない郵便番号を入力した場合、rescueでエラーを拾う事が出来ない。(status=200が帰ってくる)
      # status=200だけど@result["result"]が空なのでその条件でエラーを拾う。
      if result["status"] == 200 && result["results"] == nil
        flash.now[:alert] = "郵便番号が見つかりません。"
        # 2重renderを防ぐ為returnを付けている
        return render 'search'
      end
      @area.zipcode = result["results"][0]["zipcode"]
      @area.address1 = result["results"][0]["address1"]
      @area.address2 = result["results"][0]["address2"]
      @area.address3 = result["results"][0]["address3"]
      @area.prefcode = result["results"][0]["prefcode"]
      @area.kana1 = result["results"][0]["kana1"]
      @area.kana2 = result["results"][0]["kana2"]
      @area.kana3 = result["results"][0]["kana3"]
    # rescueで拾えるエラーを全て此方で処理。
    rescue
      redirect_to areas_search_path, alert: "#{result["message"]}"
    end
  end

  def create
    @area = Area.new(area_params)
    if @area.save
      redirect_to root_path, notice: "地域を登録しました。"
    else
      flash.now[:alert] = "Validation failed: #{@area.errors.full_messages.join}"
      render :form
    end
  end

  private

  def area_params
    params.require(:area).permit(:zipcode, :prefcode, :address1, :kana1, :address2, :kana2, :address3, :kana3, :introduction)
  end
end
