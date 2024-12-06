
 /*------------------------------------------------------------------------
    File        : Customer
    Purpose		:
    Syntax      : 
    Description :
    Author(s)   : Sebastian
    Created     : Wed Nov 20 14:40:38 ART 2024
    Notes       : 
  ----------------------------------------------------------------------*/
  
  /* ***************************  Definitions  ************************** */
  
  /* ********************  Preprocessor Definitions  ******************** */
  
  /* ***************************  Main Block  *************************** */
  
  /** Dynamically generated schema file **/
   
@openapi.openedge.entity.primarykey (fields="CustNum").
	
DEFINE TEMP-TABLE ttCustomer BEFORE-TABLE bttCustomer
FIELD CustNum AS INTEGER INITIAL "0" LABEL "Cust Num"
FIELD Country AS CHARACTER INITIAL "USA" LABEL "Country"
FIELD Name AS CHARACTER LABEL "Name"
FIELD Address AS CHARACTER LABEL "Address"
FIELD Address2 AS CHARACTER LABEL "Address2"
FIELD City AS CHARACTER LABEL "City"
FIELD State AS CHARACTER LABEL "State"
FIELD PostalCode AS CHARACTER LABEL "Postal Code"
FIELD Contact AS CHARACTER LABEL "Contact"
FIELD Phone AS CHARACTER LABEL "Phone"
FIELD SalesRep AS CHARACTER LABEL "Sales Rep"
FIELD CreditLimit AS DECIMAL INITIAL "1500" LABEL "Credit Limit"
FIELD Balance AS DECIMAL INITIAL "0" LABEL "Balance"
FIELD Terms AS CHARACTER INITIAL "Net30" LABEL "Terms"
FIELD Discount AS INTEGER INITIAL "0" LABEL "Discount"
FIELD Comments AS CHARACTER LABEL "Comments"
FIELD Fax AS CHARACTER LABEL "Fax"
FIELD EmailAddress AS CHARACTER LABEL "Email"
INDEX Comments  Comments  ASCENDING 
INDEX CountryPost  Country  ASCENDING  PostalCode  ASCENDING 
INDEX CustNum IS  PRIMARY  UNIQUE  CustNum  ASCENDING 
INDEX Name  Name  ASCENDING 
INDEX SalesRep  SalesRep  ASCENDING . 



