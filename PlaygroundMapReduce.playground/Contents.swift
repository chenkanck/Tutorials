//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func square(a: Float) -> Float {
    return a * a
}

func cube(a: Float) -> Float {
    return a * a * a
}


func averageOfFuction(a: Float, b: Float, f: (Float -> Float)) -> Float {
    return (f(a) + f(b)) / 2
}

averageOfFuction(3, b: 4, f: square)
averageOfFuction(3, b: 4, f: cube)

let c = averageOfFuction(3, b: 4) { $0 * $0 }

print(c)

let money: [Int] = [1,2,3,4,5]
let new = money.map { "\($0)$" }

print(new)

let filter = money.filter { $0 > 3 }
print(filter)

let reduce = money.reduce(0) { $0 + $1 }

print(reduce)

let rawString = ["41324", "s2312", "213fadf", "sdasd"]
let filterString = rawString.filter { Int($0) != nil }
print(filterString)

func applyTwice(f: (Float -> Float), x: Float) -> Float {
    return f(f(x))
}

print(applyTwice(square, x: 2))

func applyKTimes(f: (Float -> Float), x: Float, k: Int) -> Float {
    if k == 1 {
        return f(x)
    } else {
        return applyKTimes(f, x: f(x), k: k-1)
    }
}

print(applyKTimes(square, x: 2, k: 2))

let z = money.reduce(0) {$0 < $1 ? $1 : $0}
print(z)