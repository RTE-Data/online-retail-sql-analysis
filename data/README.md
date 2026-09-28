# Dataset

## Source

This project uses the **Online Retail** dataset provided by the UCI Machine Learning Repository.

The dataset contains transactional data from a UK-based online retail store covering transactions between December 2010 and December 2011.

Original dataset:
https://archive.ics.uci.edu/dataset/352/online+retail

## Dataset preparation

The original dataset was provided as an Excel file. It was converted to CSV format before being imported into SQL Server.

During the import process, the `InvoiceDate` field was initially loaded as text because of date-format conversion issues. The values were subsequently validated and converted to the `DATETIME2` data type in SQL Server.

The final dataset contains **541,909 rows**.

## Repository note

The original dataset is not included in this repository. Users should download the dataset directly from the UCI Machine Learning Repository.