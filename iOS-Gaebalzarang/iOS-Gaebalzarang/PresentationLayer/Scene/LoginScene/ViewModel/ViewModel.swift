//
//  ViewModelType.swift
//  iOS-Gaebalzarang
//
//  Created by Zeto on 2022/11/15.
//

import Foundation

protocol ViewModel {

    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
