//
//  Response.swift
//  ResearchKit-PoC-2
//
//  Created by Jaren Hamblin on 7/22/16.
//  Copyright © 2016 Jaren Hamblin. All rights reserved.
//

public enum Response<T> {
    case success(T), error(String)
}
