//
//  MenuViewController.swift
//  ZoomingIcons
//
//  Created by xjc on 16/8/7.
//  Copyright © 2016年 xjc. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MenuViewController: UICollectionViewController, ZoomingIconViewController {
    
    var selectedIndexPath: NSIndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        // Register cell classes
        self.collectionView!.registerNib(UINib(nibName: "ScoailItemCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        //使collectionView整体移动100个像素（什么单位）
        collectionView?.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //两行
        return 2
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //返回每行的列数
        switch section {
        case 0:
            return 2
        case 1:
            return 3
        default:
            return 0
        }
        
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
        // Configure the cell
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        selectedIndexPath = indexPath
        
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("detailViewController") as! DetailViewController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        //let cellWidth = layout.itemSize.width
        
        let numberOfCells = self.collectionView(collectionView, numberOfItemsInSection:  section)
        let widthOfCells = CGFloat(numberOfCells) * layout.itemSize.width + CGFloat(numberOfCells-1) * layout.minimumInteritemSpacing
        
        let inset = (collectionView.bounds.width - widthOfCells) / 2.0
        
        return UIEdgeInsets(top: 0, left: inset, bottom: 40, right: inset)
        
    }
    
    /**
    *  ZoomingIconViewController protocol
    */
    func zoomingIconColoredViewForTransition(transition: ZoomingIconTransition) -> UIView! {
        if let indexPath = selectedIndexPath {
            let cell = collectionView?.cellForItemAtIndexPath(indexPath) as! ScoailItemCell
            return cell.coloredView
        }else{
            return nil
        }
    }
    
    func zoomingIconImageViewForTransition(transition: ZoomingIconTransition) -> UIImageView! {
        if let indexPath = selectedIndexPath {
            let cell = collectionView?.cellForItemAtIndexPath(indexPath) as! ScoailItemCell
            return cell.imageView
        }else{
            return nil 
        }
    }



}
