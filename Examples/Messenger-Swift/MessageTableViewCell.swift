//
//  MessageTextView.swift
//  Messenger
//
//  Created by Intumit on 2016/12/23.
//  Copyright © 2016年 Slack Technologies, Inc. All rights reserved.
//

import Foundation
import UIKit

class MessageTableViewCell: UITableViewCell {
    
    static let kMessageTableViewCellMinimumHeight: CGFloat = 50.0
    static let kMessageTableViewCellAvatarHeight: CGFloat = 30.0
    
    static let messengerCellIdentifier = "MessengerCell"
    static let autoCompletionCellIdentifier = "AutoCompletionCell"
    
    var _labelView: UILabel?
    var labelView: UILabel {
        get {
            if _labelView == nil {
                _labelView = UILabel()
                _labelView?.translatesAutoresizingMaskIntoConstraints = false
                _labelView?.backgroundColor = UIColor.clear
                _labelView?.isUserInteractionEnabled = false
                _labelView?.numberOfLines = 0
                _labelView?.textColor = UIColor.black
                _labelView?.font = UIFont.boldSystemFont(ofSize: MessageTableViewCell.defaultFontSize())
            }
            
            return _labelView!
        }
    }
    var _textView: UITextView?
    var textView: UITextView? {
        get {
            if _textView == nil && isUser {
                _textView = UITextView()
                _textView?.translatesAutoresizingMaskIntoConstraints = false
                _textView?.backgroundColor = UIColor.lightGray
                _textView?.isUserInteractionEnabled = false
                _textView?.textColor = UIColor.black
                _textView?.font = UIFont.systemFont(ofSize: MessageTableViewCell.defaultFontSize())
                
                _textView?.layer.cornerRadius = 10
                _textView?.layer.masksToBounds = true
            }
            
            return _textView!
        }
    }
    var _webView: UIWebView?
    var webView: UIWebView? {
        get {
            return _webView
        }
        set {
            _webView = newValue
        }
    }
    var _thumbnailView: UIImageView?
    var thumbnailView: UIImageView {
        get {
            if _thumbnailView == nil {
                _thumbnailView = UIImageView()
                _thumbnailView?.translatesAutoresizingMaskIntoConstraints = false
                _thumbnailView?.isUserInteractionEnabled = false
                _thumbnailView?.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
                
                _thumbnailView?.layer.cornerRadius = MessageTableViewCell.kMessageTableViewCellAvatarHeight / 2.0
                _thumbnailView?.layer.masksToBounds = true
            }
            
            return _thumbnailView!
        }
    }
    
    var indexPath: IndexPath!
    var usedForMessage: Bool = false
    var isUser: Bool = false
    
    static func defaultFontSize() -> CGFloat {
        var pointSize: CGFloat = 16.0
        let contentSizeCategory = UIApplication.shared.preferredContentSizeCategory
        pointSize += SLKPointSizeDifferenceForCategory(contentSizeCategory.rawValue) // is this correct?
        
        return pointSize
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.backgroundColor = UIColor.clear
        
//        self.configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() {
        self.contentView.addSubview(self.thumbnailView)
        self.contentView.addSubview(self.labelView)
        self.contentView.addSubview(self.textView)
        
        let quarterScreenWidth = UIScreen.main.bounds.width / 4
        let views = ["thumbnailView": self.thumbnailView, "labelView": self.labelView, "textView": self.textView]
        let metrics = ["tumbSize": MessageTableViewCell.kMessageTableViewCellAvatarHeight, "padding": 15, "right": 10, "left": 5, "empty": quarterScreenWidth - MessageTableViewCell.kMessageTableViewCellAvatarHeight - 15, "quarter3": quarterScreenWidth * 3]
        let options = NSLayoutFormatOptions(rawValue: 0)
        
        if (!isUser) {
            self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-left-[thumbnailView(tumbSize)]-right-[labelView(>=0)]-empty-|", options: options, metrics: metrics, views: views))
            self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-left-[thumbnailView(tumbSize)]-right-[textView(>=0,<=quarter3)]-empty-|", options: options, metrics: metrics, views: views))
        }
        else {
            self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-empty-[thumbnailView(tumbSize)]-right-[labelView(>=0)]-left-|", options: options, metrics: metrics, views: views))
            self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-empty-[thumbnailView(tumbSize)]-right-[textView(>=0,<=quarter3)]-left-|", options: options, metrics: metrics, views: views))
        }
        
        if self.reuseIdentifier == MessageTableViewCell.messengerCellIdentifier {
            self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-right-[labelView(20)]-left-[textView(>=0@999)]-left-|", options: options, metrics: metrics, views: views))
        }
        else {
            self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[labelView]|", options: options, metrics: metrics, views: views))
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
        let pointSize = MessageTableViewCell.defaultFontSize()
        
        self.labelView.font = UIFont.boldSystemFont(ofSize: pointSize)
        self.textView.font = UIFont.systemFont(ofSize: pointSize)
        
        self.labelView.text = ""
        self.textView.text = ""
        
    }
}
