// Copyright 2020-2021 Dave Verwer, Sven A. Schmidt, and other contributors.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation
import SQLKit

/// Filters by the number of stars the package has.
///
/// Examples:
/// ```
/// stars:5  - Exactly 5 stars
/// stars:>5 - Any number of stars more than 5
/// stars:<5 - Any number of stars less than 5
/// stars:!5 - Any number of stars except 5
/// ```
struct StarsSearchFilter: SearchFilter {
    static var key: String = "stars"
    
    var comparison: SearchFilterComparison
    var value: Int
    
    init(value: String, comparison: SearchFilterComparison) throws {
        guard let intValue = Int(value) else {
            throw SearchFilterError.invalidValueType
        }
        
        self.comparison = comparison
        self.value = intValue
    }
    
    func `where`(_ builder: SQLPredicateGroupBuilder) -> SQLPredicateGroupBuilder {
        builder.where(
            SQLIdentifier("stars"),
            comparison.binaryOperator(),
            value
        )
    }
    
    func createViewModel() -> SearchFilterViewModel {
        .init(
            key: "stars",
            comparison: comparison,
            value: NumberFormatter.starsFormatter.string(from: NSNumber(value: value)) ?? "\(value)"
        )
    }
}