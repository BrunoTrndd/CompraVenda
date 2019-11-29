unit uParcela;

interface
uses DateUtils, SysUtils;

type
TParcela = class

  private
    FHandle         : Integer;
    FDataCadastro   : TDateTime;
    FDataVencimento : TDateTime;
    FValorTotal     : Currency;
    FPago           : Boolean;
    FSequencia      : Integer;

  public
    property Handle         : Integer read FHandle write FHandle;
    property DataCadastro   : TDateTime read FDataCadastro write FDataCadastro;
    property DataVencimento : TDateTime read FDataVencimento write FDataVencimento;
    property ValorTotal     : Currency read FValorTotal write FValorTotal;
    property Pago           : Boolean read FPago write FPago;
    property Sequencia      : Integer read FSequencia write FSequencia;

// CONSTRUCTOR
  constructor Create();

// DESTRUCTOR
  destructor Destroy();

// FUNCTIONS
  function ToString()  : string;
  function ListaPago() : string;
  function GetDate(prTipoData : string)   : TDateTime;

// PROCEDURES
  procedure CriarParcelas(prQtd : Integer; prValorTotal: Currency; prSequencia : Integer);

end;

var
vHandle : Integer;

implementation



{ TParcela }

function TParcela.GetDate(prTipoData: string): TDateTime;
var
  vTexto: string;
begin
  repeat
    Writeln(prTipoData + ' (dd-mm-yyyy) : ');
    Readln(vTexto);
    Result := StrToDateTimeDef(vTexto, 0, FormatSettings);
  until Result <> 0;
end;


//CREATE
constructor TParcela.Create;
begin
  FHandle         := 0;
  FDataCadastro   := 0;
  FDataVencimento := 0;
  FValorTotal     := 0;
  FPago           := False;
end;

//DESTROY
destructor TParcela.Destroy;
begin
  inherited;
end;

procedure TParcela.CriarParcelas(prQtd: Integer; prValorTotal: Currency; prSequencia : Integer);
var
vValorParcela : Currency;
i : Integer;
vData : TDateTime;
begin
//DATA PADRÃO: 01/01/2019 e adicionando um mes a cada parcela
  vData := GetDate('Data da primeira parcela');
  vHandle := vHandle + 1;
  vValorParcela := prValorTotal/prQtd;

  FSequencia      := prSequencia;
  FValorTotal     := vValorParcela;
  FDataCadastro   := Now();
  if i = 1 then
  begin
    FDataVencimento := vData;
  end else
  begin
    vData := IncMonth(vData);
    FDataVencimento := vData;
  end;
end;






function TParcela.ListaPago: string;
begin
  if FPago then
  begin
    Result := 'Pago';
  end else
  begin
    Result := 'Nao pago';
  end;

end;

function TParcela.ToString: String;
begin
  Result := '-------------------------------Parcela----------------------------'+sLineBreak+
            'Handle : '+IntToStr(FHandle)                                       +sLineBreak+
            'Data de Cadastro: '+FormatDateTime('dd-mm-yyyy',FDataCadastro)     +sLineBreak+
            'Vencimento: '+FormatDateTime('dd-mm-yyyy',FDataVencimento)         +sLineBreak+
            'Valor Total: '+FormatCurr('#.##0,00',FValorTotal)                  +sLineBreak+
            'Pago: '+ListaPago()                                                +sLineBreak+
            '------------------------------------------------------------------'+sLineBreak;
end;

end.
