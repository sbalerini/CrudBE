@openapi.openedge.export FILE(type="REST", executionMode="external", useReturnValue="false", writeDataSetBeforeImage="false").

/*------------------------------------------------------------------------
    File        : InvoiceDel.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : Sebastian
    Created     : Tue Dec 03 09:28:21 ART 2024
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */

{dsgeneral.i}

/* ***************************  Main Block  *************************** */
DEFINE INPUT PARAMETER wId AS CHARACTER.
DEFINE INPUT PARAMETER wId2 AS CHARACTER.
DEFINE OUTPUT PARAMETER DATASET FOR dsGeneral.
DEFINE VARIABLE oInvoice AS Invoice NO-UNDO.

    oInvoice = NEW Invoice().
    oInvoice:DeleteInvoice(INPUT wId , INPUT wId2 , OUTPUT DATASET dsGeneral).
    
CATCH e AS Progress.Lang.Error:
END CATCH.
FINALLY:
    DELETE OBJECT oInvoice.
END FINALLY.
