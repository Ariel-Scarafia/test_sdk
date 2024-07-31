//
//  DIFramework.swift
//
//  Created by Ariel Scarafia on 21/04/2023.
//  Copyright © 2023 Applica. All rights reserved.
//

//TODO: Posible upgrades:
//We could have a list of "unowned" (or "weak") instances who are currently sharing a shared injected value.

import Foundation
import UIKit

public protocol InjectionKey {
    associatedtype Value
    
    static var factoryValue: Value { get }
    
    static var singletonValue: Value { get set }
}

class DIFramework {
    subscript<T>(_ keyPath: KeyPath<DIFramework, T>) -> T {
        get { self[keyPath: keyPath] }
    }
    
    func getInstance<K>(_ key: K.Type) -> K.Value where K: InjectionKey {
        return key.factoryValue
    }
}

class FractoryProperty: DIFramework {
    override func getInstance<K>(_ key: K.Type) -> K.Value where K: InjectionKey {
        return key.factoryValue
    }
}

class SingletonProperty: DIFramework {
    override func getInstance<K>(_ key: K.Type) -> K.Value where K: InjectionKey {
        return key.singletonValue
    }
}

class SharedProperty: DIFramework {
    static var injectionInstances: [String : Any] = [:]

    override func getInstance<K>(_ key: K.Type) -> K.Value where K : InjectionKey {
        print("*** Returning a shared Instance of \(key)")
        return self.sharedInstance(key: key)
    }
    
     //returns a sharedInstance. If no other instance exists, initializes the instance from factoryValue
    private func sharedInstance<K>(key: K.Type) -> K.Value where K : InjectionKey {
        print("*** SHARED instance requested")
        if let sharedInstance = Self.injectionInstances.first(where: {$0.key == String(describing: key.Value) })?.value as? K.Value {
            print("*** returning storedInstance!!!!")
            return sharedInstance
        } else {
            Self.injectionInstances.add([String(describing: key.Value) : key.factoryValue])
            print("*** returning a NEW instance of \(String(describing: key.Value)) *********")
            return Self.injectionInstances.first(where: {$0.key == String(describing: key.Value)})?.value as! K.Value
        }
    }
    
    static func deShareInstance(releasingHost: UIViewController) {
        print("*** \(releasingHost) will no longer need a shared instance")
        let sharedKeys = Self.injectionInstances.keys
        sharedKeys.forEach { key in
            if releasingHost.vcContainsInjectedType(key) { //this is the key that the View is releasing.
                print("*** releasing Host does contain \(key)")
                if !areThereMoreSharedInstancesOutsideOfHost(injectedPropertyDescription: key, releasingHostVC: type(of: releasingHost)) {
                    Self.injectionInstances.removeValue(forKey: key)
                    print("**** Shared instance of \(key) is no longer used, will release______")
                }
            }
        }
    }
    
    static private func areThereMoreSharedInstancesOutsideOfHost(injectedPropertyDescription: String, releasingHostVC: Any.Type) -> Bool {
        let appWindow = UIApplication.shared.windows.first?.rootViewController

        if let mainViewController = appWindow?.presentedViewController {
            if checkChildrenViewControllersRecursivelyExcludingHost(host: releasingHostVC, children: [mainViewController], injectedType: injectedPropertyDescription) {
                return true
            }
        }
        
        if let viewControllers = appWindow?.children, !viewControllers.isEmpty {
            if checkChildrenViewControllersRecursivelyExcludingHost(host: releasingHostVC, children: viewControllers, injectedType: injectedPropertyDescription) {
                return true
            }
        }
        
        return false
    }
    
    static private func checkChildrenViewControllersRecursivelyExcludingHost(host: Any.Type, children: [UIViewController], injectedType: String) -> Bool {
        for childViewController in children {
            guard type(of: childViewController) != host else { continue }

            if childViewController.vcContainsInjectedType(injectedType) {
                return true
            }
            
            if !childViewController.children.isEmpty {
                if checkChildrenViewControllersRecursivelyExcludingHost(host: host, children: childViewController.children, injectedType: injectedType) {
                    return true
                }
            }
        }
        return false
    }
}

@propertyWrapper
struct FactoryInstance<T> {
    private let keyPath: KeyPath<DIFramework, T>
    
    var wrappedValue: T {
        get {
            let factoryInstance = FractoryProperty()
            return factoryInstance[keyPath]
        }
    }
    
    init(_ key: KeyPath<DIFramework, T>) {
        self.keyPath = key
    }
}

@propertyWrapper
struct SingletonInstance<T> {
    private let keyPath: KeyPath<DIFramework, T>

    var wrappedValue: T {
        get {
            let singletonInstanceFramework = SingletonProperty()
            return singletonInstanceFramework[keyPath]
        }
    }
    
    init(_ keyPath: KeyPath<DIFramework, T>) {
        self.keyPath = keyPath
    }
}

@propertyWrapper
struct SharedInstance<T> {
    private let keyPath: KeyPath<DIFramework, T>
    
    var wrappedValue: T {
        get {
            let sharedInstanceFramework = SharedProperty()
            return sharedInstanceFramework[keyPath]
        }
    }
    
    init(_ key: KeyPath<DIFramework, T>) {
        self.keyPath = key
    }
}

//TODO: this might not be used
@propertyWrapper
struct DeShareInstances {
    //private let releasingHost: UIViewController
    
    var wrappedValue: Void {
        get {
            //return SharedProperty.deShareInstance(releasingHost: releasingHost)
        }
    }
    
    init(from releasingHost: UIViewController) {
        //self.releasingHost = releasingHost
        //TODO: This is the method to call when de-initializing
        SharedProperty.deShareInstance(releasingHost: releasingHost)
    }
}
