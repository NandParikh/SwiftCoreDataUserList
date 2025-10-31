//
//  UserCell.swift
//  CoreDataApp
//
//  Created by                     Nand Parikh on 14/08/25.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    
    var user : UserEntity?{
        didSet {
            userConfiguration()
        }
    }
    
    func userConfiguration(){
        guard let user = user else { return }
        lblFirstName.text = user.firstName
        lblLastName.text = user.lastName
        
        let url = URL.documentDirectory.appendingPathComponent(user.imageName ?? "").appendingPathExtension("png")
        imgUser.image = UIImage(contentsOfFile: url.path(percentEncoded: true))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgUser.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgUser.applyCornerRadius(radius: imgUser.frame.width / 2)
    }
    
}
