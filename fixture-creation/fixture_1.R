# Generates fixture 1
library(crunch)
library(httptest)
library(crunchtestdemo)
login()

project_name <- "crunchtestdemo fixtures"
ds_name <- "fixture 1"
if (!(ds_name %in% listDatasets(project = project_name))) {
    data <- data.frame(
        age = c(18, 25, 35, 45, 55, 65, 75, 85),
        region = factor(c(rep("North", 4), rep("South", 4)), c("North", "South"))
    )

    ds <- newDataset(data, ds_name)
    mv(projects(), ds, project_name)
} else {
    ds <- loadDataset(ds_name, project = projects()[[project_name]])
    ds <- restoreVersion(ds, versions(ds)[[1]])
}

httpcache::clearCache()
start_capturing("tests/testthat/fixture1")

ds <- loadDataset(ds_name, project = projects()[[project_name]])
crunch_mean_by(ds, "age", "region")

stop_capturing()
