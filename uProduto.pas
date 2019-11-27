unit uProduto;

interface

uses SysUtils, Generics.Collections, uEnums, uNaturezaMercadoria;

type
  TProduto = class
  private
    FNome               : string;
    FValorUnit          : currency;
    FTipoProduto        : TTipoProduto;
    FValorCompra        : currency;
    FValorVenda         : currency;
    FSaldoVenda         : integer;
    FSaldoDisponivel    : integer;
    FNaturezaMercadoria : TNaturezaMercadoria;

  public
    property Nome               : string              read FNome write FNome;
    property ValorUnit          : currency            read FValorUnit write FValorUnit;
    property TipoProduto        : TTipoProduto        read FTipoProduto write FTipoProduto;
    property ValorCompra        : currency            read FValorCompra write FValorCompra;
    property ValorVenda         : currency            read FValorVenda write FValorVenda;
    property SaldoDisponivel    : integer             read FSaldoDisponivel write FSaldoDisponivel;
    property SaldoVenda         : integer             read FSaldoVenda write FSaldoVenda;
    property NaturezaMercadoria : TNaturezaMercadoria read FNaturezaMercadoria write FNaturezaMercadoria;

  //CONSTRUCTORS
  constructor Create();
  destructor  Destroy;override;

  //PROCEDURES
  procedure SolicitarInformacao();

  //FUNCTIONS
  function ToString() : string;


  end;

implementation

{ TProduto }

constructor TProduto.Create;
begin
  FNome               := '';
  FValorUnit          := 0.00;
  FTipoProduto        := ''; //TTipoProduto
  FValorCompra        := 0.00;
  FValorVenda         := 0.00;
  FSaldoVenda         := 0;
  FSaldoDisponivel    := 0;
  FNaturezaMercadoria := nil;
end;

destructor TProduto.Destroy;
begin

end;

procedure TProduto.SolicitarInformacao;
begin
  write('Nome do produto: ');
  readln(FNome);

  write('Valor unitário: ');
  readln(FValorUnit);

  write('1 - Produto | 2 - Servico: ');
  readln(FTipoProduto);

  write('Valor de compra: ');
  readln(FValorCompra);

  write('Valor de venda: ');
  readln(FValorVenda);

  write('Saldo inicial: ');
  readln(FSaldoDisponivel);

  write('Natureza de mercadoria: ');
  readln(FNaturezaMercadoria);
end;

function TProduto.ToString: String;
begin
  Result := '-------------------------------Produto----------------------------'+sLineBreak+
            'Nome: '+ FNome                                                     +sLineBreak+
            'Valor unitario: ' + FormatCurr('#.#00,00',FValorUnit)              +sLineBreak+
            'Tipo: ' + FTipoProduto                                             +sLineBreak+
            'Valor compra: ' + FValorCompra                                     +sLineBreak+
            'Valor venda: ' + FValorVenda                                       +sLineBreak+
            'Saldo disponivel: ' + FSaldoDisponivel                             +sLineBreak+
            'Natureza: ' + FNaturezaMercadoria                                  +sLineBreak+
            '------------------------------------------------------------------'+sLineBreak;
end;

end.
