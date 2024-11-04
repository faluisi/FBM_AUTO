pageextension 71000 FBM_CompInfoExt_AUTO extends "Company Information"
{
    layout
    {

        addlast(General)
        {
            field(FBM_SendAlert; Rec.FBM_SendAlert)
            {
                ApplicationArea = all;
            }
        }
    }


}