//
//  MenuViewController.swift
//  matchInsanity
//
//  Created by Aaron Halvorsen on 11/27/16.
//  Copyright © 2016 Aaron Halvorsen. All rights reserved.
// soundness, absurdity, insane

import UIKit
import CoreData
import StoreKit
import SwiftyStoreKit
import GCHelper

class MenuViewController: UIViewController {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var fontSizeMultiplier = UIScreen.main.bounds.width / 375
    let IAP = UIButton()
    let IAP2 = UIButton()
    var resultsTutorialRequest = [AnyObject]()
    var resultsGameRequest = [AnyObject]()
    var access = 1
    var centerPoint = CGPoint()
    var y = Int()
    var z = Int()
    var game = String()
    var gameData = String()
    var bool200 = false
    var list = [String]()
    var done = [Int]()
    var index = [Int]()
    var isToSegue = false
    var isToMatch = false
 //   var startTutorialBool = false
    let levelsData = ["Sanity", "Absurd", "Insane", "Wise", "Farcical", "Foolish", "Sensible", "Ridiculous", "Idiotic"]
    var unlockedWord = false
    var unlockedTriple = false
    var unlockedScore = false
    var score: Int = 0
    var time: Int = 0
    var purchase = String()
    var didDataLoad = false
    var annotations = ["Sanity", "Absurd", "Insane", "Wise", "Farcical", "Foolish", "Sensible", "Ridiculous", "Idiotic","0","0","0","0","0","0","0","0","0"]
    var levels = ["sanity", "absurd", "insane", "wise", "farcical", "foolish", "sensible", "ridiculous", "idiotic"]
    var array = [Int]()
    var highScores: [Int] = [0,0,0,0,0,0,0,0,0]
    
    //GC
    
