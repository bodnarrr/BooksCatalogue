//
//  MainVC.swift
//  Catalogue
//
//  Created by Andriy BODNAR on 5/2/18.
//  Copyright © 2018 Andriy BODNAR. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var mainSearchBar: UISearchBar!
    @IBOutlet weak var mainNavigationItem: UINavigationItem!
    @IBOutlet weak var mainSegmentedControl: UISegmentedControl!
    
    var books : [Book] = []
    var filteredBooks : [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegating controllers to main view
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainSearchBar.delegate = self
        
        //init search bar style
        mainSearchBar.barTintColor = UIColor(red: 110/255, green: 217/255, blue: 135/255, alpha: 1)
        mainSearchBar.layer.backgroundColor = UIColor(red: 110/255, green: 217/255, blue: 135/255, alpha: 1).cgColor
        mainSearchBar.layer.borderWidth = 1
        mainSearchBar.layer.borderColor = UIColor(red: 110/255, green: 217/255, blue: 135/255, alpha: 1).cgColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        //init data
        books = initBooks()
        filteredBooks = books
        
        //init segment control style
        let font = UIFont(name: "Helvetica Neue", size: UIFont.systemFontSize)!
        mainSegmentedControl.setTitleTextAttributes([NSAttributedStringKey.font: font],
                                                for: .normal)
        mainSegmentedControl.tintColor = UIColor(red: 110/255, green: 217/255, blue: 135/255, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        super.viewWillAppear(true)
        
        filterBySegmentControl()
        mainTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let book = filteredBooks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell") as! BookCell
        cell.setBook(book : book)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            filteredBooks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        books = filteredBooks
        mainTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "segueMainToNewInfo" {

            if let indexPath = mainTableView.indexPathForSelectedRow {

                let selectedRow = indexPath.row
                let detailVC = segue.destination as! BookInfoScrollVC
                detailVC.currentBook = self.filteredBooks[selectedRow]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        mainSearchBar.resignFirstResponder()
        performSegue(withIdentifier: "segueMainToNewInfo", sender: filteredBooks[indexPath.row])
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            
            filteredBooks = books
            mainTableView.reloadData()
            return
        }
        filteredBooks = books.filter({book -> Bool in
            book.title.lowercased().contains(searchText.lowercased()) ||
            book.author.lowercased().contains(searchText.lowercased())
            
        })
        mainTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.mainSearchBar.endEditing(true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        self.mainSearchBar.endEditing(true)
    }
    
    private func initBooks() -> [Book] {
        
        var initialArray : [Book] = []
        
        initialArray.append(Book(cover: #imageLiteral(resourceName: "Abitbol - The Power Of The Voice"), title: "The Power Of The Voice", author: "Jean Abitbol", year : "2017", genre: "Health", alreadyRead : true))
        initialArray.append(Book(cover: #imageLiteral(resourceName: "Haruf - Our Souls At Night"), title: "Our Souls At Night", author: "Kent Haruf", year: "2016", genre: "Fiction", alreadyRead : true))
        initialArray.append(Book(cover: #imageLiteral(resourceName: "Isaacson - Steve Jobs"), title: "Steve Jobs", author: "Walter Isaacson", year: "2011", genre: "Biography", alreadyRead : false))
        initialArray.append(Book(cover: #imageLiteral(resourceName: "King - Dark Tower The Gunslinger"), title: "The Dark Tower: The Gunslinger", author: "Stephen King", year: "1982", genre: "Fiction", alreadyRead : true))
        initialArray.append(Book(cover: #imageLiteral(resourceName: "Saveliev - Statistics And The Cats"), title: "The Statistics And The Cats", author: "Vladimir Saveliev", year: "2018", genre: "Popular Science", alreadyRead : false))
        
        return initialArray
    }
    
    private func filterBySegmentControl() {
        
        let segIndex = mainSegmentedControl.selectedSegmentIndex
        if (segIndex == 0) {
            
            filteredBooks = books
        } else if (segIndex == 1) {
            
            filteredBooks = books.filter({book -> Bool in
                book.alreadyRead
            })
        } else {
            
            filteredBooks = books.filter({book -> Bool in
                !book.alreadyRead
            })
        }
    }
    
    @IBAction func mainSegmentedControlTapped(_ sender: Any) {
        
            filterBySegmentControl()
            mainTableView.reloadData()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "segueMainToAdd", sender: self)
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        
        performSegue(withIdentifier: "segueMainToAboutMe", sender: self)
    }

}
