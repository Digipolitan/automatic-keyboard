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

    @IBOutlet var keyboardView: UIView?

    public var keyboardOptions = Keyboard.Options(mode: .insets)

    public var keyboard: Keyboard?

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let kv = self.keyboardView {
            self.keyboard = Keyboard(view: kv, options: self.keyboardOptions)
        }
    }

    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.keyboard = nil
    }
}
