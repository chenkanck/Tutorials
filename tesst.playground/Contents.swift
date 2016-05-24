//: Playground - noun: a place where people can play


import UIKit

class A {

}
let typeA: A.Type = A.self

class MusicViewController: UIViewController {

}

class AlbumViewController: UIViewController {

}

let usingVCTypes: [AnyClass] = [MusicViewController.self, AlbumViewController.self]

func setupVCs(vcTypes: [AnyClass]) {
    for vcType in vcTypes {
        if vcType is UIViewController.Type {
            let vc = (vcType as! UIViewController.Type).init()
            print(vc)
        }
    }
}

setupVCs(usingVCTypes)

struct Vector2D {
    var x = 0.0
    var y = 0.0
}

infix operator +* {
    associativity none
    precedence 160
}

func +* (left: Vector2D, right: Vector2D) -> Double {
    return left.x * right.x + left.y * right.y
}

let v1 = Vector2D(x: 2, y: 3)
let v2 = Vector2D(x: 1, y: 4)
let reult = v1 +* v2



class MyClass {

}
private var key: Void?

extension MyClass {
    var title: String? {
        get {
            return objc_getAssociatedObject(self, &key) as? String
        }

        set {
            objc_setAssociatedObject(self,
                                     &key, newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

//test commit in master
func printTitle(input: MyClass) {
    if let title = input.title {
        print("Title: \(title)")
    } else {
        print("没有设置")
    }
}

let a = MyClass()
printTitle(a)
a.title = "Swifter.tips"
printTitle(a)
