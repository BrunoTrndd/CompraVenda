program CompraVenda;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  uPessoa in 'uPessoa.pas',
  uProduto in 'uProduto.pas',
  uEmpresa in 'uEmpresa.pas',
  uOrdem in 'uOrdem.pas',
  uParcela in 'uParcela.pas',
  uEnums in 'uEnums.pas',
  uBaixaParcela in 'uBaixaParcela.pas',
  uOrdemProduto in 'uOrdemProduto.pas';

var FEmpresa  : TEmpresa;
    FIndice   : Integer;
begin
  try
    try
      FEmpresa  := TEmpresa.Create;
      FIndice   := 0;
      repeat
        {MENU:}
        Writeln('--------------------------------------------------------------');
        Writeln('SISTEMA DE COMPRA E VENDA');
        Writeln('--------------------------------------------------------------');
        Writeln('10   : Informacoes iniciais da empresa');
        Writeln('11   : Cadastrar Pessoa      | 12 : Cadastrar Produto    | 13 : Cadastrar Ordem de Compra   | 14 : Cadastrar Ordem de Venda');
        Writeln('21   : Consultar Pessoa      | 22 : Consultar Produto    | 23 : Consultar Ordem de Compra/Venda');
        Writeln('24   : Listar Itens da Ordem |');
        Writeln('31   : Alterar Pessoa        | 32 : Alterar Produto      | 33 : Alterar Ordem de Compra/Venda');
        Writeln('41   : Listar Parcelas de Compra Vencidas                | 42 : Listar Parcelas de Venda Vencidas');
        Writeln('51   : Efetuar Baixa de Parcelas');
        Writeln('--------------------------------------------------------------');
        Readln(FIndice);
        case FIndice of
          10:{Informacoes iniciais da empresa}
            begin
              FEmpresa.SolicitarInformacao();
            end;
          11:{Cadastrar Pessoa}
            begin

            end;
          12:{Cadastrar Produto}
            begin

            end;
          13:{Cadastrar Ordem de Compra}
            begin

            end;
          14:{Cadastrar Ordem de Venda}
            begin

            end;
          21:{Consultar Pessoa}
            begin

            end;
          22:{Consultar Produto}
            begin

            end;
          23:{Consultar Ordem de Compra/Venda}
            begin

            end;
          24:{Listar Itens da Ordem}
            begin

            end;
          31:{Alterar Pessoa}
            begin

            end;
          32:{Alterar Produto}
            begin

            end;
          33:{Alterar Ordem de Compra/Venda}
            begin

            end;
          41:{Listar Parcelas de Compra Vencidas}
            begin

            end;
          42:{Listar Parcelas de Venda Vencidas}
            begin

            end;
          51:{Efetuar Baixa de Parcelas}
            begin

            end;
        end;
      until (FIndice = 0);
    finally

    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
