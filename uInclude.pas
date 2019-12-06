unit uInclude;

interface
uses DateUtils, SysUtils;
type
TInclude = class
  public

  function GetDate(prTipoData: string): TDateTime;
end;

implementation

{ TInclude }

function TInclude.GetDate(prTipoData: string): TDateTime;
var
  vTexto: string;
begin
  repeat
    Writeln(prTipoData + ' (dd-mm-yyyy) : ');
    Readln(vTexto);
    Result := StrToDateTimeDef(vTexto, 0, FormatSettings);
  until Result <> 0;
end;


end.
