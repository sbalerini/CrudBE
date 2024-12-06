
/*------------------------------------------------------------------------
    File        : dsgeneral.i
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : Sebastian
    Created     : Wed Nov 20 14:41:06 ART 2024
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */


/* ********************  Preprocessor Definitions  ******************** */
   {"customer.i"}
   {"invoice.i"}

/* ***************************  Main Block  *************************** */
DEFINE DATASET dsCustomer FOR ttCustomer.

DEFINE DATASET dsGeneral FOR ttInvoice, ttEstados.