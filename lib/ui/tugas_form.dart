import 'package:flutter/material.dart';
import 'package:responsi/bloc/tugas_bloc.dart';
import 'package:responsi/model/tugas.dart';
import 'package:responsi/ui/tugas_page.dart';
import 'package:responsi/widget/warning_dialog.dart';

class TugasForm extends StatefulWidget {
  Tugas? tugas;

  TugasForm({Key? key, this.tugas}) : super(key: key);

  @override
  _TugasFormState createState() => _TugasFormState();
}

class _TugasFormState extends State<TugasForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH TUGAS";
  String tombolSubmit = "SIMPAN";

  final _titleTextboxController = TextEditingController();
  final _descriptionTextboxController = TextEditingController();
  final _deadlineTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.tugas != null) {
      setState(() {
        judul = "UBAH TUGAS : Charinta";
        tombolSubmit = "UBAH";
        _titleTextboxController.text = widget.tugas!.title!;
        _descriptionTextboxController.text = widget.tugas!.description!;
        _deadlineTextboxController.text = widget.tugas!.deadline!;
      });
    } else {
      judul = "TAMBAH TUGAS : Charinta";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _titleTextField(),
                _descriptionTextField(),
                _deadlineTextField(),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Title"),
      keyboardType: TextInputType.text,
      controller: _titleTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Title harus diisi";
        }
        return null;
      },
    );
  }

  Widget _descriptionTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Description"),
      keyboardType: TextInputType.text,
      controller: _descriptionTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Description harus diisi";
        }
        return null;
      },
    );
  }

  Widget _deadlineTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Deadline"),
      keyboardType: TextInputType.number,
      controller: _deadlineTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Deadline harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
      child: Text(tombolSubmit),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.tugas != null) {
              //kondisi update tugas
              ubah();
            } else {
              //kondisi tambah tugas
              simpan();
            }
          }
        }
      },
    );
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Tugas createTugas = Tugas(id: null);
    createTugas.title = _titleTextboxController.text;
    createTugas.description = _descriptionTextboxController.text;
    createTugas.deadline = _deadlineTextboxController.text;
    TugasBloc.addTugas(tugas: createTugas).then((value) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => const TugasPage(),
        ),
      );
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Tugas updateTugas = Tugas(id: null);
    updateTugas.id = widget.tugas!.id;
    updateTugas.title = _titleTextboxController.text;
    updateTugas.description = _descriptionTextboxController.text;
    updateTugas.deadline = _deadlineTextboxController.text;
    TugasBloc.updateTugas(tugas: updateTugas).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const TugasPage()));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Permintaan ubah data gagal, silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }
}
