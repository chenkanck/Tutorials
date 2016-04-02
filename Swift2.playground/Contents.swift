//: Playground - noun: a place where people can play

import UIKit

var array = Array(1...10)
array.removeFirst()
for number in array {
    print(number)
}


func printGreeting() {
    print("This is on line \(__LINE__) of \(__FUNCTION__) , \(__COLUMN__), \(__FILE__)")
}

printGreeting()