//
//  Router+Reactive.swift
//  RGRoutable
//
//  Created by Ritesh Gupta on 28/11/17.
//  Copyright © 2017 Ritesh Gupta. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa
import Result

extension Router: ReactiveExtensionsProvider {}

public extension Reactive where Base: Router {
    
    public var onNext: BindingTarget<RoutablePayload> {
        return makeBindingTarget { (router, payload) in router.onNext?(payload) }
    }
    
    public var onComplete: BindingTarget<RoutablePayload> {
        return makeBindingTarget { (router, payload) in router.onComplete(payload) }
    }
    
    public var onReturn: BindingTarget<RoutablePayload> {
        return makeBindingTarget { (router, payload) in router.onReturn?(payload) }
    }
}

// Router extension to provide various observing capabilities
public extension Reactive where Base: Router {
    
    public var onNextSignal: Signal<RoutablePayload, NoError> {
        return Signal { observer, _ in
            base.onNext = { observer.send(value: $0) }
        }
    }
    
    public var onCompleteSignal: Signal<RoutablePayload, NoError> {
        return Signal { observer, _ in
            base.onComplete = { observer.send(value: $0) }
        }
    }
    
    public var onReturnSignal: Signal<RoutablePayload, NoError> {
        return Signal { observer, _ in
            base.onReturn = { observer.send(value: $0) }
        }
    }
}
