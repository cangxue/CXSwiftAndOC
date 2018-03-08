//
//  CXRxSwiftViewModel.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/3/7.
//  Copyright © 2018年 CX. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// Model
struct CXRxSwiftViewModel {
    
    let validateLabel: Driver<String>
    
    let loginResult: Driver<LoginResult>
    
    init(username: Driver<String>, password: Driver<String>, loginTap: Driver<Void>, model: ValidatedModelType) {
        
        validateLabel = Driver.combineLatest(username, password, resultSelector:{
            model.combine(model.validatedUsername($0), model.validatedPassword($1))
        })
        
        let usernameAndPassword = Driver.combineLatest(username, password) {
            ($0, $1)
        }
        
        loginResult = loginTap.withLatestFrom(usernameAndPassword).map({ (username, password) in
            model.login(username, password)
        })

        
    }
    
    
}
