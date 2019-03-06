//
//  MessageViewController.swift
//  TestTaskCrassula
//
//  Created by Oleg Soloviev on 05.03.2019.
//  Copyright © 2019 varton. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    weak var delegate: UserLocationViewController!
    
    @IBOutlet weak var messageField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageField.text = delegate.messageText.text
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messageField.contentInset = UIEdgeInsets.zero
        messageField.scrollIndicatorInsets = messageField.contentInset
        let selectedRange = messageField.selectedRange
        messageField.scrollRangeToVisible(selectedRange)
        if messageField.text.isEmpty {
            messageField.becomeFirstResponder()
        }
    }
    
    @IBAction func doneDescription(_ sender: UIBarButtonItem) {
        delegate.messageText.text = messageField.text
        messageField.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            messageField.contentInset = UIEdgeInsets.zero
        } else {
            messageField.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        messageField.scrollIndicatorInsets = messageField.contentInset
        
        let selectedRange = messageField.selectedRange
        messageField.scrollRangeToVisible(selectedRange)
    }
    
}
