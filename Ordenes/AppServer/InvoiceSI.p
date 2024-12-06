@openapi.openedge.export FILE(type="REST", executionMode="external", useReturnValue="false", writeDataSetBeforeImage="false").

/*------------------------------------------------------------------------
    File        : InvoiceSI.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : Sebastian
    Created     : Tue Nov 26 14:44:42 ART 2024
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */

{dsgeneral.i}


/* ***************************  Main Block  *************************** */


DEFINE INPUT  PARAMETER itop AS CHARACTER NO-UNDO.
DEFINE OUTPUT PARAMETER DATASET FOR dsGeneral.

    DEFINE VARIABLE objInvoice AS Invoice NO-UNDO.
    
    objInvoice = NEW Invoice().
    objInvoice:GetInvoice(INPUT itop, OUTPUT DATASET dsGeneral).

CATCH e AS Progress.Lang.Error:
END CATCH.
FINALLY:
    DELETE OBJECT objInvoice.
END FINALLY.



