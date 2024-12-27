public class CreateInvoiceController {
    
    public Map<String, String> params;
    public String jSONString{get; set;}
    public sObject data{get; set;}
    public CreateInvoiceController(){
        params = ApexPages.currentPage().getParameters();
        System.debug(params);
        getData();
    }
    
    public void getData(){
        Id parentRecordId = params.containsKey('origin_record') ? (Id) params.get('origin_record') : null;
        String dateField = params.containsKey('invoice_date') ? params.get('invoice_date') : null;
        String dueDateField = params.containsKey('invoice_due_date') ? params.get('invoice_due_date') : null;
        String relationShipName = params.containsKey('child_relationship_name') ? params.get('child_relationship_name') : null;
        String lineDescriptionField = params.containsKey('line_item_description') ? params.get('line_item_description') : null;
        String lineQtyField = params.containsKey('line_item_quantity') ? params.get('line_item_quantity') : null;
        String lineUnitPriceField = params.containsKey('line_item_unit_price') ? params.get('line_item_unit_price') : null;

        if(
        	parentRecordId == null
            ||
            dateField == null
            ||
            dueDateField == null
            ||
            relationShipName == null
            ||
            lineDescriptionField == null
            ||
            lineQtyField == null
            ||
            lineUnitPriceField == null
        ){
            System.debug('Required Paramenters Missing!');
            return;
        }
        String lineItemFields = lineDescriptionField+','+lineUnitPriceField+','+lineQtyField;
        String query = 'SELECT Id, '+dateField+','+dueDateField+',(SELECT ID,'+lineItemFields+' FROM '+relationShipName+') FROM '+parentRecordId.getSObjectType()+ ' WHERE Id = :recordId';
        
        System.debug('query '+query);
        Map<String, Object> queryBinds = new Map<String, Object>{'recordId' => parentRecordId};

        List<sObject> parentRecord = Database.queryWithBinds(query,queryBinds,AccessLevel.USER_MODE);        
        jSONString = JSON.serializePretty(prepareJSON(parentRecord[0]));
        data = parentRecord[0];
        System.debug(jSONString);
    }
    
    public void createInvoice(){
        Invoice__c invoice = new Invoice__c();
        invoice.Account__c = (Id) params.get('account');
        invoice.DNU_InvoiceRefrence__c = (Id) params.get('origin_record');
        invoice.Due_Date__c = (Date) data.get(params.get('invoice_due_date'));
        invoice.Invoice_Date__c = (Date) data.get(params.get('invoice_date'));
        insert as USER invoice;
        
        List<InvoiceLineItem__c> lineItems = new List<InvoiceLineItem__c>();
        for(Sobject childRecord : (List<Sobject>)data.getSObjects(params.get('child_relationship_name'))){
            InvoiceLineItem__c lineItem = new InvoiceLineItem__c();
            lineItem.Invoice__c = invoice.Id;
            lineitem.Line_Description__c = (String) childRecord.get(params.get('line_item_description'));
            lineitem.Unit_Price__c = (Decimal) childRecord.get(params.get('line_item_unit_price'));
            lineitem.Quantity__c = (Decimal)childRecord.get(params.get('line_item_quantity'));
            lineItems.add(lineItem);
        }
        
        insert as USER lineItems;
        
    }
    
    public InvoiceWrapper prepareJSON(Sobject data){
        InvoiceWrapper invoice = new InvoiceWrapper();
        invoice.type = 'ACCPAY';
        invoice.InvoiceDate = (DateTime)data.get(params.get('invoice_date'));
        invoice.DueDate = (DateTime)data.get(params.get('invoice_due_date'));
        //invoice.InvoiceID = (String)data.get(params.get('id'));
        
        ContactWrapper con = new ContactWrapper();
        con.ContactID = '0000000';
        con.ContactStatus = 'ACTIVE';
        
        AddressWrapper add = new AddressWrapper();
        add.AddressType = 'POBOX';
        add.AddressLine1 = 'P O Box 123';
        add.City = 'Wellington';
        add.PostalCode = '6011';
        add.AttentionTo = 'Andrea';
        
        PhoneWrapper phone = new PhoneWrapper();
        phone.PhoneType = 'DEFAULT';
        phone.PhoneNumber = '1111111';
        phone.PhoneAreaCode = '04';
        phone.PhoneCountryCode = '64';
        
        con.Addresses = new List<AddressWrapper>{add};
        con.Phones = new List<PhoneWrapper>{phone};
            
        invoice.Contact = con;
        
        List<LineItemWrapper> lineItems = new List<LineItemWrapper>();
        for(Sobject childRecord : (List<Sobject>)data.getSObjects(params.get('child_relationship_name'))){
            LineItemWrapper lineItem = new LineItemWrapper();
            lineitem.Description = (String) childRecord.get(params.get('line_item_description'));
            lineitem.UnitAmount = (Decimal) childRecord.get(params.get('line_item_unit_price'));
            lineitem.Quantity = (Decimal)childRecord.get(params.get('line_item_quantity'));
            //lineitem.LineItemID = (String)childRecord.get(params.get('id'));
            lineItems.add(lineItem);
        }
        invoice.LineItems = lineItems;
        
        return invoice;
    }
    
    class InvoiceWrapper{
        String type;
        ContactWrapper Contact;
        DateTime InvoiceDate;
        DateTime DueDate;
        String LineAmountTypes;
        String InvoiceNumber;
        String Reference;
        String Status;
        String SubTotal;
        String TotalTax;
        String Total;
        String CurrencyCode;
        String InvoiceID;
        String AmountDue;
        String AmountPaid;
        String AmountCredited;
        String CurrencyRate;
        List<LineItemWrapper> LineItems;
        
        public invoiceWrapper(){
            
        }
    }
    
    class LineItemWrapper{
        String Description;
        Decimal UnitAmount;
        String TaxType;
        String TaxAmount;
        String LineAmount;
        String AccountCode;
        String AccountId;
        Decimal Quantity;
        String LineItemID;
    }
    
    class ContactWrapper{
        String ContactID;
        String ContactStatus;
        String Name;
        String FirstName;
        String LastName;
        String CompanyNumber;
        String EmailAddress;
        String BankAccountDetails;
        String TaxNumber;
        String AccountsReceivableTaxType;
        String AccountsPayableTaxType;
        String UpdatedDateUTC;
        Boolean IsSupplier;
        Boolean IsCustomer;
        String DefaultCurrency;
        List<AddressWrapper> Addresses;
        List<PhoneWrapper> Phones;
    }
    
    class AddressWrapper{
        String AddressType;
        String AddressLine1;
        String City;
        String PostalCode;
        String AttentionTo;
    }

    class PhoneWrapper{
        String PhoneType;
        String PhoneNumber;
        String PhoneAreaCode;
        String PhoneCountryCode;
    }
}