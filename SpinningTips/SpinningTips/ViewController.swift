//
//  ViewController.swift
//  SpinningTips
//
//  Created by xjc on 16/8/4.
//  Copyright © 2016年 xjc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    func tapTipView() {
        
        presentTips([
            Tip(title: "Tip #1: Don't Blink", summary: "Fastastic shot of Sarah for the ALS Ice Bucket Chanllenge - And yes, she tried her hardest not to blink!", image: UIImage(named: "als-ice-bucket-challenge")),
            Tip(title: "Tip #2: Explore", summary: "Get out of the house!", image: UIImage(named: "arch-architecture")),
            Tip(title: "Tip #3: Take in the Moment", summary: "Remember that each moment is unique and will never come again", image: UIImage(named: "man-mountains"))], animated: true, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true 
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let Tap = UITapGestureRecognizer(target: self, action: "tapTipView")
        
        self.view.addGestureRecognizer(Tap)
        //双击才能打开
        if Tap.numberOfTapsRequired == 2 {
           tapTipView()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