    private func loadDataGC() {
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
    
    private func addDataToGameCenter() {
        
        for i in 0...8 {
            if highScores[i] > 0 {
                GCHelper.sharedInstance.reportLeaderboardIdentifier(annotations[i], score: highScores[i])
            }
        }
        
    }
    
    //IAP
    
    private func savePurchase() {
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Purchase", into: context)
        entity.setValue(true, forKey: purchase)
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        loadLevelAccess()
    }
    
    
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
            
            title = "SCOREBOARD LOCKED"
            message = "Unlock Highscores?"
        }
        if productId == "pairings.iap.advancedLevel1" {
            
            title = "LEVEL IS LOCKED"
            message = "Unlock Level?"
        }
        if productId == "pairings.iap.advancedLevel2" {
            
            
            title = "LEVEL IS LOCKED"
            message = "Unlock all triple levels?"
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
    
    private func purchaseWord() {
        purchase = "word"
        purchase(productId: "pairings.iap.advancedLevel1")
    }
    
    private func purchaseTriples() {
        purchase = "triple"
        purchase(productId: "pairings.iap.advancedLevel2")
    }
    
    private func purchaseScoring() {
        purchase = "score"
        purchase(productId: "pairings.iap.scoreboard")
    }
    
    
    //End IAP
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if isToSegue {
            let gameView: SegueViewController = segue.destination as! SegueViewController
            gameView.y = y
            gameView.z = z
            gameView.game = game
            gameView.gameData = gameData
            gameView.list = list
            gameView.index = index
            gameView.done = done
            gameView.score = score
            gameView.time = time
        } else if isToMatch {
            let gameView: MatchViewController = segue.destination as! MatchViewController
            gameView.y = y
            gameView.z = z
            gameView.game = game
            gameView.gameData = gameData
            gameView.list = list
            gameView.index = index
            gameView.done = done
            gameView.score = score
            gameView.time = time
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha: 1.0)
        
        gameData = "Sanity"
        game = "sanity"
        shouldIDoTutorial()
        loadLevelAccess()
        loadDataGC()
        addDataToGameCenter()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "launchedPairingsGameBefore") {
            print("Not first launch.")
            
        } else {
            let myView = UIView()
            myView.backgroundColor = .black
            myView.frame = view.bounds
            view.addSubview(myView)
            UserDefaults.standard.set(true, forKey: "launchedPairingsGameBefore")
            self.performSegue(withIdentifier: "fromMenuToTutorial", sender: self)
            
        }
    }
    
    
    @objc private func scores(_ sender: UIButton) {
        if unlockedScore {
            self.performSegue(withIdentifier: "toScoreFromMenu", sender: self)
        } else {
            purchaseScoring()
            loadLevelAccess()
        }
    }
    
    @objc private func unlock(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "toIAPFromMenu", sender: self)
    }
    
    @objc private func removeIAP() {
        IAP.removeFromSuperview()
        IAP2.removeFromSuperview()
    }
    
    @objc private func directlyToMatch() {
        self.performSegue(withIdentifier: "toMatchFromMenu", sender: self)
    }
    
    @objc private func segueMatch(_ sender: UIButton) {
        let levels = ["sanity", "absurd", "insane", "wise", "farcical", "foolish", "sensible", "ridiculous", "idiotic"]
        let ys = [4,14,14,2,9,9,4,14,14]
        let zs = [7,15,29,13,23,44,8,23,43]
        game = levels[sender.tag]
        y = ys[sender.tag]
        z = zs[sender.tag]
        gameData = levelsData[sender.tag]
        
        if sender.tag < 5 {
            if loadData() && didDataLoad {
                isToSegue = true
                self.performSegue(withIdentifier: "toSegueFromMenu", sender: self)
            } else {
                isToMatch = true
                self.performSegue(withIdentifier: "toMatchFromMenu", sender: self)
            }
            
        }
        if sender.tag == 5  && unlockedWord {
            if loadData() && didDataLoad {
                isToSegue = true
                self.performSegue(withIdentifier: "toSegueFromMenu", sender: self)
            } else {
                isToMatch = true
                self.performSegue(withIdentifier: "toMatchFromMenu", sender: self)
            }
            
        } else if sender.tag == 5 {
            purchaseWord() // erase the following
            
        }
        if sender.tag > 5  && unlockedTriple {
            if loadData() && didDataLoad {
                isToSegue = true
                self.performSegue(withIdentifier: "toSegueFromMenu", sender: self)
            } else {
                isToMatch = true
                self.performSegue(withIdentifier: "toMatchFromMenu", sender: self)
            }
            
        } else if sender.tag > 5 {
            purchaseTriples() // erase the following
            
        }
        
    }
    
    
    
    
    //core data functions
    private func addLabels() {
        
        
        //icon image
        var _image2 = UIImage()
        _image2 = UIImage(named: "Sunset.png")!
        let _imageView2 = UIImageView(image: _image2)
        _imageView2.frame = CGRect(x: 0, y: 541*screenHeight/1332, width: screenWidth, height: 365*screenWidth/750)
        view.addSubview(_imageView2)
        
        var _image = UIImage()
        _image = UIImage(named: "AppIcon2.png")!
        let _imageView = UIImageView(image: _image)
        _imageView.frame = CGRect(x: 232*screenWidth/750, y: 354*screenHeight/1332, width: 324*screenWidth/750, height: 600*screenWidth/750)
        view.addSubview(_imageView)
        
        let unlock = UIButton()
        unlock.backgroundColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1.0)
        unlock.frame.size = CGSize( width: (450/750)*screenWidth, height: (76/750)*screenWidth)
        unlock.frame.origin.x = 150*screenWidth/750
        unlock.frame.origin.y = (1172/1332)*screenHeight
        
        
        unlock.tag = 2
        unlock.setTitle("Unlock Levels", for: UIControlState.normal)
        unlock.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*16)
        unlock.setTitleColor(UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0), for: .normal)
        unlock.addTarget(self, action: #selector(MenuViewController.unlock(_:)), for: .touchUpInside)
        unlock.layer.cornerRadius = 5.0
        unlock.clipsToBounds = true
        self.view.addSubview(unlock)
        
        let scores = UIButton()
        scores.backgroundColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1.0)
        scores.frame.size = CGSize( width: (450/750)*screenWidth, height: (76/750)*screenWidth)
        scores.frame.origin.x = 150*screenWidth/750
        scores.frame.origin.y = (1072/1332)*screenHeight
        scores.tag = 1
        scores.setTitle("High Scores", for: UIControlState.normal)
        scores.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*16)
        scores.setTitleColor(UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0), for: .normal)
        scores.addTarget(self, action: #selector(MenuViewController.scores(_:)), for: .touchUpInside)
        scores.layer.cornerRadius = 5.0
        scores.clipsToBounds = true
        if UIDevice.current.userInterfaceIdiom == .pad {
            unlock.frame.size = CGSize( width: (1/3)*screenWidth, height: (75/750)*screenWidth)
            unlock.frame.origin.x = screenWidth/9
            unlock.frame.origin.y = (1172/1332)*screenHeight
            scores.frame.size = CGSize( width: (1/3)*screenWidth, height: (75/750)*screenWidth)
            scores.frame.origin.x = 5*screenWidth/9
            scores.frame.origin.y = (1172/1332)*screenHeight
        }
        self.view.addSubview(scores)
        
        for i in 0...8 {
            let button = UIButton()
            button.frame.size = CGSize( width: (200/750)*screenWidth, height: (28/750)*screenWidth)
            button.frame.origin.y = CGFloat(i*52 + 35)*screenHeight/1332
            button.frame.origin.x = (47/750)*screenHeight
            button.tag = i
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
            button.setTitle(levelsData[i], for: UIControlState.normal)
            button.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*14)
            button.setTitleColor(UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0), for: .normal)
            button.addTarget(self, action: #selector(MenuViewController.segueMatch(_:)), for: .touchUpInside)
            
            self.view.addSubview(button)
        }
    }
    var step = 0
    @objc private func respondToTapGesture(_ gesture: UIGestureRecognizer) {
        step += 1
        nextAnnotation()
        
    }
    var ant: String = ""
    var buttons = [UIButton]()
    var annotation = UILabel()
    private func nextAnnotation() {
        switch step {
        case 0:
            
            annotation.frame.size = CGSize( width: (500/750)*screenWidth, height: (334/1332)*screenHeight)
            annotation.frame.origin.x = (125/750)*screenWidth
            annotation.frame.origin.y = (1000/1332)*screenHeight
            annotation.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*16)
            annotation.text = "Welcome to PAIRINGS, where we are taking matching games to a whole new level!\n\nFind the matches under the tiles above..."
            annotation.textAlignment = .center
            annotation.numberOfLines = 0
            annotation.textColor = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)
            view.addSubview(annotation)
        case 1:
            annotation.text = ant
        case 2:
            annotation.text = "\n\n\n\nWell not so easy when there's 100s of pairs to find!!!"
            for wor in wordz {
                wor.removeFromSuperview()
            }
            for im in imagez {
                im.removeFromSuperview()
            }
            annotation.layer.zPosition = 10000  //layer.zposition = 10000
            pop()
            
                for t in tiles {
                    let random = Double(arc4random_uniform(4))
                    UIView.animate(withDuration: random + 2) {
                    t.frame.origin.y += 2000*UIScreen.main.bounds.height/1332 + 3
                }
            }
        case 3:
            annotation.text = "If you love a challenge, jigsaw puzzles, crosswords, you've come to the right place."
            for t in tiles {
                t.removeFromSuperview()
            }
            
        case 4:
            annotation.text = "We know you're smart, which is why we know you're up for a difficult challenge!"
        case 5:
            annotation.text = "Now for a quick tour..."
        case 6:
            for i in 0...8 {
                let button = UIButton()
                button.frame.size = CGSize( width: (200/750)*screenWidth, height: (28/750)*screenWidth)
                button.frame.origin.y = CGFloat(i*52 + 35)*screenHeight/1332
                button.frame.origin.x = (47/750)*screenHeight
                button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
                button.setTitle(levelsData[i], for: UIControlState.normal)
                button.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*14)
                button.setTitleColor(UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 0.2), for: .normal)
                buttons.append(button)
                self.view.addSubview(button)
                if i < 3 {
                    buttons[i].setTitleColor(UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0), for: .normal)
                    buttons[i].titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*17)
                }
            }
            annotation.text = "These levels play like a traditional match game, but with a twist. There are lots of tiles to search."
        case 7:
            for i in 0...2 {
                buttons[i].setTitleColor(UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 0.2), for: .normal)
                buttons[i].titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*14)
            }
            for i in 3...5 {
                buttons[i].setTitleColor(UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0), for: .normal)
                buttons[i].titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*17)
            }
            annotation.text = "These levels have you find word pairings. How are the words paired?... Wouldn't you like to know."
        case 8:
            for i in 3...5 {
                buttons[i].setTitleColor(UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 0.2), for: .normal)
                buttons[i].titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*14)
            }
            for i in 6...8 {
                buttons[i].setTitleColor(UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0), for: .normal)
                buttons[i].titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*17)
            }
            annotation.text = "Search for sets of three symbols, challenging your memory and putting your problem solving to the test."
        case 9:
            for i in 6...8 {
                buttons[i].setTitleColor(UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 0.2), for: .normal)
                buttons[i].titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*14)
            }
            annotation.text = "Finally, keep track of highscores which award you for accuracy and speed."
        case 10:
            annotation.text = "Thanks for playing, enjoy!"
        default:
            endTutorial()
            
        }
        
    }
    var frontMargin = 10*UIScreen.main.bounds.width/750
    var topMargin = -1979*UIScreen.main.bounds.height/1332 + 3
    var tileWidth = (UIScreen.main.bounds.width - 60*UIScreen.main.bounds.width/750)/5
    var tileHeight = (UIScreen.main.bounds.width - 60*UIScreen.main.bounds.width/750)/5
    var gap = (UIScreen.main.bounds.width - 60*UIScreen.main.bounds.width/750)/50
    var margin = 10*UIScreen.main.bounds.width/750

    func pop() {
        for i in 0...4 {
            for j in 0...7 {
                let tile = UILabel()
                tiles.append(tile)
                tile.frame.size = CGSize( width: tileWidth, height: tileHeight)
                
                tile.frame.origin.x = frontMargin + CGFloat(i)*(tileWidth + margin)
                
                if UIDevice.current.userInterfaceIdiom != .pad && game == "wise" {
                    tile.frame.origin.x = frontMargin + CGFloat(i)*(tileWidth + margin)
                }
                tile.frame.origin.y = topMargin + CGFloat(j)*(tileHeight + margin)
                let point = CGPoint(x: tile.frame.origin.x, y: tile.frame.origin.y)
                pointArray.append(point)
             
                let randomNumber = Int(arc4random_uniform(6))
                tilesColors.append(randomNumber)
                let alpha: CGFloat = 0.85
                switch randomNumber {
                    
                case 0: //red
                    tile.backgroundColor = UIColor(red: 236/255, green: 72/255, blue: 81/255, alpha: alpha)
                case 1: //orange
                    tile.backgroundColor = UIColor(red: 245/255, green: 133/255, blue: 57/255, alpha: alpha)
                case 2: //yellow
                    tile.backgroundColor = UIColor(red: 248/255, green: 223/255, blue: 74/255, alpha: alpha)
                case 3: //green
                    tile.backgroundColor = UIColor(red: 157/255, green: 206/255, blue: 92/255, alpha: alpha)
                case 4: //green
                    tile.backgroundColor = UIColor(red: 245/255, green: 133/255, blue: 57/255, alpha: alpha)
                case 5: //orange
                    tile.backgroundColor = UIColor(red: 248/255, green: 223/255, blue: 74/255, alpha: alpha)
                    
                default:
                    break
                }
                
                
                
                    tile.layer.cornerRadius = 5.0
                
                tile.clipsToBounds = true
                rectArray.append(tile.frame)
                self.view.addSubview(tile)
                
            }
        }
    }
    var total = 0
    var count = 0
    var first = 99
    var second = 99
    @objc private func pick(_ gesture: UIGestureRecognizer) {
        if count == 2 {
            count = 0
            self.tiles[first].alpha = 1.0
            self.tiles[second].alpha = 1.0
            switch first {
            case 0: self.tiles[first].alpha = 0.0
            case 1: self.wordz[0].alpha = 0.0
            case 2: self.imagez[1].alpha = 0.0
            case 3: self.wordz[1].alpha = 0.0
            case 4: self.wordz[2].alpha = 0.0
            case 5: self.wordz[3].alpha = 0.0
            default: break
            }
            switch second {
            case 0: self.imagez[0].alpha = 0.0
            case 1: self.wordz[0].alpha = 0.0
            case 2: self.imagez[1].alpha = 0.0
            case 3: self.wordz[1].alpha = 0.0
            case 4: self.wordz[2].alpha = 0.0
            case 5: self.wordz[3].alpha = 0.0
            default: break
            }
        }
        
        for i in 0..<tiles.count {
            let p = gesture.location(in: self.view)
            if tiles[i].frame.contains(p) {
                UIView.animate(withDuration: 0.2) {
                if self.tiles[i].alpha == 0.0 {
                    self.tiles[i].alpha = 1.0
                    switch i {
                    case 0: self.imagez[0].alpha = 0.0
                    case 1: self.wordz[0].alpha = 0.0
                    case 2: self.imagez[1].alpha = 0.0
                    case 3: self.wordz[1].alpha = 0.0
                    case 4: self.wordz[2].alpha = 0.0
                    case 5: self.wordz[3].alpha = 0.0
                    default: break
                    }
                } else {
                    self.tiles[i].alpha = 0.0
                    if self.count == 0 { self.first = i }
                    if self.count == 1 { self.second = i }
                    self.count += 1
                    switch i {
                    case 0: self.imagez[0].alpha = 1.0
                    case 1: self.wordz[0].alpha = 1.0
                    case 2: self.imagez[1].alpha = 1.0
                    case 3: self.wordz[1].alpha = 1.0
                    case 4: self.wordz[2].alpha = 1.0
                    case 5: self.wordz[3].alpha = 1.0
                    default: break
                    }
                }
                }
            
            
            if count == 2 {
                if first == 0 && second == 2 || second == 0 && first == 2 {
                    step = 1; ant = "Images that match are pairs"; nextAnnotation()
                    tiles[first].removeFromSuperview(); tiles[second].removeFromSuperview(); count = 0; total += 1
                } else if first == 1 && second == 3 || second == 1 && first == 3 {
                    step = 1; ant = "These words match because they have something in common (both are names of late night TV hosts)"; nextAnnotation(); total += 1
                    tiles[first].removeFromSuperview(); tiles[second].removeFromSuperview(); count = 0
                } else if first == 4 && second == 5 || second == 4 && first == 5 {
                 step = 1; ant = "These words match because they have something in common (legal spelled backwards: legal)"; nextAnnotation(); total += 1
                    tiles[first].removeFromSuperview(); tiles[second].removeFromSuperview(); count = 0
                }
                print(total)
                if total == 3 {
                    let te = annotation.text!
                    annotation.text = "\(te)\nEasy enough, right?\nTAP ANYWHERE TO CONTINUE"
                    tap = UITapGestureRecognizer(target: self, action: #selector(MenuViewController.respondToTapGesture(_:)))
                    self.view.addGestureRecognizer(tap)
                }
            }
            }
        }
    }
    var tiles = [UILabel]() //save tile
    var tilesColors = [Int]() //save color number for each tile
    var pointArray = [CGPoint]()
    var rectArray = [CGRect]()
    var wordz = [UILabel]()
    var imagez = [UIImageView]()
    var tap = UITapGestureRecognizer()
    //var tap2 = UITapGestureRecognizer()
    private func startTutorial() {
        
          tap = UITapGestureRecognizer(target: self, action: #selector(MenuViewController.pick(_:)))
          self.view.addGestureRecognizer(tap)
       
        for i in 0...5 {
            if i == 1 || 3...5 ~= i {
            let wordView = UILabel()
            let words = ["","Kimmel","","Fallon","Regal","Lager"]
            wordView.text = words[i]
         
            wordView.frame = CGRect(x: 60*screenWidth/750 + CGFloat(i)*(100*screenWidth/750 + 10*screenWidth/750), y: 110*screenHeight/1334, width: 80*screenWidth/750, height: 80*screenWidth/750)
            wordView.font = UIFont(name: "HelveticaNeue-Bold", size: 10)
            wordView.alpha = 0.0
            wordView.textAlignment = .center
            wordView.textColor = UIColor.white
                
            view.addSubview(wordView)
            wordz.append(wordView)
            } else {
            let image = UIImage(named: "99.png")!
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 60*screenWidth/750 + CGFloat(i)*(100*screenWidth/750 + 10*screenWidth/750), y: 110*screenHeight/1334, width: 80*screenWidth/750, height: 80*screenWidth/750)
            imageView.alpha = 0.0
                imagez.append(imageView)
            view.addSubview(imageView)
            }
          
                let tile = UILabel()
                tiles.append(tile)
                tile.frame.size = CGSize( width: 100*screenWidth/750, height: 100*screenWidth/750)
                
                tile.frame.origin.x = 50*screenWidth/750 + CGFloat(i)*(100*screenWidth/750 + 10*screenWidth/750)
                
                tile.frame.origin.y = 100*screenHeight/1334
            let point = CGPoint(x: tile.frame.origin.x, y: tile.frame.origin.y)
                pointArray.append(point)
                
                let randomNumber = Int(arc4random_uniform(6))
                tilesColors.append(randomNumber)
                let alpha: CGFloat = 0.85
                switch randomNumber {
                    
                case 0: //red
                    tile.backgroundColor = UIColor(red: 236/255, green: 72/255, blue: 81/255, alpha: alpha)
                case 1: //orange
                    tile.backgroundColor = UIColor(red: 245/255, green: 133/255, blue: 57/255, alpha: alpha)
                case 2: //yellow
                    tile.backgroundColor = UIColor(red: 248/255, green: 223/255, blue: 74/255, alpha: alpha)
                case 3: //green
                    tile.backgroundColor = UIColor(red: 157/255, green: 206/255, blue: 92/255, alpha: alpha)
                case 4: //green
                    tile.backgroundColor = UIColor(red: 245/255, green: 133/255, blue: 57/255, alpha: alpha)
                case 5: //orange
                    tile.backgroundColor = UIColor(red: 248/255, green: 223/255, blue: 74/255, alpha: alpha)
                    
                default:
                    break
                }
                
                
         
                    tile.layer.cornerRadius = 5.0
                
                tile.clipsToBounds = true
                rectArray.append(tile.frame)
                tile.alpha = 1.0
                tile.layer.zPosition = 1000
                self.view.addSubview(tile)
            
            }
        
        
        
        
        startTutorial2()
    }
    
    private func startTutorial2() {
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Purchase", into: context)
        entity.setValue(false, forKey: "triple")
        entity.setValue(false, forKey: "word")
        entity.setValue(false, forKey: "score")
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        var _image2 = UIImage()
        _image2 = UIImage(named: "Sunset.png")!
        let _imageView2 = UIImageView(image: _image2)
        _imageView2.frame = CGRect(x: 0, y: 541*screenHeight/1332, width: screenWidth, height: 365*screenWidth/750)
        view.addSubview(_imageView2)
        
        var _image = UIImage()
        _image = UIImage(named: "AppIcon2.png")!
        let _imageView = UIImageView(image: _image)
        _imageView.frame = CGRect(x: 232*screenWidth/750, y: 354*screenHeight/1332, width: 324*screenWidth/750, height: 600*screenWidth/750)
        view.addSubview(_imageView)
        
        
        
        
        
      //  let tap = UITapGestureRecognizer(target: self, action: #selector(MenuViewController.respondToTapGesture(_:)))
      //  self.view.addGestureRecognizer(tap)
        
        nextAnnotation()
        
    }
    
    private func endTutorial() {
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Tutorial", into: context)
        entity.setValue(true, forKey: "startTutorial")
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        for v in view.subviews{
            v.removeFromSuperview()
        }
        
        addLabels()
    }
    
    private func shouldIDoTutorial() {
        
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context = appDel.persistentContainer.viewContext
        let tutorialRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tutorial")
        
        do { resultsTutorialRequest = try context.fetch(tutorialRequest) } catch  {
            print("Could not cache the response \(error)")
            
            
        }
  //      if resultsTutorialRequest.count < 1 {
  //          startTutorial()
  //      } else {
            addLabels()
  //      }
    }
    
    private func loadLevelAccess() {
        var resultslevelRequest = [AnyObject]()
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context = appDel.persistentContainer.viewContext
        
        let levelRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Purchase")
        
        do { resultslevelRequest = try context.fetch(levelRequest) } catch  {
            print("Could not cache the response \(error)")
        }
        var bools = [Bool]()
        var attributes = ["triple","word","score"]
        if resultslevelRequest.count > 0 {
            
            for i in 0...2 {
                print("results: \(resultslevelRequest.count)")
                for result in resultslevelRequest {
                    if let bo = result.value(forKey: attributes[i]) as! Bool? {
                        print("bo: \(bo)")
                        bools.append(bo)
                        for boo in bools {
                            
                            if boo {
                                switch i {
                                case 0:
                                    unlockedTriple = true
                                case 1:
                                    unlockedWord = true
                                default:
                                    unlockedScore = true
                                }
                            }
                            
                            
                        }
                    }
                }
                
            }
        }
        
    }
    
    
    
    
    private func loadData() -> Bool {
        
        var isGameInProgress = false
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context = appDel.persistentContainer.viewContext
        
        let gameRequest = NSFetchRequest<NSFetchRequestResult>(entityName: gameData)
        
        do { resultsGameRequest = try context.fetch(gameRequest)
            didDataLoad = true} catch  {
                
                do { resultsGameRequest = try context.fetch(gameRequest)
                    didDataLoad = true} catch  {
                        print("error")
                }
                
        }
        
        if resultsGameRequest.count > 0 {
            
            list = resultsGameRequest.last?.value(forKeyPath: "list") as! [String]
            done = resultsGameRequest.last?.value(forKeyPath: "bool") as! [Int]
            index = resultsGameRequest.last?.value(forKeyPath: "index") as! [Int]
            score = resultsGameRequest.last?.value(forKeyPath: "score") as! Int
            time = resultsGameRequest.last?.value(forKeyPath: "time") as! Int
            print("segue list")
            print(list)
            print(done)
            print(index)
            print(score)
            print(time)
            isGameInProgress = true
            
        }
        
        
        return isGameInProgress
        
    }
    
    //coredata functions end
}
