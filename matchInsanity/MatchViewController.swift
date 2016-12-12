//
//  ViewController.swift
//  matchInsanity
//
//  Created by Aaron Halvorsen on 11/18/16.
//  Copyright © 2016 Aaron Halvorsen. All rights reserved.
//

import UIKit
import CoreData

class MatchViewController: UIViewController {
    
    let scrollView = UIScrollView(frame: UIScreen.main.bounds)
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var indexArray = [Int]()
    let myItems = Items()
    var y = 4
    var z = 3
    var fontSizeMultiplier = UIScreen.main.bounds.width / 375
    let frontMargin = 10*UIScreen.main.bounds.width/750 + 3
    let topMargin = 179*UIScreen.main.bounds.height/1332 + 3
    let tileWidth = UIScreen.main.bounds.width/5 - 10
    var tileHeight = UIScreen.main.bounds.width/5 - 10
    var tiles = [UILabel]() //save tile
    var tilesColors = [Int]() //save color number for each tile
    var rectArray = [CGRect]()
    var pointArray = [CGPoint]()
    let gap = ((UIScreen.main.bounds.width/5 - 10) - 62.5) / 2
    var game = String()
    var gameData = String()
    var flipped1: Int? {didSet{print("flipped1: \(flipped1)")}}
    var flipped2: Int? {didSet{print("flipped2: \(flipped2)")}}
    var flipped3: Int? {didSet{print("flipped3: \(flipped3)")}}
    var flippedTiles: Int = 0
    var tileAmount = Int()
    var centerPoint = CGPoint()
    var binary = true
    var triCount = 1
    var imageViewArray: [UIImageView?] = [nil, nil, nil]
    var wordLabelArray = [UILabel?]()
    var done = [Int]()
    var listOfImagesToUse = [String]()
    var listOfWordsToUse = [String]()
    var list = [String]()
    var index = [Int]()
    var resultsGameRequest = [AnyObject]()
    var isNewBoard = 1
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        print("isNewBoard3: \(isNewBoard)")
        super.viewDidLoad()
        
