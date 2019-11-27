unit uBaixaParcela;

interface
uses uParcela, uEnums, SysUtils, DateUtils, Generics.Collections;

type
TBaixaParcela = class
  private
  FHandle    : Integer;
  FParcelas  : TList<TParcela>;
  FTipoOrdem : TTipoOrdem;

  public
  property Handle : Integer read FHandle write FHandle;
  property Parcelas : TList<TParcela> read FParcelas write FParcelas;
  property TipoOrdem : TTipoORdem read FTipoOrdem write FTipoOrdem;

// CONSTRUCTOR
  constructor Create();

// DESTRUCTOR
  destructor Destroy();

// FUNCTIONS
  function ToString()      : string;
  function ListarParcelas(): string;
  function ListarTipo()    : string;

// PROCEDURES



end;
var
  vParcela : TParcela;

implementation

{ TBaixaParcela }

//CREATE
constructor TBaixaParcela.Create;
begin
  FHandle     := 0;
  FParcelas   := TList<TParcela>.Create;
  FTipoOrdem  := TTipoOrdem.Compra;
end;
//DESTROY
destructor TBaixaParcela.Destroy;
begin
  for vParcela in Parcelas do
  begin
    vParcela.Free;
  end;
  Parcelas.Destroy;
end;

function TBaixaParcela.ListarParcelas: string;
var
vRetorno : string;
begin
  for vParcela in Parcelas do
  begin
    vRetorno := vRetorno + IntToStr(vParcela.Handle);
  end;
  Result := vRetorno;
end;
//RETORNA O TIPO EM STRING
function TBaixaParcela.ListarTipo: string;
begin
if FTipoOrdem = TTipoOrdem.Compra then
  begin
    Result := 'Compra';
  end else
  begin
    Result := 'Venda';
  end;
end;
//TO STRING
function TBaixaParcela.ToString: string;
begin
  Result := '-----------------------Baixa das Parcelas-------------------------'+sLineBreak+
            'Handle: '+IntToStr(FHandle)                                        +sLineBreak+
            'Parcelas: '+ListarParcelas()                                       +sLineBreak+
            'Tipo da Baixa: '+ListarTipo()                                      +sLineBreak+
            '------------------------------------------------------------------'+sLineBreak;
end;

end.
