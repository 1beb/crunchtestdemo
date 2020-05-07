context("crunch_mean_by")
# This `with( crunch::temp.options()` bit is what tells httptest
# to not use the actual API, but use our mocks.
#
# In rcrunch, this is all wrapped in a function called `withMockCrunch()`
# that is defined in this file:
# https://github.com/Crunch-io/rcrunch/blob/master/inst/crunch-test.R
# and is called during tests because of this file:
# https://github.com/Crunch-io/rcrunch/blob/master/tests/testthat/setup.R
with(
    crunch::temp.options(
        crunch.api = "https://app.crunch.io/api/",
        httptest.mock.paths = "fixture1"
    ),
    httptest::with_mock_api({
        # This `loadDataset()` call matches exactly how it was in the fixture_1.R
        # so that the same path through the API is used
        ds <- crunch::loadDataset(
            "fixture 1",
            project = crunch::projects()[["crunchtestdemo fixtures"]]
        )

        actual <- crunch_mean_by(ds, "age", "region")

        expect_equivalent(as.numeric(actual@arrays$mean[1:2]), c(30.75, 70))
        expect_equivalent(names(actual@arrays$mean[1:2]), c("North", "South"))
    })
)

# If it were me, I'd have a function like this:
with_api_fixture <- function(fixture_path, expr) {
    with(
        crunch::temp.options(
            crunch.api = "https://app.crunch.io/api/",
            httptest.mock.paths = fixture_path
        ),
        httptest::with_mock_api(expr)
    )
}

# Same tests, but using function
with_api_fixture("fixture1", {
    ds <- crunch::loadDataset(
        "fixture 1",
        project = crunch::projects()[["crunchtestdemo fixtures"]]
    )

    actual <- crunch_mean_by(ds, "age", "region")

    expect_equivalent(as.numeric(actual@arrays$mean[1:2]), c(30.75, 70))
    expect_equivalent(names(actual@arrays$mean[1:2]), c("North", "South"))
})
