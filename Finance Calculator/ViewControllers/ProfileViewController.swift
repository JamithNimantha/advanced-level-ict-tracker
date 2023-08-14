//
//  SavingsViewController.swift
//  Finance Calculator
//
//  Created by ABC on 12/4/20.
//

import UIKit
import Foundation
import CoreData

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var professionLbl: UILabel!
    
    @IBOutlet weak var degreeLbl: UILabel!
    
    @IBOutlet weak var dateLbl: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
       navigationController?.navigationBar.topItem!.title = NSLocalizedString("profile", comment: "")
    }
    
}
