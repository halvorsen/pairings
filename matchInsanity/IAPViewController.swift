//
//  IAPViewController.swift
//  matchInsanity
//
//  Created by Aaron Halvorsen on 11/27/16.
//  Copyright © 2016 Aaron Halvorsen. All rights reserved.
//

import UIKit
import CoreData
import StoreKit
import SwiftyStoreKit

class IAPViewController: UIViewController {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var fontSizeMultiplier = UIScreen.main.bounds.width / 375
    var purchase = String()
    
    
    
    //IAP
    
    private func purchaseRetry(productId: String) {
        
        let refreshAlert = UIAlertController(title: "PURCHASE FAILED", message: "Retry?", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            SwiftyStoreKit.purchaseProduct(productId) { result in
                switch result {
                case .success( _):
                    
                    if productId == "pairings.iap.scoreboard" {
                        
                        self.savePurchase()
                        
                    }
                    if productId == "pairings.iap.advancedLevel1" {
                        self.savePurchase()
                        
                    }
                    if productId == "pairings.iap.advancedLevel2" {
                        self.savePurchase()
                        
                    }
                    
                case .error(let error):
                    print("error: \(error)")
                    print("Purchase Failed: \(error)")
                    self.purchaseRetry(productId: productId)
                }            }
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    
    private func purchase(productId: String) {
        var title = String()
        var message = String()
        if productId == "pairings.iap.scoreboard" {
            
            title = "ADD SCOREBOARD"
            message = "Track Highscores?"
        }
        if productId == "pairings.iap.advancedLevel1" {
            
            title = "BUY FOOLISH LEVEL"
            message = "Unlock Level?"
        }
        if productId == "pairings.iap.advancedLevel2" {
            
            
            title = "BUY 3 MORE LEVELS"
            message = "Unlock triples levels?"
        }
        
        
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            SwiftyStoreKit.purchaseProduct(productId) { result in
                switch result {
                case .success( _):
                    
                    if productId == "pairings.iap.scoreboard" {
                        self.savePurchase()
                        
                    }
                    if productId == "pairings.iap.advancedLevel1" {
                        self.savePurchase()
                        
                    }
                    if productId == "pairings.iap.advancedLevel2" {
                        self.savePurchase()
                        
                    }
                    
                case .error(let error):
                    print("error: \(error)")
                    print("Purchase Failed: \(error)")
                    self.purchaseRetry(productId: productId)
                }
            }
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        let gameView: MatchViewController = segue.destination as! MatchViewController
        //        gameView.y = y
        //        gameView.z = z
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha: 1.0)
        addButtons()
        addLines()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func addLines() {
        
    }
    private func addButtons() {
        //Paths
        var start = CGPoint(x: 328*screenWidth/750, y: 435*screenHeight/1332)
        var end = CGPoint(x: 422*screenWidth/750, y: 435*screenHeight/1332)
        let shapeLayer1 = CAShapeLayer()
        let path1 = UIBezierPath()
        path1.move(to: start)
        path1.addLine(to: end)
        shapeLayer1.path = path1.cgPath
        shapeLayer1.strokeColor = UIColor(red: 248/255, green: 223/255, blue: 74/255, alpha: 1.0).cgColor
        shapeLayer1.lineWidth = 1.0
        view.layer.addSublayer(shapeLayer1)
        let shapeLayer2 = CAShapeLayer()
        let path2 = UIBezierPath()
        start = CGPoint(x: 335*screenWidth/750, y: 567*screenHeight/1332)
        end = CGPoint(x: 415*screenWidth/750, y: 567*screenHeight/1332)
        path2.move(to: start)
        path2.addLine(to: end)
        shapeLayer2.path = path2.cgPath
        shapeLayer2.strokeColor = UIColor(red: 248/255, green: 223/255, blue: 74/255, alpha: 1.0).cgColor
        shapeLayer2.lineWidth = 1.0
        view.layer.addSublayer(shapeLayer2)
        let shapeLayer3 = CAShapeLayer()
        let path3 = UIBezierPath()
        start = CGPoint(x: 342*screenWidth/750, y: 698*screenHeight/1332)
        end = CGPoint(x: 408*screenWidth/750, y: 698*screenHeight/1332)
        path3.move(to: start)
        path3.addLine(to: end)
        shapeLayer3.path = path3.cgPath
        shapeLayer3.strokeColor = UIColor(red: 248/255, green: 223/255, blue: 74/255, alpha: 1.0).cgColor
        shapeLayer3.lineWidth = 1.0
        view.layer.addSublayer(shapeLayer3)
        let shapeLayer4 = CAShapeLayer()
        let path4 = UIBezierPath()
        start = CGPoint(x: 268*screenWidth/750, y: 1135*screenHeight/1332)
        end = CGPoint(x: 483*screenWidth/750, y: 1135*screenHeight/1332)
        path4.move(to: start)
        path4.addLine(to: end)
        shapeLayer4.path = path4.cgPath
        shapeLayer4.strokeColor = UIColor(red: 248/255, green: 223/255, blue: 74/255, alpha: 1.0).cgColor
        shapeLayer4.lineWidth = 1.0
        view.layer.addSublayer(shapeLayer4)
        
        
        
        //labels
        let unlockLabel = UILabel()
        unlockLabel.frame.size = CGSize( width: screenWidth, height: (124/1332)*screenHeight)
        unlockLabel.frame.origin.x = 0
        unlockLabel.frame.origin.y = (160/1332)*screenHeight
        unlockLabel.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*75)
        unlockLabel.text = "Unlock"
        unlockLabel.textAlignment = .center
        unlockLabel.textColor = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)
        view.addSubview(unlockLabel)
        
        
        let desc1 = UILabel()
        desc1.frame.size = CGSize( width: (467/750)*screenWidth, height: (50/1332)*screenHeight)
        desc1.frame.origin.x = (144/750)*screenWidth
        desc1.frame.origin.y = (440/1332)*screenHeight
        desc1.font = UIFont(name: "HelveticaNeue", size: fontSizeMultiplier*10)
        desc1.text = "Track your speed and accuracy by saving a high score for each level."
        
        desc1.textAlignment = .center
        desc1.numberOfLines = 0
        desc1.textColor = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)
        view.addSubview(desc1)
        
