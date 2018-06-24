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

public struct Element {

    let title: String
    let view: UIView
    let testState: SnapshotTestState
    let backgroundColor: UIColor
    let width: Dimension
    let height: Dimension

    public init(title: String,
                view: UIView,
                testState: SnapshotTestState,
                backgroundColor: UIColor = .clear,
                width: Dimension = .default,
                height: Dimension = .default) {
        self.title = title
        self.view = view
        self.testState = testState
        self.backgroundColor = backgroundColor
        self.width = width
        self.height = height
    }
}

extension Element {
    public enum Dimension: ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {
        case custom(CGFloat)
        case selfSizing
        case `default`

        public init(floatLiteral value: CGFloat.NativeType) {
            self = .custom(CGFloat(value))
        }

        public init(integerLiteral value: Int) {
            self.init(floatLiteral: CGFloat.NativeType(value))
        }
    }
}
