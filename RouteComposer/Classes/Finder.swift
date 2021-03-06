//
// Created by Eugene Kazaev on 15/01/2018.
// Copyright © 2018 HBC Digital. All rights reserved.
//

import Foundation
import UIKit

/// An instance that extends the `Finder` protocol will be used by the `Router` to find out if some `UIViewController`
/// instance is integrated into the view controller stack
public protocol Finder {

    /// Type of `UIViewController` that `Finder` can find
    associatedtype ViewController: UIViewController

    /// Type of `Context` object that `Finder` can deal with
    associatedtype Context

    /// Returns the view controller instance if it is present in the stack.
    ///
    /// - Parameter context: The `Context` instance passed to the `Router`.
    /// - Returns: The `UIViewController` instance that the `Router` is looking for, nil otherwise.
    func findViewController(with context: Context) -> ViewController?

}
