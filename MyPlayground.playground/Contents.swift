//: Playground - noun: a place where people can play

import UIKit

var str = "Wed Apr 27, 2016 10:30AM"
let formatter = NSDateFormatter()
formatter.dateFormat = "E MM dd, yyyy hh:mma"
let date = formatter.dateFromString(str)
