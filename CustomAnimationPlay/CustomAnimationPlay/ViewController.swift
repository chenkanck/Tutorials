//
//  ViewController.swift
//  CustomAnimationPlay
//
//  Created by Kan Chen on 2/17/16.
//  Copyright © 2016 Kan Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func click(sender: AnyObject) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("formsheet") as!FormSheetViewController
        presentModalViewController(vc, formView: button)
    }

    func presentModalViewController(modalViewController: UIViewController, formView: UIView) {
        modalViewController.modalPresentationStyle = .FormSheet
        presentViewController(modalViewController, animated: false, completion: nil)
        let originalShadowColor = modalViewController.view.layer.shadowColor
        modalViewController.view.layer.shadowColor = UIColor.clearColor().CGColor

        let originalFrame = modalViewController.view.frame
        modalViewController.view.frame = formView.frame
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            modalViewController.view.frame = originalFrame
            }) { (finished) -> Void in
                modalViewController.view.superview?.layer.shadowColor = originalShadowColor
        }
    }
}

