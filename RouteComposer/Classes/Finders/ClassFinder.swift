//
// Created by Eugene Kazaev on 15/01/2018.
// Copyright (c) 2018 HBC Tech. All rights reserved.
//

import Foundation
import UIKit

/// A default implementation of the view controllers finder that searches for a view controller by its name.
public struct ClassFinder<VC: UIViewController, C>: StackIteratingFinder {

    /// A `UIViewController` type associated with this `ClassFinder`
    public typealias ViewController = VC

    /// A context type associated with this `ClassFinder`
    public typealias Context = C

    /// A `StackIterator` is to be used by `ClassFinder`
    public let iterator: StackIterator

    /// Constructor
    ///
    /// Parameters
    ///   - options: A combination of the `SearchOptions`
    ///   - startingPoint: `DefaultStackIterator.StartingPoint` value
    public init(options: SearchOptions, startingPoint: DefaultStackIterator.StartingPoint = .topmost) {
        self.iterator = DefaultStackIterator(options: options, startingPoint: startingPoint)
    }

    /// Constructor
    ///
    /// - Parameter iterator: A `StackIterator` is to be used by `ClassFinder`
    public init(iterator: StackIterator = DefaultStackIterator()) {
        self.iterator = iterator
    }

    public func isTarget(_ viewController: ViewController, with context: Context) -> Bool {
        return true
    }

}
