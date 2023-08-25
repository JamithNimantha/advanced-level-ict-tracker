//
//  TutorialViewController.swift
//  Finance Calculator
//
//  Created by Kirishikesan on 2023-08-23.
//

import UIKit

class TutorialViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let dataSource: [Tutorial] = [
        Tutorial(year: "2021", marks: "78%", date: "2023-08-03", duration: "2 Hrs", url: "https://www.google.com"),
        Tutorial(year: "2021", marks: "78%", date: "2023-08-03", duration: "2 Hrs", url: "https://www.google.com"),
        Tutorial(year: "2021", marks: "78%", date: "2023-08-03", duration: "2 Hrs", url: "https://www.google.com"),
        Tutorial(year: "2021", marks: "78%", date: "2023-08-03", duration: "2 Hrs", url: "https://www.google.com")
    ]
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        if let learningMaterialCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell3", for: indexPath) as? CollectionViewCell {
            learningMaterialCell.configure(with: dataSource[indexPath.row])
            cell = learningMaterialCell
        }
        return cell;
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
    }
    

    
}
