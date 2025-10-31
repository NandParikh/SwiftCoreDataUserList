//
//  UserListVC.swift
//  CoreDataApp
//
//  Created by                     Nand Parikh on 14/08/25.
//

import UIKit

class UserVC: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var tblUser: UITableView!
    @IBOutlet weak var lblNoUsersFound: UILabel!
    
    private let viewModel = UserViewModel()
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
        
        viewModel.onReload = { [weak self] in
            
            if self?.viewModel.numberOfRows() == 0 {
                self?.lblNoUsersFound.isHidden = false
            } else {
                self?.lblNoUsersFound.isHidden = true
            }
            self?.tblUser.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.refresh()
    }
    
    // MARK: - Configure View
    func configureView(){
        self.title = "User"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tblUser.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
    }
    
    @IBAction func btnAddUserClicked(_ sender: UIBarButtonItem) {
        let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
}
// MARK: - TableView Delegate and Data Source Methods
extension UserVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell else {
            return UITableViewCell()
        }
        
        let user = viewModel.user(at: indexPath.row)
        cell.user = user
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [self] _, _, _ in
            viewModel.deleteUser(at: indexPath.row)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { _, _, _ in
            let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
            registerVC.viewModel.user = self.viewModel.user(at: indexPath.row)
            self.navigationController?.pushViewController(registerVC, animated: true)
        }
        editAction.backgroundColor = .systemBlue
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return config
    }
    
}
