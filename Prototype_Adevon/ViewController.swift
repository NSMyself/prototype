//
//  ViewController.swift
//  Prototype_Adevon
//
//  Created by Ricardo Figueira on 12/02/16.
//  Copyright © 2016 Ricardo Figueira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var loveButton: UIButton!
    @IBOutlet weak var pressButton: UIButton!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    let threshold:CGFloat = 5.0
    let minHeight:CGFloat = 200
    var lastTopViewFrame = CGRect.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pan = UIPanGestureRecognizer(target:self, action:"pan:")
        pan.maximumNumberOfTouches = 1
        pan.minimumNumberOfTouches = 1
        self.topView.addGestureRecognizer(pan)
        
        self.view.bringSubviewToFront(self.topView)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.lastTopViewFrame = self.topView.frame
    }
    
    //MARK: - Icon animation
    @IBAction func pressButtonDidPress(sender: AnyObject) {
        twitterButton.transform = CGAffineTransformMakeTranslation(0, 50)
        emailButton.transform = CGAffineTransformMakeTranslation(0, 50)
        loveButton.transform = CGAffineTransformMakeTranslation(0, 50)
        
        twitterButton.alpha = 0
        emailButton.alpha = 0
        loveButton.alpha = 0
        
        
        springWithDelay(0.72, delay: 0.00, damping: 0.42, velocity: 0.1, animations: {
            self.loveButton.transform = CGAffineTransformMakeTranslation(0, 0)
            self.loveButton.alpha = 1
        })
        
        springWithDelay(0.72, delay: 0.11, damping: 0.42, velocity: 0.1, animations: {
            self.twitterButton.transform = CGAffineTransformMakeTranslation(0, 0)
            self.twitterButton.alpha = 1
        })
        
        springWithDelay(0.72, delay: 0.22, damping: 0.42, velocity: 0.1, animations: {
            self.emailButton.transform = CGAffineTransformMakeTranslation(0, 0)
            self.emailButton.alpha = 1
        })
      }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Panning
    func pan(rec:UIPanGestureRecognizer) {
        
        //heightConstraint.active = false
        
        switch rec.state {
            case .Began:
                print("began")
            
            case .Changed:
                
                    let locationInView = rec.locationInView(self.view)

                    let incrementalHeight = locationInView.y - self.lastTopViewFrame.maxY
                    let resizedHeight = self.topView.frame.height + incrementalHeight
                    /*print("incremental: \(incrementalHeight)")
                    print("old Height: \(self.topView.frame.height)")
                    print("new Height: \(resizedHeight)")*/


                    if (resizedHeight <= 1200) {
                        self.topView.frame = CGRect(x: self.topView.frame.origin.x, y: self.topView.frame.origin.y, width: self.topView.frame.width, height: resizedHeight)
                        
                        
                        let bottomHeight = self.view.frame.height - resizedHeight
                        
                        self.bottomView.frame = CGRect(x: self.bottomView.frame.origin.x, y: self.view.frame.maxY - bottomHeight, width: self.bottomView.frame.width, height: bottomHeight)
                        
                        self.lastTopViewFrame = self.topView.frame
                    }
                    
                
            case .Ended:
                print("ended")
            case .Possible:
                print("possible")
            case .Cancelled:
                print("cancelled")
            case .Failed:
                print("failed")
        }
    }
}

