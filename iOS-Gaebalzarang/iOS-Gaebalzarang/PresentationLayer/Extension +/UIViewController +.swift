//
//  UIViewController +.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/22.
//

import UIKit

extension UIViewController {

    func setKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc
    func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height

        NotificationCenter.default.post(name: Notification.Name("KeyboardHeight"), object: self, userInfo: ["KeyboardHeight": keyboardHeight])
    }

    @objc
    func keyboardWillHide(notification: NSNotification) {
        guard self.view.window?.frame.origin.y != 0 else { return }

        UIView.animate(withDuration: 1.0) {
            self.view.window?.frame.origin.y = 0
        }
    }

    func setViewBound(dueTo keyboard: CGFloat, with view: UIView) {
        guard view.isFirstResponder else { return }

        let distanceFromBottom = self.view.frame.height - view.frame.maxY
        if distanceFromBottom <= keyboard + 90 {
            UIView.animate(withDuration: 0.3) {
                self.view.window?.frame.origin.y -= 90
            }
        }
    }
}
