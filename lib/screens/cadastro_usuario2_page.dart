import 'package:flutter/material.dart';
import 'cadastro_usuario3_page.dart';

class CadastroUsuario2Page extends StatefulWidget {
  const CadastroUsuario2Page({super.key});

  @override
  State<CadastroUsuario2Page> createState() => _CadastroUsuario2PageState();
}

class _CadastroUsuario2PageState extends State<CadastroUsuario2Page> {
  final idadeController = TextEditingController();
  final alturaController = TextEditingController();
  final pesoController = TextEditingController();

  String? sexoSelecionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.indigo,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Cadastro de usuário',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 30),

                campoComRotulo('Idade:', idadeController, tipo: TextInputType.number),
                const SizedBox(height: 15),

                // Campo Sexo como Dropdown
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sexo:',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.indigo,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black, width: 1.3),
                      ),
                      child: DropdownButton<String>(
                        value: sexoSelecionado,
                        isExpanded: true,
                        underline: Container(),
                        hint: const Text('Selecione'),
                        items: <String>['Masculino', 'Feminino'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (novoValor) {
                          setState(() {
                            sexoSelecionado = novoValor;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                campoComRotulo('Altura (cm):', alturaController, tipo: TextInputType.number),
                const SizedBox(height: 15),

                campoComRotulo('Peso (kg):', pesoController, tipo: TextInputType.number),
                const SizedBox(height: 40),

                SizedBox(
                  width: 160,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.black, width: 1.5),
                      elevation: 3,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CadastroUsuario3Page(),
                        ),
                      );
                    },
                    child: const Text(
                      'Avançar',
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget campoComRotulo(String rotulo, TextEditingController controller,
      {TextInputType tipo = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          rotulo,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.indigo,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black, width: 1.3),
          ),
          child: TextField(
            controller: controller,
            keyboardType: tipo,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
