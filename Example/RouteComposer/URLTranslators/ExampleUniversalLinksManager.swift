//
// Created by Eugene Kazaev on 19/01/2018.
// Copyright (c) 2018 HBC Digital. All rights reserved.
//

import Foundation
import UIKit

struct ExampleUniversalLinksManager {

    private static var translators: [ExampleURLTranslator] = []

    static func register(translator: ExampleURLTranslator) {
        translators.append(translator)
    }

    static func destination(for url: URL) -> ExampleDestination<UIViewController, Any?>? {
        guard let translator = translators.first(where: { $0.destination(from: url) != nil }) else {
            return nil
        }

        return translator.destination(from: url)
    }

}

extension ExampleUniversalLinksManager {

    static func configure() {
        ExampleUniversalLinksManager.register(translator: ColorURLTranslator())
        ExampleUniversalLinksManager.register(translator: ProductURLTranslator())
        ExampleUniversalLinksManager.register(translator: CityURLTranslator())
    }

}
