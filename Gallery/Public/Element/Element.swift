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
    
    let backgroundColor: UIColor
    let width: Width
    let height: CGFloat?
    let snapshot: SnapshotTest
    // Default initializer
    public init(title: String,
                view: UIView,
                backgroundColor: UIColor = .clear,
                width: Width = .default,
                height: CGFloat? = nil,
                snapshot: SnapshotTest) {
        self.title = title
        self.view = view
        self.backgroundColor = backgroundColor
        self.width = width
        self.height = height
        self.snapshot = snapshot
    }
    // Initialized for gradual adoption of new initializer
    public init(title: String,
                view: UIView,
                backgroundColor: UIColor = .clear,
                testState: SnapshotTestState,
                width: Width = .default,
                height: CGFloat? = nil) {
        self.init(title: title, view: view, backgroundColor: backgroundColor, width: width, height: height, snapshot: .init(state: testState))
    }
    
    public struct SnapshotTest {
        let state: SnapshotTestState
        let containerType: UIView.Type
        
        public init(state: SnapshotTestState, containerType: UIView.Type = UIView.self) {
            self.state = state
            self.containerType = containerType
        }
    }
}

extension Element {
    public enum Width: ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {
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
