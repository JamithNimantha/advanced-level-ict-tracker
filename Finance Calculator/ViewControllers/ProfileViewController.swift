//
//  SavingsViewController.swift
//  Finance Calculator
//
//  Created by ABC on 12/4/20.
//

import UIKit
import Foundation
import CoreData
//import Charts

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var pastPapersView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var schoolPaperView: UIView!
    @IBOutlet weak var tutorialView: UIView!
    
    //var barChartView: BarChartView!
    
    var context: NSManagedObjectContext? {
        guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    @IBOutlet weak var ppTotal: UILabel!
    @IBOutlet weak var PPAVGMarks: UILabel!
    @IBOutlet weak var PPMaxMarks: UILabel!
    @IBOutlet weak var PPMinMarks: UILabel!
    
    @IBOutlet weak var SPTotal: UILabel!
    @IBOutlet weak var SPAVGMarks: UILabel!
    @IBOutlet weak var SPMaxMarks: UILabel!
    @IBOutlet weak var SPMinMarks: UILabel!
    
    
    @IBOutlet weak var TPTotal: UILabel!
    @IBOutlet weak var TPAVGMarks: UILabel!
    @IBOutlet weak var TPMaxMarks: UILabel!
    @IBOutlet weak var TPMinMarks: UILabel!
    
    @IBOutlet weak var profileName: UILabel!
    var pastPapers: [Paper] = []
    var schoolPapers: [Paper] = []
    var tutorialPapers: [Paper] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        generateMockData()
//        fetchSchoolPaperData()
        fetchSchoolPaperData()
        fetchTutorialPaperData()
        fetchPastPaperData()
        loadCardViews()
        calculateAndAssignStatistics()
//        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(pastPapersViewDoubleTapped))
//        doubleTapGesture.numberOfTapsRequired = 2
//        pastPapersView.addGestureRecognizer(doubleTapGesture)
    }
    
