//
//  IAPViewController.swift
//  matchInsanity
//
//  Created by Aaron Halvorsen on 11/27/16.
//  Copyright © 2016 Aaron Halvorsen. All rights reserved.
//

import UIKit

class IAPViewController: UIViewController {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var fontSizeMultiplier = UIScreen.main.bounds.width / 375

    
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
        view.backgroundColor = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1.0)
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

        
        
        //images
        var image = UIImage()
        image = UIImage(named: "Troll.png")!
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 306*screenWidth/750, y: 896*screenHeight/1332, width: 138*screenWidth/750, height: 150*screenWidth/750)
        view.addSubview(imageView)
        
        
        
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
        desc2.text = "Complicate things further by finding three of each symbol."
        desc2.textAlignment = .center
        desc2.numberOfLines = 0
        desc2.textColor = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)
        view.addSubview(desc2)
        
        let desc3 = UILabel()
        desc3.frame.size = CGSize( width: (467/750)*screenWidth, height: (50/1332)*screenHeight)
        desc3.frame.origin.x = (144/750)*screenWidth
        desc3.frame.origin.y = (704/1332)*screenHeight
        desc3.font = UIFont(name: "HelveticaNeue", size: fontSizeMultiplier*10)
        desc3.text = "Haven’t had enough punishment? Try finding four of each symbol."
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
        
        var arrow = UIButton()
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
        quad.setTitle("Quad!", for: UIControlState.normal)
        quad.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*12)
        quad.setTitleColor(UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0), for: .normal)
        quad.addTarget(self, action: #selector(IAPViewController.quad(_:)), for: .touchUpInside)
    
     
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
        
        
    }

    @objc private func restore(_ sender: UIButton) {
        
    }
    
    @objc private func quad(_ sender: UIButton) {
        
    }
    
    @objc private func triples(_ sender: UIButton) {
        
    }
    
    @objc private func scoring(_ sender: UIButton) {
        
    }
    
    @objc private func menu(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toMenuFromIAP", sender: self)
    }

}
