//
//  UITextField+.swift
//  NewsApp-main
//
//  Created by Rajesh Gunasekar on 08/04/25.
//

import UIKit
import Combine

extension UITextField {
    func setRightImage(with image: String, isPassword: Bool = false) {
        let containerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 40))
        let imageView: UIButton = UIButton(type: .custom)
        imageView.setImage(UIImage(systemName: image), for: .normal)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 15, y: 11, width: 25, height: 18)
        
        if isPassword {
            imageView.addTarget(self, action: #selector(onClickRightImage), for: .touchUpInside)
        } else {
            imageView.isUserInteractionEnabled = false
        }
        
        containerView.addSubview(imageView)
        self.rightView = containerView
        self.rightViewMode = .always
        self.tintColor = .gray
    }
    
    @objc private func onClickRightImage(_ sender: UIButton) {
        self.isSecureTextEntry.toggle()
        sender.alpha = self.isSecureTextEntry ? 1.0 : 0.5
    }
}
