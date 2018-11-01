/*
 The MIT License (MIT)

 Copyright (c) 2018-present Badoo Trading Limited.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import UIKit

public struct VCSnapshotItem: Item {

    // MARK: - Instantiation

    public init(_ vcItem: ViewControllerItem, snapshot: Element.SnapshotTest) {
        self.vcItem = vcItem
        let vc = vcItem.viewController()
        let view: UIView = vc.view
        let elementTitle = String(describing: type(of: vc)) + "_" + vcItem.title
        self.elementsProvider = ElementProvider(element: Element(title: elementTitle, view: view, width: 375, height: 568, snapshot: snapshot))
    }

    // MARK: - Item

    public var title: String {
        return vcItem.title
    }

    public var subtitle: String? {
        return vcItem.subtitle
    }

    public let elementsProvider: ElementsProviding?
    public let vcItem: ViewControllerItem

    public func viewController() -> UIViewController {
        return vcItem.viewController()
    }
    
    fileprivate struct ElementProvider: ElementsProviding {
        
        var testCaseName: String {
            return element.title
        }
        
        fileprivate let element: Element
        func elements() -> [Element] {
            return [element]
        }
        
    }
}
