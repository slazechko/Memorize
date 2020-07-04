//
//  Array+Only.swift
//  Memorize
//
//  Created by Sam Lazechko on 7/4/20.
//  Copyright © 2020 Sam Lazechko. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        //if the array only has one element, return it. Else, return nil.
        count == 1 ? first : nil
    }
}
