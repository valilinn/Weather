//
//  ObservableObject.swift
//  Weather
//
//  Created by Валентина Лінчук on 22/10/2023.
//

import Foundation

final class ObservableObject<T> {
    
    var value: T? {
        didSet {
            notifyObservers()
        }
    }
    
    private var observers: [((T?) -> ())] = []
    
    init(_ value: T?) {
        self.value = value
    }
    
    func bind(_ observer: @escaping (T?) -> ()) {
        observers.append(observer)
    }
    
    private func notifyObservers() {
        for observer in observers {
            observer(value)
        }
    }
    
}

