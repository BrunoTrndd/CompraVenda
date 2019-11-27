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
//    FOrdem          : TOrdem;
    FPago           : Boolean;

  public
    property Handle         : Integer read FHandle write FHandle;
    property DataCadastro   : TDateTime read FDataCadastro write FDataCadastro;
    property DataVencimento : TDateTime read FDataVencimento write FDataVencimento;
    property ValorTotal     : Currency read FValorTotal write FValorTotal;
//    property Ordem          : TOrdem read FOrdem write FOrdem;
    property Pago           : Boolean read FPago write FPago;

// CONSTRUCTOR
  constructor Create();

// DESTRUCTOR
  destructor Destroy();

// FUNCTIONS
  function ToString() : String;

// PROCEDURES


end;

implementation


{ TParcela }

constructor TParcela.Create;
begin
  FHandle         = 0;
  FDataCadastro   = 0;
  FDataVencimento = 0;
  FValorTotal     = 0;
  FPago           = False;
end;

destructor TParcela.Destroy;
begin
//  FOrdem.Free;
end;




function TParcela.ToString: String;
begin
  Result := '-------------------------------Parcela----------------------------'+sLineBreak+
            'Handle : '+FHandle                                                 +sLineBreak+
            'Data de Cadastro: '+FormatDateTime('dd-mm-yyyy',FDataCadastro)     +sLineBreak+
            'Vencimento: '+FormatDateTime('dd-mm-yyyy',FDataVencimento)         +sLineBreak+
            'Valor Total: '+FValorTotal                                         +sLineBreak+
            'Pago: '+FPago                                                      +sLineBreak+
            '------------------------------------------------------------------'+sLineBreak;
end;

end.
