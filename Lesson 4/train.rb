class Train

  attr_accessor :speed, :number, :station, :route, :wagons, :type
  attr_writer :station_index

  def initialize(speed = 0, number, type)
    @speed = speed
    @number = number
    @type = type
    @wagons = []
    @station_index = 0
    puts "Создан поезд №#{number}, тип: #{type}"
  end 

  def add_wagons(wagon)
    
    if speed == 0 && @type == wagon.type
      self.wagons << wagon
      puts "Прицеплен 1 вагон типа #{wagon.type}."
    else  
      puts "Поезд находится в движении, невозможно прицеплять вагоны!"
    end  
    
  end

  def remove_wagons
    if self.wagons.empty?
      puts "Все вагоны уже были отцеплены!"
    elsif speed == 0
      @wagons.pop
      puts "Отцеплен 1 вагон"
    else
      puts "Нельзя на ходу отцеплять вагоны!"
    end

  end

  def received_route(route)
    self.route = route
    print "Поезду № #{number} типа #{type} "
    puts "назначен маршрут #{route.stations.first.name} - #{route.stations.last.name}"
    route.stations.first.get_train(self)
  end

  def current_station
    @route.stations[@station_index]
  end


  def moving_next
    if @route.stations[@station_index + 1]
      current_station.send_train(self)
      @station_index += 1
      current_station.get_train(self)
    else
      puts "Впереди нет станций!"
    end
  end
  
  def moving_back
    if @station_index > 0
      current_station.send_train(self)
      @station_index -= 1
      current_station.get_train(self)
    else
      puts "Позади нет станций!"
    end
  end

  def pre_curr_next
    puts "Текущая станция поезда #{route.stations[@station_index].name}"
    puts "Следующая - #{route.stations[@station_index + 1].name}" if @station_index != route.stations.size - 1
    puts "Предыдущая - #{route.stations[@station_index - 1].name}" if @station_index > 0 
  end

  private # методы доступные классу

  def current_speed
    self.speed
  end

  def stop 
    self.speed = 0
  end

 

end
