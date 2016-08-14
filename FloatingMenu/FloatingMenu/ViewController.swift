//
//  ViewController.swift
//  FloatingMenu
//
//  Created by xjc on 16/8/13.
//  Copyright © 2016年 xjc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FloatingMenuControllerDelegate {
    
    var imageView: UIImageView!
    @IBOutlet weak var AddBtn: FloatingButton!

    @IBAction func handleMenuButton(sender: AnyObject) {
        
        let controller = FloatingMenuController(fromView: sender as! UIButton)
        
        controller.delegate = self
        
        controller.buttonItems = [
            FloatingButton(image: UIImage(named: "icon-add")),
            FloatingButton(image: UIImage(named: "model-8")),
            FloatingButton(image: UIImage(named: "model-7")),
            FloatingButton(image: UIImage(named: "model-4")),
            FloatingButton(image: UIImage(named: "model-5")),
        ]
        
        controller.labelTitles = [
            "New Contact",
            "Heidi Hernandez",
            "Neil Ross",
            "Elijah Woods",
            "Bella Douglas"
        ]
        
        presentViewController(controller, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        imageView.image = UIImage(named: "inbox")
        view.addSubview(imageView)
        
        view.bringSubviewToFront(AddBtn)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //-MARK: FloatingMenuControllerDelegate
    func floatingMenuController(controller: FloatingMenuController, didTapOnButton button: UIButton, atIndex index: Int) {
        print("tapped index \(index)")
        controller.dismissViewControllerAnimated(true, completion: nil)
    }


}

