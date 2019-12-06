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
    function BoolToString(prBool: Boolean): string;

  private
  protected

  end;

var
  vHandle : Integer;

implementation

{ TPessoa }

function TPessoa.BoolToString(prBool: Boolean): string;
begin
  if prBool = True then
    Result  :=  'Sim'
  else
    Result  :=  'Nao';
end;

constructor TPessoa.Create();
begin
  vHandle       := vHandle +1;
  FHandle       := vHandle;
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
  Writeln('Nome       : ' + FNome);
  Writeln('Cliente    : ' + BoolToString(EhCliente));
  Writeln('Fornecedor : ' + BoolToString(EhFornecedor));
end;

end.
