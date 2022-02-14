//
//  ViewController.swift
//  LittleBoyChamp
//
//  Created by Clay Boyd on 2/11/22.
//
// Creates a ranking of group of friends as the biggest "little boy" storing information about each friend in Firebase real time database and displaying the top 3 "littlest boys" on the home page
// Little boy score is defined by doing an offence worth of a point which includes examples such as not washing their dishes
//
// TODO generalize the listOfBoys to a user list and connect to a user auth object. Signup fields will include each parameter in Lad object
// TODO fix stack view object to return to original position when keyboard disappears
// TODO continue updating UI for better user experience.



import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    // Var links
    @IBOutlet weak var bbLabel: UILabel!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var firstPlaceLabel: UILabel!
    @IBOutlet weak var secondPlaceLabel: UILabel!
    @IBOutlet weak var thirdPlaceLabel: UILabel!
    @IBOutlet weak var offenceTextField: UITextField!
    @IBOutlet weak var theBoydPicker: UIPickerView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var firstImg: UIImageView!
    @IBOutlet weak var secondImg: UIImageView!
    @IBOutlet weak var thirdImg: UIImageView!
    @IBOutlet weak var lilLabel: UILabel!
    @IBOutlet weak var stackBottom: NSLayoutConstraint!
    
    // Global variables
    var listOfBoys = [
                       Lad(firstName: "Antyush", lastName: "Bollini", photoPath: "antyush", score: 0),
                       Lad(firstName: "Allistair", lastName: "Nathan", photoPath: "allistair", score: 0),
                       Lad(firstName: "Clay", lastName: "Boyd", photoPath: "clay", score: 0),
                       Lad(firstName: "Ethan", lastName: "Rehn", photoPath: "ethan", score: 5), // ethan starts with 5 automatically for being a little boy
                       Lad(firstName: "Matt", lastName: "Kendrick", photoPath: "matt", score: 0),
                       Lad(firstName: "Spencer", lastName: "Goldstein", photoPath: "spencer", score: 0),
                       Lad(firstName: "Gabe", lastName: "Waldbaum", photoPath: "gabe", score: 0),
                       Lad(firstName: "Luka", lastName: "Marcetta", photoPath: "luka", score: 0),
                       Lad(firstName: "Tom", lastName: "Zimet", photoPath: "tom", score: 0),
                       Lad(firstName: "Caden", lastName: "Wakefield", photoPath: "caden", score: 0),
                       Lad(firstName: "Mac", lastName: "Anderson", photoPath: "mac", score: 0),
                       Lad(firstName: "Johnny", lastName: "Reser", photoPath: "baby", score: 0),
                       Lad(firstName: "LJ", lastName: "Reyes", photoPath: "lj", score: 0),
                        ]
    
    var selectedOffender: String = ""

    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleElements()
        theBoydPicker.dataSource = self
        theBoydPicker.delegate = self
        
        refreshLeaderBoard()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    // Moves the stack view up when keyboard pops up
    @objc func keyboardWillChange(notification: NSNotification) {
        if let info: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRect = info.cgRectValue
            let keyboardHeight = keyboardRect.height
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
                self.stackBottom.constant = keyboardHeight + 20
            }
        }
    }
    
    // Sets the style for the UI View
    func styleElements() {
        view.backgroundColor = .white
        Utils.styleRoundImg(img: firstImg)
        Utils.styleRoundImg(img: secondImg)
        Utils.styleRoundImg(img: thirdImg)
        Utils.styleTitle(title: bbLabel)
        Utils.styleTitle(title: pageTitle)
        Utils.styleNameLabel(Name: secondPlaceLabel)
        Utils.styleNameLabel(Name: thirdPlaceLabel)
        Utils.styleNameLabel(Name: lilLabel)
        Utils.styleWinnerLabel(Name: firstPlaceLabel)
        Utils.styleEmptyButton(button: refreshButton)
        Utils.styleFilledButton(button: confirmButton)
        Utils.styleTextField(textfield: offenceTextField)
        Utils.stlyePicker(picker: theBoydPicker)
    }
    
    @IBAction func confirmTapped(_ sender: Any) {
        // Validate offence
        // TODO create db of good and bad offences to
        let offence_is_bad = true
        guard let offence = offenceTextField.text else {return}
        if offence != "" {
            //let offender = "Luka"
            if offence_is_bad == true {
                for boy in listOfBoys {
                    if boy.firstName == selectedOffender {
                        boy.score += 1
                        
                        print(boy.firstName, boy.score)
                    }
                    // update DB
                    let post = ["firstName": boy.firstName, "lastName": boy.lastName, "score": boy.score] as [String: Any]
                    ref.child(boy.firstName).setValue(post)
                }
            // Once logic is created this will be implemented
//            } else { // will never be executed without logic for offence_is_bad
//                for boy in listOfBoys {
//                    if boy.firstName == selectedOffender {
//                        boy.score -= 1
//                    }
//                }
            }
            // Do some thing to show it is updating
            offenceTextField.text = ""
        } else {
            print("error")
            resetForm()
        }
        // refresh list
        refreshLeaderBoard()
        offenceTextField.resignFirstResponder()
    }
    
    // dispalys an alert when the confirm button is pressed before fields are filled
    func resetForm() {
        let alert = UIAlertController(title: "Please fill in the field with a valid offense", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default , handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        Utils.setContinueButton(enabled: true, button: confirmButton)
        confirmButton.setTitle("Confirm", for: .normal)
    }
    
    
    @IBAction func refreshTapped(_ sender: Any) {
        refreshLeaderBoard()
    }
    
    
    // Reads the database
    // Updates the little boy scores to match the DB value
    // Sorts the list by descending order of score
    // Assigns first second and third place
    // Refreshes the viewController
    func refreshLeaderBoard() {
        ref.observe(.value, with: { [self]snapshot in
            for child in snapshot.children {
                guard let childSnapshot = child as? NSDictionary,
                   let dict = childSnapshot as? [String:Any],
                   let name = dict["firstName"] as? String,
                   let score = dict["score"] as? Int else {return}
                 
                for boy in self.listOfBoys {
                    if name == boy.firstName {
                        boy.score = score
                    }
                }
            }
        })
        
        // Sort then rank the top 3 champions!
        listOfBoys = listOfBoys.sorted(by: { $0.score > $1.score })
        let littleBoyChamp = listOfBoys[0]
        let littleBoySecond = listOfBoys[1]
        let littleBoyThird = listOfBoys[2]
        
        // Set the viewer values
        firstPlaceLabel.text = littleBoyChamp.firstName
        if littleBoyChamp.photoPath != "" {
            firstImg.image = UIImage(named: littleBoyChamp.photoPath)
        }
        
        
        secondPlaceLabel.text = littleBoySecond.firstName
        if littleBoySecond.photoPath != "" {
            secondImg.image = UIImage(named: littleBoySecond.photoPath)
        }

        
        thirdPlaceLabel.text = littleBoyThird.firstName
        
        if littleBoyThird.photoPath != "" {
            thirdImg.image = UIImage(named: littleBoyThird.photoPath)
        }
        
    }
    
    
    //===================================================================
    // =================Extension methods for picker view================
    // delegate
    @objc func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listOfBoys[row].firstName
    }
    
    @objc func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOffender = listOfBoys[row].firstName as String
        confirmButton.setTitle("Confirm for \(selectedOffender)", for: .normal)
    }
    
    // data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listOfBoys.count
    }
   
} // end of class
