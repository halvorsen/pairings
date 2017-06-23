//
//  TutorialViewController.swift
//  pairings
//
//  Created by Aaron Halvorsen on 4/30/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class TutorialViewController: UIViewController {
    let slide1 = UIImageView()
    let slide2 = UIImageView()
    let slide3 = UIImageView()
    let slide4 = UIImageView()
    var sw: CGFloat {get{return UIScreen.main.bounds.width}}
    var sh: CGFloat {get{return UIScreen.main.bounds.height}}
    var fontSizeMultiplier: CGFloat {get{return UIScreen.main.bounds.width / 375}}
    let playerController = AVPlayerViewController()
    var viewOnScreen = UIImageView()
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let panLeft = UISwipeGestureRecognizer(target: self, action: #selector(TutorialViewController.swipeFuncLeft(_:)))
        let panRight = UISwipeGestureRecognizer(target: self, action: #selector(TutorialViewController.swipeFuncRight(_:)))
        panLeft.direction = .left
        panRight.direction = .right
        view.addGestureRecognizer(panLeft)
        view.addGestureRecognizer(panRight)
        
        view.backgroundColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1.0)
        viewOnScreen = slide1
        setupSlide1()
        setupSlide2()
        setupSlide3()
        setupSlide4()
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc private func swipeFuncRight(_ gesture: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.5) {
            
            switch self.viewOnScreen {
            case self.slide1:
                self.slide2.frame.origin.x += self.sw
                self.delay(bySeconds: 0.5) {
                    
                    self.performSegue(withIdentifier: "fromTutorialToMenu", sender: self)
                    
                    
                }
            case self.slide4:
                self.button.removeFromSuperview()
                
            default:
                self.slide2.frame.origin.x += self.sw
                self.slide1.frame.origin.x += self.sw
                self.slide4.frame.origin.x += self.sw
                self.slide3.frame.origin.x += self.sw
                
            }
        }
        switch viewOnScreen {
            
        case slide2: viewOnScreen = slide1
        case slide3: viewOnScreen = slide2
        case slide4: viewOnScreen = slide3
        default: break
            
        }
        
    }
    @objc private func swipeFuncLeft(_ gesture: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.5) {
            
            
            self.slide1.frame.origin.x -= self.sw
            self.slide2.frame.origin.x -= self.sw
            self.slide3.frame.origin.x -= self.sw
            self.slide4.frame.origin.x -= self.sw
            
        }
        
        switch viewOnScreen {
        case slide1:
            
           
            delay(bySeconds: 0.5) {
              
                self.performSegue(withIdentifier: "fromTutorialToMenu", sender: self)
                
                
            }
        case slide2: viewOnScreen = slide3
        case slide3: viewOnScreen = slide4
        self.view.addSubview(self.button)
        delay(bySeconds: 0.5) {
            UIView.animate(withDuration: 1.0) {
                self.button.alpha = 1.0
            }
            }
        case slide4:
            UIView.animate(withDuration: 0.5) {
                self.button.frame.origin.x -= self.sw
            }
            delay(bySeconds: 0.5) {
                self.button.removeFromSuperview()
                self.performSegue(withIdentifier: "fromTutorialToMenu", sender: self)
                
                
            }
        default: break
            
            
        }
    }
    private func setupSlide1() {
        slide1.frame = CGRect(x: 40*sw/375, y: 70*sh/667, width: 295*sw/375, height: 527*sh/667)
        slide1.image = #imageLiteral(resourceName: "Tutorial1")
        slide1.layer.cornerRadius = sw/50
        slide1.layer.masksToBounds = true
        view.addSubview(slide1)
    }
    private func setupSlide2() {
        slide2.frame = CGRect(x: 40*sw/375 + sw, y: 70*sh/667, width: 295*sw/375, height: 527*sh/667)
       
        slide2.layer.cornerRadius = sw/50
        slide2.layer.masksToBounds = true
        view.addSubview(slide2)
    }
    private func setupSlide3() {
        slide3.frame = CGRect(x: 40*sw/375 + 2*sw, y: 70*sh/667, width: 295*sw/375, height: 527*sh/667)
       
        slide3.layer.cornerRadius = sw/50
        slide3.layer.masksToBounds = true
        view.addSubview(slide3)
    }
    private func setupSlide4() {
        slide4.frame = CGRect(x: 40*sw/375 + 3*sw, y: 70*sh/667, width: 295*sw/375, height: 527*sh/667)
       
        slide4.layer.cornerRadius = sw/50
        slide4.layer.masksToBounds = true
        view.addSubview(slide4)
    }
    public func delay(bySeconds seconds: Double, dispatchLevel: DispatchLevel = .main, closure: @escaping () -> Void) {
        let dispatchTime = DispatchTime.now() + seconds
        dispatchLevel.dispatchQueue.asyncAfter(deadline: dispatchTime, execute: closure)
    }
    
    public enum DispatchLevel {
        case main, userInteractive, userInitiated, utility, background
        var dispatchQueue: DispatchQueue {
            switch self {
            case .main:                 return DispatchQueue.main
            case .userInteractive:      return DispatchQueue.global(qos: .userInteractive)
            case .userInitiated:        return DispatchQueue.global(qos: .userInitiated)
            case .utility:              return DispatchQueue.global(qos: .utility)
            case .background:           return DispatchQueue.global(qos: .background)
            }
        }
    }
    
}
