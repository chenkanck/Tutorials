//
//  ViewController.swift
//  GCDPlaygroud
//
//  Created by Kan Chen on 5/23/16.
//  Copyright © 2016 Kan Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        test()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func test() {
        let task = delay(5) { print("delay 5 times") }
        cancel(task)
    }

    typealias TASK = (cancel: Bool) -> Void

    func delay(time: NSTimeInterval, task: () -> ()) -> TASK? {

        func dispatch_later(block: () -> ()) {
            dispatch_after(
                dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC))),
                dispatch_get_main_queue(),
                block)
        }

        var closure: dispatch_block_t? = task
        var result: TASK?

        let delayedClosure: TASK = { cancel in
            if let internalClosure = closure {
                if (cancel == false) {
                    dispatch_async(dispatch_get_main_queue(), internalClosure)
                }
            }
            closure = nil
            result = nil
        }
        result = delayedClosure

        dispatch_later { 
            if let delayedClosure = result {
                delayedClosure(cancel: false)
            }
        }
        return result
    }

    func cancel(task: TASK?) {
        task?(cancel: true)
    }
}

