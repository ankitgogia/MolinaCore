//
//  LinkableTextView.swift
//  MemberHIH
//
//  Created by Jeremy Moy on 2/10/17.
//  Copyright © 2017 Molina Healthcare, Inc. All rights reserved.
//
// **OwnerVC must be set by the controller that will present the Alert
//

import UIKit
import SafariServices

public protocol LinkableTextViewDelegate: class {
    func linkableTextView(textView: LinkableTextView, shouldCall phoneNumber: String?)
    func linkableTextView(textView: LinkableTextView, shouldOpen url: URL)
}

extension LinkableTextViewDelegate {
    func linkableTextView(textView: LinkableTextView, shouldCall phoneNumber: String?) {}
    func linkableTextView(textView: LinkableTextView, shouldOpen url: URL) {}
}

public class LinkableTextView: UITextView, UITextViewDelegate {
    
    public weak var linkableTextViewDelegate: LinkableTextViewDelegate?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.delegate = self
        self.dataDetectorTypes = [UIDataDetectorTypes.phoneNumber, UIDataDetectorTypes.link]
        self.contentInset = UIEdgeInsets(top: -4, left: -6, bottom: 0, right: 0)
    }
    
    public func textViewDidChangeSelection(_ textView: UITextView) {
        if !NSEqualRanges(textView.selectedRange, NSMakeRange(0, 0)) {
            textView.selectedRange = NSMakeRange(0, 0)
        }
    }

    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        if let delegate = linkableTextViewDelegate {
        
            if (URL.scheme == "tel") {
                
                let phoneNumber: String = URL.absoluteString.replacingOccurrences(of: "tel:", with: "").replacingOccurrences(of: "%20", with: " ")
                delegate.linkableTextView(textView: self, shouldCall: phoneNumber)
                
            } else if let delegate = linkableTextViewDelegate {
                delegate.linkableTextView(textView: self, shouldOpen: URL)
                
            }
            
            return false
            
        }
        return true
    }
}
