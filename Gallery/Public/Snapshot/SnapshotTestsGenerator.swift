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

public struct SnapshotTestsGenerator {

    // MARK: - Type declarations

    private typealias TestImplementation = @convention(block) (Any, Selector) -> Void

    // MARK: - Private properties

    private let type: SnapshotTestCase.Type
    private static let defaultWidth: CGFloat = 375

    // MARK: - Instantiation

    public init(type: SnapshotTestCase.Type) {
        self.type = type
    }

    // MARK: - Public API

    public func generateTests(forProviders providers: [ElementsProviding]) {
        for provider in providers {
            self.setup(provider: provider)
        }
    }

    // MARK: - Private methods

    private func setup(provider: ElementsProviding) {
        let testCaseName = provider.testCaseName.cString(using: .utf8)!
        let testCaseClass: AnyClass = objc_allocateClassPair(self.type, testCaseName, 0)!
        for element in provider.elements() where element.testState != .disabled {
            addTestMethod(forClass: testCaseClass, element: element)
        }
        objc_registerClassPair(testCaseClass)
    }

    private func addTestMethod(forClass class: AnyClass, element: Element) {
        let types = typeEncodingForTestMethod()
        let implementationBlock = makeTestImplementation(forElement: element)
        let implementation = imp_implementationWithBlock(implementationBlock)
        let selector = registeredSelector(forElement: element)
        class_addMethod(`class`, selector, implementation, types)
    }

    private func makeTestImplementation(forElement element: Element) -> TestImplementation {
        return { _self, _cmd in
            guard let testCase = _self as? SnapshotTestCase else { fatalError() }

            let recordMode: Bool
            switch element.testState {
            case .final:
                recordMode = false
            case .record:
                recordMode = true
            case .disabled:
                assertionFailure()
                return
            }

            testCase.recordMode = recordMode

            let container = UIView()
            let view = element.view
            view.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(view)

            switch element.width {
            case .custom(let width):
                view.widthAnchor.constraint(equalToConstant: width).isActive = true
            case .default:
                view.widthAnchor.constraint(equalToConstant: SnapshotTestsGenerator.defaultWidth).isActive = true
            case .selfSizing:
                break
            }

            switch element.height {
            case .custom(let height):
                view.heightAnchor.constraint(equalToConstant: height).isActive = true
            case .selfSizing, .default:
                break
            }

            view.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
            view.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true

            testCase.verify(view: view)
        }
    }

    private func typeEncodingForTestMethod() -> UnsafePointer<CChar> {
        @objc class TestCaseTemplate: NSObject {
            @objc func testMethodTemplate() {}
        }
        let selectorTemplate = #selector(TestCaseTemplate.testMethodTemplate)
        let method = class_getInstanceMethod(TestCaseTemplate.self, selectorTemplate)!
        return method_getTypeEncoding(method)!
    }

    private func registeredSelector(forElement element: Element) -> Selector {
        let name = "test_" + element.title.replacingOccurrences(of: " ", with: "_")
        return sel_registerName(name.cString(using: .utf8)!)
    }
}

extension SnapshotTestsGenerator {
    public func generateTests(forItemStore itemStore: ItemStore) {
        self.generateTests(forProviders: itemStore.allElementProviders)
    }
}
