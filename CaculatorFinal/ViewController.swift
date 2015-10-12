//
//  ViewController.swift
//  CaculatorFinal
//
//  Created by ying on 15/10/10.
//  Copyright © 2015年 ying. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Property
    @IBOutlet weak var display: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var isUserInputNumber:Bool = false  //判断用户是否已经输入
    
    var hasInputNumberArray = [Double]()
    var hasInputOperatorArray = [String]()
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            isUserInputNumber = false
        }
    }
    
    var isFloatingNumber = false //判断用户是否输入了一个带小数点的数
    
    //*************************************

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if digit == "." {
            if !isFloatingNumber {
                display.text = display.text! + digit
                isFloatingNumber = true
            }
        }
        else if isUserInputNumber {
            let currentString = display.text!
            if currentString != "0" {
                display.text = display.text! + digit
            }
            else {
                if digit != "0" {
                    display.text = digit
                }
            }
            
        }
        else {
            display.text = digit
            isUserInputNumber = true
        }
        
    }

    @IBAction func operate(sender: UIButton) {
        isUserInputNumber = false
        isFloatingNumber = false
        hasInputNumberArray.append(displayValue)
        hasInputOperatorArray.append(sender.currentTitle!)
        //******************************************************
        //print("InputArray = \(hasInputNumberArray)")
        //print("InputOperatorArray = \(hasInputOperatorArray)")
    }
    
    @IBAction func caculateResult(sender: UIButton) {
        
        if (hasInputOperatorArray.count > 0) && (hasInputNumberArray.count > 0) {
            let twoActor = NSNumberFormatter().numberFromString(display.text!)!.doubleValue
            let operatorTemp = hasInputOperatorArray.removeLast()
            isFloatingNumber = false
            switch operatorTemp {
             case "×" :
                display.text = "\(twoActor * hasInputNumberArray.removeLast())"
             case "÷" :
                display.text = "\(hasInputNumberArray.removeLast() / twoActor)"
             case "+" :
                display.text = "\(twoActor + hasInputNumberArray.removeLast())"
             case "−" :
                display.text = "\(hasInputNumberArray.removeLast() - twoActor)"
             default :
                print("Operator is Wrong")
            }
        
        }
        
    }
    
    @IBAction func clearAll(sender: UIButton) {
        isUserInputNumber = false
        display.text = "0.0"
        isFloatingNumber = false
        hasInputOperatorArray.removeAll()
        hasInputNumberArray.removeAll()
    }
    
    @IBAction func delWrongNum(sender: UIButton) {
       display.text!.removeAtIndex(display.text!.endIndex.predecessor())
    }
    
    
}

