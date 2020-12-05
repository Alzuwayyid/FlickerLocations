//
//  Constants.swift
//  FlickerLocationsTests
//
//  Created by Mohammed on 05/12/2020.
//

import Foundation


struct Constants{
    var proccessURLTest = URL(string: "https://live.staticflickr.com/65535/50628317031_cb0d87610f.jpg")
    

}


protocol ErrorProtocol: LocalizedError {

    var title: String? { get }
    var code: Int { get }
}

struct CustomError: ErrorProtocol {

    var title: String?
    var code: Int
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }

    private var _description: String

    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
    }
}
