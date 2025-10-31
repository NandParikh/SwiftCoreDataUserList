//
//  DatabaseManager.swift
//  CoreDataApp
//
//  Created by                     Nand Parikh on 14/08/25.
//

import Foundation
import CoreData
import UIKit

class DatabaseManager{
    
    // MARK: - NSManagedObject Context
    private var context : NSManagedObjectContext{
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    // MARK: - Add User
    func addUser(user : UserModel){
        let userEntity = UserEntity(context: context) // User create karta he
        addUpdateUser(userEntity: userEntity, user: user)
    }
    
    func updateUser(user: UserModel, userEntity: UserEntity) {
        addUpdateUser(userEntity: userEntity, user: user)
        // Database mai reflect karne ke liye - IMP
    }
    
    // MARK: - Add Update User
    private func addUpdateUser(userEntity : UserEntity, user : UserModel){
        userEntity.firstName = user.firstName
        userEntity.lastName = user.lastName
        userEntity.password = user.password
        userEntity.email = user.email
        userEntity.imageName = user.imageName
        saveContext()
    }
    
    // MARK: - Save Context
    func saveContext(){
        do {
            try context.save() // Most Important
        } catch {
            print("User saving error",error.localizedDescription)
        }
    }
    
    // MARK: - Fetch User
    func fetchUsers() -> [UserEntity]{
        var users : [UserEntity] = []
        do {
            users =  try context.fetch(UserEntity.fetchRequest())
        } catch  {
            print("Error in fetch user", error)
        }
        return users
    }
    
    // MARK: - Delete User
    func deleteUser(userEntity : UserEntity){
        context.delete(userEntity)
        saveContext() // Most Important
    }
}
