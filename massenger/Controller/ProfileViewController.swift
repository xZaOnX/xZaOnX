//
//  ProfileViewController.swift
//  massenger
//
//  Created by Ozan Öneyman on 22.07.2024.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let data = ["Log out"]
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    


}

extension ProfileViewController:UITableViewDelegate,UITableViewDataSource {
   

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let actionSheet = UIAlertController(title: "Warning",
                                      message: "Do you really want to log out",
                                      preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Log out",
                                      style: .destructive,
                                      handler: { [weak self] _ in
            guard let strongSelf = self else{
                return
            }
            
            do{
              try FirebaseAuth.Auth.auth().signOut()
                
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                strongSelf.present(nav , animated: true)
                
            }catch{
                print("failed to log out")
            }
                

        }))
        actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel,handler: nil))
        present(actionSheet,animated: true)
        
    
        
    }
}