//    @objc func pastPapersViewDoubleTapped() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Use your storyboard name
//        if let barChartVC = storyboard.instantiateViewController(withIdentifier: "BarChartViewController") as? BarChartViewController {
//            barChartVC.pastPapers = pastPapers // Pass the data to the bar chart view controller
//            present(barChartVC, animated: true, completion: nil)
//        }
//    }
    
    func setupUI() {
            profileImg.layer.cornerRadius = profileImg.frame.size.height / 2
            profileImg.layer.borderWidth = 0.2
            profileImg.layer.masksToBounds = true
        
        if let imageData = UserDefaults.standard.data(forKey: "ProfileImage"),
                let savedImage = UIImage(data: imageData) {
                profileImg.image = savedImage
            }
        
        if let savedName = UserDefaults.standard.string(forKey: "ProfileName") {
                profileName.text = savedName
            }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
            profileImg.addGestureRecognizer(tapGesture)
            profileImg.isUserInteractionEnabled = true
        
        let nameTapGesture = UITapGestureRecognizer(target: self, action: #selector(profileNameTapped))
            profileName.addGestureRecognizer(nameTapGesture)
            profileName.isUserInteractionEnabled = true
    }
    
    
    @objc func profileNameTapped() {
        let alertController = UIAlertController(title: "Edit Profile Name", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Enter new name"
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            if let newName = alertController.textFields?.first?.text, !newName.isEmpty {
                self.profileName.text = newName
                UserDefaults.standard.set(newName, forKey: "ProfileName")
            }
        }

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        present(alertController, animated: true, completion: nil)
    }

    @objc func profileImageTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileImg.image = selectedImage
            UserDefaults.standard.set(selectedImage.pngData(), forKey: "ProfileImage")
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }


    
    func loadCardViews() {
            loadCardViewStyle(pastPapersView)
            loadCardViewStyle(schoolPaperView)
            loadCardViewStyle(tutorialView)
    }
    
    func loadCardViewStyle(_ cardView: UIView) {
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius = 2.0
        cardView.layer.shadowOpacity = 1.0
    }
    
    func calculateAndAssignStatistics() {
        if let ppStats = calculateStatistics(for: pastPapers) {
            ppTotal.text = "Total: \(ppStats.total)"
            PPAVGMarks.text = "AVG Marks: " + String(format: "%.2f", ppStats.average) + "%"
            PPMinMarks.text = "Min Marks: " + String(format: "%.2f", ppStats.min) + "%"
            PPMaxMarks.text = "Max Marks: " + String(format: "%.2f", ppStats.max) + "%"
        }
        
        if let spStats = calculateStatistics(for: schoolPapers) {
            SPTotal.text = "Total: \(spStats.total)"
            SPAVGMarks.text = "AVG Marks: " + String(format: "%.2f", spStats.average) + "%"
            SPMinMarks.text = "Min Marks: " + String(format: "%.2f", spStats.min) + "%"
            SPMaxMarks.text = "Max Marks: " + String(format: "%.2f", spStats.max) + "%"
        }
        
        if let tpStats = calculateStatistics(for: tutorialPapers) {
            TPTotal.text = "Total: \(tpStats.total)"
            TPAVGMarks.text = "AVG Marks: " + String(format: "%.2f", tpStats.average) + "%"
            TPMinMarks.text = "Min Marks: " + String(format: "%.2f", tpStats.min) + "%"
            TPMaxMarks.text = "Max Marks: " + String(format: "%.2f", tpStats.max) + "%"
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        fetchSchoolPaperData()
        fetchTutorialPaperData()
        fetchPastPaperData()
       navigationController?.navigationBar.topItem!.title = NSLocalizedString("profile", comment: "")
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            fetchSchoolPaperData()
            fetchTutorialPaperData()
            fetchPastPaperData()
    }
    
    func calculateStatistics(for papers: [Paper]) -> (total: Int, average: Double, min: Double, max: Double)? {
        guard !papers.isEmpty else { return nil }
        
        let totalPapers = papers.count
        let totalMarks = papers.reduce(0) { $0 + $1.marks }
        let averageMarks = Double(totalMarks) / Double(totalPapers)
        let minMarks = papers.reduce(Double.greatestFiniteMagnitude) { min($0, Double($1.marks)) }
            let maxMarks = papers.reduce(0) { max($0, Double($1.marks)) }
        
        return (totalPapers, averageMarks, minMarks, maxMarks)
    }
    
    
    func generateMockData() {
            pastPapers = [
                Paper(name: "Past Paper 1", date: Date(), marks: 85),
                Paper(name: "Past Paper 2", date: Date(), marks: 70),
                Paper(name: "Past Paper 3", date: Date(), marks: 80),
            ]
            
            schoolPapers = [
                Paper(name: "School Paper 1", date: Date(), marks: 90),
                Paper(name: "School Paper 2", date: Date(), marks: 65),
            ]
            
            tutorialPapers = [
                Paper(name: "Tutorial Paper 1", date: Date(), marks: 80),
                Paper(name: "Tutorial Paper 2", date: Date(), marks: 75),
            ]
        }
    
    func fetchSchoolPaperData()
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"PastPaperData")
        do
        {
            let savingData = try self.context?.fetch(request) as! [PastPaperData]
            if(savingData.count > 0 )
            {
            
                schoolPapers = savingData
                    .filter{data in return data.category == "SCHOOL_PAPER"}
                    .compactMap { data in
                                        guard let year = data.year,
                                              let marksString = data.marks,
                                              let marks = Int(marksString),
                                              let dateString = data.date,
                                              let date = dateFromString(dateString) else {
                                            return nil
                                        }
                                        
                                        return Paper(name: year,
                                                     date: date,
                                                     marks: marks)
                }
            }
            else
            {
                print("No results found")
            }
        }
        catch
        {
            print("Error in fetching items")
        }
    }
    
    func dateFromString(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString)
    }
    
    func fetchPastPaperData()
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"PastPaperData")
        do
        {
            let savingData = try self.context?.fetch(request) as! [PastPaperData]
            if(savingData.count > 0 )
            {
            
                pastPapers = savingData
                    .filter{data in return data.category == "PAST_PAPER"}
                    .compactMap { data in
                                        guard let year = data.year,
                                              let marksString = data.marks,
                                              let marks = Int(marksString),
                                              let dateString = data.date,
                                              let date = dateFromString(dateString) else {
                                            return nil
                                        }
                                        
                                        return Paper(name: year,
                                                     date: date,
                                                     marks: marks)
                }
            }
            else
            {
                print("No results found")
            }
        }
        catch
        {
            print("Error in fetching items")
        }
    }
    
    func fetchTutorialPaperData()
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"PastPaperData")
        do
        {
            let savingData = try self.context?.fetch(request) as! [PastPaperData]
            if(savingData.count > 0 )
            {
            
                tutorialPapers = savingData
                    .filter{data in return data.category == "TUTORIAL"}
                    .compactMap { data in
                                        guard let year = data.year,
                                              let marksString = data.marks,
                                              let marks = Int(marksString),
                                              let dateString = data.date,
                                              let date = dateFromString(dateString) else {
                                            return nil
                                        }
                                        
                                        return Paper(name: year,
                                                     date: date,
                                                     marks: marks)
                }
            }
            else
            {
                print("No results found")
            }
        }
        catch
        {
            print("Error in fetching items")
        }
    }
    
}
