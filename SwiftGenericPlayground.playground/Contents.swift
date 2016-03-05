//: Playground - noun: a place where people can play

import UIKit

func swapTwoValue<T>(inout a:T, inout _ b:T) {
    let temp = a
    a = b
    b = temp
}

var a = 12
var b = 13
swap(&a, &b)

func swap2<Int>(inout a: Int, inout b: Int) {
    let temp = a
    a = b
    b = temp
}

swap(&a, &b)
print("\(a) + \(b)")

var items = [1,3]
items.removeLast()
items.removeLast()
//items.removeLast()

struct Stack<Item> {
    var items: [Item] = []
    mutating func push(x: Item) {
        items.append(x)
    }
    mutating func pop(x: Item) {
        items.removeLast()
    }
}

extension Stack {
    var topItem: Item? {
        return items.last
    }
}

func findStringIndex(string:String, strings: [String]) -> Int? {
    return strings.indexOf(string)
}

func findIndex<T: Equatable >(item: T, items: [T]) -> Int? {
    for (index, value) in items.enumerate() {
        if value == item {
            return index
        }
    }
    return nil
}

protocol Container {
    typealias ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType{ get }
}