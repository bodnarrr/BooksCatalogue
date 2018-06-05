//
//  BookClass.swift
//  Catalogue
//
//  Created by Andriy BODNAR on 02.05.2018.
//  Copyright © 2018 Andriy BODNAR. All rights reserved.
//

import Foundation
import UIKit

class Book {
    
    var cover : UIImage
    var title : String
    var author : String
    var year : String
    var genre : String
    var notes : String
    var alreadyRead : Bool
    
    init(cover : UIImage, title : String, author : String, year : String, genre : String, alreadyRead : Bool) {
        
        self.cover = cover
        self.title = title
        self.author = author
        self.year = year
        self.genre = genre
        self.notes = ""
        self.alreadyRead = alreadyRead
        
    }
    
    init() {
        
        self.cover = UIImage(named: "no cover cropped")!
        self.title = "unknown"
        self.author = "unknown"
        self.year = "unknown"
        self.genre = "unknown"
        self.notes = ""
        self.alreadyRead = false
    }
}
