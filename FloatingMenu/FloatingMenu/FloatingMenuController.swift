//
//  FloatingMenuController.swift
//  FloatingMenu
//
//  Created by xjc on 16/8/13.
//  Copyright © 2016年 xjc. All rights reserved.
//

import UIKit

class FloatingMenuController: UIViewController {
    
    let fromView: UIView
    
    let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
    let closeButton = FloatingButton(image: UIImage(named: "icon-close"), backgroundColor: UIColor.flatRedColor)
    
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
    
    func configButtons() {
        let parentController = presentingViewController
        let center = parentController!.view.convertPoint(fromView.center, fromView: fromView.superview)
        
        closeButton.center = center
    }
    
    func handleCloseMenu(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        blurredView.frame = view.bounds
        view.addSubview(blurredView)
        view.addSubview(closeButton)
        
        closeButton.addTarget(self, action: "handleCloseMenu:", forControlEvents: .TouchUpInside)
        view.addSubview(closeButton)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
