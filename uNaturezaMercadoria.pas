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
  procedure SolicitarInformacao();

  //FUNCTIONS
  function ToString() : string;

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

procedure TNaturezaMercadoria.SolicitarInformacao;
var
  vAux : integer;

begin
  write('Nome: ');
  readln(FNome);

  vAux := vAux + 1;
  FHandle := vAux;
end;

function TNaturezaMercadoria.ToString;

begin
  Result := ('Nome: ' + FNome);
end;

end.
