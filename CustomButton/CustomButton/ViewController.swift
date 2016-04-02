//
//  ViewController.swift
//  CustomButton
//
//  Created by Kan Chen on 3/30/16.
//  Copyright © 2016 Kan Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button: DRCImagePositionButton!

    override func viewDidLoad() {
        super.viewDidLoad()
//        let button = DRCIconButton()
//
//        button.backgroundColor = UIColor.blueColor()
//        view.addSubview(button)
//        button.buttonTitle = "test"
    }

    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickedButton(sender: AnyObject) {
        print("Tap")
    }
    
}