        let desc2 = UILabel()
        desc2.frame.size = CGSize( width: (467/750)*screenWidth, height: (50/1332)*screenHeight)
        desc2.frame.origin.x = (144/750)*screenWidth
        desc2.frame.origin.y = (572/1332)*screenHeight
        desc2.font = UIFont(name: "HelveticaNeue", size: fontSizeMultiplier*10)
        desc2.text = "Complicate things further by finding three of each symbol. (Unlock 3 Levels)"
        desc2.textAlignment = .center
        desc2.numberOfLines = 0
        desc2.textColor = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)
        view.addSubview(desc2)
        
        let desc3 = UILabel()
        desc3.frame.size = CGSize( width: (467/750)*screenWidth, height: (50/1332)*screenHeight)
        desc3.frame.origin.x = (144/750)*screenWidth
        desc3.frame.origin.y = (704/1332)*screenHeight
        desc3.font = UIFont(name: "HelveticaNeue", size: fontSizeMultiplier*10)
        desc3.text = "Haven’t had enough punishment? Try the largest word pairing puzzle. (Unlock 1 Level)"
        desc3.textAlignment = .center
        desc3.numberOfLines = 0
        desc3.textColor = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)
        view.addSubview(desc3)
        
        let desc4 = UILabel()
        desc4.frame.size = CGSize( width: screenWidth, height: (50/1332)*screenHeight)
        desc4.frame.origin.x = 0
        desc4.frame.origin.y = (800/1332)*screenHeight
        desc4.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*12)
        desc4.text = "More Coming Very Soon!…"
        desc4.textAlignment = .center
        desc4.textColor = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)
        view.addSubview(desc4)
        
        
        //buttons
        
        let arrow = UIButton()
        arrow.frame = CGRect(x: 329*screenWidth/750, y: 41*screenHeight/1332, width: 93*screenWidth/750, height: 76*screenWidth/750)
        arrow.setImage(UIImage(named: "Arrow.png"), for: .normal)
        arrow.tag = 200
        arrow.addTarget(self, action: #selector(IAPViewController.menu(_:)), for: .touchUpInside)
        view.addSubview(arrow)
        
        let scoring = UIButton()
        
        scoring.frame.size = CGSize( width: (450/750)*screenWidth, height: (24/750)*screenWidth)
        scoring.frame.origin.x = 150*screenWidth/750
        scoring.frame.origin.y = (407/1332)*screenHeight
        scoring.tag = 2
        scoring.setTitle("Scoring!", for: UIControlState.normal)
        scoring.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*12)
        scoring.setTitleColor(UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0), for: .normal)
        scoring.addTarget(self, action: #selector(IAPViewController.scoring(_:)), for: .touchUpInside)
        
        self.view.addSubview(scoring)
        
        let triples = UIButton()
        
        triples.frame.size = CGSize( width: (450/750)*screenWidth, height: (24/750)*screenWidth)
        triples.frame.origin.x = 150*screenWidth/750
        triples.frame.origin.y = (539/1332)*screenHeight
        triples.tag = 1
        triples.setTitle("Triples!", for: UIControlState.normal)
        triples.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*12)
        triples.setTitleColor(UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0), for: .normal)
        triples.addTarget(self, action: #selector(IAPViewController.triples(_:)), for: .touchUpInside)
        
        
        self.view.addSubview(triples)
        
        let quad = UIButton()
        
        quad.frame.size = CGSize( width: (450/750)*screenWidth, height: (24/750)*screenWidth)
        quad.frame.origin.x = 150*screenWidth/750
        quad.frame.origin.y = (671/1332)*screenHeight
        quad.tag = 2
        quad.setTitle("Foolish!", for: UIControlState.normal)
        quad.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*12)
        quad.setTitleColor(UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0), for: .normal)
        quad.addTarget(self, action: #selector(IAPViewController.word(_:)), for: .touchUpInside)
        
        
        self.view.addSubview(quad)
        
        let restore = UIButton()
        
        restore.frame.size = CGSize( width: (450/750)*screenWidth, height: (76/750)*screenWidth)
        restore.frame.origin.x = 150*screenWidth/750
        restore.frame.origin.y = (1080/1332)*screenHeight
        restore.tag = 1
        restore.setTitle("Restore Purchases", for: UIControlState.normal)
        restore.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*12)
        restore.setTitleColor(UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0), for: .normal)
        restore.addTarget(self, action: #selector(IAPViewController.restore(_:)), for: .touchUpInside)
        
        self.view.addSubview(restore)
        if UIDevice.current.userInterfaceIdiom == .pad {
            unlockLabel.frame.size = CGSize( width: screenWidth, height: (224/1332)*screenHeight)
            restore.frame.origin.y = (1065/1332)*screenHeight
            quad.frame.origin.y = (661/1332)*screenHeight
            triples.frame.origin.y = (529/1332)*screenHeight
            scoring.frame.origin.y = (397/1332)*screenHeight
        }
        
    }
    
    @objc private func restore(_ sender: UIButton) {
        
        let refreshAlert = UIAlertController(title: "RESTORE", message: "Restore previously purchased items?", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            
            SwiftyStoreKit.restorePurchases() { results in
                if results.restoreFailedProducts.count > 0 {
                    print("Restore Failed: \(results.restoreFailedProducts)")
                    SwiftyStoreKit.restorePurchases() { results in
                        if results.restoreFailedProducts.count > 0 {
                            print("Restore Failed: \(results.restoreFailedProducts)")
                        }
                        else if results.restoredProductIds.count > 0 {
                            print("Restore Success: \(results.restoredProductIds)")
                            let refreshAlert = UIAlertController(title: "Success", message: "You're all set", preferredStyle: UIAlertControllerStyle.alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                                }))
                            self.present(refreshAlert, animated: true, completion: nil)
                            for r in results.restoredProductIds {
                                switch r {
                                case "pairings.iap.scoreboard":
                                    self.purchase = "score"
                                case "pairings.iap.advancedLevel1":
                                    self.purchase = "word"
                                    
                                case "pairings.iap.advancedLevel2":
                                    self.purchase = "triple"
                                default:
                                    break
                                    
                                }
                                
                                self.savePurchase()
                            }
                            
                        }
                        else {
                            print("Nothing to Restore")
                            
                            
                            let alert = UIAlertController(title: "RESTORE ERROR", message: "Nothing to Restore", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                    }
                }
                else if results.restoredProductIds.count > 0 {
                    print("Restore Success: \(results.restoredProductIds)")
                    let refreshAlert = UIAlertController(title: "Success", message: "You're all set", preferredStyle: UIAlertControllerStyle.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                        }))
                    self.present(refreshAlert, animated: true, completion: nil)
                    for r in results.restoredProductIds {
                        switch r {
                        case "pairings.iap.scoreboard":
                            self.purchase = "score"
                        case "pairings.iap.advancedLevel1":
                            self.purchase = "word"
                            
                        case "pairings.iap.advancedLevel2":
                            self.purchase = "triple"
                        default:
                            break
                            
                        }
                        
                        self.savePurchase()
                    }
                    
                    
                } else {
                    print("Nothing to Restore")
                    
                    let alert = UIAlertController(title: "RESTORE ERROR", message: "Nothing to Restore", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    @objc private func word(_ sender: UIButton) {
        purchase = "word"
        purchase(productId: "pairings.iap.advancedLevel1")
    }
    
    @objc private func triples(_ sender: UIButton) {
        purchase = "triple"
        purchase(productId: "pairings.iap.advancedLevel2")
    }
    
    @objc private func scoring(_ sender: UIButton) {
        purchase = "score"
        purchase(productId: "pairings.iap.scoreboard")
    }
    
    @objc private func menu(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toMenuFromIAP", sender: self)
    }
    
    //core data functions
    private func savePurchase() {
        print("purchase attribute: \(purchase)")
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Purchase", into: context)
        entity.setValue(true, forKey: purchase)
        do {
            try context.save()
        } catch {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    
}
