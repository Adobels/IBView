//
//  InferredAttributesOwnerStrategy.swift
//
//
//  Created by Blazej SLEBODA on 29/09/2023.
//

import UIKit

public class InferredAttributesOwnerStrategy: UIViewDSLEngineConstraintsProtocol {
    
    // MARK: - Private Properties
    
    private var constraintsToApply: [(UIView, [NSLayoutConstraint])] = []
    
    
    // MARK: - UIViewDSLEngineConstraintsProtocol Methods
    
    public func rootViewIbSubviewsWillExecute() {
        if !constraintsToApply.isEmpty {
            fatalError("Attempted to begin subviews definition while constraintsToApply is not empty. This indicates that there may have been a previous incomplete or erroneous subviews definition process.")
        }
    }
    
    public func rootViewIbSubviewsDidExecute() {
        activateAutoLayout()
    }
    
    public func addConstraints(for owner: UIView, constraints: [NSLayoutConstraint]) {
        guard !constraints.isEmpty else { return }
        constraints.forEach {
            if !UIViewDSLHelper.involvesOwnerView(owner, in: $0) {
                fatalError("Added constraints do not involve the specified owner view. Please ensure that constraints are correctly defined for the owner view.")
            }
        }
        constraintsToApply.append((owner, constraints))
    }
    
    public func addRootViewConstraints(on rootView: UIView, constraints: [NSLayoutConstraint]) {
        guard !constraints.isEmpty else { return }
        constraintsToApply.append((rootView, constraints))
        activateAutoLayout()
    }
    
    // MARK: - Private Methods
    
    private func activateAutoLayout() {
        var allConstraints: [NSLayoutConstraint] = []
        constraintsToApply.forEach { owner, constraints in
            allConstraints.append(contentsOf: constraints)
            owner.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate(allConstraints)
        constraintsToApply.removeAll()
    }
}