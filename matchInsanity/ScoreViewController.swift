//
//  ScoreViewController.swift
//  matchInsanity
//
//  Created by Aaron Halvorsen on 12/5/16.
//  Copyright © 2016 Aaron Halvorsen. All rights reserved.
//

import UIKit
import CoreData
import GCHelper

class ScoreViewController: UIViewController {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var fontSizeMultiplier = UIScreen.main.bounds.width / 375
    var annotations = ["Sanity", "Absurd", "Insane", "Wise", "Farcical", "Foolish", "Sensible", "Ridiculous", "Idiotic","0","0","0","0","0","0","0","0","0"]
    var levels = ["sanity", "absurd", "insane", "wise", "farcical", "foolish", "sensible", "ridiculous", "idiotic"]
    var array = [Int]()
    var highScores: [Int] = [0,0,0,0,0,0,0,0,0]
    
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha: 1.0)
        loadData()
        addButtons()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addDataToGameCenter()
    }
    private func addDataToGameCenter() {
     
            for i in 0...8 {
                if highScores[i] > 0 {
                GCHelper.sharedInstance.reportLeaderboardIdentifier(annotations[i], score: highScores[i])
                }
            }
        
    }
    
    @objc private func showGameCenterVC(_ sender: UIButton) {
        GCHelper.sharedInstance.showGameCenter(self, viewState: .leaderboards)
    }
    
    private func loadData() {
        print("loaddata")
        var resultsScoreRequest = [AnyObject]()
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context = appDel.persistentContainer.viewContext
        
        let scoreRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HighScores")
        
        do { resultsScoreRequest = try context.fetch(scoreRequest) } catch  {
            print("Could not cache the response \(error)")
        }
 
        if resultsScoreRequest.count > 0 {
            
            for i in 0...8 {
                
                //   var score: Int? = 0
                var maxNumber: Int
                for result in resultsScoreRequest {
                    if let score = result.value(forKey: levels[i]) as! Int? {
                        
                        array.append(score)
                    }
                    
                }
                if array.count > 0 {
                    maxNumber = array.max()!
                        annotations[i+9] = String(maxNumber)
                    print("maxscore")
                        print(maxNumber)
                    print("i: \(i)")
                    highScores[i] = maxNumber
                    }
                array.removeAll()
                
            }
        }
    }
    
    private func addButtons() {
        
        //buttons
        let arrow = UIButton()
        arrow.frame = CGRect(x: 329*screenWidth/750, y: 41*screenHeight/1332, width: 93*screenWidth/750, height: 76*screenWidth/750)
        arrow.setImage(UIImage(named: "Arrow.png"), for: .normal)
        arrow.tag = 200
        arrow.addTarget(self, action: #selector(ScoreViewController.menu(_:)), for: .touchUpInside)
        view.addSubview(arrow)
        
        let gameCenter = UIButton()
        gameCenter.frame = CGRect(x: (343/750)*screenWidth, y: (1050/1332)*screenHeight, width: 64*screenWidth/750, height: 64*screenWidth/750)
        gameCenter.setImage(UIImage(named: "gc.png"), for: .normal)
        gameCenter.addTarget(self, action: #selector(ScoreViewController.showGameCenterVC(_:)), for: .touchUpInside)
        self.view.addSubview(gameCenter)
        
        //Labels
        let menuLabel = UILabel()
        if UIDevice.current.userInterfaceIdiom == .pad {
            menuLabel.frame.size = CGSize( width: screenWidth, height: (224/1332)*screenHeight)
        } else {
            menuLabel.frame.size = CGSize( width: screenWidth, height: (124/1332)*screenHeight)
        }
        
        menuLabel.frame.origin.x = 0
        menuLabel.frame.origin.y = (160/1332)*screenHeight
        menuLabel.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*75)
        menuLabel.text = "Scores"
        menuLabel.textAlignment = .center
        menuLabel.textColor = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)
        view.addSubview(menuLabel)
        
        let topMargin: CGFloat = 444*screenHeight/1332
        let margin: CGFloat = 59*screenHeight/1332
        
        
        
        for i in 0...17 {
            let annotation = UILabel()
            
            annotation.text = annotations[i]
            annotation.frame.origin.x = 106*screenWidth/750
            annotation.textColor = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)
            annotation.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*20)
            annotation.frame.size = CGSize( width: (220/750)*screenWidth, height: (76/750)*screenWidth)
            annotation.textAlignment = .left
            annotation.frame.origin.y = topMargin + CGFloat(i)*margin
            if i > 8 {
                annotation.frame.origin.x += 380*screenWidth/750
                annotation.textAlignment = .right
                annotation.frame.size = CGSize( width: (159/750)*screenWidth, height: (76/750)*screenWidth)
                annotation.frame.origin.y = topMargin + CGFloat(i-9)*margin
                
            }
            view.addSubview(annotation)
        }
        
    }
    
    @objc private func menu(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toMenuFromScore", sender: self)
    }
}
