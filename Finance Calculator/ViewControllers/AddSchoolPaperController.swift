//
//  SavingsViewController.swift
//  Finance Calculator
//
//  Created by ABC on 12/4/20.
//

import UIKit
import Foundation
import CoreData

class AddSchoolPaperController: UIViewController {

    
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var marks: UITextField!
    @IBOutlet weak var duration: UITextField!
    @IBOutlet weak var paper: UITextField!
    
    @IBAction func onAddPaper(_ sender: Any) {
        displaySuccessAlert()
    }
    
    
    func displaySuccessAlert()
    {
         let alert = UIAlertController(title: "Successfull", message: "Paper Added Successfully", preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default))
         self.present(alert, animated: true, completion: nil)
        clearSavings()
    }
    
    func clearSavings()
    {
        clearEachValue(field: year)
        clearEachValue(field: marks)
        clearEachValue(field: duration)
        clearEachValue(field: paper)
        
    }
    
    func clearEachValue(field: UITextField)
    {
        field.text=""
        field.clear()
    }
}
