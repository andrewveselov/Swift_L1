//
//  main.swift
//  L1_VeselovAndrew
//
// Swift level 1 Lesson 3 2019-03-25
// Homework
// Andrew Veselov
//
// 1. Описать несколько структур – любой легковой автомобиль и любой грузовик.
// 2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
// 3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
// 4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
// 5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
// 6. Вывести значения свойств экземпляров в консоль.

import Foundation

enum windows {
    case open
    case close
}

enum engine {
    case run
    case stop
}

enum controlCar {
    case engine(status: engine)
    case windows(status: windows)
    case putBaggageToTrunk(volume: Int)
    case removeBaggageFromTrunk(volume: Int)
}

enum controlTruck {
    case engine(status: engine)
    case windows(status: windows)
    case putCargoToBody(volume: Int)
    case removeCargoFromBody(volume: Int)
}

// The passenger car structure
struct passengerCar {
    let model: String                   // Model name
    let releaseYear: Int                // Release year
    let trunkVolume: Int                // Trunk volume
    var windows: windows                // Windows status
    var engine: engine                  // Engine status
    var trunkFreeSpace: Int {           // Trunk free space (calculated)
        get {
            return trunkVolume - baggageVolume
        }
    }
    var baggageVolume: Int              // Baggage volume
    
// 4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
    
    // The func for control passenger car
    mutating func control(doit: controlCar) {
        switch doit {
        case .engine(status: .run):
            print ("\(model): engine switcing on...")
            self.engine = .run
        case .engine(status: .stop):
            print("\(model): engine switcing off...")
            self.engine = .stop
        case .windows(status: .open):
            print("\(model): windows are opening...")
            self.windows = .open
        case .windows(status: .close):
            print("\(model): windows are closing...")
            self.windows = .close
        case .putBaggageToTrunk(let baggageVolume) where trunkFreeSpace >= baggageVolume:
            print("\(model): baggage volume \(baggageVolume) putting in the trunk...")
            self.baggageVolume += baggageVolume
        case .putBaggageToTrunk(let baggageVolume):
            print("? \(model): Not enough space in the trunk for baggage volume \(baggageVolume)")
        case .removeBaggageFromTrunk(let baggageVolume) where self.baggageVolume >= baggageVolume:
            print("\(model): baggage volume \(baggageVolume) removing from the trunk...")
            self.baggageVolume -= baggageVolume
        case .removeBaggageFromTrunk(let baggageVolume):
            print("? \(model): No such amount of baggage(\(baggageVolume)) in the trunk")
        }
    }
    
    // Constructor
    public init(model: String, releaseYear: Int, trunkVolume: Int) {
        self.model = model
        self.releaseYear = releaseYear
        self.trunkVolume = trunkVolume
        self.windows = .close
        self.engine = .stop
        self.baggageVolume = 0
    }
    
    // For print description auto
    var description: String {
        return "Passenger car: \(model)\n" +
        "release year: \(releaseYear)\n" +
        "trank volume: \(trunkVolume)\n" +
        "baggage volume: \(baggageVolume)\n" +
        "trank free space: \(trunkFreeSpace)\n" +
        "engine status: \(engine)\n" +
        "windows status: \(windows)\n\n"
    }
}

// The truck car structure
struct truckCar {
    let model: String                   // Model name
    let releaseYear: Int                // Release year
    let bodyVolume: Int                 // Body volume
    var windows: windows                // Windows status
    var engine: engine                  // Engine status
    var bodyFreeSpace: Int {            // Body free space (calculated)
        get {
            return bodyVolume - cargoVolume
        }
    }
    var cargoVolume: Int                // Cargo volume
    
    // 4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
    
    // The func for control trunk auto
    mutating func control(doit: controlTruck) {
        switch doit {
        case .engine(status: .run):
            print ("\(model): engine switcing on...")
            self.engine = .run
        case .engine(status: .stop):
            print("\(model): engine switcing off...")
            self.engine = .stop
        case .windows(status: .open):
            print("\(model): windows are opening...")
            self.windows = .open
        case .windows(status: .close):
            print("\(model): windows are closing...")
            self.windows = .close
        case .putCargoToBody(let cargoVolume) where bodyFreeSpace >= cargoVolume:
            print("\(model): cargo volume \(cargoVolume) putting to the body...")
            self.cargoVolume += cargoVolume
        case .putCargoToBody(let cargoVolume):
            print("? \(model): Not enough space in the body for cargo volume \(cargoVolume)")
        case .removeCargoFromBody(let cargoVolume) where self.bodyVolume >= cargoVolume:
            print("\(model): cargo volume \(cargoVolume) removing from the body...")
            self.cargoVolume -= cargoVolume
        case .removeCargoFromBody(let cargoVolume):
            print("? \(model): No such amount of cargo(\(cargoVolume)) in the body")
        }
    }
    
    // Constructor
    public init(model: String, releaseYear: Int, bodyVolume: Int) {
        self.model = model
        self.releaseYear = releaseYear
        self.bodyVolume = bodyVolume
        self.windows = .close
        self.engine = .stop
        self.cargoVolume = 0
    }
    // For print description auto
    var description: String {
        return "Passenger car: \(model)\n" +
            "release year: \(releaseYear)\n" +
            "body volume: \(bodyVolume)\n" +
            "cargo volume: \(cargoVolume)\n" +
            "body free space: \(bodyFreeSpace)\n" +
            "engine status: \(engine)\n" +
            "windows status: \(windows)\n\n"
    }
}

// 5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.

print("\nTask #5.")
print("Initializing multiple instances of structures...")
var pasCar1 = passengerCar(model: "AUDI Q7", releaseYear: 2019, trunkVolume: 50)
var pasCar2 = passengerCar(model: "TOYOTA RAV4", releaseYear: 2018, trunkVolume: 30)
var trunk1 = truckCar(model: "Hyundai HD 250", releaseYear: 2018, bodyVolume: 20000)
var trunk2 = truckCar(model: "ЗиЛ 5301", releaseYear: 2019, bodyVolume: 10000)

//print(pasCar1.description)
//print(pasCar2.description)

pasCar1.control(doit: .engine(status: .run))
pasCar1.control(doit: .windows(status: .open))
pasCar1.control(doit: .putBaggageToTrunk(volume: 50))
pasCar1.control(doit: .removeBaggageFromTrunk(volume: 20))

pasCar2.control(doit: .engine(status: .run))
pasCar2.control(doit: .putBaggageToTrunk(volume: 50))

trunk1.control(doit: .putCargoToBody(volume: 19999))
trunk1.control(doit: .putCargoToBody(volume: 2))
trunk1.control(doit: .engine(status: .run))

trunk2.control(doit: .windows(status: .open))

// 6. Вывести значения свойств экземпляров в консоль.

print("\nTask #6.")
print("Print descriptions...")
print(pasCar1.description)
print(pasCar2.description)
print(trunk1.description)
print(trunk2.description)

print("All tasks done.")
