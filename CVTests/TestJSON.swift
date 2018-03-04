//
//  TestJSON.swift
//  CVTests
//
//  Created by Paolo Carollo on 04/03/2018.
//  Copyright © 2018 Paolo Carollo. All rights reserved.
//

import Foundation

class TestJSON {
    
    static let validJSONWithThreeAreasOneSectionEachOneRowEach: String = """
    {
        "areas": [
            {
                "name": "me",
                "sections": [
                    {
                        "name": "Personal Details",
                        "rows": [
                            {
                                "type": "image",
                                "title": "",
                                "details": "profile.png"
                            }
                        ]
                    }
                ]
            },
            {
                "name": "experience",
                "sections": [
                    {
                        "name": "iOS Developer",
                        "rows": [
                            {
                                "type": "job",
                                "title": "company",
                                "details": "TheFakeCompany Limited"
                            }
                        ]
                    }
                ]
            },
            {
                "name": "settings",
                "sections": [
                    {
                        "name": "Info",
                        "rows": [
                            {
                                "type": "description",
                                "title": "app version",
                                "details": "$(app_version)"
                            }
                        ]
                    }
                ]
            }
        ]
    }
    """
 
    static let validJSONButWrong: String = """
    {
        books: [
            {
                "name": "Game of thrones"
            }
        ]
    }
    """
    
    static let invalidJSON: String = """
    cars: [
        "make" : "Ferrari",
        "make" : "Jaguar"
    ]
    """
    
}
