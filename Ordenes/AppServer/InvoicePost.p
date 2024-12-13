@openapi.openedge.export FILE(type="REST", executionMode="external", useReturnValue="false", writeDataSetBeforeImage="false").

/*------------------------------------------------------------------------
    File        : InvoicePost.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : Sebastian
    Created     : Mon Dec 02 10:22:30 ART 2024
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */

{dsgeneral.i}

/* ***************************  Main Block  *************************** */
DEFINE INPUT-OUTPUT PARAMETER DATASET FOR dsGeneral.

DEFINE VARIABLE oInvoice AS Invoice NO-UNDO.
   
   
    oInvoice = NEW Invoice().
    oInvoice:PostInvoice(INPUT-OUTPUT DATASET dsGeneral).
     
CATCH e AS Progress.Lang.Error: 
END CATCH.
FINALLY:
    EMPTY TEMP-TABLE ttinvoice.
    DELETE OBJECT oInvoice.
END FINALLY.
