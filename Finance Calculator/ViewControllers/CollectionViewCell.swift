//
//  CollectionViewCell.swift
//  Finance Calculator
//
//  Created by Kirishikesan on 2023-08-22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var marksLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    var url : String = ""
    
    @IBAction func viewButtonClicked(_ sender: UIButton) {
        if let link = URL(string: self.url){
            print(url)
            UIApplication.shared.open(link)
        }
    }
    
    func configure(with learningMaterial: LearningMaterial){
        yearLabel.text = "Year - \(learningMaterial.year)"
        marksLabel.text = "Marks - \(learningMaterial.marks)"
        dateLabel.text = "Date - \(learningMaterial.date)"
        durationLabel.text = "Duration - \(learningMaterial.duration)"
        url = learningMaterial.url
    }
    
}

