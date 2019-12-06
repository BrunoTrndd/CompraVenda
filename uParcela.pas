unit uParcela;

interface
uses DateUtils, SysUtils, uEnums, uInclude;

type
TParcela = class(TInclude)

  private
    FHandle         : Integer;
    FDataCadastro   : TDateTime;
    FDataVencimento : TDateTime;
    FValor          : Currency;
    FPago           : Boolean;
    FSequencia      : Integer;
    FAbrangencia    : TTipoOrdem;

  public
    property Handle         : Integer   read FHandle          write FHandle;
    property DataCadastro   : TDateTime read FDataCadastro    write FDataCadastro;
    property DataVencimento : TDateTime read FDataVencimento  write FDataVencimento;
    property ValorTotal     : Currency  read FValor           write FValor;
    property Pago           : Boolean   read FPago            write FPago;
    property Sequencia      : Integer   read FSequencia       write FSequencia;

// CONSTRUCTOR
  constructor Create(prAbrangencia : TTipoOrdem; prValor : Currency; prDataVencimento : TDateTime);

// DESTRUCTOR
  destructor Destroy();override;

// FUNCTIONS
  function ToString()  : string;
  function ListaPago() : string;

// PROCEDURES
  procedure BaixarParcela();

end;

var
vHandle : Integer;

implementation

{ TParcela }



//CREATE
constructor TParcela.Create(prAbrangencia : TTipoOrdem; prValor : Currency; prDataVencimento : TDateTime);
begin
  Inc(vHandle);
  FHandle         := vHandle;
  FDataCadastro   := Now();
  FDataVencimento := prDataVencimento;
  FValor          := prValor;
  FPago           := False;
  FAbrangencia    := prAbrangencia;
end;

//DESTROY
destructor TParcela.Destroy;
begin
  inherited;
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

procedure TParcela.BaixarParcela();
begin
  if Now() > DataVencimento then
  begin
    Writeln('A parcela ' + IntToStr(Handle) + ' esta vencida, mas foi baixada.');
    Pago := True;
  end else if Pago then
    begin
      raise Exception.Create('A Parcela' + IntToStr(Handle) + ' ja esta paga.');
    end else
    begin
      Pago := True;
    end;
end;



function TParcela.ToString: String;
begin
  Result := '-------------------------------Parcela----------------------------'+sLineBreak+
            'Handle : '+IntToStr(FHandle)                                       +sLineBreak+
            'Data de Cadastro: '+FormatDateTime('dd-mm-yyyy',FDataCadastro)     +sLineBreak+
            'Vencimento: '+FormatDateTime('dd-mm-yyyy',FDataVencimento)         +sLineBreak+
            'Valor Total: '+FormatCurr('#.##0,00',FValor)                       +sLineBreak+
            'Pago: '+ListaPago()                                                +sLineBreak+
            '------------------------------------------------------------------'+sLineBreak;
end;

end.
