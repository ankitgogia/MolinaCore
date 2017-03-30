//
//  USState.swift
//  MemberHIH
//
//  Created by Jaren Hamblin on 12/28/16.
//  Copyright © 2016 Molina Healthcare Inc. All rights reserved.
//

import Foundation

public enum USState: String {
    
    case ak, al, ar, az, ca, co, ct, dc, de, fl, ga, hi, ia, id, il, `in`, ks, ky, la, ma, md, me, mi, mn, mo, ms, mt, nc, nd, ne, nh, nj, nm, nv, ny, oh, ok, or, pa, ri, sc, sd, tn, tx, ut, va, vt, wa, wi, wv, wy, pr
    
    public static let dictionary: [String: String] = [
        "AL": "Alabama",
        "AK": "Alaska",
        "AS": "American Samoa",
        "AZ": "Arizona",
        "AR": "Arkansas",
        "CA": "California",
        "CO": "Colorado",
        "CT": "Connecticut",
        "DE": "Delaware",
        "DC": "District Of Columbia",
        "FM": "Federated States Of Micronesia",
        "FL": "Florida",
        "GA": "Georgia",
        "GU": "Guam",
        "HI": "Hawaii",
        "ID": "Idaho",
        "IL": "Illinois",
        "IN": "Indiana",
        "IA": "Iowa",
        "KS": "Kansas",
        "KY": "Kentucky",
        "LA": "Louisiana",
        "ME": "Maine",
        "MH": "Marshall Islands",
        "MD": "Maryland",
        "MA": "Massachusetts",
        "MI": "Michigan",
        "MN": "Minnesota",
        "MS": "Mississippi",
        "MO": "Missouri",
        "MT": "Montana",
        "NE": "Nebraska",
        "NV": "Nevada",
        "NH": "New Hampshire",
        "NJ": "New Jersey",
        "NM": "New Mexico",
        "NY": "New York",
        "NC": "North Carolina",
        "ND": "North Dakota",
        "MP": "Northern Mariana Islands",
        "OH": "Ohio",
        "OK": "Oklahoma",
        "OR": "Oregon",
        "PW": "Palau",
        "PA": "Pennsylvania",
        "PR": "Puerto Rico",
        "RI": "Rhode Island",
        "SC": "South Carolina",
        "SD": "South Dakota",
        "TN": "Tennessee",
        "TX": "Texas",
        "UT": "Utah",
        "VT": "Vermont",
        "VI": "Virgin Islands",
        "VA": "Virginia",
        "WA": "Washington",
        "WV": "West Virginia",
        "WI": "Wisconsin",
        "WY": "Wyoming"
    ]
    
    public init?(code: String?) {
        guard let code = code?.lowercased() else { return nil }
        guard let state = USState(rawValue: code) else { return nil }
        self = state
    }
    
    /// Full Name
    public var name: String { return USState.dictionary[self.rawValue.uppercased()] ?? "" }
    
    /// 2 letter code
    public var code: String { return self.rawValue.uppercased() }
    
    /// Array of all states and codes as tuples sorted
    public static var array: [(key: String, value: String)] { return USState.dictionary.sorted { $0.0 < $1.0 } }
    
    /// Array of only codes sorted
    public static var codesArray: [String] { return USState.dictionary.map{$0.0}.sorted{$0 < $1} }
    
    /// Array of only names sorted
    public static var namesArray: [String] { return USState.dictionary.map{$0.1}.sorted{$0 < $1} }
    
}
