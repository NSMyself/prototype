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
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var pressButton: UIButton!

    let threshold:CGFloat = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pan = UIPanGestureRecognizer(target:self, action:"pan:")
        pan.maximumNumberOfTouches = 1
        pan.minimumNumberOfTouches = 1
        self.topView.addGestureRecognizer(pan)
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
        
        let p:CGPoint = rec.locationInView(self.view)
        var center = CGPoint.zero
        
        switch rec.state {
        case .Began:
            print("began")
            
        case .Changed:
                center = self.topView.center
                let distance = sqrt(pow((center.x - p.x), 2.0) + pow((center.y - p.y), 2.0))
                print("distance \(distance)")
                
                if distance > threshold {
                    self.topView.center.y = p.y// - (p.y % snapY)
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

