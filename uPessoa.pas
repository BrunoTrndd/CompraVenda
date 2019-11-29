unit uPessoa;

interface

uses
  Generics.Collections;

type
  TPessoa = class
  public
    FHandle       : Integer;
    FNome         : string;
    FEhCliente    : Boolean;
    FEhFornecedor : Boolean;

    property Nome         : string        read FNome          write FNome;
    property EhCliente    : Boolean       read FEhCliente     write FEhCliente;
    property EhFornecedor : Boolean       read FEhFornecedor  write FEhFornecedor;

    constructor Create();
    destructor Destroy; override;

    //PPROCEDURES
    procedure SolicitarInformacoes();

    //FUNCTIONS
    function ToString(): string; override;

  private
  protected

  end;

implementation

{ TPessoa }

constructor TPessoa.Create();
begin
  FHandle       := 0;
  FNome         := '';
  FEhCliente    := False;
  FEhFornecedor := False;
end;

destructor TPessoa.Destroy;
begin
   inherited;
end;

procedure TPessoa.SolicitarInformacoes;
var vOpcao: Char;
begin
  Writeln('Informe o Nome:');
  Readln(FNome);
  repeat
  Writeln('A Pessoa e um cliente?(S/N)');
  Readln(vOpcao);
  until (vOpcao = 'S') or (vOpcao = 'N');
  case vOpcao of
    'S':  FEhCliente  := True;
    'N':  FEhCliente  := False;
  end;
  repeat
  Writeln('A Pessoa e um fornecedor?(S/N)');
  Readln(vOpcao);
  until (vOpcao = 'S') or (vOpcao = 'N');
  case vOpcao of
    'S':  FEhFornecedor  := True;
    'N':  FEhFornecedor  := False;
  end;
  Writeln('Cadastro concluido com sucesso!');
end;

function TPessoa.ToString: string;
begin
  Writeln('Nome: ' + FNome);
  Write('Cliente: ');
  if EhCliente = True then
    Writeln('Sim')
  else
    Writeln('Não');
  Write('Fornecedor: ');
  if EhFornecedor = True then
    Writeln('Sim')
  else
    Writeln('Não');
end;



end.
