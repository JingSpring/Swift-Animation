//
//  TipViewViewController.swift
//  SpinningTips
//
//  Created by xjc on 16/8/4.
//  Copyright © 2016年 xjc. All rights reserved.
//

import UIKit

private let kTipViewOffset: CGFloat = 500
private let kTipViewHeight: CGFloat = 400
private let kTipViewWidth: CGFloat = 300

class TipViewViewController: UIViewController {
    
    var tips = [Tip]()
    var index = 0
    
    var tipView: TipView!
    var animator: UIDynamicAnimator!
    var attachmentBehavior: UIAttachmentBehavior!
    var snapBehavior: UISnapBehavior!
    var panBehavior: UIAttachmentBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设为白色则不会使界面全黑
        self.view.backgroundColor = UIColor(white: 1, alpha: 0.6)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setupAnimator()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    enum TipViewPosition: Int {
        case Default
        case RotatedLeft
        case RotatedRight
        
        func viewCenter(var center: CGPoint) -> CGPoint {
            switch self {
            case .RotatedLeft:
                center.y += kTipViewOffset
                center.x -= kTipViewOffset
            case .RotatedRight:
                center.y += kTipViewOffset
                center.x += kTipViewOffset
            default:
                ()
            }
            return center
        }
        func viewTransform() -> CGAffineTransform {
            switch self {
            case .RotatedLeft:
                return CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
                
            case .RotatedRight:
                return CGAffineTransformMakeRotation(CGFloat(M_PI_2))
                
            default:
                return CGAffineTransformIdentity
            }
        }
    }
    
    func createTipView() -> TipView? {
        
        if let view = UINib(nibName: "TipView", bundle: nil).instantiateWithOwner(nil, options: nil).first as! TipView? {
            
            view.frame = CGRect(x: 0, y: 0, width: kTipViewWidth, height: kTipViewHeight)
            
            return view
        }
        return nil
    }
    
    func updateTipView(tipView: UIView, position: TipViewPosition) {
        let center = CGPoint(x: CGRectGetWidth(view.bounds)/2, y: CGRectGetHeight(view.bounds)/2)
        tipView.center = position.viewCenter(center)
        tipView.transform = position.viewTransform()
    }
    
    func resetTipView(tipView: UIView, position: TipViewPosition) {
        animator.removeAllBehaviors()
        
        updateTipView(tipView, position: position)
        animator.updateItemUsingCurrentState(tipView)
        
        animator.addBehavior(attachmentBehavior)
        animator.addBehavior(snapBehavior)
    }
    
    func setupAnimator() {
        animator = UIDynamicAnimator(referenceView: view)
        
        var center = CGPoint(x: CGRectGetWidth(view.bounds)/2, y: CGRectGetHeight(view.bounds)/2)
        
        tipView = createTipView()
        view.addSubview(tipView)
        snapBehavior = UISnapBehavior(item: tipView, snapToPoint: center)
        
        center.y += kTipViewOffset
        attachmentBehavior = UIAttachmentBehavior(item: tipView, offsetFromCenter: UIOffset(horizontal: 0, vertical: kTipViewOffset), attachedToAnchor: center)
        
        setupTipView(tipView, index: 0)
        resetTipView(tipView, position: .RotatedRight)
        
        let pan = UIPanGestureRecognizer(target: self, action: "panTipView:")
        view.addGestureRecognizer(pan)
        
    }
    
    func panTipView(pan: UIPanGestureRecognizer) {
        let location = pan.locationInView(view)
        
        switch pan.state {
        case .Began:
            animator.removeBehavior(snapBehavior)
            panBehavior = UIAttachmentBehavior(item: tipView, attachedToAnchor: location)
            animator.addBehavior(panBehavior)
            
        case .Changed:
            panBehavior.anchorPoint = location
            
        case .Ended:
            fallthrough
        case .Cancelled:
            let center = CGPoint(x: CGRectGetWidth(view.bounds)/2, y: CGRectGetHeight(view.bounds)/2)
            let offset = location.x - center.x
            if fabs(offset) < 100 {
                animator.removeBehavior(panBehavior)
                animator.addBehavior(snapBehavior)
            }else{
                
                var nextIndex = self.index
                var position = TipViewPosition.RotatedRight
                var nextPosition = TipViewPosition.RotatedLeft
                
                if offset > 0 {
                    nextIndex -= 1
                    nextPosition = .RotatedLeft
                    position = .RotatedRight
                }else{
                    nextIndex += 1
                    nextPosition = .RotatedRight
                    position = .RotatedLeft
                }
                
                if nextIndex < 0 {
                    nextIndex = 0
                    nextPosition = .RotatedRight
                }
                
//                let position = offset > 0 ? TipViewPosition.RotatedRight : TipViewPosition.RotatedLeft
//                let nextPosition = offset > 0 ? TipViewPosition.RotatedLeft : TipViewPosition.RotatedRight
                let duration = 0.4
                
                let center = CGPoint(x: CGRectGetWidth(view.bounds)/2, y: CGRectGetHeight(view.bounds)/2)
                
                panBehavior.anchorPoint = position.viewCenter(center)
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(duration * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                    [self]
                    if nextIndex >= self.tips.count {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }else{
                        self.index = nextIndex
                        self.setupTipView(self.tipView, index: nextIndex)
                        self.resetTipView(self.tipView, position: nextPosition)
                    }
                }
            }
        default:
            ()
        }
    }
    
    func setupTipView(tipView: TipView, index: Int) {
        if index < tips.count {
            let tip = tips[index]
            tipView.tip = tip
            
            
            tipView.pageControl.numberOfPages = tips.count
            tipView.pageControl.currentPage = index
        }else{
            tipView.tip = nil
        }
    }

}



extension UIViewController {
    
    func presentTips(tips: [Tip], animated: Bool, completion: (() -> Void)?) {
        
        let controller = TipViewViewController()
        controller.tips = tips
        controller.modalPresentationStyle = .OverFullScreen
        controller.modalTransitionStyle = .CrossDissolve
        presentViewController(controller, animated: animated, completion: completion)
    }
}

