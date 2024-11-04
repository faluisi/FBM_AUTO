report 60189 FBM_Checkext_AUTO
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
        send: Boolean;
        ExtManagement: Codeunit "Extension Management";

    begin
        cr := 13;
        lf := 10;
        crlf := format(cr) + format(lf);

        cinfo.Get();
        if ExtManagement.IsInstalledByAppId('9d836a4f-3b97-4179-ae7d-608f099ba7f3') then
            bodytxt += info.Name + crlf
        else begin
            bodytxt += StrSubstNo('The extension %1 is not installed!', ExtManagement.GetAppName('9d836a4f-3b97-4179-ae7d-608f099ba7f3')) + crlf;
            send := true;
        end;

        if ExtManagement.IsInstalledByAppId('e6857996-833b-464e-91d1-e5102f622d69') then
            bodytxt += info.Name + crlf
        else begin
            bodytxt += StrSubstNo('The extension %1 is not installed!', ExtManagement.GetAppName('e6857996-833b-464e-91d1-e5102f622d69')) + crlf;
            send := true;
        end;
        if ExtManagement.IsInstalledByAppId('58b7a12d-f433-4fb1-b33c-f816f041f53f') then
            bodytxt += info.Name + crlf
        else begin
            bodytxt += StrSubstNo('The extension %1 is not installed!', ExtManagement.GetAppName('58b7a12d-f433-4fb1-b33c-f816f041f53f')) + crlf;
            send := true;
        end;
#if JYM
         if  ExtManagement.IsInstalledByAppId('3c5c97e5-3674-41f4-b04f-fc563d2a7fd4') then 
          bodytxt += info.Name + crlf
          else begin
        bodytxt+=  StrSubstNo('The extension %1 is not installed!',ExtManagement.GetAppName('3c5c97e5-3674-41f4-b04f-fc563d2a7fd4'))+crlf;
        send:=true;
        end;
        bodytxt+='MX';
#endif
        if send then begin
            emailMsg.Create(cinfo.FBM_SendAlert, 'extensions ALERT!!', bodytxt);
            email.send(emailMsg);
        end;

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