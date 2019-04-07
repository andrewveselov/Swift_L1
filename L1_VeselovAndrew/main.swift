//
//  main.swift
//  L1_VeselovAndrew
//
// Swift level 1 Lesson 6 2019-04-04
// Homework
// Andrew Veselov
//
// 1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
// 2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
// 3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.

import Foundation

enum grade: Int {
    case excellent = 5
    case good = 4
    case fair = 3
    case poor = 2
}

enum gender {
    case male, female
}

protocol Grade {
    var grade: grade {get set}
}

class Student: Grade {
    var grade: grade
    var name: String
    var gender: gender
    
    init(name: String, gender: gender, grade: grade) {
        self.name = name
        self.gender = gender
        self.grade = grade
    }
}
extension Student: CustomStringConvertible {
    var description : String {
        return "Name: \(name), Grade: \(grade)\n"
    }
}

struct Stack<T: Grade> {
    private var elements: [T] = []
    
    mutating func push(_ element: T) {
        elements.append(element)
    }
    mutating func pop() -> T? {
        return elements.removeLast()
    }
    
    var gradePointAverage: Double {
        var summ = 0.0
        for element in elements {
            summ += Double(element.grade.rawValue)
        }
        return summ / Double(elements.count)
    }
}

// 2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
extension Stack {
    func filter(predicate:(T) -> Bool) -> [T] {
        var result = [T]()
        for i in elements {
            if predicate(i) {
                result.append(i)
            }
        }
        return result
    }
}


// 3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
 extension Stack {
    // The func checks array index
    func testIndex(index: Int) -> Bool {
        return (elements.count - 1 >= index) && (index >= 0)
    }
    
    subscript(element: Int) -> T? {
        get {
            return testIndex(index: element) ? elements[element] : nil
        }
        set(newValue) {
            
        }
    }
}


print("Fill the student productivity journal...")
var journal = Stack<Student>()
journal.push(Student(name: "Ivan Ivanov", gender: .male, grade: .excellent))
journal.push(Student(name: "Semyon Semyonov", gender: .male, grade: .good))
journal.push(Student(name: "Kira Moon", gender: .female, grade: .excellent))
journal.push(Student(name: "Michael Cook", gender: .male, grade: .excellent))
journal.push(Student(name: "Vera Vasileva", gender: .female, grade: .good))
journal.push(Student(name: "Eva Petrova", gender: .female, grade: .poor))

print(journal)
print("Average grade of students: \(journal.gradePointAverage)")
print("\nList of female students:")
print(journal.filter(predicate: {$0.gender == .female}))
print("\nChecking access to non-existent array index...")
print("index 5: \(journal[5])")
print("index 6: \(journal[6])")
print("\nAll tasks done.")
