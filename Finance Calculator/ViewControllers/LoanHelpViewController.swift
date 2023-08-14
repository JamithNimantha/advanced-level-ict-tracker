//
//  LoanHelpViewController.swift
//  Finance Calculator
//
//  Created by ABC on 12/6/20.
//

import UIKit

class LoanHelpViewController: UIViewController {

    @IBOutlet weak var helpTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    // custom methods
    func setUpUI()
    {
           self.view.backgroundColor = UIColor.backgroundColor()
           self.helpTitle.text = NSLocalizedString("loan", comment: "")
    }
}
