//
//  DetailViewController.swift
//  ZoomingIcons
//
//  Created by xjc on 16/8/8.
//  Copyright © 2016年 xjc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

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

}
