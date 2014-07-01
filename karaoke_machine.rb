# coding: utf-8

class KaraokeMachine
  # 音階配列
  MELODY_MAPS = %w(C C# D D# E F F# G G# A A# B)

  # 初期処理
  def initialize(melody)
    # メロディをばらして配列に変換
    @melody = melody.scan(/[A-G| ]#?/)
  end

   # メロディ変換
  def transpose(amount)
    # 音階配列を引数分回転
    moved_melody_maps = MELODY_MAPS.rotate(amount)
    @melody.map{|value|
      # 音階配列からインデックス取得
      index = MELODY_MAPS.index(value)
      # 回転した音階配列からインデックスの値を取得して結果文字列に繋げる
      index ? moved_melody_maps[index] : value
    }.join
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
