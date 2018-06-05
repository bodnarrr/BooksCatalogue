//
//  AddVC.swift
//  Catalogue
//
//  Created by Andriy BODNAR on 02.05.2018.
//  Copyright © 2018 Andriy BODNAR. All rights reserved.
//

import UIKit

class AddVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleErrorLabel: UILabel!
    @IBOutlet weak var authorErrorLabel: UILabel!
    @IBOutlet weak var yearErrorLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        delegateTextFields()
        initFieldsBorders()
        
        view.layer.backgroundColor = UIColor(red: 242/255, green: 245/255, blue: 247/255, alpha: 1).cgColor
        
        //init save btn style
        saveButton.layer.borderWidth = 0
        saveButton.layer.backgroundColor = UIColor(red: 110/255, green: 217/255, blue: 135/255, alpha: 1).cgColor
        saveButton.layer.cornerRadius = 5
        saveButton.tintColor = UIColor.white
        
        //init cover
        coverImage.layer.cornerRadius = 5
        if coverImage.image == UIImage(named: "no cover cropped") {
            coverImage.layer.borderWidth = 0.5
            coverImage.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }

    @IBAction func coverTapped(_ sender: UITapGestureRecognizer) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        
        titleTextField.resignFirstResponder()
        authorTextField.resignFirstResponder()
        yearTextField.resignFirstResponder()
        genreTextField.resignFirstResponder()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        coverImage.image = selectedImage
        hintLabel.isHidden = true
        coverImage.layer.borderWidth = 0
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        if self.checkFields() == true {
        
            if let destVC = navigationController?.viewControllers[0] as? MainVC {
                
                let book = Book(cover: coverImage.image!, title: titleTextField.text ?? "unknown", author: authorTextField.text ?? "unknown", year: yearTextField.text ?? "unknown", genre: genreTextField.text ?? "unknown", alreadyRead : false)
                
                destVC.books.insert(book, at: 0)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    private func checkFields() -> Bool {
        
        var checkResult : Bool = true
        
        if !(self.titleTextField.text?.isEmpty)! {
            
            self.titleTextField.layer.borderColor = UIColor(red: 110/255, green: 217/255, blue: 135/255, alpha: 1).cgColor
            self.titleErrorLabel.isHidden = true
        } else {
            self.titleErrorLabel.isHidden = false
            self.titleErrorLabel.text = "* title field can not be empty"
            checkResult = false
        }
        
        if !(self.authorTextField.text?.isEmpty)! {
            
            self.authorTextField.layer.borderColor = UIColor(red: 110/255, green: 217/255, blue: 135/255, alpha: 1).cgColor
            self.authorErrorLabel.isHidden = true
        } else {
            self.authorErrorLabel.isHidden = false
            self.authorErrorLabel.text = "* author field can not be empty"
            checkResult = false
        }
        
        if !(self.yearTextField.text?.isEmpty)! {
            
            let year = Int(yearTextField.text!)
            print(year ?? 42)
            if year == nil || (year != nil && (year! < 0 || year! > 2018))  {
                
                yearTextField.layer.borderWidth = 1.0
                yearTextField.layer.borderColor = UIColor.red.cgColor
                yearErrorLabel.text = "* year is incorrect"
                self.yearErrorLabel.isHidden = false
                checkResult = false
            } else {
                
                yearTextField.layer.borderColor = UIColor(red: 110/255, green: 217/255, blue: 135/255, alpha: 1).cgColor
                self.yearErrorLabel.isHidden = true
            }
        }
        
        return checkResult
    }
    
    private func initFieldsBorders() {
        
        titleTextField.layer.borderColor = UIColor.red.cgColor
        titleTextField.layer.borderWidth = 1.0
        titleTextField.layer.cornerRadius = 5
        authorTextField.layer.borderColor = UIColor.red.cgColor
        authorTextField.layer.borderWidth = 1.0
        authorTextField.layer.cornerRadius = 5
        yearTextField.layer.cornerRadius = 5
    }
    
    private func delegateTextFields() {
        
        titleTextField.delegate = self
        authorTextField.delegate = self
        yearTextField.delegate = self
        genreTextField.delegate = self
    }
    
}
