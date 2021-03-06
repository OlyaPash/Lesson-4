class Main

  attr_accessor :stations, :trains, :routes, :wagons, :end_station, :starting_station

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
#   @end_station = end_station
#   @starting_station = starting_station
  end


  def create_station
    puts "Введите назание станции: "
    st_name = gets.chomp
    station = Station.new(st_name)
    @stations << station
    @stations.each {|el| puts el.name}
  end

  def create_train
    puts "Введите номер для нового поезда: "
    number = gets.chomp.to_i 
    puts "Выберите тип поезда: passenger, cargo"
    type = gets.chomp
      if type == "passenger"
        train = PassengerTrain.new(number, type)
        @trains << train
      elsif type == "cargo"
        train = CargoTrain.new(number, type)
        @trains << train
      else
        puts "Поезд не создан!"
      end
  end

  def create_route
    if @stations.length < 2
      puts "В маршруте должно быть минимум две станции!"
    else
      stations_list
      puts "Введите индекс станции, чтобы выбрать начальную: "
      @starting_station = gets.chomp.to_i
      first_st = @stations[@starting_station]
      puts "Введите индекс для конечной: "
      @end_station = gets.chomp.to_i
      last_st = @stations[@end_station]
      route = Route.new(first_st, last_st)
      @routes << route
    end
    
  end
  
  def add_station_route
    if @routes.empty?
      puts "Маршрут пуст!"
    else
      @routes.each_with_index do |v, i| 
        puts "#{i} : #{v.stations.first.name} - #{v.stations.last.name}"  # найти решение, чтобы выводилось имя
      end
      puts "Выберите маршрут(индекс): "
      route = gets.to_i
      
      puts "Выберите станцию(индекс), чтобы добавить к маршруту: "
      @stations.each_with_index {|v, i| puts "#{i} - #{v.name}"}
      st_name = gets.chomp.to_i
      @routes[route].add_station(@stations[st_name])
      @routes[route].show_stations
    end
  end

  def remove_station
    if @routes.empty?
      puts "Маршрут пуст!"
    else
      @routes.each_with_index do |v, i| 
        puts "#{i} : #{v.stations.first.name} - #{v.stations.last.name}" 
      end
      puts "Выберите маршрут: "
      route = gets.to_i
      
      puts "Выберите станцию(индекс), чтобы удалить из маршрута: "
      @stations.each_with_index {|v, i| puts "#{i} - #{v.name}"}
      st_name = gets.chomp.to_i
      @routes[route].delete_station(@stations[st_name])
      @routes[route].show_stations
    end
  end

  
  def get_route
    if @routes.empty?
      puts "В маршруте нет станций! Нужно добавить станции!"
    else
      @trains.each_with_index {|v, i| puts "Индекс:#{i} - №#{v.number}"}
      puts "Введите индекс номера поезда, которому хотите назначить маршрут: "
      train = gets.chomp.to_i

      @routes.each_with_index do |v, i| 
        puts "#{i} : #{v.stations.first.name} - #{v.stations.last.name}"
      end

      puts "Выберите маршрут: "
      route = gets.to_i

      @trains[train].received_route(@routes[route])
    end
  end

  def add_wagon_train

    if @trains.empty?
      puts "Необходимо создать поезд!"
    else 
      trains_list
      puts "Введите индекс поезда которому хотите добавить вагон: "
      train = gets.to_i
      
      case @trains[train].type 
        when "cargo"
          wagon = CargoWagon.new
          @wagons << wagon
          @trains[train].add_wagons(wagon)
        when "passenger"
          wagon = PassengerWagon.new
          @wagons << wagon
          @trains[train].add_wagons(wagon)
      end
    end

  end

  def delete_wagon
    if @trains.empty?
      puts "Необходимо создать поезд!"
    else 
      trains_list
      puts "Введите индекс поезда от которого хотите отцепить вагон: "
      train = gets.to_i
      
      @trains[train].remove_wagons  
    end
    
  end

  def train_next
    if @trains.empty?
      puts "Необходимо создать поезд!"
    else
      trains_list
      puts "Введите индекс поезда: "
      train = gets.chomp.to_i
      @trains[train].moving_next
    end 
    @trains[train].pre_curr_next
  end

  def train_back
    if @trains.empty?
      puts "Необходимо создать поезд!"
    else
      trains_list
      puts "Введите индекс поезда: "
      train = gets.chomp.to_i
      @trains[train].moving_back
    end  
    @trains[train].pre_curr_next
  end

  def trains_on_station
    @stations.each do |station|
      puts "На станции #{station.name} поезда:"
      station.trains.each do |train|
        puts "№#{train.number}"
      end
    end
  end

  def stations_list
    @stations.each_with_index do |station, index| 
      puts "Индекс: #{index} станция: #{station.name}"
    end
  end

  def trains_list
    @trains.each_with_index do|train, index| 
      puts "В списке с индексом: #{index} поезд №#{train.number}"
    end
  end

  def show_station_train_list
    stations_list
    trains_list
  end

  def to_begin
    loop do
      puts
      puts "Введите номер для: "
      puts "1. Создания станции"
      puts "2. Создания поезда"
      puts "3. Создания маршрута"
      puts "4. Добавления станции"
      puts "5. Удаления станции из маршрута"
      puts "6. Назначения маршрута поезду"
      puts "7. Добавления вагонов к поезду"
      puts "8. Отцепки вагонов от поезда"
      puts "9. Перемещения поезда по маршруту вперед "
      puts "10.Перемещения поезда назад"
      puts "11.Просматривания списка станций и списка поездов на станции"
      puts "0. Выход"

      input = gets.to_i
      break puts "До свидания!" if input == 0

      case input
        when 1
          create_station
        when 2
          create_train
        when 3
          create_route
        when 4
          add_station_route
        when 5
          remove_station
        when 6
          get_route
        when 7
          add_wagon_train
        when 8
          delete_wagon
        when 9
          train_next
        when 10
          train_back
        when 11
          trains_on_station
        end
    end
  end
end


