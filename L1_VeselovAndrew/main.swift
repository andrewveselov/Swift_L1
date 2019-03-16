//
//  main.swift
//  L1_VeselovAndrew
//
//  Created by Andrew Veselov on 15/03/2019.
//  Copyright © 2019 Andrew Veselov. All rights reserved.
//
// Swift level 1 2019-03-14
// Homework
// Andrew Veselov
//
// 1. Решить квадратное уравнение.
// 2. Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.
// 3. * Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.
//

import Foundation
// Task #1
// 1. Решить квадратное уравнение.
//
print("Task #1. Quardic equation:")
print("ax² + bx + c = 0")
print("Eneter a (a≠0):")
guard var input:String = readLine(),
    let a = Double(input), a != 0 else {
        print("?Wrong input")
        exit(0)
}

print("Eneter b:")
input = readLine()!
guard let b = Double(input) else {
    print("?Wrong input")
    exit(0)
}
print("Eneter c:")
input = readLine()!
guard let c = Double(input) else {
    print("?Wrong input")
    exit(0)
}
print("\(a)x² + \(b)x + \(c) = 0")

let discriminant = b*b-4*a*c
if discriminant == 0 {
    let x = (-b)/(2*a)
    print("x₁,₂ = \(x)")
} else if discriminant < 0 {
    print("No solutions in real numbers.")
} else {
    let x1 = (-b + sqrt(discriminant))/(2*a)
    let x2 = (-b - sqrt(discriminant))/(2*a)
    print("x₁ = \(x1) , x₂ = \(x2)")
}

// Task #2
// 2. Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.
//
print("\n\nTask #2.")
print("Enter the length of the first leg of the triangle:")
input = readLine()!
guard let leg1 = Double(input), leg1 > 0 else {
    print("?Wrong input")
    exit(0)
}
print("Enter the length of the second leg of the triangle:")
input = readLine()!
guard let leg2 = Double(input), leg2 > 0 else {
    print("?Wrong input")
    exit(0)
}
let area = leg1 * leg2 / 2
let hypotenuse = sqrt (leg1 * leg1 + leg2 * leg2)
let perimeter = leg1 + leg2 + hypotenuse
print("aria = \(area) perimeter = \(perimeter) hypotenuse = \(hypotenuse)")

// Task #3
// 3. * Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.
//
print("\n\nTask #3.")
print("Enter deposit amount:")
input = readLine()!
guard let deposit = Double(input), deposit > 0 else {
    print("?Wrong input")
    exit(0)
}

print("Enter deposit percentage:")
input = readLine()!
guard let percentage = Double(input), percentage >= 0 else {
    print("?Wrong input")
    exit(0)
}
var depositAmount: Double = deposit

for _ in 1...5 {
    depositAmount = depositAmount + depositAmount * percentage / 100
}
print("The deposit amount after 5 years with percentages capitalization will be \(depositAmount)")

print("\n\nAll tasks done.")
