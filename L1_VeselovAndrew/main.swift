//
//  main.swift
//  L1_VeselovAndrew
//
// Swift level 1 Lesson 5 2019-04-01
// Homework
// Andrew Veselov
//
// 1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
// 2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
// 3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
// 4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
// 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
// 6. Вывести сами объекты в консоль.

import Foundation

enum windows {
    case open, close
}

enum engine {
    case run, stop
}

// 1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.

protocol Car : class {
    var model: String { get }                       // Model name
    var releaseYear: Int { get }                    // Release year
    var windows: windows { get set }                // Windows status
    var engine: engine { get set }                  // Engine status
    
    // Standard methods for control auto
    func Windows(status: windows)
    func Engine(status: engine)
}

// 2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).

extension Car {

    func Windows(status: windows) {
        switch status {
        case .open:
            print("\(model): windows are opening...")
            self.windows = .open
        case .close:
            print("\(model): windows are closing...")
            windows = .close
        }
    }

    func Engine(status: engine) {
        switch status {
        case .run:
            print ("\(model): engine switcing on...")
            self.engine = .run
        case .stop:
            print("\(model): engine switcing off...")
            self.engine = .stop
        }
    }
}

// Additional protocol TrunkCar based on the Car protocol

protocol TrunkCar: Car {
    var bodyVolume: Int {get}               // Body volume
    var bodyFreeSpace: Int {get}            // Body free space (calculated)
    var cargoVolume: Int {get set}          // Cargo volume
    
    func PutCargoToBody(volume: Int)
    func RemoveCargoFromBody(volume: Int)
}

extension TrunkCar {
    func PutCargoToBody(volume: Int) {
        if bodyFreeSpace >= volume {
            print("\(model): cargo volume \(volume) putting to the body...")
            self.cargoVolume += volume
        } else {
            print("? \(model): Not enough space in the body for cargo volume \(volume)")
        }
    }
    
    func RemoveCargoFromBody(volume: Int) {
        if self.bodyVolume >= volume {
            print("\(model): cargo volume \(volume) removing from the body...")
            self.cargoVolume -= volume
        } else {
            print("? \(model): No such amount of cargo(\(volume)) in the body")
        }
    }
}

// Additional protocol SportCar based on the Car protocol

protocol SportCar: Car {
    var maxSpeed: Int {get}                 // Maximal speed
    var currentSpeed: Int {get set}         // Current speed
    
    func IncreaseSpeed(speed: Int)
    func ReduceSpeed(speed: Int)
}

extension SportCar {
    func IncreaseSpeed(speed: Int) {
        if speed + currentSpeed <= maxSpeed {
            print("\(model): burns to speed \(speed)...")
            self.currentSpeed += speed
        } else {
            print("? \(model): can not accelerate to speed \(speed + currentSpeed) maximum speed - \(maxSpeed)")        }
    }
    
    func ReduceSpeed(speed: Int) {
        if self.currentSpeed >= speed {
            print("\(model): slows down at \(speed)...")
            self.currentSpeed -= speed
        } else {
            print("? \(model): stops...")
            self.currentSpeed = 0
        }
    }
}

// 3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.

// Protocol Car is implemented through linked TrunkCar and SportCar

class trunkCar: TrunkCar {
    var model: String
    var releaseYear: Int
    var windows: windows
    var engine: engine
    let bodyVolume: Int
    var bodyFreeSpace: Int {                    // calculated
        get {
            return bodyVolume - cargoVolume
        }
    }
    var cargoVolume: Int

    init(model: String, releaseYear: Int, bodyVolume: Int) {
        self.bodyVolume = bodyVolume
        self.cargoVolume = 0
        self.model = model
        self.releaseYear = releaseYear
        self.engine = .stop
        self.windows = .close
    }
}

class sportCar: SportCar {
    let maxSpeed: Int
    var currentSpeed: Int
    var model: String
    var releaseYear: Int
    var windows: windows
    var engine: engine
    
    init(model: String, releaseYear: Int, maxSpeed: Int) {
        self.maxSpeed = maxSpeed
        self.currentSpeed = 0
        self.model = model
        self.releaseYear = releaseYear
        self.engine = .stop
        self.windows = .close
    }
}

// 4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.

extension trunkCar: CustomStringConvertible {
    var description: String {
        return "Automobile: \(model)\n" +
                "release year: \(releaseYear)\n" +
                "engine status: \(engine)\n" +
                "windows status: \(windows)\n" +
                "body volume: \(bodyVolume)\n" +
                "cargo volume: \(cargoVolume)\n"
    }
}

extension sportCar: CustomStringConvertible {
    var description: String {
        return "Automobile: \(model)\n" +
                "release year: \(releaseYear)\n" +
                "engine status: \(engine)\n" +
                "windows status: \(windows)\n" +
                "max speed: \(maxSpeed)\n" +
                "current speed: \(currentSpeed)\n"
    }
}

// 5. Создать несколько объектов каждого класса. Применить к ним различные действия.

print("\nTask #5.")
print("Creating multiple class objects...")
var sportCar1 = sportCar(model: "Maserati Levante", releaseYear: 2019, maxSpeed: 400)
var trunkCar1 = trunkCar(model: "Hyundai HD 250", releaseYear: 2018, bodyVolume: 20000)
var trunkCar2 = trunkCar(model: "ЗиЛ 5301", releaseYear: 2019, bodyVolume: 10000)
print("\nObject control...")
sportCar1.Engine(status: .run)
sportCar1.Windows(status: .open)
sportCar1.IncreaseSpeed(speed: 50)
sportCar1.IncreaseSpeed(speed: 600)
sportCar1.ReduceSpeed(speed: 10)

trunkCar1.PutCargoToBody(volume: 19999)
trunkCar1.PutCargoToBody(volume: 2)
trunkCar1.Engine(status: .run)
trunkCar2.Windows(status: .open)

// 6. Вывести сами объекты в консоль.

print("\nTask #6.")
print("Print descriptions...")
print(sportCar1)
print(trunkCar1)
print(trunkCar2)
print("All tasks done.")