        self.view = self.scrollView
        self.scrollView.contentSize = CGSize(width: 2.9*screenWidth, height: 6.08*screenWidth)
        view.backgroundColor = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1.0)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MatchViewController.respondToTapGesture(_:)))
        self.view.addGestureRecognizer(tap)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("isNewBoard4: \(isNewBoard)")
        if game == "wise" || game == "farcical" || game == "foolish" {
            tileHeight = tileWidth/2
            print("tileHeight: \(tileHeight)")
        }
        
        tileAmount = (y+1)*(z+1)
        print("isnewboard: \(isNewBoard)")
        if isNewBoard == 1 {
            organizeIndex()
            
            selectItems()
            if done.count == 0 {
                done.append(500)
            }
        } else {
            if game == "wise" || game == "farcical" || game == "foolish" {
                listOfWordsToUse = list
            } else {
                listOfImagesToUse = list
            }
            indexArray = index
        }
        print("done: \(done)")
        addLabels()
        if done.count > 1 {
            if game == "wise" || game == "farcical" || game == "foolish" {
                for n in done {
                    tiles[n].alpha = 0.0
                    
                    let wordView = UILabel()
                    
                    wordView.text = listOfWordsToUse[indexArray[n]]
                    
                    
                    wordView.frame = CGRect(x: pointArray[n].x, y: pointArray[n].y, width: tileWidth, height: tileHeight)
                    wordView.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*10)
                    wordView.alpha = 0.2
                    wordView.textAlignment = .center
                    wordView.textColor = UIColor.white
                    view.addSubview(wordView)
                }
                
            } else if game == "sanity" || game == "absurd" || game == "insane" {
                for n in done {
                    if n == 500 {
                        print("500")
                    } else {
                        print("n: \(n)")
                        var image = UIImage()
                        if indexArray[n] < tileAmount/2 {
                            image = UIImage(named: listOfImagesToUse[indexArray[n]])!
                        } else {
                            image = UIImage(named: listOfImagesToUse[indexArray[n] - tileAmount/2])!
                        }
                        let imageView = UIImageView(image: image)
                        imageView.frame = CGRect(x: pointArray[n].x + gap, y: pointArray[n].y + gap, width: 125*screenWidth/750, height: 125*screenWidth/750)
                        imageView.alpha = 0.2
                        view.addSubview(imageView)
                        tiles[n].alpha = 0.0
                    }
                }
            } else {
                for n in done {
                    if n == 500 {
                        print("500")
                    } else {
                        print("n: \(n)")
                        var image = UIImage()
                        if indexArray[n] < tileAmount/3 {
                            image = UIImage(named: myItems.listOfImages[indexArray[n]])!
                        } else if indexArray[n] < 2*tileAmount/3 {
                            image = UIImage(named: myItems.listOfImages[indexArray[n] - tileAmount/3])!
                        } else {
                            image = UIImage(named: myItems.listOfImages[indexArray[n] - 2*tileAmount/3])!
                        }
                        let imageView = UIImageView(image: image)
                        imageView.frame = CGRect(x: pointArray[n].x + gap, y: pointArray[n].y + gap, width: 125*screenWidth/750, height: 125*screenWidth/750)
                        imageView.alpha = 0.2
                        view.addSubview(imageView)
                        tiles[n].alpha = 0.0
                    }
                }
            }
        }
        
    }
    
    
    private func addLabels() {
        
        let arrow = UIButton()
        arrow.frame = CGRect(x: 25*screenWidth/750, y: 33*screenHeight/1332, width: 44*screenWidth/750, height: 37*screenWidth/750)
        arrow.setImage(UIImage(named: "Arrow.png"), for: .normal)
        arrow.tag = 200
        arrow.addTarget(self, action: #selector(MatchViewController.menu(_:)), for: .touchUpInside)
        view.addSubview(arrow)
        
        let scoreLabel = UILabel()
        scoreLabel.frame.size = CGSize( width: (500/750)*screenWidth, height: (115/1332)*screenHeight)
        scoreLabel.frame.origin.x = frontMargin + 35
        scoreLabel.frame.origin.y = (31/1332)*screenHeight
        scoreLabel.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*70)
        scoreLabel.text = "123450"
        scoreLabel.textAlignment = .left
        scoreLabel.textColor = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)
        view.addSubview(scoreLabel)
        
        for i in 0...y {
            for j in 0...z {
                let tile = UILabel()
                tiles.append(tile)
                tile.frame.size = CGSize( width: tileWidth, height: tileHeight)
                tile.frame.origin.x = frontMargin + CGFloat(i)*(tileWidth + 6)
                tile.frame.origin.y = topMargin + CGFloat(j)*(tileHeight + 6)
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
                
                
                if game == "wise" || game == "farcical" || game == "foolish" {
                    tile.layer.cornerRadius = 2.0
                } else {
                    tile.layer.cornerRadius = 5.0
                }
                tile.clipsToBounds = true
                rectArray.append(tile.frame)
                self.view.addSubview(tile)
                
            }
        }
    }
    
    
    
    @objc private func respondToTapGesture(_ gesture: UIGestureRecognizer) {
        
        
        if game == "sanity" || game == "absurd" || game == "insane" {
            switch flippedTiles {
            case 0, 1:
                centerPoint = gesture.location(in: view)
                outerLoop: for n in 0..<tileAmount {
                    if rectArray[n].contains(centerPoint) {
                        if done.contains(n) {
                            break outerLoop
                        }
                        tiles[n].alpha = 0.0
                        var image = UIImage()
                        print("n: \(n)")
                        
                        if indexArray[n] < tileAmount/2 {
                            print(indexArray[n])
                            print(listOfImagesToUse[indexArray[n]])
                            print(indexArray[n])
                            image = UIImage(named: listOfImagesToUse[indexArray[n]])!
                        } else {
                            print(indexArray[n] - tileAmount/2)
                            print(listOfImagesToUse[indexArray[n] - tileAmount/2])
                            print(indexArray[n] - tileAmount/2)
                            image = UIImage(named: listOfImagesToUse[indexArray[n] - tileAmount/2])!
                        }
                        let imageView = UIImageView(image: image)
                        imageView.frame = CGRect(x: pointArray[n].x + gap, y: pointArray[n].y + gap, width: 125*screenWidth/750, height: 125*screenWidth/750)
                        imageView.alpha = 1.0
                        
                        if imageViewArray.count == 0 {
                            imageViewArray.append(imageView)
                            flipped1 = n
                        } else if imageViewArray.count == 1 {
                            imageViewArray.append(imageView)
                            flipped2 = n
                        } else if binary {
                            imageViewArray[0] = imageView
                            flipped1 = n
                            binary = false
                        } else {
                            imageViewArray[1] = imageView
                            flipped2 = n
                            binary = true
                        }
                        view.addSubview(imageView)
                        
                        if flipped1 != nil && flipped2 != nil {
                            if tiles[flipped1!].alpha == 0.0 && tiles[(flipped2!)].alpha == 0.0 {
                                flippedTiles = 2
                                
                                if (indexArray[flipped1!] == indexArray[flipped2!] - tileAmount/2) || (indexArray[flipped1!] == indexArray[flipped2!] + tileAmount/2) {
                                    done.append(flipped1!)
                                    done.append(flipped2!)
                                    flipped1 = nil
                                    flipped2 = nil
                                    
                                    imageViewArray[0]!.alpha = 0.2
                                    imageViewArray[1]!.alpha = 0.2
                                    imageViewArray[0] = nil
                                    imageViewArray[1] = nil
                                    flippedTiles = 0
                                    
                                    
                                }
                            } else {
                                flippedTiles = 1
                            }
                            
                        } else {
                            flippedTiles = 1
                        }
                        
                        break outerLoop
                    }
                    
                }
                
            case 2:
                centerPoint = gesture.location(in: view)
                outerLoop: for n in 0..<tileAmount {
                    
                    if rectArray[n].contains(centerPoint) && flipped1 != nil && flipped2 != nil  {
                        if done.contains(n) {
                            print("entered case 2 done statement")
                            print(done)
                            break outerLoop
                        }
                        tiles[flipped1!].alpha = 1.0
                        tiles[flipped2!].alpha = 1.0
                        imageViewArray[0]?.removeFromSuperview()
                        imageViewArray[1]?.removeFromSuperview()
                    }
                    if rectArray[n].contains(centerPoint) {
                        if done.contains(n) {
                            print("entered case 2 done statement")
                            print(done)
                            break outerLoop
                        }
                        tiles[n].alpha = 0.0
                        var image = UIImage()
                        if indexArray[n] < tileAmount/2 {
                            image = UIImage(named: listOfImagesToUse[indexArray[n]])!
                        } else {
                            print(indexArray[n] - tileAmount/2)
                            print(listOfImagesToUse[indexArray[n] - tileAmount/2])
                            print(indexArray[n] - tileAmount/2)
                            image = UIImage(named: listOfImagesToUse[indexArray[n] - tileAmount/2])!
                        }
                        let imageView = UIImageView(image: image)
                        imageView.frame = CGRect(x: pointArray[n].x + gap, y: pointArray[n].y + gap, width: 125*screenWidth/750, height: 125*screenWidth/750)
                        imageView.alpha = 1.0
                        view.addSubview(imageView)
                        
                        if binary {
                            imageViewArray[0] = imageView
                            flipped1 = n
                            binary = false
                        } else {
                            imageViewArray[1] = imageView
                            flipped2 = n
                            binary = true
                        }
                        flippedTiles = 1
                        
                        break outerLoop
                    }
                    
                }
                
            default:
                break
            }
        }
        
        if game == "wise" || game == "farcical" || game == "foolish" {
            switch flippedTiles {
            case 0, 1:
                centerPoint = gesture.location(in: view)
                outerLoop: for n in 0..<tileAmount {
                    
                    if rectArray[n].contains(centerPoint) {
                        
                        print("done: \(done)")
                        if done.contains(n) {
                            
                            break outerLoop
                        }
                        tiles[n].alpha = 0.0
                        
                        let wordView = UILabel()
                        
                        wordView.text = listOfWordsToUse[indexArray[n]]
                        
                        
                        wordView.frame = CGRect(x: pointArray[n].x, y: pointArray[n].y, width: tileWidth, height: tileHeight)
                        wordView.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*10)
                        wordView.alpha = 1.0
                        wordView.textAlignment = .center
                        wordView.textColor = UIColor.white
                        view.addSubview(wordView)
                        if wordLabelArray.count == 0 {
                            wordLabelArray.append(wordView)
                            flipped1 = n
                        } else if wordLabelArray.count == 1 {
                            wordLabelArray.append(wordView)
                            flipped2 = n
                        } else if binary {
                            wordLabelArray[0] = wordView
                            flipped1 = n
                            binary = false
                        } else {
                            wordLabelArray[1] = wordView
                            flipped2 = n
                            binary = true
                        }
                        
                        
                        if flipped1 != nil && flipped2 != nil {
                            print("flip1: \(flipped1)")
                            print("flip2: \(flipped2)")
                            print("indexArray[flipped1!]: \(indexArray[flipped1!])")
                            print("indexArray[flipped2!]: \(indexArray[flipped2!])")
                            if tiles[flipped1!].alpha == 0.0 && tiles[(flipped2!)].alpha == 0.0 {
                                flippedTiles = 2
                                
                                if (indexArray[flipped1!] == indexArray[flipped2!] - tileAmount/2) || (indexArray[flipped1!] == indexArray[flipped2!] + tileAmount/2) {
                                    done.append(flipped1!)
                                    done.append(flipped2!)
                                    flipped1 = nil
                                    flipped2 = nil
                                    
                                    wordLabelArray[0]!.alpha = 0.2
                                    wordLabelArray[1]!.alpha = 0.2
                                    wordLabelArray[0] = nil
                                    wordLabelArray[1] = nil
                                    flippedTiles = 0
                                    
                                    
                                }
                            } else {
                                flippedTiles = 1
                            }
                            
                        } else {
                            flippedTiles = 1
                        }
                        
                        break outerLoop
                    }
                    
                }
                
            case 2:
                centerPoint = gesture.location(in: view)
                outerLoop: for n in 0..<tileAmount {
                    
                    if rectArray[n].contains(centerPoint) && flipped1 != nil && flipped2 != nil  {
                        if done.contains(n) {
                            
                            break outerLoop
                        }
                        tiles[flipped1!].alpha = 1.0
                        tiles[flipped2!].alpha = 1.0
                        wordLabelArray[0]?.removeFromSuperview()
                        wordLabelArray[1]?.removeFromSuperview()
                    }
                    if rectArray[n].contains(centerPoint) {
                        if done.contains(n) {
                            
                            break outerLoop
                        }
                        tiles[n].alpha = 0.0
                        
                        let wordView = UILabel()
                        
                        wordView.text = listOfWordsToUse[indexArray[n]]
                        print(wordView.text)
                        print("indexArray[n]: \(indexArray[n])")
                        wordView.frame = CGRect(x: pointArray[n].x, y: pointArray[n].y, width: tileWidth, height: tileHeight)
                        wordView.font = UIFont(name: "HelveticaNeue-Bold", size: fontSizeMultiplier*10)
                        wordView.alpha = 1.0
                        wordView.textAlignment = .center
                        wordView.textColor = UIColor.white
                        view.addSubview(wordView)
                        
                        if binary {
                            wordLabelArray[0] = wordView
                            flipped1 = n
                            binary = false
                        } else {
                            wordLabelArray[1] = wordView
                            flipped2 = n
                            binary = true
                        }
                        flippedTiles = 1
                        
                        break outerLoop
                    }
                    
                }
                
            default:
                break
            }
        }
        
        if game == "sensible" || game == "rediculous" || game == "idiotic" {
            switch flippedTiles {
            case 0, 1, 2:
                centerPoint = gesture.location(in: view)
                outerLoop: for n in 0..<tileAmount {
                    if rectArray[n].contains(centerPoint) {
                        if done.contains(n) {
                            break outerLoop
                        }
                        tiles[n].alpha = 0.0
                        var image = UIImage()
                        if indexArray[n] < tileAmount/3 {
                            image = UIImage(named: myItems.listOfImages[indexArray[n]])!
                        } else if indexArray[n] < 2*tileAmount/3 {
                            image = UIImage(named: myItems.listOfImages[indexArray[n] - tileAmount/3])!
                        } else {
                            image = UIImage(named: myItems.listOfImages[indexArray[n] - 2*tileAmount/3])!
                        }
                        let imageView = UIImageView(image: image)
                        imageView.frame = CGRect(x: pointArray[n].x + gap, y: pointArray[n].y + gap, width: 125*screenWidth/750, height: 125*screenWidth/750)
                        imageView.alpha = 1.0
                        
                        //                        if imageViewArray.count == 0 {
                        //                            imageViewArray.append(imageView)
                        //                            flipped1 = n
                        //                            triCount += 1
                        //                        } else if imageViewArray.count == 1 {
                        //                            imageViewArray.append(imageView)
                        //                            flipped2 = n
                        //                            triCount += 1
                        //                        } else if imageViewArray.count == 2 {
                        //                            imageViewArray.append(imageView)
                        //                            flipped3 = n
                        //                            triCount += 1
                        
                        if triCount%3 == 1 {
                            imageViewArray[0] = imageView
                            flipped1 = n
                            print(indexArray[n])
                            triCount += 1
                        } else if triCount%3 == 2 {
                            imageViewArray[1] = imageView
                            flipped2 = n
                            print(indexArray[n])
                            triCount += 1
                        } else if triCount%3 == 0 {
                            imageViewArray[2] = imageView
                            flipped3 = n
                            print(indexArray[n])
                            triCount += 1
                        }
                        
                        view.addSubview(imageView)
                        
                        if flipped1 != nil && flipped2 != nil && flipped3 != nil {
                            var flips = [indexArray[flipped1!], indexArray[flipped2!],indexArray[flipped3!]]
                            //                            print("highest: \(flips[0])")
                            //                            print("second: \(flips[1])")
                            //                            print("third: \(flips[2])")
                            flips = flips.sorted { $0 > $1 }
                            //                            print("after highest: \(flips[0])")
                            //                            print("after second: \(flips[1])")
                            //                            print("after third: \(flips[2])")
                            if tiles[flipped1!].alpha == 0.0 && tiles[(flipped2!)].alpha == 0.0 {
                                flippedTiles = 2
                            }
                            if tiles[(flipped2!)].alpha == 0.0 && tiles[(flipped3!)].alpha == 0.0 {
                                flippedTiles = 2
                            }
                            if tiles[flipped1!].alpha == 0.0 && tiles[(flipped3!)].alpha == 0.0 {
                                flippedTiles = 2
                            }
                            if tiles[flipped1!].alpha == 0.0 && tiles[(flipped2!)].alpha == 0.0 && tiles[(flipped3!)].alpha == 0.0 {
                                flippedTiles = 3
                                print("checked for triple match")
                                if (flips[0] - 2*tileAmount/3 == flips[2]) && (flips[1] - tileAmount/3 == flips[2]) {
                                    done.append(flipped1!)
                                    done.append(flipped2!)
                                    done.append(flipped3!)
                                    flipped1 = nil
                                    flipped2 = nil
                                    flipped3 = nil
                                    
                                    imageViewArray[0]!.alpha = 0.2
                                    imageViewArray[1]!.alpha = 0.2
                                    imageViewArray[2]!.alpha = 0.2
                                    imageViewArray[0] = nil
                                    imageViewArray[1] = nil
                                    imageViewArray[2] = nil
                                    flippedTiles = 0
                                    
                                    
                                }
                            } else {
                                flippedTiles = 1
                            }
                            
                        } else {
                            flippedTiles = 1
                        }
                        
                        break outerLoop
                    }
                    
                }
                
            case 3:
                centerPoint = gesture.location(in: view)
                outerLoop: for n in 0..<tileAmount {
                    
                    if rectArray[n].contains(centerPoint) && flipped1 != nil && flipped2 != nil && flipped2 != nil {
                        if done.contains(n) {
                            
                            break outerLoop
                        }
                        tiles[flipped1!].alpha = 1.0
                        tiles[flipped2!].alpha = 1.0
                        tiles[flipped3!].alpha = 1.0
                        imageViewArray[0]?.removeFromSuperview()
                        imageViewArray[1]?.removeFromSuperview()
                        imageViewArray[2]?.removeFromSuperview()
                        flipped1 = nil
                        flipped2 = nil
                        flipped3 = nil
                    }
                    if rectArray[n].contains(centerPoint) {
                        if done.contains(n) {
                            
                            break outerLoop
                        }
                        tiles[n].alpha = 0.0
                        var image = UIImage()
                        if indexArray[n] < tileAmount/3 {
                            image = UIImage(named: myItems.listOfImages[indexArray[n]])!
                        } else if indexArray[n] < 2*tileAmount/3 {
                            image = UIImage(named: myItems.listOfImages[indexArray[n] - tileAmount/3])!
                        } else {
                            image = UIImage(named: myItems.listOfImages[indexArray[n] - 2*tileAmount/3])!
                        }
                        let imageView = UIImageView(image: image)
                        imageView.frame = CGRect(x: pointArray[n].x + gap, y: pointArray[n].y + gap, width: 125*screenWidth/750, height: 125*screenWidth/750)
                        imageView.alpha = 1.0
                        view.addSubview(imageView)
                        
                        if triCount%3 == 1 {
                            imageViewArray[0] = imageView
                            flipped1 = n
                            print(indexArray[n])
                            triCount += 1
                        } else if triCount%3 == 2 {
                            imageViewArray[1] = imageView
                            flipped2 = n
                            print(indexArray[n])
                            triCount += 1
                        } else if triCount%3 == 0 {
                            imageViewArray[2] = imageView
                            flipped3 = n
                            print(indexArray[n])
                            triCount += 1
                        }
                        flippedTiles = 1
                        
                        break outerLoop
                    }
                    
                }
                
            default:
                break
            }
        }
        
    }
    
    private func selectItems() {
        var allNumbers = [Int]()
        var m: Int = 0
        print("game: \(game)")
        if game == "sensible" || game == "sanity" {
            m = Int(arc4random_uniform(UInt32(175)))
        }
        if game == "rediculous" || game == "absurd" {
            m = Int(arc4random_uniform(UInt32(100)))
        }
        if game == "sensible" || game == "rediculous" || game == "idiotic" {
            for i in m..<(m+tileAmount/3) {
                allNumbers.append(i)
            }
            print("m: \(m)")
            print("allNumbers: \(allNumbers)")
            for i in m..<(m+tileAmount/3) {
                
                let randomNumber = Int(arc4random_uniform(UInt32(allNumbers.count)))
                print("allNumbers.count: \(allNumbers.count)")
                if let index = allNumbers.index(of: allNumbers[randomNumber]) {
                    print("boo")
                    print(i)
                    listOfImagesToUse.append(myItems.listOfImages[allNumbers[randomNumber]])
                    allNumbers.remove(at: index)
                }
                
                
                
            }
            
            
        } else {
            
            for i in m..<(m+tileAmount/2) {
                allNumbers.append(i)
            }
            
            for _ in m..<(m+tileAmount/2) {
                
                let randomNumber = Int(arc4random_uniform(UInt32(allNumbers.count)))
                if let index = allNumbers.index(of: allNumbers[randomNumber]) {
                    listOfImagesToUse.append(myItems.listOfImages[allNumbers[randomNumber]])
                    allNumbers.remove(at: index)
                }
            }
        }
        if game == "wise" {
            for i in 0..<43 {
                listOfWordsToUse.append(myItems.listOfWords[i])
            }
            for i in 380..<423 {
                listOfWordsToUse.append(myItems.listOfWords[i])
            }
        }
        if game == "farcical" {
            
            for i in 0..<120 {
                listOfWordsToUse.append(myItems.listOfWords[i+35])
            }
            for i in 380..<500 {
                listOfWordsToUse.append(myItems.listOfWords[i+35])
            }
            
        }
        if game == "foolish" {
            
            for i in 0..<225 {
                listOfWordsToUse.append(myItems.listOfWords[i+155])
            }
            for i in 380..<605 {
                listOfWordsToUse.append(myItems.listOfWords[i+155])
            }
        }
    }
    
    private func organizeIndex() {
        var allNumbers = [Int]()
        for i in 0..<tileAmount {
            allNumbers.append(i)
        }
        
        for _ in 0..<tileAmount {
            
            let randomNumber = Int(arc4random_uniform(UInt32(allNumbers.count)))
            if let index = allNumbers.index(of: allNumbers[randomNumber]) {
                indexArray.append(allNumbers[randomNumber])
                allNumbers.remove(at: index)
            }
            
            
            
        }
        
    }
    
    
    
    
    
    
    @objc private func menu(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toMenuFromMatch", sender: self)
    }
    
    private func buyBonuses() {
        //IAP
    }
    
    
    private func sanityLevel(_ sender: UIButton) {
        y = 4
        z = 6
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        done.removeAll()
        tileAmount = (y+1)*(z+1)
        rectArray.removeAll()
        pointArray.removeAll()
        indexArray.removeAll()
        tiles.removeAll()
        tilesColors.removeAll()
        imageViewArray.removeAll()
        self.scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight)
        addLabels()
        organizeIndex()
        selectItems()
        binary = true
        flippedTiles = 0
        flipped1 = nil
        flipped2 = nil
        done.append(500)
        
    }
    private func absurdLevel(_ sender: UIButton) {
        y = 14
        z = 15
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        done.removeAll()
        tileAmount = (y+1)*(z+1)
        rectArray.removeAll()
        pointArray.removeAll()
        indexArray.removeAll()
        tiles.removeAll()
        tilesColors.removeAll()
        imageViewArray.removeAll()
        self.scrollView.contentSize = CGSize(width: 2.9*screenWidth, height: 4.08*screenWidth)
        addLabels()
        organizeIndex()
        selectItems()
        binary = true
        flippedTiles = 0
        flipped1 = nil
        flipped2 = nil
        done.append(500)
        
    }
    
    private func insaneLevel(_ sender: UIButton) {
        y = 14
        z = 29
        done.removeAll()
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        tileAmount = (y+1)*(z+1)
        rectArray.removeAll()
        pointArray.removeAll()
        indexArray.removeAll()
        tiles.removeAll()
        tilesColors.removeAll()
        imageViewArray.removeAll()
        self.scrollView.contentSize = CGSize(width: 2.9*screenWidth, height: 4.08*screenWidth)
        addLabels()
        organizeIndex()
        selectItems()
        binary = true
        flippedTiles = 0
        flipped1 = nil
        flipped2 = nil
        done.append(500)
        
    }
    
    private func wiseLevel(_ sender: UIButton) {
        y = 4
        z = 6
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        done.removeAll()
        tileAmount = (y+1)*(z+1)
        rectArray.removeAll()
        pointArray.removeAll()
        indexArray.removeAll()
        tiles.removeAll()
        tilesColors.removeAll()
        imageViewArray.removeAll()
        self.scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight)
        addLabels()
        organizeIndex()
        selectItems()
        binary = true
        flippedTiles = 0
        flipped1 = nil
        flipped2 = nil
        done.append(500)
        
    }
    private func farcicalLevel(_ sender: UIButton) {
        y = 14
        z = 15
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        done.removeAll()
        tileAmount = (y+1)*(z+1)
        rectArray.removeAll()
        pointArray.removeAll()
        indexArray.removeAll()
        tiles.removeAll()
        tilesColors.removeAll()
        imageViewArray.removeAll()
        self.scrollView.contentSize = CGSize(width: 2.9*screenWidth, height: 4.08*screenWidth)
        addLabels()
        organizeIndex()
        selectItems()
        binary = true
        flippedTiles = 0
        flipped1 = nil
        flipped2 = nil
        done.append(500)
        
    }
    
    private func foolishLevel(_ sender: UIButton) {
        y = 14
        z = 29
        done.removeAll()
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        tileAmount = (y+1)*(z+1)
        rectArray.removeAll()
        pointArray.removeAll()
        indexArray.removeAll()
        tiles.removeAll()
        tilesColors.removeAll()
        imageViewArray.removeAll()
        self.scrollView.contentSize = CGSize(width: 2.9*screenWidth, height: 4.08*screenWidth)
        addLabels()
        organizeIndex()
        selectItems()
        binary = true
        flippedTiles = 0
        flipped1 = nil
        flipped2 = nil
        done.append(500)
        
    }
    
    private func sensibleLevel(_ sender: UIButton) {
        y = 4
        z = 6
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        done.removeAll()
        tileAmount = (y+1)*(z+1)
        rectArray.removeAll()
        pointArray.removeAll()
        indexArray.removeAll()
        tiles.removeAll()
        tilesColors.removeAll()
        imageViewArray.removeAll()
        self.scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight)
        addLabels()
        organizeIndex()
        selectItems()
        binary = true
        flippedTiles = 0
        flipped1 = nil
        flipped2 = nil
        done.append(500)
        
    }
    private func rediculousLevel(_ sender: UIButton) {
        y = 14
        z = 15
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        done.removeAll()
        tileAmount = (y+1)*(z+1)
        rectArray.removeAll()
        pointArray.removeAll()
        indexArray.removeAll()
        tiles.removeAll()
        tilesColors.removeAll()
        imageViewArray.removeAll()
        self.scrollView.contentSize = CGSize(width: 2.9*screenWidth, height: 4.08*screenWidth)
        addLabels()
        organizeIndex()
        selectItems()
        binary = true
        flippedTiles = 0
        flipped1 = nil
        flipped2 = nil
        done.append(500)
        
    }
    
    private func idioticLevel(_ sender: UIButton) {
        y = 14
        z = 29
        done.removeAll()
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        tileAmount = (y+1)*(z+1)
        rectArray.removeAll()
        pointArray.removeAll()
        indexArray.removeAll()
        tiles.removeAll()
        tilesColors.removeAll()
        imageViewArray.removeAll()
        self.scrollView.contentSize = CGSize(width: 2.9*screenWidth, height: 4.08*screenWidth)
        addLabels()
        organizeIndex()
        selectItems()
        binary = true
        flippedTiles = 0
        flipped1 = nil
        flipped2 = nil
        done.append(500)
        
    }
    //coredata functions
    
    private func deleteAllData(entity: String)
    {
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context = appDel.persistentContainer.viewContext
        let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
        do { try context.execute(DelAllReqVar) }
        catch { print(error) }
    }
    
    private func saveLevel() {
        var index = [Int]()
        var bool = [Int]()
        var list = [String]()
        bool = done
        for i in 0..<tileAmount {
            index.append(indexArray[i])
            if game == "wise" || game == "farcical" || game == "foolish" {
                list.append(listOfWordsToUse[i])
            } else if game == "sanity" || game == "absurd" || game == "insane" {
                if i < tileAmount/2 {
                    list.append(listOfImagesToUse[i])
                } else {
                    if i < tileAmount/3 {
                        list.append(listOfImagesToUse[i])
                    }
                }
            }
        }
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        if resultsGameRequest.count > 0 {
            deleteAllData(entity: gameData)
        }
        
        let entity = NSEntityDescription.insertNewObject(forEntityName: gameData, into: context)
        entity.setValue(index, forKey: "index")
        entity.setValue(bool, forKey: "bool")
        entity.setValue(list, forKey: "list")
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("levelSaved")
        saveLevel()
    }
    
    
    //coredata functions end
    
    
}



