//
//  ViewController.swift
//  TestSync
//
//  Created by Kan Chen on 3/28/16.
//  Copyright © 2016 Kan Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var critical: Int = 0
        let serial_queue = dispatch_queue_create("serial", DISPATCH_QUEUE_CONCURRENT)
        let lock = NSLock()
        dispatch_async(serial_queue) {
            lock.lock()
            critical += 1
            print(critical)
            lock.unlock()
        }

        dispatch_sync(serial_queue) {
            lock.lock()
            critical += 3
            print(critical)
            lock.unlock()
        }

        dispatch_async(serial_queue) {
            for _ in 0..<10 {
                self.method1()
            }
        }
        dispatch_async(serial_queue) {
            for _ in 0..<10 {
                self.method2()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var two = 0
    var one = 0
    func method1() {
        one += 1
        print(one)
    }
    func method2() {
        two += 1
        print(two)
    }

}

