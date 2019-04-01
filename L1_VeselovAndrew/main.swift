//
//  main.swift
//  L1_VeselovAndrew
//
// Swift level 1 Lesson 4 2019-03-28
// Homework
// Andrew Veselov
//
// 1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
// 2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
// 3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
// 4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
// 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
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

// 3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.

enum controlCar {
    case engine(status: engine)
    case windows(status: windows)
    case increaseSpeed(speed: Int)
    case reduceSpeed(speed: Int)
    case putCargoToBody(volume: Int)
    case removeCargoFromBody(volume: Int)
}

// 1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.

class Car {
    var model: String                   // Model name
    var releaseYear: Int                // Release year
    var windows: windows                // Windows status
    var engine: engine                  // Engine status

    public init(model: String, releaseYear: Int) {
        self.model = model
        self.releaseYear = releaseYear
        self.windows = .close
        self.engine = .stop
        print("Object \"\(model)\" created.")
    }

    // For control auto
    func control(doit: controlCar) {}
    
    // Print description
    func description() {
        print("Automobile: \(model)\n" +
            "release year: \(releaseYear)\n" +
            "engine status: \(engine)\n" +
            "windows status: \(windows)")
    }
}

// 2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.

class trunkCar: Car {
    let bodyVolume: Int                 // Body volume
    var bodyFreeSpace: Int {            // Body free space (calculated)
        get {
            return bodyVolume - cargoVolume
        }
    }
    var cargoVolume: Int                // Cargo volume

    init(model: String, releaseYear: Int, bodyVolume: Int) {
        self.bodyVolume = bodyVolume
        cargoVolume = 0
        super.init(model: model, releaseYear: releaseYear)
    }

// 4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.

    override func control(doit: controlCar) {
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
        case .increaseSpeed( _):
            print("? \(model): Уou cannot control the speed of the truck car.")
        case .reduceSpeed( _):
            print("? \(model): Уou cannot control the speed of the truck car.")
        }
    }
    
    override func description() {
        super.description()
        print("body volume: \(bodyVolume)\n" +
            "cargo volume: \(cargoVolume)\n")
    }

}

class sportСar: Car {
    let maxSpeed: Int           // Maximal speed
    var currentSpeed: Int       // Current speed
    
    public init(model: String, releaseYear: Int, maxSpeed: Int) {
        self.maxSpeed = maxSpeed
        self.currentSpeed = 0
        super.init(model: model, releaseYear: releaseYear)
    }
  
// 4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
    
    override func control(doit: controlCar) {
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
        case .increaseSpeed(let speed) where speed + currentSpeed <= maxSpeed:
            print("\(model): burns to speed \(speed)...")
            self.currentSpeed += speed
        case .increaseSpeed(let speed):
            print("? \(model): can not accelerate to speed \(speed + currentSpeed) maximum speed - \(maxSpeed)")
        case .reduceSpeed(let speed) where self.currentSpeed >= speed:
            print("\(model): slows down at \(speed)...")
            self.currentSpeed -= speed
        case .reduceSpeed( _):
            print("? \(model): stops...")
            self.currentSpeed = 0
        case .putCargoToBody( _):
            print("? \(model): You can not transport cargo on a sports car.")
        case .removeCargoFromBody( _):
            print("? \(model): You can not transport cargo on a sports car.")
        }
    }

    override func description() {
        super.description()
        print("max speed: \(maxSpeed)\n" +
            "current speed: \(currentSpeed)\n")
    }

}

// 5. Создать несколько объектов каждого класса. Применить к ним различные действия.

print("\nTask #5.")
print("Creating multiple class objects...")
var sportCar1 = sportСar(model: "Maserati Levante", releaseYear: 2019, maxSpeed: 400)

var trunkCar1 = trunkCar(model: "Hyundai HD 250", releaseYear: 2018, bodyVolume: 20000)
var trunkCar2 = trunkCar(model: "ЗиЛ 5301", releaseYear: 2019, bodyVolume: 10000)
print("\nObject control...")
sportCar1.control(doit: .engine(status: .run))
sportCar1.control(doit: .windows(status: .open))
sportCar1.control(doit: .putCargoToBody(volume: 50))
sportCar1.control(doit: .increaseSpeed(speed: 50))
sportCar1.control(doit: .increaseSpeed(speed: 600))
sportCar1.control(doit: .reduceSpeed(speed: 10))

trunkCar1.control(doit: .putCargoToBody(volume: 19999))
trunkCar1.control(doit: .putCargoToBody(volume: 2))
trunkCar1.control(doit: .engine(status: .run))

trunkCar2.control(doit: .windows(status: .open))
trunkCar2.control(doit: .increaseSpeed(speed: 100))

// 6. Вывести значения свойств экземпляров в консоль.

print("\nTask #6.")
print("Print descriptions...")
sportCar1.description()
trunkCar1.description()
trunkCar2.description()

print("All tasks done.")
