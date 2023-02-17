pageextension 50115 RecommendedAppsListExt extends "Recommended Apps List"
{
    actions
    {
        addfirst(Processing)
        {
            action(AddRecommendedApps)
            {
                Caption = 'Add Recommended Apps';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Add;

                trigger OnAction()
                var
                    AddRecommendedApp: Page "ZY Add Recommended App";
                begin
                    if AddRecommendedApp.RunModal() = Action::OK then
                        AddRecommendedApp.InsertRecommendedApp();
                end;
            }
            action(DeleteRecommendedApps)
            {
                Caption = 'Delete Selected Recommended Apps';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Delete;

                trigger OnAction()
                var
                    RecommendedApps: Codeunit "Recommended Apps";
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    if RecommendedApps.DeleteApp(Rec.Id) then
                        Message('Recommended App is deleted!!!');
                end;
            }
        }
    }
}

page 50116 "ZY Add Recommended App"
{
    Caption = 'Add Recommended App';
    PageType = StandardDialog;

    layout
    {
        area(Content)
        {
            field(AppId; AppId)
            {
                Caption = 'App Id';
                ApplicationArea = All;
            }
            field(SortingId; SortingId)
            {
                Caption = 'Sourting Id';
                ApplicationArea = All;
            }
            field(Name; Name)
            {
                Caption = 'Name';
                ApplicationArea = All;
            }
            field(Publisher; Publisher)
            {
                Caption = 'Publisher';
                ApplicationArea = All;
            }
            field(ShortDescription; ShortDescription)
            {
                Caption = 'Short Description';
                ApplicationArea = All;
            }
            field(LongDescription; LongDescription)
            {
                Caption = 'Long Description';
                ApplicationArea = All;
                MultiLine = true;
            }
            field(AppSourceURL; AppSourceURL)
            {
                Caption = 'AppSource URL';
                ApplicationArea = All;
            }
        }
    }

    var
        AppId: Guid;
        SortingId: Integer;
        Name: Text[250];
        Publisher: Text[250];
        ShortDescription: Text[250];
        LongDescription: Text[2480];
        AppSourceURL: Text;


    procedure InsertRecommendedApp()
    var
        RecommendedApps: Codeunit "Recommended Apps";
        RecommendedBy: Enum "App Recommended By";
    begin
        if RecommendedApps.InsertApp(AppId, SortingId, Name, Publisher, ShortDescription, LongDescription, RecommendedBy::"Your Microsoft Reseller", AppSourceURL) then
            Message('Recommended App is added!!!')
        else
            Error('Something is wrong!!!');
    end;
}

pageextension 50116 RecommendedAppCardExt extends "Recommended App Card"
{

    actions
    {
        addfirst(Processing)
        {
            action(InstallAppSourceExtension)
            {
                Caption = 'Install AppSource Extension';
                ApplicationArea = All;
                Image = Installments;

                trigger OnAction()
                var
                    ExtManagement: Codeunit "Extension Management";
                begin
                    ExtManagement.DeployExtension(Rec.Id, 1041, true);
                end;
            }
        }
    }
}
