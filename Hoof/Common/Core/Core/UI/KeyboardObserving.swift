//
//  KeyboardObserving.swift
//  Core
//
//  Created by Sameh Mabrouk on 14/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

///Conform to KeyboardObserving to observe UIKeyboard events.
public protocol KeyboardObserving: AnyObject {
    func keyboardHeight() -> Observable<CGFloat>

    /// Call this method to unregister for Keyboard Notifications
    func unregisterFromKeyboardEvents()
}

public extension KeyboardObserving {
    
    func keyboardHeight() -> Observable<CGFloat> {
        return Observable
            .from([
                NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
                    .map { notification -> CGFloat in
                        (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
                },
                NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
                    .map { _ -> CGFloat in
                        0
                }
            ]).merge()
    }
    
    func unregisterFromKeyboardEvents() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
