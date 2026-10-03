### Sales Value and Duplicate Row Investigation

The dataset contains approximately **£9.75 million in net transaction value**, calculated from quantity multiplied by unit price. This figure includes both positive sales and negative cancellation transactions.

An investigation of the dataset identified **4,879 groups of exact duplicate rows**, affecting **1,933 distinct invoices**. Removing additional copies of these rows would reduce the calculated transaction value by approximately **£21,741 (0.22%)**.

However, inspection of individual affected invoices suggested that some repeated rows could represent legitimate customer purchasing activity rather than database duplication. For example, repeated products and quantities appeared within larger customer orders. As a result, the original transaction records were retained rather than being mechanically deduplicated. This preserves the source data while avoiding the assumption that every exact duplicate represents an error.