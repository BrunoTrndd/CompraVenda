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

  public
    property Handle         : Integer read FHandle write FHandle;
    property DataCadastro   : TDateTime read FDataCadastro write FDataCadastro;
    property DataVencimento : TDateTime read FDataVencimento write FDataVencimento;
    property ValorTotal     : Currency read FValorTotal write FValorTotal;
    property Pago           : Boolean read FPago write FPago;

// CONSTRUCTOR
  constructor Create();

// DESTRUCTOR
  destructor Destroy();

// FUNCTIONS
  function ToString()  : string;
  function ListaPago() : string;

// PROCEDURES


end;

implementation


{ TParcela }

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
//  FOrdem.Free;
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
