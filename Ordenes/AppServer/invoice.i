
/*------------------------------------------------------------------------
    File        : invoice.i
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : Sebastian
    Created     : Tue Nov 26 14:06:31 ART 2024
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

DEFINE TEMP-TABLE ttinvoice LIKE Invoice.

DEFINE TEMP-TABLE ttcliente LIKE Customer.
DEFINE TEMP-TABLE ttEstados 
   FIELD Estado      AS CHARACTER
   FIELD Descripcion AS CHARACTER.
   
   
   
/* ********************  Preprocessor Definitions  ******************** */

/* ***************************  Main Block  *************************** */
