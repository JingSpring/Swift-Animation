//
//  DetailViewController.swift
//  ZoomingIcons
//
//  Created by xjc on 16/8/8.
//  Copyright © 2016年 xjc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, ZoomingIconViewController {
    
    @IBOutlet weak var coloredView: UIView!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var backButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var summaryLabelBottomConstraint: NSLayoutConstraint!
    
    
    var item: SocailItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = item {
            coloredView.backgroundColor = item.color
            imageView.image = item.image
            
            titleLabel.text = item.name
            summaryLabel.text = item.summary
        }else{
            coloredView.backgroundColor = UIColor.grayColor()
            imageView.image = nil
            
            titleLabel.text = nil
            summaryLabel.text = nil 
        }
        
    }
    //最后加的一步
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func handleBackButton(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func setupState(initial: Bool) {
        if initial {
            backButtonTopConstraint.constant = -64
            summaryLabelBottomConstraint.constant = -200
        }else{
            backButtonTopConstraint.constant = 0
            summaryLabelBottomConstraint.constant = 80
        }
        view.layoutIfNeeded()
    }
    
    /**
    *  ZoomingIconViewController protocol
    */
    func zoomingIconColoredViewForTransition(transition: ZoomingIconTransition) -> UIView! {
        return coloredView
    }
    
    func zoomingIconImageViewForTransition(transition: ZoomingIconTransition) -> UIImageView! {
        return imageView
    }
    
    func zoomingIconTransition(transition: ZoomingIconTransition, willAnimateTransitionWithOperation operation: UINavigationControllerOperation, isForegroundViewController isForeground: Bool) {
        setupState(operation == .Push)
        
        UIView.animateWithDuration(0.6, delay: operation == .Push ? 0.2 : 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .TransitionNone, animations: { () -> Void in
            [self]
            self.setupState(operation == .Pop)
            }) { (finished) -> Void in
                
        }
        
    }

}
