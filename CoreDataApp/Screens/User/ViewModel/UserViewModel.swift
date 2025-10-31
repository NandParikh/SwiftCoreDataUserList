//
//  UserViewModel.swift
//  CoreDataApp
//
//  Created by                     Nand Parikh on 14/08/25.
//

import Foundation

final class UserViewModel{
    private let manager = DatabaseManager()
    private(set) var users : [UserEntity] = []
    
    var onReload : (() -> Void)?
        
    func refresh(){
        users = manager.fetchUsers()
        
        // Notify view controller
        onReload?()
    }
    
    func numberOfRows() -> Int {
        return users.count
    }
    
    func user(at index: Int) -> UserEntity {
        return users[index]
    }
    
    func deleteUser(at index: Int){
        let userToDelete = users[index]
        manager.deleteUser(userEntity: userToDelete)        
        refresh()
    }
}
