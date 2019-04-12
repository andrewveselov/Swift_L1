//
//  main.swift
//  L1_VeselovAndrew
//
// Swift level 1 Lesson 7 2019-04-09
// Homework
// Andrew Veselov
//
// 1. Придумать класс, методы которого могут создавать непоправимые ошибки. Реализовать их с помощью try/catch.
// 2. Придумать класс, методы которого могут завершаться неудачей. Реализовать их с использованием Error.

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

enum StackError: Error {
    case indexOutOfRange
    case stackEmpty
}

struct Stack<T: Grade> {
    private var elements: [T] = []
    
    mutating func push(_ element: T) {
        elements.append(element)
    }
    mutating func pop() -> T? {
        return elements.removeLast()
    }

// 1. Придумать класс, методы которого могут создавать непоправимые ошибки. Реализовать их с помощью try/catch.
    func gradePointAverage() throws -> Double  {
        guard !elements.isEmpty else {
            throw StackError.stackEmpty
        }
        var summ = 0.0
        for element in elements {
            summ += Double(element.grade.rawValue)
        }
        return summ / Double(elements.count)
    }
}

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

 extension Stack {
    // The func checks array index
    func testIndex(index: Int) -> Bool {
        return (elements.count - 1 >= index) && (index >= 0)
    }
    
// 2. Придумать класс, методы которого могут завершаться неудачей. Реализовать их с использованием Error.
    
    subscript(element: Int) -> (T?, StackError?) {
        get {
            return testIndex(index: element) ? (elements[element], nil) : (nil, StackError.indexOutOfRange)
        }
        set(newValue) {
            
        }
    }
}

var journal = Stack<Student>()
var gradePointAverage: Double

print("Test try ... catch processing...")
do {
    gradePointAverage = try journal.gradePointAverage()
    print("Average grade of students: \(gradePointAverage)")
} catch StackError.stackEmpty {
    print("?Error: Journal is empty.")
}

print("Fill the student productivity journal...")
journal.push(Student(name: "Ivan Ivanov", gender: .male, grade: .excellent))
journal.push(Student(name: "Semyon Semyonov", gender: .male, grade: .good))
journal.push(Student(name: "Kira Moon", gender: .female, grade: .excellent))
journal.push(Student(name: "Michael Cook", gender: .male, grade: .excellent))
journal.push(Student(name: "Vera Vasileva", gender: .female, grade: .good))
journal.push(Student(name: "Eva Petrova", gender: .female, grade: .poor))
print(journal)
do {
    gradePointAverage = try journal.gradePointAverage()
    print("Average grade of students: \(gradePointAverage)")
} catch StackError.stackEmpty {
    print("?Error: Journal is empty.")
}

print("\nError handling test...")
let index = 6
if let student = journal[index].0 {
    print("Student's name: \(student.name)")
} else if let error = journal[index].1 {
    print("?Error: \(error)")
}

print("\nAll tasks done.")
