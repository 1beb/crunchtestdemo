# crunchtestdemo
Demo usage of httptest to capture mocks from the crunch API.

In this 
[commit](https://github.com/gergness/crunchtestdemo/commit/cce311a552ee45baf4cffe5d3e99426339570bb3), 
we go from a (simple) working but untested package,
to one that uses httptest to have mock tests.

## Key steps

- file 
[`inst/httptest/redact.R`](https://github.com/gergness/crunchtestdemo/blob/cce311a552ee45baf4cffe5d3e99426339570bb3/inst/httptest/redact.R) 
pulls the `crunch` package's redaction file
which helps make sure that `httptest::capture_requests()` doesn't include
tokens, and also does some other pruning on the requests.
  
- file 
[`fixture-creation/fixture_1.R`](https://github.com/gergness/crunchtestdemo/blob/cce311a552ee45baf4cffe5d3e99426339570bb3/fixture-creation/fixture_1.R) 
is a replayable script that makes the requests we need for a test and saves them into
this folder 
[`tests/testthat/fixture1`](https://github.com/gergness/crunchtestdemo/tree/cce311a552ee45baf4cffe5d3e99426339570bb3/tests/testthat/fixture1).
  
- Now the test in 
[`tests/testthat/test-crunch_mean_by.R`](https://github.com/gergness/crunchtestdemo/blob/cce311a552ee45baf4cffe5d3e99426339570bb3/tests/testthat/test-crunch_mean_by.R) 
can use the fixture.
I've run the same set of tests twice, once with the options being set 
explicitly, and another with a function modeled after `with_mock_crunch()` 
from the crunch package. I modified it so that it takes a directory path,
because I would recommend not having overlapping mocks like the crunch
does.
