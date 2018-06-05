//
//  BookInfoScrollVC.swift
//  Catalogue
//
//  Created by Andriy BODNAR on 5/3/18.
//  Copyright © 2018 Andriy BODNAR. All rights reserved.
//

import UIKit

class BookInfoScrollVC: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var bookCoverBackground: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var inScrollView: UIView!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet weak var alreadyReadLabel: UILabel!
    @IBOutlet weak var switcherView: UIView!
    
    var currentBook = Book()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        notesTextView.delegate = self
        
        //init styles
        bookCoverBackground.layer.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        coverImage.layer.backgroundColor = UIColor.white.cgColor
        inScrollView.layer.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1).cgColor
        notesTextView.layer.cornerRadius = 5
        saveButton.layer.cornerRadius = 5
        saveButton.backgroundColor = UIColor(red: 110/255, green: 217/255, blue: 135/255, alpha: 1)
        saveButton.isHidden = true
        switcher.onTintColor = UIColor(red: 110/255, green: 217/255, blue: 135/255, alpha: 1)
        
        //init content
        coverImage.image = currentBook.cover
        bookTitle.text = currentBook.title
        bookAuthor.text = currentBook.author
        if currentBook.notes != "" {
         
            notesTextView.text = currentBook.notes
        } else {
            
            notesTextView.text = "Add Notes..."
        }
        if currentBook.alreadyRead == true {
            
            switcher.isOn = true
        } else {
            
            switcher.isOn = false
        }
        switcherView.isHidden = false
        switcher.isEnabled = true
        alreadyReadLabel.isEnabled = true
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
      
        notesTextView.becomeFirstResponder()
        notesTextView.text = currentBook.notes
        
        //hide switcher and show bitton
        switcher.isHidden = true
        switcherView.isHidden = true
        alreadyReadLabel.isHidden = true
        switcher.isEnabled = false
        alreadyReadLabel.isEnabled = false
        saveButton.isHidden = false
        
        scrollView.setContentOffset(CGPoint(x: 0, y: 230), animated: false)
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        notesTextView.resignFirstResponder()
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        currentBook.notes = notesTextView.text
        
        //hide button and show switcher
        saveButton.isHidden = true
        switcher.isHidden = false
        switcher.isEnabled = true
        alreadyReadLabel.isEnabled = true
        alreadyReadLabel.isHidden = false
        switcherView.isHidden = false
        
        if notesTextView.text.isEmpty {
            
            notesTextView.text = "Add Notest..."
        }
    }
    
    @IBAction func switcherTapped(_ sender: UISwitch) {
        
        if sender.isOn == true {
            
            currentBook.alreadyRead = true
        } else {
            
            currentBook.alreadyRead = false
        }
    }
    
}
