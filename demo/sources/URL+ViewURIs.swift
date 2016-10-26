/*
 *  Copyright (c) 2016 Spotify AB.
 *
 *  Licensed to the Apache Software Foundation (ASF) under one
 *  or more contributor license agreements.  See the NOTICE file
 *  distributed with this work for additional information
 *  regarding copyright ownership.  The ASF licenses this file
 *  to you under the Apache License, Version 2.0 (the
 *  "License"); you may not use this file except in compliance
 *  with the License.  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing,
 *  software distributed under the License is distributed on an
 *  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *  KIND, either express or implied.  See the License for the
 *  specific language governing permissions and limitations
 *  under the License.
 */

import Foundation

extension URL {
    /// The view URI used for the "Root" feature
    static var rootViewURI: URL {
        return URL(viewURI: "root")
    }
    
    // The view URI used for the "GitHub search" feature
    static var gitHubSearchViewURI: URL {
        return URL(viewURI: "githubsearch")
    }
    
    /// The view URI used for the "Pretty pictures" feature
    static var prettyPicturesViewURI: URL {
        return URL(viewURI: "prettypictures")
    }
    
    /// The view URI used for the "Really long list" feature
    static var reallyLongListViewURI: URL {
        return URL(viewURI: "reallylonglist")
    }
    
    /// The view URI used for the "Todo list" feature
    static var todoListViewURI: URL {
        return URL(viewURI: "todoList")
    }
    
    /// The view URI used for the "Action Playground" feature
    static var acitonPlaygroundViewURI: URL {
        return URL(viewURI: "actionPlayground")
    }
}

private extension URL {
    init(viewURI: String) {
        self.init(string: "hub-demo:" + viewURI)!
    }
}
