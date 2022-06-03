//
//  UIView+Extension.swift
//  SeriesApp
//
//  Created by Yuri Chaves on 01/06/22.
//

import Foundation
import UIKit
extension UIView {
    func addViewCodeSubviews(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
}

public extension UIView {

    // MARK: - TopAnchor
    @discardableResult
    func topAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = topAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult
    func topAnchor(greaterThan anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult
    func topAnchor(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = topAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    // MARK: - BottomAnchor

    @discardableResult
    func bottomAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = bottomAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult
    func bottomAnchor(greaterThan anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult
    func bottomAnchor(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    // MARK: - LeadingAnchor

    @discardableResult
    func leadingAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = leadingAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    // MARK: - TrailingAnchor

    @discardableResult
    func trailingAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = trailingAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult
    func trailingAnchor(lessThanOrEqualTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = trailingAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    // MARK: - HeightAnchor

    @discardableResult
    func heightAnchor(equalTo height: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = heightAnchor.constraint(equalToConstant: height)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult
    func heightAnchor(greaterThanOrEqualToConstant height: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = heightAnchor.constraint(greaterThanOrEqualToConstant: height)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult
    func heightAnchor(greaterThanOrEqualTo nsLayoutDimension: NSLayoutDimension, priority: UILayoutPriority = UILayoutPriority.required, multiplier: CGFloat = 1) -> Self {
        let constraint = heightAnchor.constraint(greaterThanOrEqualTo: nsLayoutDimension, multiplier: multiplier)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult
    func heightAnchor(equalTo nsLayoutDimension: NSLayoutDimension, priority: UILayoutPriority = UILayoutPriority.required, multiplier: CGFloat = 1) -> Self {
        let constraint = heightAnchor.constraint(equalTo: nsLayoutDimension, multiplier: multiplier)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult
    func heightAnchor(lessThanOrEqualToConstant height: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = heightAnchor.constraint(lessThanOrEqualToConstant: height)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult
    func heightAnchor(lessThanOrEqualTo nsLayoutDimension: NSLayoutDimension, priority: UILayoutPriority = UILayoutPriority.required, multiplier: CGFloat = 1) -> Self {
        let constraint = heightAnchor.constraint(lessThanOrEqualTo: nsLayoutDimension, multiplier: multiplier)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    // MARK: - WidthAnchor

    @discardableResult
    func widthAnchor(equalTo width: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = widthAnchor.constraint(equalToConstant: width)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult
    func widthAnchor(equalTo nsLayoutDimension: NSLayoutDimension, priority: UILayoutPriority = UILayoutPriority.required, multiplier: CGFloat = 1) -> Self {
        let constraint = widthAnchor.constraint(equalTo: nsLayoutDimension, multiplier: multiplier)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult
    func widthAnchor(greaterThanOrEqualToConstant width: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = widthAnchor.constraint(greaterThanOrEqualToConstant: width)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult
    func widthAnchor(lessThanOrEqualToConstant width: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = widthAnchor.constraint(lessThanOrEqualToConstant: width)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    // MARK: - CenterAnchor

    @discardableResult
    func centerXAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = centerXAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult
    func centerYAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = centerYAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }
}
