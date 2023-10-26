import 'package:flutter/material.dart';
import 'package:responsi/bloc/tugas_bloc.dart';
import 'package:responsi/model/tugas.dart';
import 'package:responsi/ui/tugas_form.dart';
import 'package:responsi/ui/tugas_page.dart';
import 'package:responsi/widget/warning_dialog.dart';

class TugasDetail extends StatefulWidget {
  Tugas? tugas;

  TugasDetail({Key? key, this.tugas}) : super(key: key);

  @override
  _TugasDetailState createState() => _TugasDetailState();
}

class _TugasDetailState extends State<TugasDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Tugas : Charinta'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Title : ${widget.tugas!.title}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Description : ${widget.tugas!.description}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Deadline : ${widget.tugas!.deadline}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TugasForm(
                  tugas: widget.tugas!,
                ),
              ),
            );
          },
        ),
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        // Tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            TugasBloc.deleteTugas(widget.tugas!.id).then((value) {
              if (value) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const TugasPage(),
                ));
              } else {
                showDialog(
                  context: context,
                  builder: (context) => const WarningDialog(
                    description: "Gagal menghapus data. Silakan coba lagi.",
                  ),
                );
              }
            }).catchError((error) {});

            Navigator.pop(context);
          },
        ),
        // Tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
