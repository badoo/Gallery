//
// The MIT License (MIT)
//
// Copyright (c) 2015-present Badoo Trading Limited.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

public func cartProduct<A, B>(
    of possibleValues: ([A], [B])
) -> [(A, B)] {
    let (a, b) = possibleValues
    return cartProduct(of: (a, b, [()]))
        .map { a, b, _ in (a, b) }
}

public func cartProduct<A, B, C>(
    of possibleValues: ([A], [B], [C])
) -> [(A, B, C)] {
    let (a, b, c) = possibleValues
    return cartProduct(of: (a, b, c, [()]))
        .map { a, b, c, _ in (a, b, c) }
}

public func cartProduct<A, B, C, D>(
    of possibleValues: ([A], [B], [C], [D])
) -> [(A, B, C, D)] {
    let (a, b, c, d) = possibleValues
    return cartProduct(of: (a, b, c, d, [()]))
        .map { a, b, c, d, _ in (a, b, c, d) }
}

public func cartProduct<A, B, C, D, E>(
    of possibleValues: ([A], [B], [C], [D], [E])
) -> [(A, B, C, D, E)] {
    let (a, b, c, d, e) = possibleValues
    return cartProduct(of: (a, b, c, d, e, [()]))
        .map { a, b, c, d, e, _ in (a, b, c, d, e) }
}

public func cartProduct<A, B, C, D, E, F>(
    of possibleValues: ([A], [B], [C], [D], [E], [F])
) -> [(A, B, C, D, E, F)] {
    let (a, b, c, d, e, f) = possibleValues
    return cartProduct(of: (a, b, c, d, e, f, [()]))
        .map { a, b, c, d, e, f, _ in (a, b, c, d, e, f) }
}

public func cartProduct<A, B, C, D, E, F, G>(
    of possibleValues: ([A], [B], [C], [D], [E], [F], [G])
) -> [(A, B, C, D, E, F, G)] {
    let (a, b, c, d, e, f, g) = possibleValues
    return cartProduct(of: (a, b, c, d, e, f, g, [()]))
        .map { a, b, c, d, e, f, g, _ in (a, b, c, d, e, f, g) }
}

public func cartProduct<A, B, C, D, E, F, G, H>(
    of possibleValues: ([A], [B], [C], [D], [E], [F], [G], [H])
) -> [(A, B, C, D, E, F, G, H)] {
    let (a, b, c, d, e, f, g, h) = possibleValues
    return cartProduct(of: (a, b, c, d, e, f, g, h, [()]))
        .map { a, b, c, d, e, f, g, h, _ in (a, b, c, d, e, f, g, h) }
}

public func cartProduct<A, B, C, D, E, F, G, H, I>(
    of possibleValues: ([A], [B], [C], [D], [E], [F], [G], [H], [I])
) -> [(A, B, C, D, E, F, G, H, I)] {
    var result: [(A, B, C, D, E, F, G, H, I)] = []
    let (`as`, bs, cs, ds, es, fs, gs, hs, `is`) = possibleValues
    let capacity = `as`.count
        * bs.count
        * cs.count
        * ds.count
        * es.count
        * fs.count
        * gs.count
        * hs.count
        * `is`.count
    assert(capacity > 0)
    result.reserveCapacity(capacity)
    for a in `as` {
        for b in bs {
            for c in cs {
                for d in ds {
                    for e in es {
                        for f in fs {
                            for g in gs {
                                for h in hs {
                                    for i in `is` {
                                        result.append((a, b, c, d, e, f, g, h, i))
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return result
}
