//
//  BookCell.swift
//  Catalogue
//
//  Created by Andriy BODNAR on 02.05.2018.
//  Copyright © 2018 Andriy BODNAR. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {

    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookYear: UILabel!
    @IBOutlet weak var bookGenre: UILabel!
    @IBOutlet weak var alreadyReadMark: UIImageView!
    
    func setBook (book : Book) {
        
        bookCover.image = book.cover
        bookTitle.text = book.title
        bookAuthor.text = book.author
        bookYear.text = book.year
        bookGenre.text = book.genre
        if book.alreadyRead == true {
            
            alreadyReadMark.isHidden = false
        } else {
            
            alreadyReadMark.isHidden = true
        }
    }
    
}
