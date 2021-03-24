import 'package:flutter/material.dart';

class AlertaCalculoTotalComBebida extends StatelessWidget {
  final title;
  final valorFinalPessoasQueBeberam;
  final valorFinalPessoasQueNaoBeberam;

  AlertaCalculoTotalComBebida(this.title, this.valorFinalPessoasQueBeberam,
      this.valorFinalPessoasQueNaoBeberam);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Pessoas que beberam: $valorFinalPessoasQueBeberam reais'),
            Text(
                'Pessoas que não beberam: $valorFinalPessoasQueNaoBeberam reais'),
          ],
        ),
      ),
      actions: [
        new ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Ok'))
      ],
    );
  }
}

class AlertaCalculoTotalSemBebida extends StatelessWidget {
  final title;
  final valorFinal;
  AlertaCalculoTotalSemBebida(this.title, this.valorFinal);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Cada um deve pagar: $valorFinal reais'),
          ],
        ),
      ),
      actions: [
        new ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Ok'))
      ],
    );
  }
}

class AlertaCampoInvalido extends StatelessWidget {
  final title;
  final content;
  AlertaCampoInvalido(this.title, this.content);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        new ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Ok'))
      ],
    );
  }
}
