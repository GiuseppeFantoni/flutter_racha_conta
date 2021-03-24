import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "Racha Conta";
  var valorTotalConta = 0.0;
  var numeroTotalPessoas = 0;
  var valorTotalBebidas = 0.0;
  var numeroPessoasQueBeberam = 0;
  var _currentSliderValue = 10;


  double tratamentoFloat(String number) {
    if (number == '') return 0.0;
    return double.parse(number.replaceAll(',', '.'));
  }

  int tratamentoInt(String number) {
    if (number == '') return 0;
    return int.parse(number);
  }

  dynamic calculoSemBebida() {
    var gorjeta = _currentSliderValue / 100;
    var result = (valorTotalConta / numeroTotalPessoas) * (1 + gorjeta);

    return result.toStringAsFixed(2);
  }

  Map<String, dynamic> calculoComBebida() {
    var gorjeta = _currentSliderValue / 100;
    var valorDeQuemSohComeu =
        (valorTotalConta / numeroTotalPessoas) * (1 + gorjeta);
    var valorDeQuemComeuBebeu = ((valorTotalBebidas / numeroPessoasQueBeberam) +
        (valorTotalConta / numeroTotalPessoas)) *
        (1 + gorjeta);

    return {
      "pessoas_que_beberam": valorDeQuemComeuBebeu.toStringAsFixed(2),
      "pessoas_que_nao_beberam": valorDeQuemSohComeu.toStringAsFixed(2)
    };
  }

  showDialogs() {
    if (valorTotalConta == 0) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertaCampoInvalido(
                "Campo Invalido:", "Favor verificar o valor total da conta");
          });
      return;
    }

    if (numeroTotalPessoas == 0.0) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertaCampoInvalido(
                "Campo Invalido:", "Favor verificar o número total de pessoas");
          });
      return;
    }

    if (valorTotalBebidas == 0.0 && numeroPessoasQueBeberam == 0) {
      var valorFinal = calculoSemBebida();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertaCalculoTotalSemBebida("Total a pagar:", valorFinal);
          });
      return;
    }

    if (valorTotalBebidas == 0) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertaCampoInvalido("Campo Invalido:",
                "Favor verificar o valor total da conta das bebidas");
          });
      return;
    }

    if (numeroPessoasQueBeberam == 0.0) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertaCampoInvalido("Campo Invalido:",
                "Favor verificar o número total de pessoas que beberam");
          });
      return;
    }

    var valorFinal = calculoComBebida();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertaCalculoTotalComBebida(
              "Total a pagar:",
              valorFinal['pessoas_que_beberam'],
              valorFinal['pessoas_que_nao_beberam']);
        });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 10.0),
                        child: Text("Digite o Valor da Conta(Sem as bebidas):",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.w500))),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                      child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.lunch_dining,
                                size: 20.0,
                                color: Colors.blue,
                              ),
                            ),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 23, maxHeight: 20),
                            isDense: true,
                          ),
                          keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\,?\d{0,2}')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              valorTotalConta = tratamentoFloat(value);
                            });
                          }),
                    ),
                  ],
                )),
            Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 10.0),
                        child: Text("Digite o Número Total de Pessoas:",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.w500))),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                      child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.people_outline_sharp,
                                size: 20.0,
                                color: Colors.blue,
                              ),
                            ),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 23, maxHeight: 20),
                            isDense: true,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) {
                            setState(() {
                              numeroTotalPessoas = tratamentoInt(value);
                            });
                          }),
                    ),
                  ],
                )),
            Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 10.0),
                        child: Text("Digite o Valor da Conta das Bebidas:",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.w500))),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                      child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.local_bar,
                                size: 20.0,
                                color: Colors.blue,
                              ),
                            ),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 23, maxHeight: 20),
                            isDense: true,
                          ),
                          keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\,?\d{0,2}')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              valorTotalBebidas = tratamentoFloat(value);
                            });
                          }),
                    ),
                  ],
                )),
            Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 10.0),
                        child: Text("Digite o Número Total de Pessoas que Beberam:",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.w500))),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                      child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.people_rounded,
                                size: 20.0,
                                color: Colors.blue,
                              ),
                            ),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 23, maxHeight: 20),
                            isDense: true,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) {
                            setState(() {
                              numeroPessoasQueBeberam = tratamentoInt(value);
                            });
                          }),
                    ),
                  ],
                )),
            Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(25.0, 10.0, 15.0, 0.0),
                        child: Text("Informe a Porcentagem da Gorjeta:",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.w500))),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 1.5,
                        ),
                        child: Slider(
                            activeColor: Colors.pink,
                            inactiveColor: Colors.grey[200],
                            max: 100,
                            min: 0,
                            divisions: 20,
                            value: _currentSliderValue.toDouble(),
                            label: _currentSliderValue.round().toString(),
                            onChanged: (value) {
                              setState(() {
                                _currentSliderValue = value.toInt();
                              });
                            }),
                      ),
                    ),
                  ],
                )),
            ElevatedButton(
              onPressed: () {
                showDialogs();
              },
              child: Text('Calcular valor'),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  textStyle:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
