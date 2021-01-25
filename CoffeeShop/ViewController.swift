//
//  ViewController.swift
//  CoffeeShop
//
//  Created by Wei Xu on 2020-04-05.
//  Copyright © 2020 Georgebrown. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var milkDisplay: UILabel!
    @IBOutlet weak var sugarDisplay: UILabel!
    @IBOutlet weak var milkStepper: UIStepper!
    @IBOutlet weak var sugarStepper: UIStepper!
    @IBOutlet weak var coffeeTypeSegment: UISegmentedControl!
    @IBOutlet weak var sizeSegment: UISegmentedControl!
    @IBOutlet weak var rewardSwitch: UISwitch!
    @IBOutlet weak var summaryOrderLabel: UILabel!
    @IBOutlet weak var orderSummaryTextview: UITextView!
    
    // MARK: Default functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: Actions
    @IBAction func milkStepperChanged(_ sender: UIStepper) {
        milkDisplay.text="\(Int(milkStepper.value))"
        
        // Reset coffee type
        coffeeTypeSegment.selectedSegmentIndex=UISegmentedControl.noSegment
    }
    
    @IBAction func sugarStepperChanged(_ sender: UIStepper) {
        sugarDisplay.text="\(sugarStepper.value)"
        
        // Reset coffee type
        coffeeTypeSegment.selectedSegmentIndex=UISegmentedControl.noSegment
    }
    
    @IBAction func coffeeTypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            // Black = no milk, no sugar
            milkStepper.value=milkStepper.minimumValue
            milkDisplay.text="\(Int(milkStepper.minimumValue))"
            sugarStepper.value=sugarStepper.minimumValue
            sugarDisplay.text="\(sugarStepper.minimumValue)"
        case 1:
            // Regular = 1 milk, 0.5 sugar
            milkStepper.value=1
            milkDisplay.text="1"
            sugarStepper.value=0.5
            sugarDisplay.text="0.5"
        case 2:
            // Double Double = 2 milk, 2 sugar
            milkStepper.value=2
            milkDisplay.text="2"
            sugarStepper.value=2.0
            sugarDisplay.text="2.0"
        default:
            break
        }
    }
    
    @IBAction func placeOrderPressed(_ sender: Any) {
        //display a summary of the person’s order, and the final price
        if(sizeSegment.selectedSegmentIndex==UISegmentedControl.noSegment) {
            let box = UIAlertController(
                title: "Size Error",
                message: "Please choose the size",
                preferredStyle: .alert
            )
            box.addAction(
                UIAlertAction(title:"OK", style: .default, handler:nil)
            )
            self.present(box, animated:true)
        } else {
            var subTotal:Double=0
            var tax:Double=0
            var total:Double
            var sizeTitle:String
            var rewardApplied:String
            
            if(sizeSegment.selectedSegmentIndex==0) {
                tax=1.67*0.13
                subTotal=1.67+tax
            } else if(sizeSegment.selectedSegmentIndex==1) {
                tax=1.89*0.13
                subTotal=1.89+tax
            } else if(sizeSegment.selectedSegmentIndex==2) {
                tax=2.10*0.13
                subTotal=2.10+tax
            }
            
            if(rewardSwitch.isOn==true) {
                total=0
                rewardApplied="yes"
            } else {
                total=subTotal
                rewardApplied="no"
            }
            
            sizeTitle = sizeSegment.titleForSegment(at: sizeSegment.selectedSegmentIndex)!
            
            summaryOrderLabel.isHidden=false
            orderSummaryTextview.text="Milk: \(Int(milkStepper.value)), Sugar: \(sugarStepper.value)\n"
            orderSummaryTextview.text+="Size: \(sizeTitle)\n"
            orderSummaryTextview.text+="Subtotal: \(String(format: "%.2f", subTotal))\n"
            orderSummaryTextview.text+="Tax: \(String(format: "%.2f", tax))\n"
            orderSummaryTextview.text+="Rewards Applied: \(rewardApplied)\n"
            orderSummaryTextview.text+="Total: $\(String(format: "%.2f", total))\n"
            
        }
    }
    
    @IBAction func cancelOrderPressed(_ sender: Any) {
        // reset all controls to their default values
        // Milk and sugar default to 0
        milkStepper.value=milkStepper.minimumValue
        milkDisplay.text="\(Int(milkStepper.minimumValue))"
        sugarStepper.value=sugarStepper.minimumValue
        sugarDisplay.text="\(sugarStepper.minimumValue)"
        
        // Coffee shortcuts (black, regular, double double)   are not selected
        coffeeTypeSegment.selectedSegmentIndex=UISegmentedControl.noSegment
        
        // Size defaults to small
        sizeSegment.selectedSegmentIndex=0
        
        // Rewards switch defaults to OFF
        rewardSwitch.isOn=false
        
        // Summary of Order is hidden
        summaryOrderLabel.isHidden=true
        orderSummaryTextview.text=""
        
    }
}

