unit uNaturezaMercadoria;

interface

uses SysUtils;

type
  TNaturezaMercadoria = class
  private
    FHandle : integer;
    FNome   : string;

  public
    property Handle : integer read FHandle write FHandle;
    property Nome   : string  read FNome   write FNome;

  //CONSTRUCTOR
  constructor Create();

  //DESTRUCTOR
  destructor Destroy;override;

  //PROCEDIMENTOS
  procedure SolicitarInformacao(prListaQuantia: Integer);

  //FUNCTIONS
  function ToString() : string; override;

  end;

implementation

{ TNaturezaMercadoria }

constructor TNaturezaMercadoria.Create;
begin
  FHandle := 0;
  FNome := '';
end;

destructor TNaturezaMercadoria.Destroy;
begin

end;

procedure TNaturezaMercadoria.SolicitarInformacao(prListaQuantia: integer);

begin
  write('Nome: ');
  readln(FNome);
  FHandle := prListaQuantia+1;
end;

function TNaturezaMercadoria.ToString;

begin
  Result := ('Handle' + IntToStr(FHandle)+sLineBreak+
             'Nome: ' + FNome);
end;

end.

