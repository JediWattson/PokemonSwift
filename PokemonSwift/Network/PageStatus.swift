//
//  PageStatus.swift
//  PokemonSwift
//
//  Created by Field Employee on 10/5/20.
//  Copyright © 2020 JediWattson. All rights reserved.
//

import Foundation

enum PageStatus {
case ready (nextPage: Int)
case loading (page: Int)
case done
}

enum MyError: Error {
case limitError
case httpError
}
