/*
 The MIT License (MIT)

 Copyright (c) 2015-present Badoo Trading Limited.

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

protocol ObserverProtocol: class {}

final class Observable<T> {
    private(set) var value: T
    private var observers: [ObserverWrapper<T>] = []

    init(_ value: T) {
        self.value = value
    }

    func setValue(_ value: T) {
        self.value = value
        for observer in observers {
            observer.closure(value)
        }
    }

    func observe(didChange: @escaping (T) -> Void) -> ObserverProtocol {
        let observer = ObserverWrapper(closure: didChange)
        observers.append(observer)
        return Disposable { [weak self] in
            guard let sself = self else { return }
            guard let index = sself.observers.index(of: observer) else { return }
            sself.observers.remove(at: index)
        }
    }
}

private final class ObserverWrapper<T>: Equatable {

    let closure: (T) -> Void

    init(closure: @escaping (T) -> Void) {
        self.closure = closure
    }

    static func == (lhs: ObserverWrapper<T>, rhs: ObserverWrapper<T>) -> Bool {
        return lhs === rhs
    }
}

private final class Disposable: ObserverProtocol {

    private let onDeinit: () -> Void

    init(onDeinit: @escaping () -> Void) {
        self.onDeinit = onDeinit
    }

    deinit {
        self.onDeinit()
    }
}
