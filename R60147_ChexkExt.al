report 60147 FBM_Checkext_CO
{
    Caption = 'Check Extensions';
    //UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;



    dataset
    {
        dataitem(DataItemName; "Company Information")
        {

        }
    }

    trigger
    OnInitReport()
    var
        info: ModuleInfo;
        email: Codeunit Email;
        emailMsg: Codeunit "Email Message";
        cinfo: record "Company Information";
        cr: Char;
        lf: char;
        crlf: text[2];
        bodytxt: text;

    begin
        cr := 13;
        lf := 10;
        crlf := format(cr) + format(lf);

        cinfo.Get();
        if not navapp.GetModuleInfo('9d836a4f-3b97-4179-ae7d-608f099ba7f3', info) then begin
            bodytxt += StrSubstNo('The extension %1 is not installed!', info.Name) + crlf;
        end;
        if not navapp.GetModuleInfo('e6857996-833b-464e-91d1-e5102f622d69', info) then begin
            bodytxt += StrSubstNo('The extension %1 is not installed!', info.Name) + crlf;
        end;
        if not navapp.GetModuleInfo('58b7a12d-f433-4fb1-b33c-f816f041f53f', info) then begin
            bodytxt += StrSubstNo('The extension %1 is not installed!', info.Name) + crlf;
        end;
#if JYM
         if not navapp.GetModuleInfo('3c5c97e5-3674-41f4-b04f-fc563d2a7fd4', info) then begin
        bodytxt+=  StrSubstNo('The extension %1 is not installed!',info.Name)+crlf;
        end;
#endif
        emailMsg.Create(cinfo.FBM_SendAlert, 'extensions ALERT!!', bodytxt);
        email.send(emailMsg);

    end;

    var
        glsetup: record "General Ledger Setup";
        tmpBlob: Codeunit "Temp Blob";
        cnv64: Codeunit "Base64 Convert";
        InStr: InStream;
        OutStr: OutStream;
        txtB64: Text;
        format: ReportFormat;
        email: Codeunit Email;
        emailMsg: Codeunit "Email Message";
        recRef: RecordRef;
        Customer: Record Customer;
}