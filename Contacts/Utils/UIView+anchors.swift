//
//  UIView+anchors.swift
//  Contacts
//
//  Created by Angel Avila on 12/19/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

extension UIView {
    
    static func anchorViews(views: [UIView], insideView containerView: UIView, containerYspacing: CGFloat, containerXspacing: CGFloat, interItemYspacing: CGFloat, shouldSetWidth: Bool = false) {
        
        for (i, view) in views.enumerated() {
            containerView.addSubview(view)
            
            if i == 0 {
                view.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: UIEdgeInsets.init(top: containerYspacing, left: containerXspacing, bottom: 0, right: containerXspacing))
            } else {
                view.anchor(top: views[i-1].bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: UIEdgeInsets.init(top: interItemYspacing, left: containerXspacing, bottom: 0, right: containerXspacing))
            }
            
            if shouldSetWidth {
                let width = containerView.bounds.width - containerXspacing * 2
                view.anchorSize(size: CGSize(width: width, height: 0))
            }
            
            if i == views.count - 1 {
                //                view.anchor(top: nil, leading: nil, bottom: containerView.bottomAnchor, trailing: nil, padding: UIEdgeInsetsMake(0, 0, containerYspacing, 0))
            }
        }
    }
    
    func fillSuperview() {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func anchorSize(size: CGSize) {
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func anchorCenterX(to view: UIView, constant: CGFloat = 0)  {
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
    }
    
    func anchorCenterY(to view: UIView, constant: CGFloat = 0)  {
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
    }
    
    func anchorCenter(to view: UIView) {
        anchorCenterX(to: view)
        anchorCenterY(to: view)
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        anchorSize(size: size)
    }
}
