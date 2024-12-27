#Created below Components-
## Apex Class - CreateInvoiceController
## VF Page - CreateInvoice
## Custom objects - 
1. Invoice__c

###Fields-

Account__c -> Lookup field on Account </br>
Invoice Number -> Auto Number starts from 1 </br>
Invoice_Date__c -> Date field </br>
Due_Datye__c -> Date field </br>
Invoice Reference -> URL Formula field ( hyperlink to the record based on the record id ) </br>
Total -> Roll up Summary ( Sum on line item amount field )</br>
DNU_Invoice_reference__c -> internal text field used to store Reference record ID</br>

2. Invoice Line Item

###Fields-

Invoice__c -> Lookup field on Invoice__c</br>
Line Description -> Long text field</br>
Quantity -> Number field</br>
Unit Price -> Currency field</br>
Amount -> Formula Field ( Quantity * UnitPrice)</br>

VF page URL - /apex/CreateInvoice?origin_record=0065g00000RxqzEAAR&account=0015g00000wbTN4AAM&invoice_date=LastActivityDate&invoice_due_date=Due_Date__c&child_relationship_name=OpportunityLineItems&line_item_description=Description&line_item_quantity=Quantity&line_item_unit_price=UnitPrice


Final VF screen - ![image](https://github.com/user-attachments/assets/1f5f6bf3-2794-41ef-91a1-87805a6dd5a4)

JSON Output - attached in the files




