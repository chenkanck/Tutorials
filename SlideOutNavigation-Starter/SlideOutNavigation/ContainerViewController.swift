//
//  ContainerViewController.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOutState {
    case BothCollapsed
    case LeftPanelExpanded
    case RightPanelExpanded
}

class ContainerViewController: UIViewController, UIGestureRecognizerDelegate {

    var centerNavigationController: UINavigationController!
    var centerViewController: CenterViewController!
    var leftViewController: SidePanelViewController?
    var rightViewController: SidePanelViewController?
    var currentState: SlideOutState = .BothCollapsed {
        didSet {
            let shouldShadow = currentState != .BothCollapsed
            showShadowForCenterViewController(shouldShadow)
        }
    }

    let centerPanelExpandedOffset: CGFloat = 60
  override func viewDidLoad() {
    super.viewDidLoad()
    centerViewController = UIStoryboard.centerViewController()
    centerViewController.delegate = self

    centerNavigationController = UINavigationController(rootViewController: centerViewController)
    view.addSubview(centerNavigationController.view)
    addChildViewController(centerNavigationController)
    centerNavigationController.didMoveToParentViewController(self)

    let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
    centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
  }

    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        let gestureIsDraggingfromLeftToRight = recognizer.velocityInView(view).x > 0
        print(NSDate())
        switch recognizer.state {
        case .Began:
            if currentState == .BothCollapsed {
                if gestureIsDraggingfromLeftToRight {
                    addLeftPanelViewController()
                } else {
                    addRightPanelViewController()
                }
                showShadowForCenterViewController(true)
            }
        case .Changed:
            recognizer.view!.center.x = recognizer.view!.center.x + recognizer.translationInView(view).x
            recognizer.setTranslation(CGPointZero, inView: view)
        case .Ended:
            if leftViewController != nil {
                let hasMovedGreaterThanHalfWay = recognizer.view!.center.x > view.bounds.size.width
                animateLeftPanel(shouldExpand: hasMovedGreaterThanHalfWay)
            } else if rightViewController != nil {
                let hasMovedGreaterThanHalfway = recognizer.view!.center.x < 0
                animateRightPancel(shouldExpanded: hasMovedGreaterThanHalfway)
            }
        default:
            break
        }
    }
}

private extension UIStoryboard {
  class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
  
  class func leftViewController() -> SidePanelViewController? {
    return mainStoryboard().instantiateViewControllerWithIdentifier("LeftViewController") as? SidePanelViewController
  }
  
  class func rightViewController() -> SidePanelViewController? {
    return mainStoryboard().instantiateViewControllerWithIdentifier("RightViewController") as? SidePanelViewController
  }
  
  class func centerViewController() -> CenterViewController? {
    return mainStoryboard().instantiateViewControllerWithIdentifier("CenterViewController") as? CenterViewController
  }
  
}


extension ContainerViewController: CenterViewControllerDelegate {
    func toggleLeftPanel() {
        let notAlreadyExpanded = currentState != .LeftPanelExpanded
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    func toggleRightPanel() {
        let notAlreadyExPanded = currentState != .RightPanelExpanded
        if notAlreadyExPanded {
            addRightPanelViewController()
        }
        animateRightPancel(shouldExpanded: notAlreadyExPanded)
    }
    func collapseSidePanels() {
        switch currentState {
        case .RightPanelExpanded:
            toggleRightPanel()
        case .LeftPanelExpanded:
            toggleLeftPanel()
        case .BothCollapsed:
            break

        }
    }

    func addLeftPanelViewController(){
        if leftViewController == nil {
            leftViewController = UIStoryboard.leftViewController()
            leftViewController!.animals = Animal.allCats()
            addChildSidePanelController(leftViewController!)
        }
    }

    func addRightPanelViewController() {
        if rightViewController == nil {
            rightViewController = UIStoryboard.rightViewController()
            rightViewController?.animals = Animal.allDogs()
            addChildSidePanelController(rightViewController!)
        }
    }

    func addChildSidePanelController(sidePanelController: SidePanelViewController) {
        sidePanelController.delegate = centerViewController
        view.insertSubview(sidePanelController.view, atIndex: 0)
        addChildViewController(sidePanelController)
        sidePanelController.didMoveToParentViewController(self)
    }

    func animateRightPancel(shouldExpanded shouldExpanded: Bool) {
        if shouldExpanded {
            currentState = .RightPanelExpanded
            animateCenterPanelXPoistion(-CGRectGetWidth(centerNavigationController.view.frame) + centerPanelExpandedOffset)
        } else {
            animateCenterPanelXPoistion(0, completion: { _ in
                self.currentState = .BothCollapsed
                self.rightViewController?.view.removeFromSuperview()
                self.rightViewController = nil
            })
        }
    }

    func animateLeftPanel(shouldExpand shouldExpand: Bool) {
        if shouldExpand {
            currentState = .LeftPanelExpanded
            animateCenterPanelXPoistion(CGRectGetWidth(centerNavigationController.view.frame) - centerPanelExpandedOffset)
        } else {
            animateCenterPanelXPoistion(0, completion: { finished  in
                self.currentState = .BothCollapsed
                self.leftViewController?.view.removeFromSuperview()
                self.leftViewController = nil
            })
        }
    }

    func animateCenterPanelXPoistion(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil ) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: { () -> Void in
            self.centerNavigationController.view.frame.origin.x = targetPosition
            }, completion: completion)
    }

    func showShadowForCenterViewController(shouldShowShadow: Bool) {
        if shouldShowShadow {
            centerNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
}