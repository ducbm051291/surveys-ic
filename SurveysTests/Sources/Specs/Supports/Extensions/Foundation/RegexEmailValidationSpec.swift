import Nimble
import Quick

@testable import Surveys

final class RegexEmailValidationSpec: QuickSpec {

    override func spec() {

        describe("an Email Validation Regex") {

            context("when email is valid") {

                let email: String = "duc@nimblehq.co"

                it("validation return true value") {
                    expect(email.validate(.email)) == true
                }
            }

            context("when email is invalid") {

                let email: String = "duc@nimblehq"

                it("validation return false value") {
                    expect(email.validate(.email)) == true
                }
            }
        }
    }
}
