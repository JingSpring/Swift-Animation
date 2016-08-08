//
//  ZoomingIconTransition.swift
//  ZoomingIcons
//
//  Created by xjc on 16/8/8.
//  Copyright © 2016年 xjc. All rights reserved.
//

import UIKit

private let kZoomingIconTransitionDuration: NSTimeInterval = 0.6

class ZoomingIconTransition: NSObject, UIViewControllerAnimatedTransitioning, UINavigationControllerDelegate {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return kZoomingIconTransitionDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(transitionContext)
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()
        
        //setup animation
        containerView?.addSubview(fromViewController.view)
        containerView?.addSubview(toViewController.view)
        toViewController.view.alpha = 0
        
        //perform animation
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .TransitionNone, animations: { () -> Void in
            [self]
            toViewController.view.alpha = 1
            }) { (finished) -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
        
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
