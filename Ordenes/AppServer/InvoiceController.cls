@openapi.openedge.export FILE(type="REST", executionMode="singleton", useReturnValue="false", writeDataSetBeforeImage="false").

 
 /*------------------------------------------------------------------------
    File        : InvoiceController
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Sebastian
    Created     : Tue Dec 03 14:46:39 ART 2024
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS InvoiceController: 
    {dsgeneral.i}
       
     CONSTRUCTOR PUBLIC InvoiceController (  ):
        SUPER ().        
    END CONSTRUCTOR.
    
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
    METHOD PUBLIC VOID GetAll(INPUT itop as INTEGER, OUTPUT DATASET dsGeneral):
        DEFINE VARIABLE objInvoice AS Invoice NO-UNDO.
      
        objInvoice = NEW Invoice().
        objInvoice:GetInvoice(INPUT itop ,OUTPUT DATASET dsGeneral).
        
        
        CATCH e AS Progress.Lang.Error:
        END CATCH.
        FINALLY:
            DELETE OBJECT objInvoice.
        END FINALLY.
        
    END METHOD.
    
    
    
    

END CLASS.