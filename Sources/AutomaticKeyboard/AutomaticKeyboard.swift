//
//  AutomaticKeyboard.swift
//  AutomaticKeyboard
//
//  Created by David LINHARES on 24/10/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import Foundation
import UIKit

public class AutomaticKeyboard {

    public let view: UIView
    public let options: Options

    public var isVisible: Bool {
        return self.keyboardHeight != 0
    }

    private var keyboardHeight: CGFloat = 0
    private var autoCloseGestureRecognizer: UITapGestureRecognizer?

    public enum ViewMode {
        case resize
        case translate
        case insets
    }

    public struct Options {
        public let mode: ViewMode
        public let offset: CGFloat
        public let isRelative: Bool
        public let shouldAutoCloseOnTouchView: Bool

        public init(mode: ViewMode = .resize, offset: CGFloat = 0, isRelative: Bool = true, shouldAutoCloseOnTouchView: Bool = true) {
            self.mode = mode
            self.offset = offset
            self.isRelative = isRelative
            self.shouldAutoCloseOnTouchView = shouldAutoCloseOnTouchView
        }
    }

    public init(view: UIView, options: Options = Options()) {
        self.view = view
        self.options = options
        if options.shouldAutoCloseOnTouchView {
            let autoCloseGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(close))
            autoCloseGestureRecognizer.isEnabled = false
            view.addGestureRecognizer(autoCloseGestureRecognizer)
            self.autoCloseGestureRecognizer = autoCloseGestureRecognizer
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc public func close() {
        self.view.endEditing(true)
    }

    private func transform(duration: TimeInterval, keyboardHeight: CGFloat, animation: UIView.AnimationCurve) {
        guard self.keyboardHeight != keyboardHeight else {
            return
        }

        var delta: CGFloat = 0
        if self.keyboardHeight == 0 {
            delta += self.options.offset
        } else if keyboardHeight == 0 {
            delta -= self.options.offset
        }

        delta += self.options.isRelative ? keyboardHeight - self.keyboardHeight : 0

        UIView.beginAnimations("keyboard_transform", context: nil)
        UIView.setAnimationDuration(duration)
        UIView.setAnimationCurve(animation)

        switch self.options.mode {
        case .resize:
            self.view.frame.size.height -= delta
        case .translate:
            var frame = self.view.frame
            frame.origin.y -= delta
            self.view.frame = frame
        case .insets:
            if let scrollView = self.view as? UIScrollView {
                scrollView.contentInset.bottom += delta
            } else {
                self.view.layoutMargins.bottom += delta
            }
        }
        self.view.layoutIfNeeded()

        UIView.commitAnimations()

        self.keyboardHeight = keyboardHeight
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let window = self.view.window else {
            return
        }

        self.autoCloseGestureRecognizer?.isEnabled = true

        let endKeyboardFrame = window.convert(keyboardRect, to: self.view)

        var animation: UIView.AnimationCurve = .linear
        if let curveInfo = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int,
            let curve = UIView.AnimationCurve(rawValue: curveInfo) {
            animation = curve
        }

        self.transform(duration: userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.3, keyboardHeight: endKeyboardFrame.height, animation: animation)
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {
                return
        }

        self.autoCloseGestureRecognizer?.isEnabled = false

        var animation: UIView.AnimationCurve = .linear
        if let curveInfo = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int,
            let curve = UIView.AnimationCurve(rawValue: curveInfo) {
            animation = curve
        }

        self.transform(duration: userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.3, keyboardHeight: 0, animation: animation)
    }

}
