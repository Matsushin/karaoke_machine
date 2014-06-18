# coding: utf-8

# まだまだリファクタリングしたかったのですが、挑戦者枠が残り2人となってしまったので提出します。
# Rubyでまともに動くプログラムを組むのは初めてでしたが楽しかったです。
class KaraokeMachine
  # メロディと数字のマップ配列
  @@melody_maps ={
      'C' => 0,
      'C#' => 1,
      'D' => 2,
      'D#' => 3,
      'E' => 4,
      'F' => 5,
      'F#' => 6,
      'G' => 7,
      'G#' => 8,
      'A' => 9,
      'A#' => 10,
      'B' => 11,
  }

  # 初期処理
  def initialize(melody)
    # 元のメロディ文字列を配列に変換
    @originals = melody.split("")
    @@numbers = []
    @prev = ''
    # 配列内の音のみ数字に変換して保管
    @originals.each{|value|
      if @prev != '#'
        if value === '#'
          # シャープ検索
          @@numbers.push @@melody_maps[@prev + value]
        else
          melody_match(@prev)
        end
      end
      @prev = value
    }

    #残りの最後の文字を変換
    if @prev != '#'
      melody_match(@prev)
    end
  end

   # メロディ変換
  def transpose(amount)
    @results = []
    @melody_maps_reverse =  @@melody_maps.invert
    # 数字変換したmelody配列の各数字をamount分移動
    @@numbers.each{|value|
      # 数字判定
      if value.is_a?(Integer)
        value = value + amount
        @map_length = @@melody_maps.length
        # 1オクターブ上がる
        if value > 11
          if value > 22
            value = value.modulo(@map_length)
            value = @map_length + value
          end
          value = value - 12
        # 1オクターブ下がる
        elsif value < 0
          if value <= -11
            value = value.modulo(@map_length)
            value = value - @map_length
          end
          value = @map_length + value
        end
        @results.push @melody_maps_reverse[value]
      else
        @results.push value
      end
    }

    # 結果を文字列にして返す
    return @results.join("")
  end

  # 配列の値があれば数字変換して保管
  private
  def melody_match(prev)
    if @@melody_maps[prev]
      @@numbers.push @@melody_maps[prev]
    else
      @@numbers.push prev
    end
  end
end

describe KaraokeMachine do
  it "メロディ無し" do
    melody = ""
    answer = melody
    expect(KaraokeMachine.new(melody).transpose(0)).to eq answer
  end

  # ここから下のコメントを外していって、テストを全部パスさせてください！
  it "変更無し" do
    melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
    answer = melody
    expect(KaraokeMachine.new(melody).transpose(0)).to eq answer
  end

  it "2上げる" do
    melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
    answer = "D E F# G |F# E D   |F# G A B |A G F#   |D   D   |D   D   |DDEEF#F#GG|F# E D   "
    expect(KaraokeMachine.new(melody).transpose(2)).to eq answer
  end

  it "7上げる" do
    melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
    answer = "G A B C |B A G   |B C D E |D C B   |G   G   |G   G   |GGAABBCC|B A G   "
    expect(KaraokeMachine.new(melody).transpose(7)).to eq answer
  end

  it "1下げる" do
    melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
    answer = "B C# D# E |D# C# B   |D# E F# G# |F# E D#   |B   B   |B   B   |BBC#C#D#D#EE|D# C# B   "
    expect(KaraokeMachine.new(melody).transpose(-1)).to eq answer
  end
  it "7下げる" do
    melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
    answer = "F G A A# |A G F   |A A# C D |C A# A   |F   F   |F   F   |FFGGAAA#A#|A G F   "
    expect(KaraokeMachine.new(melody).transpose(-7)).to eq answer
  end
  it "1オクターブ上げる" do
    melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
    answer = melody
    expect(KaraokeMachine.new(melody).transpose(12)).to eq answer
  end
  it "1オクターブ下げる" do
    melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
    answer = melody
    expect(KaraokeMachine.new(melody).transpose(-12)).to eq answer
  end
  it "14上げる" do
    melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
    answer = "D E F# G |F# E D   |F# G A B |A G F#   |D   D   |D   D   |DDEEF#F#GG|F# E D   "
    expect(KaraokeMachine.new(melody).transpose(14)).to eq answer
  end

  it "13下げる" do
    melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
    answer = "B C# D# E |D# C# B   |D# E F# G# |F# E D#   |B   B   |B   B   |BBC#C#D#D#EE|D# C# B   "
    expect(KaraokeMachine.new(melody).transpose(-13)).to eq answer
  end

  it "2オクターブ上げる" do
    melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
    answer = melody
    expect(KaraokeMachine.new(melody).transpose(24)).to eq answer
  end

  it "2オクターブ下げる" do
    melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
    answer = melody
    expect(KaraokeMachine.new(melody).transpose(-24)).to eq answer
  end
  it "26上げる" do
    melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
    answer = "D E F# G |F# E D   |F# G A B |A G F#   |D   D   |D   D   |DDEEF#F#GG|F# E D   "
    expect(KaraokeMachine.new(melody).transpose(26)).to eq answer
  end

  it "25上げる" do
    melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
    answer = "B C# D# E |D# C# B   |D# E F# G# |F# E D#   |B   B   |B   B   |BBC#C#D#D#EE|D# C# B   "
    expect(KaraokeMachine.new(melody).transpose(-25)).to eq answer
  end

  it "6上げる(メロディはF#から開始)" do
    melody = "F# G# A# B |A# G# F#   |A# B C# D# |C# B A#   |F#   F#   |F#   F#   |F#F#G#G#A#A#BB|A# G# F#   "
    answer = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
    expect(KaraokeMachine.new(melody).transpose(6)).to eq answer
  end

  it "6下げる(メロディはF#から開始)" do
    melody = "F# G# A# B |A# G# F#   |A# B C# D# |C# B A#   |F#   F#   |F#   F#   |F#F#G#G#A#A#BB|A# G# F#   "
    answer = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
    expect(KaraokeMachine.new(melody).transpose(-6)).to eq answer
  end
  it "連続してtransposeを呼び出す" do
    melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
    karaoke = KaraokeMachine.new(melody)

     answer = melody
     expect(karaoke.transpose(0)).to eq answer

     answer = "D E F# G |F# E D   |F# G A B |A G F#   |D   D   |D   D   |DDEEF#F#GG|F# E D   "
     expect(karaoke.transpose(2)).to eq answer

     answer = "B C# D# E |D# C# B   |D# E F# G# |F# E D#   |B   B   |B   B   |BBC#C#D#D#EE|D# C# B   "
     expect(karaoke.transpose(-1)).to eq answer
   end
end
