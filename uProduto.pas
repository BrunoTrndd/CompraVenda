unit uProduto;

interface

uses SysUtils, Generics.Collections, uEnums, uNaturezaMercadoria;

type
  TProduto = class
  private
    FHandle             : Integer;
    FNome               : string;
    FValorUnit          : currency;
    FTipoProduto        : TTipoProduto;
    FValorCompra        : currency;
    FValorVenda         : currency;
    FSaldoVenda         : integer;
    FSaldoDisponivel    : integer;
    FNaturezaMercadoria : TNaturezaMercadoria;


  public
    property Nome               : string              read FNome                write FNome;
    property ValorUnit          : currency            read FValorUnit           write FValorUnit;
    property TipoProduto        : TTipoProduto        read FTipoProduto         write FTipoProduto;
    property ValorCompra        : currency            read FValorCompra         write FValorCompra;
    property ValorVenda         : currency            read FValorVenda          write FValorVenda;
    property SaldoDisponivel    : integer             read FSaldoDisponivel     write FSaldoDisponivel;
    property SaldoVenda         : integer             read FSaldoVenda          write FSaldoVenda;
    property NaturezaMercadoria : TNaturezaMercadoria read FNaturezaMercadoria  write FNaturezaMercadoria;
    property Handle             : Integer             read FHandle              write FHandle;

  //CONSTRUCTORS
  constructor Create();
  destructor  Destroy;override;

  //PROCEDURES
  procedure SolicitarInformacao();
  procedure AtualizaEstoque(prQuantidade : integer; prTipoMovimentacao : TTipoOrdem; prStatusOrdem : TStatus);

  //FUNCTIONS
  function ToString() : string;
  function ListaTipo() : string;


  end;
var
vHandle : Integer;

implementation

{ TProduto }

constructor TProduto.Create;
begin
  vHandle             := vHandle + 1;
  FHandle             := vHandle;
  FNome               := '';
  FValorUnit          := 0.00;
  FTipoProduto        := TTipoProduto.Produto;
  FValorCompra        := 0.00;
  FValorVenda         := 0.00;
  FSaldoVenda         := 0;
  FSaldoDisponivel    := 0;
  FNaturezaMercadoria := nil;
end;

destructor TProduto.Destroy;
begin

end;

function TProduto.ListaTipo(): string;
begin
  if FTipoProduto = TTipoProduto.Produto then
  begin
    Result := 'Produto';
  end else if FTipoProduto = TTipoProduto.Servico then
  begin
    Result:= 'Servico';
  end;


end;

procedure TProduto.SolicitarInformacao;
var
  vTipo : integer;
  vNatureza : string;

begin
  write('Nome do produto: ');
  readln(FNome);

  write('Valor unitario: ');
  readln(FValorUnit);

  write('1 - Produto | 2 - Servico: ');
  readln(vTipo);

  case vTipo of
    1:
    begin
      FTipoProduto := TTipoProduto.Produto;
    end;

    2:
    begin
      FTipoProduto := TTipoProduto.Servico;
    end;
  end;


  write('Valor de compra: ');
  readln(FValorCompra);

  write('Valor de venda: ');
  readln(FValorVenda);

  write('Saldo inicial: ');
  readln(FSaldoDisponivel);

  write('Natureza de mercadoria: ');
//  readln(vNatureza);

end;

function TProduto.ToString: String;
begin
  Result := '-------------------------------Produto----------------------------'+sLineBreak+
            'Nome: '+ FNome                                                     +sLineBreak+
            'Valor unitario: ' + FormatCurr('#.#00,00',FValorUnit)              +sLineBreak+
            'Tipo: ' + ListaTipo()                                              +sLineBreak+
            'Valor compra: ' + FormatCurr('#.##0,00',FValorCompra)              +sLineBreak+
            'Valor venda: ' + FormatCurr('#.##0,00',FValorVenda)                +sLineBreak+
            'Saldo disponivel: ' + IntToStr(FSaldoDisponivel)                   +sLineBreak+
            'Saldo reservado: ' + IntToStr(FSaldoVenda)                           +sLineBreak+
//            'Natureza: ' + FNaturezaMercadoria                                  +sLineBreak+      CORRIGIR O TIPO UTILIZANDO O METODO PARA RETORNAR UMA STRING
            '------------------------------------------------------------------'+sLineBreak;
end;

procedure TProduto.AtualizaEstoque(prQuantidade: integer; prTipoMovimentacao: TTipoOrdem; prStatusOrdem: TStatus);
begin
  if prTipoMovimentacao = TTipoOrdem.Compra then //Entrada-Compra
  begin
    if (prStatusOrdem = TStatus.Encerrado) then
    begin
      FSaldoDisponivel := FSaldoDisponivel + prQuantidade;
    end;

    if (prStatusOrdem = TStatus.Cancelado) then
    begin
      FSaldoDisponivel := FSaldoDisponivel - prQuantidade;
    end;
  end;


  if prTipoMovimentacao= TTipoOrdem.Venda then //Saída-Venda
  begin
    if (FSaldoDisponivel - prQuantidade) < 0 then
      raise Exception.Create ('Nao foi possivel realizar a movimentacao de estoque.'                +sLineBreak+
                              'Quantidade da venda e maior que a quantidade disponivel.'            +sLineBreak+
                              'Quantidade disponivel: ' + IntToStr(FSaldoDisponivel)                +sLineBreak+
                              'Quantidade reservada: ' + IntToStr(FSaldoDisponivel)                 +sLineBreak+
                              'Quantidade movimentada: ' + IntToStr(prQuantidade)                   +sLineBreak);

    //Status Cadastrado
    if (prStatusOrdem = TStatus.Cadastrado) then
    begin
      FSaldoDisponivel := FSaldoDisponivel - prQuantidade;
      FSaldoVenda := FSaldoVenda + prQuantidade;
    end;

    //Status Encerrado
    if (prStatusOrdem = TStatus.Encerrado) then
    begin
      FSaldoVenda := FSaldoVenda - prQuantidade;
    end;

    //Status Cancelado
    if (prStatusOrdem = TStatus.Cancelado) then
    begin
      FSaldoDisponivel := FSaldoDisponivel + prQuantidade;
      FSaldoVenda := FSaldoVenda - prQuantidade;
    end;
  end;
end;

end.

