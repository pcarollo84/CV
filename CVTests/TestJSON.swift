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
                        "units": [
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
                        "units": [
                            {
                                "type": "job",
                                "title": "Company",
                                "details": "PocketSizeMedia Limited"
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
                        "units": [
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
    
}
