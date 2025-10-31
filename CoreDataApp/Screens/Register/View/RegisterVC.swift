//
//  RegisterVC.swift
//  CoreDataApp
//
//  Created by                     Nand Parikh on 14/08/25.
//

import UIKit
import PhotosUI

class RegisterVC: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var imgUserPic: UIImageView!
    @IBOutlet weak var btnRegister: UIButton!
    
    private var imageSelectedByUser: Bool = false
    
    let viewModel : RegisterViewModel = RegisterViewModel()
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
        addGesture()
        configureUserData()
    }
    
    // MARK: - Configure View
    func configureView(){
        imgUserPic.applyCornerRadius(radius: imgUserPic.frame.width / 2)
        
        if let user : UserEntity = viewModel.user{
            self.title = "Update"
            
            txtFirstName.text = user.firstName
            txtLastName.text = user.lastName
            txtEmailAddress.text = user.email
            txtPassword.text = user.password
            
            let url = URL.documentDirectory.appendingPathComponent(user.imageName ?? "").appendingPathExtension("png")
            imgUserPic.image = UIImage(contentsOfFile: url.path(percentEncoded: true))
            imgUserPic.contentMode = .scaleAspectFill
            
        }else{
            self.title = "Register"
        }
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureUserData(){
        if let user : UserEntity = viewModel.user{
            btnRegister.setTitle("Update", for: .normal)
        }else{
            btnRegister.setTitle("Register", for: .normal)
        }
    }
    
    func addGesture(){
        let imgTap = UITapGestureRecognizer(target: self, action: #selector(openGallary))
        imgUserPic.addGestureRecognizer(imgTap)
        imgUserPic.isUserInteractionEnabled = true
    }
    
    @objc func openGallary(){
        
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        
        let pickerVC = PHPickerViewController(configuration: config)
        pickerVC.delegate = self
        self.present(pickerVC, animated: true)
    }
    
    // MARK: - IB-Action Methods
    @IBAction func btnRegisterClicked(_ sender: UIButton) {
        guard let firstName = txtFirstName.text, !firstName.isEmpty else { return openAlert(title: "CoreDataApp", message: "Please enter first name") }
        guard let lastName = txtLastName.text, !lastName.isEmpty else { return openAlert(title: "CoreDataApp", message: "Please enter last name") }
        guard let emali = txtEmailAddress.text, !emali.isEmpty else { return openAlert(title: "CoreDataApp", message: "Please enter email") }
        guard let password = txtPassword.text, !password.isEmpty else { return openAlert(title: "CoreDataApp", message: "Please enter password") }
        guard imageSelectedByUser else { return openAlert(title: "CoreDataApp", message: "Please choose your profile image.") }
        
        
        let dbManager: DatabaseManager = DatabaseManager()
        
        
        if let user : UserEntity = viewModel.user{
            // Here we will update the data in existing user entity. We will not change the image name so, we will use existing image name here.
            let existingUser = UserModel(firstName: firstName, lastName: lastName, email: emali, password: password, imageName: user.imageName ?? "")
            dbManager.updateUser(user: existingUser, userEntity: user)
            
            saveImageToDocumentDirector(imageName: existingUser.imageName)
        }else{
            
            let imageName = UUID().uuidString
            saveImageToDocumentDirector(imageName: imageName)
            
            // Here we will add new data to user entity
            let newUser = UserModel(firstName: firstName, lastName: lastName, email: emali, password: password, imageName: imageName)
            dbManager.addUser(user: newUser)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Save Image to Document Directory
    func saveImageToDocumentDirector(imageName : String){
        let fileUrl = URL.documentDirectory.appending(component: imageName).appendingPathExtension("png")
        
        if let data = imgUserPic.image?.pngData(){
            do {
                try data.write(to: fileUrl)
            }catch{
                print("Saving image to document directory error : \(error)")
            }
        }
    }
    
}

extension RegisterVC : PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        // Always dismiss picker first (handles cancel case)
        picker.dismiss(animated: true)
        
        guard !results.isEmpty else { return } // user canceled, nothing to do
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
                guard let self, let image = image as? UIImage else { return }
                DispatchQueue.main.async {
                    self.imgUserPic.image = image
                    self.imgUserPic.contentMode = .scaleAspectFill
                    self.imageSelectedByUser = true
                }
            }
        }
    }
}


