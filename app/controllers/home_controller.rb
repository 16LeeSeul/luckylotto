class HomeController < ApplicationController
  def index
  
  end


  def show
    @my_lotto=(1..45).to_a.sample(6).sort
    # my_lotto : 무작위 수 6개 추출
    
    require('open-uri') 
    require('json')
    page=JSON.parse(open('http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=801').read).sort
    
    @num = Array.new
       # num : 당첨 번호 배열
    
    page.each do |x,v|
      if x.include?('drwtNo')
       @num << v
      end
    end
 
    @num1 = 0
    # num1 : 보너스 당첨 번호
    
    page.each do |x,v|
      if x.include?('bnusNo')
       @num1 = v
      end
    end
   
     @a = Array.new
     @b=0
     
    # a : 내 번호와 당첨 번호의 맞는 숫자를 넣은 배열
    # b : 보너스 번호가 나왔을 때
   
    @num.each do |x|
      if @my_lotto.include?(x)
        @a << x
      end
    end
    
  @my_lotto.each do |x|
    if x == @num1
     @b=@num1
     @a << x
    end
  end
  
  @rank = 999999
  # rank : 내 등수
 
  if @a.include?(@num1)
    if @a.count == 6
      @rank = 2
    end
    if @a.count == 5
      @rank = 4
      elsif @a.count == 4
      @rank = 5
      elsif @a.count == 3
    end
  else
    if @a.count == 6
      @rank = 1
    elsif @a.count == 5
      @rank = 3
    elsif @a.count == 4
      @rank = 4
    elsif @a.count == 3
      @rank = 5
    end
  end
  
  end
end