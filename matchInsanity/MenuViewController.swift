//
//  MenuViewController.swift
//  matchInsanity
//
//  Created by Aaron Halvorsen on 11/27/16.
//  Copyright © 2016 Aaron Halvorsen. All rights reserved.
// soundness, absurdity, insane

import UIKit
import CoreData

class MenuViewController: UIViewController {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var fontSizeMultiplier = UIScreen.main.bounds.width / 375
    let IAP = UIButton()
    let IAP2 = UIButton()

    var access = 1
    var centerPoint = CGPoint()
    var y = Int()
    var z = Int()
    var game = String()
    var gameData = String()
    var accessToScore = false
    var accessToWord = false
    var accesstoTriple = false
    var resultsGameRequest = [AnyObject]()
    var list = [String]()
    var done = [Int]()
    var index = [Int]()
    var isToSegue = false
    var isToMatch = false
    
    
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
        } else if isToMatch {
            let gameView: MatchViewController = segue.destination as! MatchViewController
            gameView.y = y
            gameView.z = z
            gameView.game = game
            gameView.gameData = gameData
            gameView.list = list
            gameView.index = index
            gameView.done = done
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1.0)
        addButtons()
        var image = UIImage()
        switch access {
        case 1:
            image = UIImage(named: "MenuWheelFull.png")!
        case 2:
            image = UIImage(named: "MenuWheelNoTriples.png")!
        default:
            break
            print("done: \(done)")
        }
        
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 82*screenWidth/750, y: 376*screenHeight/1332, width: 590*screenWidth/750, height: 558*screenWidth/750)
        imageView.alpha = 1.0
        view.addSubview(imageView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MenuViewController.respondToTapGesture(_:)))
        self.view.addGestureRecognizer(tap)
        game = "farcical"
        gameData = "Farcical"
        loadData()
 
    }
    var paths = [UIBezierPath]()
    private func addButtons() {
        
        //virtual buttons to select levels:
        
        let start = CGPoint(x: 380*screenWidth/750, y: 615*screenHeight/1332)
        let point1 = CGPoint(x: (104/750)*screenWidth, y: (449/1332)*screenHeight)
        let point2 = CGPoint(x: 279*screenWidth/750, y: 332*screenHeight/1332)
        let point3 = CGPoint(x: 482*screenWidth/750, y: 344*screenHeight/1332)
        let point4 = CGPoint(x: 639*screenWidth/750, y: 476*screenHeight/1332)
        let point5 = CGPoint(x: 659*screenWidth/750, y: 667*screenHeight/1332)
        let point6 = CGPoint(x: 582*screenWidth/750, y: 862*screenHeight/1332)
        let point7 = CGPoint(x: 382*screenWidth/750, y: 922*screenHeight/1332)
        let point8 = CGPoint(x: 181*screenWidth/750, y: 853*screenHeight/1332)
        let point9 = CGPoint(x: 81*screenWidth/750, y: 668*screenHeight/1332)
        let point10 = CGPoint(x: 104*screenWidth/750, y: 449*screenHeight/1332)
        let points = [point1, point2, point3, point4, point5, point6, point7, point8, point9, point10]
        for i in 0...8 {
            let path = UIBezierPath()
            path.move(to: start)
            path.addLine(to: points[i])
            path.addLine(to: points[i+1])
           // path.addLine(to: start)
            path.close()
            paths.append(path)
        }
        let shapeLayer2 = CAShapeLayer()
        let path2 = UIBezierPath()
        let start1 = CGPoint(x: 335*screenWidth/750, y: 567*screenHeight/1332)
        let end1 = CGPoint(x: 415*screenWidth/750, y: 567*screenHeight/1332)
        path2.move(to: start1)
        path2.addLine(to: end1)
        shapeLayer2.path = path2.cgPath
        shapeLayer2.strokeColor = UIColor(red: 248/255, green: 223/255, blue: 74/255, alpha: 1.0).cgColor
        shapeLayer2.lineWidth = 1.0
        view.layer.addSublayer(shapeLayer2)
        let shapeLayer3 = CAShapeLayer()
        let path3 = UIBezierPath()
        let start2 = CGPoint(x: 342*screenWidth/750, y: 698*screenHeight/1332)
        let end2 = CGPoint(x: 408*screenWidth/750, y: 698*screenHeight/1332)
        path3.move(to: start2)
        path3.addLine(to: end2)
        shapeLayer3.path = path3.cgPath
        shapeLayer3.strokeColor = UIColor(red: 248/255, green: 223/255, blue: 74/255, alpha: 1.0).cgColor
        shapeLayer3.lineWidth = 1.0
        view.layer.addSublayer(shapeLayer3)
        let shapeLayer4 = CAShapeLayer()
        let path4 = UIBezierPath()
        let start3 = CGPoint(x: 268*screenWidth/750, y: 1135*screenHeight/1332)
        let end3 = CGPoint(x: 483*screenWidth/750, y: 1135*screenHeight/1332)
        path4.move(to: start3)
        path4.addLine(to: end3)
        shapeLayer4.path = path4.cgPath
        shapeLayer4.strokeColor = UIColor(red: 248/255, green: 223/255, blue: 74/255, alpha: 1.0).cgColor
        shapeLayer4.lineWidth = 1.0
        view.layer.addSublayer(shapeLayer4)
        
        let menuLabel = UILabel()
        menuLabel.frame.size = CGSize( width: screenWidth, height: (124/1332)*screenHeight)
        menuLabel.frame.origin.x = 0
        menuLabel.frame.origin.y = (95/1332)*screenHeight
        menuLabel.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*75)
        menuLabel.text = "Menu"
        menuLabel.textAlignment = .center
        menuLabel.textColor = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)
        view.addSubview(menuLabel)
        
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
        self.view.addSubview(scores)
       

        
    }
    
    @objc private func respondToTapGesture(_ gesture: UIGestureRecognizer) {
        print("taprecognized")
        let levels = ["sanity", "absurd", "insane", "idiotic", "rediculous", "sensible", "foolish", "farcical", "wise"]
        let levelsData = ["Sanity", "Absurd", "Insane", "Sensible", "Rediculous", "Idiotic", "Foolish", "Farcical", "Wise"]
        let ys = [4,14,14,14,14,4,14,14,4]
        let zs = [7,15,29,43,23,8,29,15,10]
            for n in 0...8 {
                centerPoint = gesture.location(in: view)
                if paths[n].contains(centerPoint) {
                    game = levels[n]
                    gameData = levelsData[n]
                    y = ys[n]
                    z = zs[n]
                    segueMatch()
                }
            }
       
    }
    
    @objc private func scores(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "toScoreFromMenu", sender: self)
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
    
    @objc private func segueMatch() {
        if loadData() {
            isToSegue = true
            self.performSegue(withIdentifier: "toSegueFromMenu", sender: self)
        } else {
            isToMatch = true
            self.performSegue(withIdentifier: "toMatchFromMenu", sender: self)
        }
        
    }
    
    
    //core data functions
    
    private func loadData() -> Bool {
        var isGameInProgress = false
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context = appDel.persistentContainer.viewContext
        
        let gameRequest = NSFetchRequest<NSFetchRequestResult>(entityName: gameData)
        
        do { resultsGameRequest = try context.fetch(gameRequest) } catch  {
            print("Could not cache the response \(error)")
        }
        
        if resultsGameRequest.count > 0 {
            isGameInProgress = true
            list = resultsGameRequest.last?.value(forKeyPath: "list") as! [String]
            done = resultsGameRequest.last?.value(forKeyPath: "bool") as! [Int]
            index = resultsGameRequest.last?.value(forKeyPath: "index") as! [Int]
        }
        print("list: \(list)")
        print("done: \(done)")
        print("index: \(index)")
        
        return isGameInProgress
        
    }

    //coredata functions end
}
