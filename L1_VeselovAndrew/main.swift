//
//  main.swift
//  L1_VeselovAndrew
//
// Swift level 1 Lesson 2 2019-03-18
// Homework
// Andrew Veselov
//
// 1. Написать функцию, которая определяет, четное число или нет.
// 2. Написать функцию, которая определяет, делится ли число без остатка на 3.
// 3. Создать возрастающий массив из 100 чисел.
// 4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.
// 5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов.
// Числа Фибоначчи определяются соотношениями Fn=Fn-1 + Fn-2.
//
// 6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги:
// a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
// b. Пусть переменная p изначально равна двум — первому простому числу.
// c. Зачеркнуть в списке числа от 2p до n, считая шагами по p (это будут числа, кратные p: 2p, 3p, 4p, ...).
// d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
// e. Повторять шаги c и d, пока возможно.

import Foundation

// Task #1
// 1. Написать функцию, которая определяет, четное число или нет.

// The evenNumber func returns true if the argument is even and returns false if odd
func evenNumber(number: Int) -> Bool {
    if number % 2 == 0 {
        return true
    } else {
        return false
    }
}

// Task #2
// 2. Написать функцию, которая определяет, делится ли число без остатка на 3.

// The dividedThree func returns true if the argument is divisible by 3 and returns false if not
func dividedThree(number: Int) -> Bool {
    if number % 3 == 0 {
        return true
    } else {
        return false
    }
}

// Task #3
// 3. Создать возрастающий массив из 100 чисел.

// The arrayIncreassingNumbers func fills array of the given dimension of increasing numbers
func arrayIncreassingNumbers(array: inout [Int], dimension: Int) {
    for i in array.count...(dimension - 1) {
        array.append(i)
    }
}

// Task #4
// Удалить из этого массива все четные числа и все числа, которые не делятся на 3.

// The clearArrayTwoThree func removes from the given array all numbers that are divisible by 3 or are even
func clearArrayTwoThree(array: inout [Int]) {
    var i = 0
    while array.count != i {
//        print("i=\(i) \(evenNumber(number: i)) \(dividedThree(number: i))")
        if evenNumber(number: array[i]) || dividedThree(number: array[i]) {
            array.remove(at: i)
//            print("i=\(i) removed")
        } else {
            i += 1
        }
    }
}

// Task #5
// 5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов.
// Числа Фибоначчи определяются соотношениями Fn=Fn-1 + Fn-2.
//

// The addNextFibo func adds the Fibonacci number to the next element of the array
func addNextFibo(array: inout [Double]) {
    switch array.count {
    case 0:                 // the first element is known
        array.append(0)
    case 1:                 // the second element is known too
        array.append(1)
    default:
        array.append(array[array.count - 1] + array[array.count - 2])
    }
}

// Task #6
// 6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги:
// a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
// b. Пусть переменная p изначально равна двум — первому простому числу.
// c. Зачеркнуть в списке числа от 2p до n, считая шагами по p (это будут числа, кратные p: 2p, 3p, 4p, ...).
// d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
// e. Повторять шаги c и d, пока возможно.

// The primes func returns an array of prime numbers found Eratosthenes method in the range from 1 to "width" in the amount of "numbers" (where "width" and "numbers" are func arguments)
func primes(width: Int, numbers: Int) -> [Int] {
    var workArray: [Int] = []
    var index = 2
    arrayIncreassingNumbers(array: &workArray, dimension: width)
    workArray[1] = 0
    while index < width {
        if workArray[index] != 0 {
            var j = index * 2
            while j < width {
                workArray[j] = 0
                j += index
            }
        }
        index += 1
    }
    // clear and trim array
    var i = 0
    while workArray.count != i {
        if workArray[i] == 0 || i >= numbers{
            workArray.remove(at: i)
        } else {
            i += 1
        }
    }
    return workArray
}
    
print("Task #3.")
print("Creating array...")
var arrayIncr: [Int] = []
arrayIncreassingNumbers(array: &arrayIncr, dimension: 100)
print(arrayIncr)

print("\nTask #4.")
print("Filtring array...")
clearArrayTwoThree(array: &arrayIncr)
print(arrayIncr)

print("\nTask #5.")
print("Filling the array with Fibonacci numbers...")
var arrayFibo: [Double] = []
for _ in 1...100 {
    addNextFibo(array: &arrayFibo)
}
print(arrayFibo)

print("\nTask #6.")
print("The array with prime numbers...")
print(primes(width: 1000, numbers: 100))

print("\n\nAll tasks done.")
