//
//  VerticalStack.swift
//  UIViewKit
//
//  Created by Blazej SLEBODA on 11/02/2024.
//

import UIKit

public func VerticalStack(spacing: CGFloat? = nil, alignment: UIStackView.Alignment? = nil, distribution: UIStackView.Distribution? = nil) -> UIStackView {
    let stackView = UIStackView()
    stackView.axis = .vertical
    if let alignment {
        stackView.alignment = alignment
    }
    if let distribution {
        stackView.distribution = distribution
    }
    if let spacing {
        stackView.spacing = spacing
    }
    return stackView
}
