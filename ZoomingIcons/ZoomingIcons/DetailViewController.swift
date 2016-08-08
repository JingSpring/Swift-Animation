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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func handleBackButton(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
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

}
