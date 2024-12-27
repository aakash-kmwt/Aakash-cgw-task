Created below objects and fields- 

Invoice__c

Fields-

Account__c -> Lookup field on Account
Invoice Number -> Auto Number starts from 1
Invoice_Date__c -> Date field
Due_Datye__c -> Date field
Invoice Reference -> URL Formula field ( hyperlink to the record based on the record id )
Total -> Roll up Summary ( Sum on line item amount field )
DNU_Invoice_reference__c -> internal text field used to store Reference record ID


Invoice Line Item

Fields-

Invoice__c -> Lookup field on Invoice__c
Line Description -> Long text field
Quantity -> NUmber field
Unit Price -> Currency field
Amount -> Formula Field ( Quantity * UnitPrice)
