//
//  SegueViewController.swift
//  matchInsanity
//
//  Created by Aaron Halvorsen on 12/7/16.
//  Copyright © 2016 Aaron Halvorsen. All rights reserved.
//

import UIKit
import CoreData

class SegueViewController: UIViewController {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var fontSizeMultiplier = UIScreen.main.bounds.width / 375
    var y = Int()
    var z = Int()
    var game = String()
    var gameData = String()
    var goBack = false
    var list = [String]()
    var index = [Int]()
    var done = [Int]()
    var isNewBoard: Int = 0
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if goBack {
            print("returned to Menu")
        } else {
            let gameView: MatchViewController = segue.destination as! MatchViewController
            gameView.isNewBoard = isNewBoard
            gameView.y = y
            gameView.z = z
            gameView.game = game
            gameView.gameData = gameData
            gameView.list = list
            gameView.index = index
            gameView.done = done
            
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        print("z: \(z)")
        print("y: \(y)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        modalPresentationStyle = .overCurrentContext
        view.backgroundColor = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 0.85)
        let arrow = UIButton()
        arrow.frame = CGRect(x: 329*screenWidth/750, y: 41*screenHeight/1332, width: 93*screenWidth/750, height: 76*screenWidth/750)
        arrow.setImage(UIImage(named: "Arrow.png"), for: .normal)
        arrow.tag = 200
        //        arrow.addTarget(self, action: #selector(SegueViewController.menu(_:)), for: .touchUpInside)
        view.addSubview(arrow)
        
        let menuLabel = UILabel()
        menuLabel.frame.size = CGSize( width: screenWidth, height: (124/1332)*screenHeight)
        menuLabel.frame.origin.x = 0
        menuLabel.frame.origin.y = (95/1332)*screenHeight
        menuLabel.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*75)
        menuLabel.text = "Menu"
        menuLabel.textAlignment = .center
        menuLabel.textColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1.0)
        view.addSubview(menuLabel)
        
        let arrowSend = UIButton()
        arrowSend.frame = CGRect(x: 0, y: 0, width: screenWidth, height: (426/1332)*screenHeight)
        arrowSend.tag = 200
        arrowSend.addTarget(self, action: #selector(SegueViewController.menu(_:)), for: .touchUpInside)
        view.addSubview(arrowSend)
        
        let reset = UIButton()
        reset.backgroundColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1.0)
        reset.frame.size = CGSize( width: (450/750)*screenWidth, height: (76/750)*screenWidth)
        reset.frame.origin.x = 150*screenWidth/750
        reset.frame.origin.y = (426/1332)*screenHeight
        reset.tag = 2
        reset.setTitle("Reset Level", for: UIControlState.normal)
        reset.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*16)
        reset.setTitleColor(UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0), for: .normal)
        reset.addTarget(self, action: #selector(SegueViewController.reset(_:)), for: .touchUpInside)
        reset.layer.cornerRadius = 5.0
        reset.clipsToBounds = true
        self.view.addSubview(reset)
        
        
        
        
        let same = UIButton()
        same.backgroundColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1.0)
        same.frame.size = CGSize( width: (450/750)*screenWidth, height: (76/750)*screenWidth)
        same.frame.origin.x = 150*screenWidth/750
        same.frame.origin.y = (591/1332)*screenHeight
        same.tag = 1
        same.setTitle("Continue Game", for: UIControlState.normal)
        same.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*16)
        same.setTitleColor(UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0), for: .normal)
        same.addTarget(self, action: #selector(SegueViewController.same(_:)), for: .touchUpInside)
        same.layer.cornerRadius = 5.0
        same.clipsToBounds = true
        self.view.addSubview(same)
        
        
        print("done: \(done)")
        
        // Do any additional setup after loading the view.
    }
    
    @objc private func menu(_ sender: UIButton) {
        print("Went1")
        goBack = true
        self.performSegue(withIdentifier: "toMenuFromSegue", sender: self)
    }
    private func deleteAllData(entity: String)
    {
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context = appDel.persistentContainer.viewContext
        let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
        do { try context.execute(DelAllReqVar) }
        catch { print(error) }
    }
    @objc private func reset(_ sender: UIButton) {
        print("Went2")
        isNewBoard = 1
         print("isNewBoard1: \(isNewBoard)")
        deleteAllData(entity: gameData)
        done.removeAll()
        index.removeAll()
        list.removeAll()
         print("isNewBoard2: \(isNewBoard)")
        self.performSegue(withIdentifier: "toMatchFromSegue", sender: self)

        
    }
    @objc private func same(_ sender: UIButton) {
        print("Went3")
        isNewBoard = 0
        self.performSegue(withIdentifier: "toMatchFromSegue", sender: self)
    }
    
    
    
    
    
    
}
