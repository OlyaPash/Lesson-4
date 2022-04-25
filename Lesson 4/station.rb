class Station
  
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    puts "Станция #{name} построена."
  end 

  def get_train(train)
    @trains << train
    puts "Уважаемые пассажиры! На станцию #{name} прибыл поезд № #{train.number}"
  end

  def show_trains(type = nil)
    if type
      puts "На станции #{name} поездa типа #{type} №:"
      trains.each {|train| puts train.number if train.type == type}
    else
      puts "На станции #{name} поезда №: "
      trains.each {|train| puts train.number}
    end
  end

  def send_train(train)
    trains.each {|train| train.number}
    trains.delete(train)
    puts "Поезд №#{train.number} отправляется со станции #{name}"
  end

end