//
//  ViewModel.swift
//  MFallingWords
//
//  Created by Mani on 04/11/19.
//  Copyright © 2019 geekmk. All rights reserved.
//

import RxSwift
import RxCocoa


class ViewModel<V: ViewIO> {
    
    private(set) weak var viewIO: V?
    private var isSetup = false
    internal var disposeBag = DisposeBag()
    
    ///view model will subscribe to outputs of View and performs all its internal operations after attachView is called
    ///
    ///- Parameter viewIO: view  to attach
    final public func attachView(viewIO: V) -> Disposable {
        self.viewIO = viewIO
        self.disposeBag = DisposeBag() //cleanup all the previous subscriptions
        
        // lazy setup
        if !isSetup {
            isSetup = true
            setup()
        }
        
        return viewAttached()
        
    }
    
    /// Main entry point to View Model, manage subscriptions here
    internal func viewAttached() -> Disposable {
        fatalError("This function should be overriden")
    }
    
    /// Setups view model's initial state, start async operation, etc
    /// Called only once upon `attachView`
    internal func setup() {
        //no op as of nothing much to do here
    }
    
    /// Disposable builder
    internal func disposable(_ disposables: Disposable?...) -> Disposable {
        return Disposables.create(disposables.compactMap{ $0 })
    }
    
}

// Shortcut
public typealias Action = Driver<Void>
