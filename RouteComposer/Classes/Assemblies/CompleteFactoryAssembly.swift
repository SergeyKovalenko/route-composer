//
// Created by Eugene Kazaev on 16/03/2018.
//

import Foundation
import UIKit

/// Builds a `ContainerFactory` fulfilled with the children `UIViewController` factories.
///
/// ```swift
/// let rootFactory = CompleteFactoryAssembly(factory: TabBarFactory())
///         .with(XibFactory<HomeViewController, Any?>, using: TabBarControllerFactory.add())
///         .with(XibFactory<AccountViewController, Any?>, using: TabBarControllerFactory.add())
///         .assemble()
/// ```
/// *NB: Order matters here*
public final class CompleteFactoryAssembly<FC: ContainerFactory> {

    private struct AddAction<C: ContainerFactory>: ContainerAction {

        func perform(with viewController: UIViewController, on existingController: C.ViewController, animated: Bool, completion: @escaping (ActionResult) -> Void) {
            assertionFailure("Should never be called")
        }

        func perform(embedding viewController: UIViewController, in childViewControllers: inout [UIViewController]) {
            childViewControllers.append(viewController)
        }

    }

    private var factory: FC

    private var childFactories: [DelayedIntegrationFactory<FC.Context>] = []

    /// Constructor
    ///
    /// - Parameters:
    ///   - factory: The `ContainerFactory` instance.
    public init(factory: FC) {
        self.factory = factory
    }

    /// Adds a `Factory` that is going to be used as a child
    ///
    /// - Parameters:
    ///   - childFactory: The instance of `Factory`.
    ///   - action: The instance of `Factory` to be used to integrate the view controller produced by the factory.
    public func with<CFC: Factory, A: ContainerAction>(_ childFactory: CFC, using action: A) -> Self
            where
            CFC.Context == FC.Context, A.ViewController == FC.ViewController {
        guard let factoryBox = FactoryBox(childFactory, action: ContainerActionBox(action)) else {
            return self
        }
        childFactories.append(DelayedIntegrationFactory<CFC.Context>(factoryBox))
        return self
    }

    /// Adds a `ContainerFactory` that is going to be used as a child
    ///
    /// - Parameters:
    ///   - childFactory: The instance of `ContainerFactory`.
    ///   - action: The instance of `ContainerFactory` to be used to integrate the view controller produced by the factory.
    public func with<CFC: ContainerFactory, A: ContainerAction>(_ childContainer: CFC, using action: A) -> Self
            where
            CFC.Context == FC.Context, A.ViewController == FC.ViewController {
        guard let factoryBox = ContainerFactoryBox(childContainer, action: ContainerActionBox(action)) else {
            return self
        }

        childFactories.append(DelayedIntegrationFactory<CFC.Context>(factoryBox))
        return self
    }

    /// Adds a `Factory` as the last view controller in the stack.
    ///
    /// - Parameters:
    ///   - childFactory: The instance of `Factory`.
    public func with<CFC: Factory>(_ childFactory: CFC) -> Self where CFC.Context == FC.Context {
        guard let factoryBox = FactoryBox(childFactory, action: ContainerActionBox(AddAction<FC>())) else {
            return self
        }
        childFactories.append(DelayedIntegrationFactory<CFC.Context>(factoryBox))
        return self
    }

    /// Adds a `ContainerFactory` as the last view controller in the stack.
    ///
    /// - Parameters:
    ///   - childFactory: The instance of `ContainerFactory`.
    public func with<CFC: ContainerFactory>(_ childContainer: CFC) -> Self where CFC.Context == FC.Context {
        guard let factoryBox = ContainerFactoryBox(childContainer, action: ContainerActionBox(AddAction<FC>())) else {
            return self
        }

        childFactories.append(DelayedIntegrationFactory<CFC.Context>(factoryBox))
        return self
    }

    /// Assembles all the children factories provided and returns a `ContainerFactory` instance.
    ///
    /// - Returns: The `CompleteFactory` with child factories provided.
    public func assemble() -> CompleteFactory<FC> {
        let completeFactory = CompleteFactory(factory: factory, childFactories: childFactories)
        return completeFactory
    }

}
