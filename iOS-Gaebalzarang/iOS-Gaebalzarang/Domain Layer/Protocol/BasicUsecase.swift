//
//  BasicUsecase.swift
//  iOS-Gaebalzarang
//
//  Created by Zeto on 2022/11/16.
//

import RxSwift

protocol BasicUsecase {
    
    func execute(with disposeBag: DisposeBag)
}
