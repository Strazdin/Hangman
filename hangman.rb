#Игра "виселица"
#encoding: cp866
class Hangman
  def self.comporus#выбор режима игры: против компьютера или с человеком, которое загадывает слово сам
    ###
    @@maswordget=[]; @@maswordget.clear #массив хранит введенные буквы используется в методе getword
    @@words=[]; @@words.clear#words - слово по буквам в массиве
    @@wordgets=0#переменная считает угаданные слова
    @@wordget=0#для введеной буквы
    @@masugad=[]; @@masugad.clear#хранит угаданные буквы
    @@popytky=1#количество попыток
    @@mas=[]; @@mas.clear#обнуляем массив для записи слово из файла для повторной игры
    @@word=[]; @@word.clear
    ###
    80.times{puts " "}
    print "Enter - играть с человеком. Остальные клавиши - с компьюетером. "
    loop do
    Hangman.kaka
    @@compus=gets.to_s.encode("UTF-8").strip#переменная для выбора
    break
   end
    80.times{puts " "}
    Hangman.computer if @@compus != ""
    Hangman.us       if @@compus == ""
  end
  def self.us
  print "Загадайте слово: "
  loop do
  Hangman.kaka
  yn=gets.strip.upcase;
  @@words=yn.split(//)
  break
  end
  80.times{puts " "}
  Hangman.printers
  end
  def self.computer#Читает случайное слово из файла words.txt и разбивает его по буквам
    @@mas=[];#mas - запись файла в массив, word - слово в "" (to_s)
    x=0
    File.readlines("words.txt").each{|line| @@mas=line.split};@@mas.delete_at(0);x=0#чтение с файла word, добавление слов в массив и удаление первого элемента со знаком"?"
    @@word=@@mas.sample.upcase;@@words=@@word.split(//)#выбор случайного слова и разбиение его на буквы. Итог: ["О","Б","Е","Д"]
    Hangman.printers
  end
  def self.printers#вывод угаданных букв, изображений из файлов 1-8, а также условие выигрыша/проигрыша
    if @@popytky==8#условие проигрыша
    puts "Вы не угадали слово, которое было загаданно: #{@@words}"
    #20.times{print" "};@@words.each {|w| print "#{w.capitalize} "}; print "\n"#выводит рандомное слово над черточками
    #20.times{print" "};@@words.size.times {print "_  "}; print "\n";print "\n";print "\n"#вывод на экран "_  _  _  _"
                                                                     x=0#if x>0;x+=1 чтобы не отображалась первая строка в файлах 1-8
    File.readlines("#{@@popytky}.txt").each{|line| puts "#{line}" if x>0;x+=1} ; print "\n";print "\n"
    print "Хотите поиграть еще? Д/Н: "
    yn=gets.to_s.strip.capitalize
    Hangman.comporus if yn=="Д"
    exit if yn != "Д"
  else
    #print @@words; #вывод загадданого слова
    print "\n";print "\n"
    20.times{print" "};@@words.each_with_index do |w,i|#выводит угаданную букву над черточками
    if w==@@wordget || @@masugad.include?(w)
      print "#{w}"
    else
      print " "
    end
     print "  "
   end
    print "\n"
    #                                                                   о  б  е  д
    20.times{print" "};@@words.size.times {print "_  "}#вывод на экран "_  _  _  _"
    print "\n";print "\n";                                            x=0
    File.readlines("#{@@popytky}.txt").each {|line| puts "#{line}" if x>0;x+=1} #if @@popytky>0
    print "\n";print "\n"
    ###p @@words, @@maswordget
      if @@words-@@masugad==[] #условие выигрыша
        Hangman.winn
      else
        Hangman.getword
      end
    end
  end
  def self.getword
    loop do
      puts "Введенные буквы:"
      print "#{@@maswordget}"; print "\n"
      print "Введите букву загаданного слова: "
    loop do 
    Hangman.kaka
    @@wordget=gets.to_s.encode("UTF-8").strip.capitalize
    break
    end
    80.times{puts " "}
      unless @@maswordget.include?(@@wordget)#добавили букву в массив проверив была ли она там
        @@maswordget<<@@wordget
          if @@words.include?(@@wordget)#проверяем есть ли введеная буква в загаданном слове
             @@masugad<<@@wordget
             @@wordgets+=1
             Hangman.printers
           else
             @@popytky+=1
             Hangman.printers
        break#выход из цикла
          end
      else
        print "Эта буква уже есть: #{@@wordget} \n"
        Hangman.printers
      end#end условия
    end#end цикла
  end#end метода
  def self.kaka
  # XXX/ Этот код необходим только при использовании русских букв на Windows
if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
  def self.winn
   80.times{puts " "}
   puts "ПОБЕДА! Вы угадали слово, которое было загаданно: #{@@words}"; print "\n"
   print "Хотите поиграть еще? Д/Н: "
   yn=gets.to_s.strip.capitalize
   Hangman.comporus if yn=="Д"
   exit if yn != "Н"
  end
end
# /XXX
end
end

Hangman.comporus