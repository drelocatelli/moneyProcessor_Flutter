import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Slide {

  final String imageUrl;
  final String title;
  final String description;

  Slide({
    required this.imageUrl,
    required this.title,
    required this.description
  });

  static final colors = [
    {
      "color": Colors.cyan
    },
    {
      "color": Colors.lime
    },
    {
      "color": Colors.lightGreen
    },
    {
      "color": Colors.purpleAccent
    },
    {
      "color": Colors.cyan
    },
  ];

  static final slideList = [
    Slide(
      imageUrl: "images/um.png",
      title: "Organize suas contas onde estiver",
      description: "Simples, fácil de usar e gratuito.",
    ),
    Slide(
        imageUrl: "images/dois.png",
        title: "Organize suas contas onde estiver",
        description: "Simples, fácil de usar e gratuito."
    ),
    Slide(
        imageUrl: "images/tres.png",
        title: "Saiba para onde vai seu dinheiro",
        description: "Vendo o destino de cada centavo."
    ),
    Slide(
        imageUrl: "images/quatro.png",
        title: "Nunca mais esqueça de pagar as contas",
        description: "Anote o futuro!"
    ),
    Slide(
        imageUrl: "images/cadastro.png",
        title: "Junte-se a nós",
        description: "Comece criando uma conta ou entre."
    ),
  ];

}