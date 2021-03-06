//
//  CommentInputAccessoryView.swift
//  Instagram_Pro
//
//  Created by Srujan Valluri on 18/10/18.
//  Copyright © 2018 unimelb_daweixu. All rights reserved.
//

import UIKit

protocol CommentInputAccessoryViewDelegate {
    func didSubmit(for comment: String)
}

class CommentInputAccessoryView: UIView {
    
    var delegate: CommentInputAccessoryViewDelegate?
    
    func clearCommentTextField() {
        commentTextView.text = nil
        commentTextView.showPlaceholderLabel()
    }
    
    fileprivate let commentTextView: CommentInputTextView = {
        let tv = CommentInputTextView()
        //        tv.placeholder = "Enter Comment"
        tv.isScrollEnabled = false
        //        tv.backgroundColor = .red
        tv.font = UIFont.systemFont(ofSize: 18)
        return tv
    }()
    
    fileprivate let submitButton: UIButton = {
        let sb = UIButton(type: .system)
        sb.setTitle("Submit", for: .normal)
        sb.setTitleColor(.black, for: .normal)
        sb.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        sb.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        return sb
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 1
        autoresizingMask = .flexibleHeight
        
        backgroundColor = .white
        
        setupSubmitButton()
        
        setupCommentText()

        setupLineSeparatorView()
    }
    
    fileprivate func setupCommentText() {
        addSubview(commentTextView)
        // 3
        if #available(iOS 11.0, *) {
            commentTextView.quickSetAnchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: submitButton.leftAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 0, height: 0)
        } else {
            // Fallback on earlier versions
        }
    }

    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    fileprivate func setupLineSeparatorView() {
        let lineSeparatorView = UIView()
        lineSeparatorView.backgroundColor = UIColor.quickSetRGB(red: 230, green: 230, blue: 230)
        addSubview(lineSeparatorView)
        lineSeparatorView.quickSetAnchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    @objc func handleSubmit() {
        guard let commentText = commentTextView.text else { return }
        delegate?.didSubmit(for: commentText)
    }
    
    fileprivate func setupSubmitButton() {
        addSubview(submitButton)
        submitButton.quickSetAnchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 50, height: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
