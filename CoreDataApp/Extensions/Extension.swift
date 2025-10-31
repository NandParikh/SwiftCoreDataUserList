//
//  UIView+Extension.swift
//  SwiftBasics
//
//  Created by                     Nand Parikh on 13/08/25.
//

import UIKit

extension UIView {
    func applyCornerRadius(radius : CGFloat){
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

extension UIViewController{
    func openAlert(title : String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButtonAction = UIAlertAction(title: "OK", style: .default) { (_) in
            
        }
        alert.addAction(okButtonAction)
        
//        let cancelButtonAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
//            
//        }
//        
//        alert.addAction(cancelButtonAction)
        
        present(alert, animated: true)
    }
}

extension URL {
    static var documentDirectory : URL{
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
