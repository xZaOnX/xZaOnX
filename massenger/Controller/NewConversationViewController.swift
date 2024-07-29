//
//  NewConversationViewController.swift
//  massenger
//
//  Created by Ozan Öneyman on 22.07.2024.
//

import UIKit
import JGProgressHUD





class NewConversationViewController: UIViewController {
    
     private let spinner = JGProgressHUD()
 
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "search for users..."
        return searchBar
    }()
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.isHidden = true
        table.register(UITableView.self,
                       gitforCellReuseIdentifier: "cell")
        return table
    }()
    
    
    private let noResultsLabel : UILabel = {
        let label = UILabel()
        label.text = " no result"
        label.isHidden = true
        label.textAlignment = .center
        label.textColor = .green
        label.font = .systemFont(ofSize: 21, weight: .medium)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(dismissSelf))
        
    }
    @objc private func dismissSelf(){
        dismiss(animated: true,completion: nil)
    }

    
    


}

extension NewConversationViewController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
