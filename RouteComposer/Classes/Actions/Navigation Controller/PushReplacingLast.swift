//
// Created by Eugene Kazaev on 15/01/2018.
// Copyright (c) 2018 HBC Tech. All rights reserved.
//

import UIKit

/// Pushes view controller into the `UINavigationController`'s child stack
public extension NavigationControllerFactory {

    /// Pushes view controller into the `UINavigationController`'s child stack
    public class PushReplacingLast: NavigationControllerAction {

        /// Constructor
        public init() {
        }

        public func perform(embedding viewController: UIViewController, in containerViewControllers: inout [UIViewController]) {
            containerViewControllers.removeLast()
            containerViewControllers.append(viewController)
        }

        public func perform(viewController: UIViewController, on existingController: UIViewController, animated: Bool, completion: @escaping(_: ActionResult) -> Void) {
            guard let navigationController = existingController as? UINavigationController ?? existingController.navigationController else {
                return completion(.failure("Could not find UINavigationController in \(existingController) to present view controller \(viewController)."))
            }
            var viewControllers = navigationController.viewControllers
            perform(embedding: viewController, in: &viewControllers)
            navigationController.setViewControllers(viewControllers, animated: animated)
            return completion(.continueRouting)
        }

    }

}