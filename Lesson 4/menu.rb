require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon_passenger'
require_relative 'wagon_cargo'
require_relative 'main'

interface = Main.new
interface.to_begin