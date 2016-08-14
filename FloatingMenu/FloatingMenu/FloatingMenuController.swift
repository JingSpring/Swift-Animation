//
//  FloatingMenuController.swift
//  FloatingMenu
//
//  Created by xjc on 16/8/13.
//  Copyright © 2016年 xjc. All rights reserved.
//

import UIKit

//get notified when the buttons are tapped
@objc
protocol FloatingMenuControllerDelegate: class {
    optional func floatingMenuController(controller: FloatingMenuController, didTapOnButton button: UIButton, atIndex index: Int)
    optional func floatingmenuControllerDidCancel(controller: FloatingMenuController)
}

class FloatingMenuController: UIViewController {
    
    let fromView: UIView
    
    let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
    let closeButton = FloatingButton(image: UIImage(named: "icon-close"), backgroundColor: UIColor.flatRedColor)
    
    var buttonDirection = Direction.Up
    var buttonPadding: CGFloat = 70
    var buttonItems = [UIButton]()
    
    weak var delegate: FloatingMenuControllerDelegate?
    
    enum Direction {
        case Up
        case Down
        case Left
        case Right
        
        func offsetPoint(point: CGPoint, offset: CGFloat) -> CGPoint {
            switch self {
            case .Up:
                return CGPoint(x: point.x, y: point.y - offset)
            case .Down:
                return CGPoint(x: point.x, y: point.y + offset)
            case .Left:
                return CGPoint(x: point.x - offset, y: point.y)
            case .Right:
                return CGPoint(x: point.x + offset, y: point.y)
            }
        }
    }
    
    init(fromView: UIView) {
        
        self.fromView = fromView
        super.init(nibName: nil, bundle: nil)
        //make the system doesn't remove the presenting view controller.
        modalPresentationStyle = .OverFullScreen
        modalTransitionStyle = .CrossDissolve
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configButtons(initial: Bool) {
        let parentController = presentingViewController
        let center = parentController!.view.convertPoint(fromView.center, fromView: fromView.superview)
        
        closeButton.center = center
        
        if initial {
            closeButton.alpha = 0
            closeButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
            
            for (_, button) in buttonItems.enumerate() {
                button.center = center
                button.alpha = 0
                button.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
            }
        }else{
            closeButton.alpha = 1
            closeButton.transform = CGAffineTransformIdentity
            
            //enumerate：调用序列 7.0后不再使用：enumerate(buttonItems)
            for (index, button) in buttonItems.enumerate() {
                button.center = buttonDirection.offsetPoint(center, offset: buttonPadding * CGFloat(index+1))
                button.alpha = 1
                button.transform = CGAffineTransformIdentity
            }
            
        }
    }
    
    func animateButton(visible: Bool) {
        configButtons(visible)
        
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .TransitionNone, animations: { () -> Void in
            [self]
            self.configButtons(!visible)
            }, completion: nil)
    }
    
    func handleCloseMenu(sender: AnyObject) {
        // ! /  ? 使用要注意
        delegate?.floatingmenuControllerDidCancel?(self)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //add the method to handle button taps,to find the index to our button and make a call to our delegate
    func handleMenuButton(sender: AnyObject) {
        let button = sender as! UIButton
        if let index = buttonItems.indexOf(button) {
            delegate?.floatingMenuController!(self, didTapOnButton: button, atIndex: index)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        blurredView.frame = view.bounds
        view.addSubview(blurredView)
        view.addSubview(closeButton)
        
        closeButton.addTarget(self, action: "handleCloseMenu:", forControlEvents: .TouchUpInside)
        view.addSubview(closeButton)
        
        for button in buttonItems {
            button.addTarget(self, action: "handleMenuButton:", forControlEvents: .TouchUpInside)
            view.addSubview(button)
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        animateButton(true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        animateButton(false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
