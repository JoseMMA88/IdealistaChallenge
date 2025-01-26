//
//  BasePreseter.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 26/1/25.
//

import Foundation

public typealias Action = () -> Void

public class BasePresenter {
    
    public func viewWillAppear() {}
    
    public func viewDidLoad() {}
    
    public func viewDidAppear() {}
    
    public func viewDidDisappear() {}
    
}

public protocol BasePresenterDelegate: AnyObject {
    
}
