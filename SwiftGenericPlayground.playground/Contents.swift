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

struct Stack<Item>: Container {
    var items: [Item] = []
    mutating func push(x: Item) {
        items.append(x)
    }
    mutating func pop(x: Item) {
        items.removeLast()
    }
    typealias ItemType = Item
    mutating func append(item: ItemType) {
        push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i:Int) -> ItemType {
        return items[i]
    }

}

extension Stack {
    var topItem: Item? {
        return items.last
    }
}
struct IntStack: Container {
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }

//    typealias ItemType = Int
    mutating func append(item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

func allItemMatch<C1: Container, C2: Container where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>(someContainer:C1, _ anotherContainer: C2) -> Bool {
    if someContainer.count != anotherContainer.count {
        return false
    }
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    return true
}
extension Array: Container {}
var stackOfString = Stack<String>()
stackOfString.push("uno")
stackOfString.push("dos")
stackOfString.push("tres")
var arrayOfString = ["uno", "dos", "tres"]
if allItemMatch(arrayOfString, stackOfString) {
    print("good")
}