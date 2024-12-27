#Created below objects and fields- 

##Invoice__c

###Fields-

Account__c -> Lookup field on Account <br/>
Invoice Number -> Auto Number starts from 1 <br/>
Invoice_Date__c -> Date field <br/>
Due_Datye__c -> Date field <br/>
Invoice Reference -> URL Formula field ( hyperlink to the record based on the record id ) <br/>
Total -> Roll up Summary ( Sum on line item amount field ) <br/>
DNU_Invoice_reference__c -> internal text field used to store Reference record ID <br/>


##Invoice Line Item <br/>

###Fields- <br/>

Invoice__c -> Lookup field on Invoice__c <br/>
Line Description -> Long text field <br/>
Quantity -> Number field <br/>
Unit Price -> Currency field <br/>
Amount -> Formula Field ( Quantity * UnitPrice) <br/>



![image](https://github.com/user-attachments/assets/1cd6f2d2-3a0b-4ceb-a79f-90f879a2dd34)



Invoice record page -
![image](https://github.com/user-attachments/assets/c6f73ebd-b48c-4309-8d3f-a788321a737e)

Invoice line item record page - 
![image](https://github.com/user-attachments/assets/92ebff03-d812-428a-a518-94112d48ec19)

