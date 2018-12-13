//
//  ViewController.swift
//  AutomaticKeyboardSample-iOS
//
//  Created by Benoit BRIATTE on 23/12/2016.
//  Copyright © 2016 Digipolitan. All rights reserved.
//

import UIKit
import AutomaticKeyboard

class ViewController: UIViewController {

    @IBOutlet weak var keyboardView: UIView!
    @IBOutlet weak var textField: UITextField!

    @IBOutlet var offsetLabel: UILabel!
    @IBOutlet var resizeButton: UIButton!
    @IBOutlet var insetsButton: UIButton!
    @IBOutlet var translateButton: UIButton!

    public var keyboard: AutomaticKeyboard?

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.resetKeyboard(options: self.keyboardOptions())
    }

    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.keyboard = nil
    }

    private func resetKeyboard(options: AutomaticKeyboard.Options) {
        self.keyboard?.close()
        if let kbv = self.keyboardView {
            self.keyboard = AutomaticKeyboard(view: kbv, options: options)
        } else {
            self.keyboard = nil
        }
    }

    private func keyboardOptions() -> AutomaticKeyboard.Options {
        var mode = AutomaticKeyboard.ViewMode.resize
        if self.insetsButton.isSelected {
            mode = .insets
        } else if self.translateButton.isSelected {
            mode = .translate
        }
        var offset: CGFloat = 0
        if let offsetStr = self.offsetLabel.text,
            let offsetUnwrap = Float(offsetStr) {
            offset = CGFloat(offsetUnwrap)
        }
        return AutomaticKeyboard.Options(mode: mode, offset: offset)
    }

    @IBAction func touchMode(_ sender: UIButton) {
        self.resizeButton.isSelected = false
        self.insetsButton.isSelected = false
        self.translateButton.isSelected = false
        sender.isSelected = true
        self.resetKeyboard(options: self.keyboardOptions())
    }

    @IBAction func stepperDidfinish(_ sender: UIStepper) {
        self.resetKeyboard(options: self.keyboardOptions())
    }

    @IBAction func stepperUpdateOffset(_ sender: UIStepper) {
        if let isVisible = self.keyboard?.isVisible, isVisible == true {
            self.keyboard?.close()
        }
        self.offsetLabel.text = String(Int(sender.value))
    }
}

extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
