unit uBaixaParcela;

interface
uses uParcela, uEnums, SysUtils, DateUtils, Generics.Collections;

type
TBaixaParcela = class
  private
  FHandle    : Integer;
  FParcelas  : TList<TParcela>;

  public
  property Handle   : Integer            read FHandle   write FHandle;
  property Parcelas : TList<TParcela>    read FParcelas write FParcelas;


// CONSTRUCTOR
  constructor Create();

// DESTRUCTOR
  destructor Destroy();override;

// FUNCTIONS
  function ToString()      : string;
  function ListarParcelas(): string;
  function ListarTipo()    : string;

// PROCEDURES
  procedure AdicionarParcela(prParcela : TParcela);
  procedure BaixarParcelas(prCallBack : TProc<Currency>);


end;
var
  vParcela : TParcela;

implementation

{ TBaixaParcela }

{
  ADICIONARPARCELA
  PARAM : PARCELA
  ADICIONA A PARCELA NA LISTA DE PARCELAS DA BAIXA
}
procedure TBaixaParcela.AdicionarParcela(prParcela : TParcela);
begin
  Parcelas.Add(prParcela);
end;



//CREATE
procedure TBaixaParcela.BaixarParcelas(prCallBack: TProc<Currency>);
var
vValorTotal : Currency; 
begin
vValorTotal := 0;
  try
    for vParcela in Parcelas do
    begin
      vValorTotal := vValorTotal + vParcela.ValorTotal;
      vParcela.BaixarParcela();
    end;
    prCallBack(vValorTotal);
  except
    on E : Exception do
      Writeln('Erro: ' + E.Message);
  end;
end;

constructor TBaixaParcela.Create;
begin
  FHandle     := 0;
  FParcelas   := TList<TParcela>.Create;
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






{
  LISTARPARCELAS
  PARAM  : NONE
  RETURN : STRING
  RETORNA EM UMA LINHA TODOS OS HANDLES DAS PARCELAS QUE ESTAO VINCULADOS A ORDEM
}
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


function TBaixaParcela.ListarTipo: string;
begin

end;

//TO STRING
function TBaixaParcela.ToString: string;
begin
  Result := '-----------------------Baixa das Parcelas-------------------------'+sLineBreak+
            'Handle: '+IntToStr(FHandle)                                        +sLineBreak+
            'Parcelas: '+ListarParcelas()                                       +sLineBreak+
            '------------------------------------------------------------------'+sLineBreak;
end;

end.
