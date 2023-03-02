//
//  Functions.swift
//  MyLocations
//
//  Created by Kyle Musto on 2/27/23.
//

import Foundation

func afterDelay(_ seconds: Double, run: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(
        deadline: .now() + seconds,
        execute: run)
}
