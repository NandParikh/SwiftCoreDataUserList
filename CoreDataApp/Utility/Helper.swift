//
//  Helper.swift
//  CoreDataApp
//
//  Created by                     Nand Parikh on 31/10/25.
//

import Foundation
import UIKit

@IBDesignable
class DesignableTextField: UITextField {

    @IBInspectable var cornerRadius: CGFloat = 8.0 {
        didSet { updateView() }
    }

    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet { updateView() }
    }

    @IBInspectable var borderColor: UIColor = .lightGray {
        didSet { updateView() }
    }

    @IBInspectable var padding: CGFloat = 10.0

    override func awakeFromNib() {
        super.awakeFromNib()
        updateView()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateView()
    }

    private func updateView() {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: padding, dy: 0)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: padding, dy: 0)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: padding, dy: 0)
    }
}

@IBDesignable
class DesignableButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 8.0 { didSet { updateView() } }
    @IBInspectable var borderWidth: CGFloat = 1.0 { didSet { updateView() } }
    @IBInspectable var borderColor: UIColor = .blue { didSet { updateView() } }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateView()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateView()
    }

    private func updateView() {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
}



