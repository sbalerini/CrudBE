 /*------------------------------------------------------------------------
    File        : Invoice
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Sebastian
    Created     : Tue Nov 26 14:04:16 ART 2024
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Json.ObjectModel.JsonObject.
USING Progress.Json.JsonParser.
USING Progress.Json.ObjectModel.ObjectModelParser.
USING Progress.Json.ObjectModel.JsonArray.
USING OpenEdge.Net.*.
USING OpenEdge.Net.HTTP.*.


BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Invoice: 
    {"dsgeneral.i"}
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    CONSTRUCTOR PUBLIC Invoice (  ):
        SUPER ().        
    END CONSTRUCTOR.
    
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID GetInvoice(INPUT itop AS CHARACTER, OUTPUT DATASET dsGeneral):
        EMPTY TEMP-TABLE ttinvoice NO-ERROR.   
       
       output to C:\temporal\zzztop.txt.
              display "1" itop.
              output close.
        FIND Invoice WHERE Invoice.Invoicenum = INTEGER(itop) NO-ERROR.
        IF AVAILABLE Invoice THEN DO: 
             CREATE ttinvoice.
             BUFFER-COPY Invoice TO ttinvoice.
        END.
        ELSE DO:
             FOR EACH Invoice NO-LOCK:  
                CREATE ttinvoice.
                BUFFER-COPY Invoice TO ttinvoice.
             END.
        END.
    END METHOD.
    
    METHOD PUBLIC VOID PostInvoice(INPUT-OUTPUT DATASET dsGeneral):
        FIND FIRST ttinvoice NO-ERROR.
        IF ttinvoice.Invoicenum < 0 OR ttinvoice.CustNum < 0 THEN DO:
            CREATE ttEstados.
            ASSIGN ttEstados.Estado      = "Error"
                   ttEstados.Descripcion = "El indice no puede ser negativo. Verifique y Reingrese".
            RETURN.
        END.
        
        IF YEAR(ttinvoice.InvoiceDate) <= 2000 OR YEAR(ttinvoice.InvoiceDate) >= 2500 THEN DO:
            CREATE ttEstados.
            ASSIGN ttEstados.Estado      = "Error"
                   ttEstados.Descripcion = "Año incorrecto. Verifique y Reingrese".
             RETURN.
        END.
        IF DAY(ttinvoice.InvoiceDate) > 31 OR MONTH(ttinvoice.InvoiceDate) > 12 THEN DO:
            CREATE ttEstados.
            ASSIGN ttEstados.Estado      = "Error"
                   ttEstados.Descripcion = "Mes o dia incorrecto. Verifique y Reingrese".
             RETURN.
        END.
        IF DATE(ttinvoice.InvoiceDate) > TODAY THEN DO:
            CREATE ttEstados.
            ASSIGN ttEstados.Estado      = "Error"
                   ttEstados.Descripcion = "Fecha futura. Verifique y Reingrese".
            RETURN.
        END.
        IF ttinvoice.Amount > (ttinvoice.TotalPaid + ttinvoice.Adjustment)  THEN DO:
            CREATE ttEstados.
            ASSIGN ttEstados.Estado      = "Error"
                   ttEstados.Descripcion = "El monto no puede ser mayor a total pago con ajuste".
            RETURN.
        END.
        FIND Invoice WHERE Invoice.Invoicenum    =  ttinvoice.Invoicenum NO-ERROR.
        IF NOT AVAILABLE Invoice THEN DO:
            FOR EACH ttinvoice :
            FIND LAST Invoice USE-INDEX CustNum .
            ttinvoice.CustNum = (Invoice.CustNum  + 1).
            FIND LAST Invoice USE-INDEX OrderNum .
            ttinvoice.OrderNum = (Invoice.OrderNum  + 1).
            CREATE Invoice.
            ASSIGN Invoice.Invoicenum  = ttinvoice.Invoicenum
                   Invoice.CustNum     = ttinvoice.CustNum
                   Invoice.InvoiceDate = ttinvoice.InvoiceDate
                   Invoice.Amount      = DECIMAL(REPLACE(STRING(ttinvoice.Amount), ",", "")) 
                   Invoice.TotalPaid   = DECIMAL(REPLACE(STRING(ttinvoice.TotalPaid), ",", ""))
                   Invoice.Adjustment  = ttinvoice.Adjustment
                   Invoice.OrderNum    = ttinvoice.OrderNum
                   Invoice.ShipCharge  = ttinvoice.ShipCharge.
            END.
            CREATE ttEstados.
            ASSIGN ttEstados.Estado      = "OK"
                   ttEstados.Descripcion = "El registro ha sido creado".
        END.
        ELSE DO:
            CREATE ttEstados.
            ASSIGN ttEstados.Estado      = "Error"
                   ttEstados.Descripcion = "El registro ya Existe".
        END.
          
    END METHOD.
    


    METHOD PUBLIC VOID UpdateInvoice(INPUT-OUTPUT DATASET dsGeneral):
      
        FIND FIRST ttinvoice NO-ERROR.
        IF ttinvoice.Invoicenum < 0 OR ttinvoice.CustNum < 0 THEN DO:
            CREATE ttEstados.
            ASSIGN ttEstados.Estado      = "Error"
                   ttEstados.Descripcion = "El indice no puede ser negativo. Verifique y Reingrese".
            RETURN.
        END.
        IF ttinvoice.Amount > (ttinvoice.TotalPaid + ttinvoice.Adjustment)  THEN DO:
            CREATE ttEstados.
            ASSIGN ttEstados.Estado      = "Error"
                   ttEstados.Descripcion = "El monto no puede ser mayor a total pago con ajuste".
            RETURN.
        END.
         output to C:\temporal\zzztop.txt.
              display "Dentro UpdateInvoice" STRING(ttinvoice.InvoiceDate) string(ttinvoice.InvoiceDate) .
              output close.
        FIND Invoice WHERE Invoice.Invoicenum   = ttinvoice.Invoicenum
                       AND Invoice.CustNum      = ttinvoice.CustNum EXCLUSIVE-LOCK NO-ERROR.
        IF AVAILABLE Invoice THEN DO:
            ASSIGN Invoice.InvoiceDate = TODAY
                   Invoice.Amount      = DECIMAL(REPLACE(STRING(ttinvoice.Amount), ",", "")) 
                   Invoice.TotalPaid   = DECIMAL(REPLACE(STRING(ttinvoice.TotalPaid), ",", ""))
                   Invoice.Adjustment  = ttinvoice.Adjustment
                   Invoice.ShipCharge  = ttinvoice.ShipCharge.
                 
            CREATE ttEstados.
            ASSIGN ttEstados.Estado      = "OK"
                   ttEstados.Descripcion = "El registro ha sido modificado".
        END.
        ELSE DO:
            CREATE ttEstados.
            ASSIGN ttEstados.Estado      = "Error"
                   ttEstados.Descripcion = "El registro NO Existe, No puede ser modificado".
        END.
    END METHOD.
    
    
    
    METHOD PUBLIC VOID DeleteInvoice(INPUT wId AS CHARACTER, INPUT wId2 AS CHARACTER, INPUT wId3 AS CHARACTER, OUTPUT DATASET dsGeneral):
        
         output to C:\temporal\zzztop.txt.
              display "1" wId wId2 wId3 .
              output close.
        CREATE ttEstados.
        FIND Invoice WHERE Invoice.Invoicenum       =  INTEGER(wId) 
                       AND Invoice.Custnum          =  INTEGER(wId2)
                       AND Invoice.Ordernum         =  INTEGER(wId3)  NO-ERROR.
        IF AVAILABLE Invoice THEN DO:
            IF Invoice.Amount > (Invoice.TotalPaid + Invoice.Adjustment)  THEN DO:
                CREATE ttEstados.
                ASSIGN ttEstados.Estado      = "Error"
                       ttEstados.Descripcion = "El monto no puede ser mayor a total pago con ajuste".
                RETURN.
            END.
            ElSE DO:
                DELETE Invoice.
                ASSIGN ttEstados.Estado      = "OK"
                       ttEstados.Descripcion = "El registro ha sido eliminado".
            END.
        END.
        ELSE DO:
            ASSIGN ttEstados.Estado      = "Error"
                   ttEstados.Descripcion = "El registro No Existe".
        END.
    END METHOD.
    

END CLASS.

