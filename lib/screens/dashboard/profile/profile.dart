import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smarter/models/exception.dart';
import 'package:smarter/models/user/change_profile_request.dart';
import 'package:smarter/models/user/user_response.dart';
import 'package:smarter/screens/authentication/sign_in/sign_in.dart';
import 'package:smarter/services/storage_service.dart';
import 'package:smarter/services/user_service.dart';
import 'package:smarter/utils/toast_builder.dart';
import 'package:smarter/utils/validator.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

enum Gender { male, female }

class _ProfileState extends State<Profile> {
  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();
  final UserService _userService = const UserService();
  final StorageService _storageService = StorageService();
  final Validator _validator = const Validator();
  final ToastBuilder _toastBuilder = const ToastBuilder();
  String? _avtUrl, _name, _newPassword, _confirmedPassword;
  Gender? _gender;
  DateTime? _dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Tài khoản")),
      body: FutureBuilder<UserResponse>(
        future: _userService.getCurrentUser(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          UserResponse user = snapshot.data!;
          _name ??= user.name;
          if (user.gender != null) {
            user.gender! == "MALE"
                ? _gender ??= Gender.male
                : _gender ??= Gender.female;
          }
          if (user.imageUrl != null) {
            _avtUrl ??= user.imageUrl!;
          }
          if (user.dateOfBirth != null) {
            _dateTime ??= DateTime.tryParse(user.dateOfBirth!);
          }
          return SingleChildScrollView(
            reverse: true,
            child: Center(
              child: SizedBox(
                width: 380,
                child: Form(
                    key: _globalFormKey,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Center(
                            child: GestureDetector(
                              onTap: () async {
                                final results = await FilePicker.platform
                                    .pickFiles(
                                        allowMultiple: false,
                                        type: FileType.custom,
                                        allowedExtensions: [
                                      'png',
                                      'jpg',
                                      'jpeg'
                                    ]);
                                if (results == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Bạn không chọn ảnh nào!")));
                                  return;
                                }
                                final path = results.files.single.path!;
                                final fileName = results.files.single.name;
                                await _storageService.uploadFile(
                                    path, fileName);
                                final newUrl =
                                    await _storageService.downloadUrl(fileName);
                                setState(() {
                                  _avtUrl = newUrl;
                                });
                              },
                              child: _avtUrl != null
                                  ? CircleAvatar(
                                      radius: 60,
                                      backgroundImage: NetworkImage(_avtUrl!),
                                      backgroundColor: Colors.transparent,
                                    )
                                  : CircleAvatar(
                                      radius: 60,
                                      backgroundColor: Colors.red,
                                      child: Text(
                                        _getTheFirstLetterOfName(user.name),
                                        style: const TextStyle(
                                            fontSize: 55, color: Colors.white),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.person,
                                    size: 24,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    "Mời bạn nhập tên",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 375,
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  validator: (input) =>
                                      input!.isEmpty || input.trim().isEmpty
                                          ? "Mời bạn nhập tên"
                                          : null,
                                  initialValue: _name,
                                  onSaved: (input) => _name = input!.trim(),
                                  decoration: const InputDecoration(
                                      hintText: "Họ và tên"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              const Spacer(),
                              const Icon(
                                Icons.transgender,
                                size: 24,
                                color: Colors.blue,
                              ),
                              const Text(
                                "Giới tính",
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                width: 297,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: ListTile(
                                        title: Transform.translate(
                                          offset: const Offset(-20, 0),
                                          child: const Text('Nam'),
                                        ),
                                        leading: Radio<Gender>(
                                          value: Gender.male,
                                          groupValue: _gender,
                                          onChanged: (Gender? value) {
                                            setState(() {
                                              _gender = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: ListTile(
                                        title: Transform.translate(
                                          offset: const Offset(-20, 0),
                                          child: const Text('Nữ'),
                                        ),
                                        leading: Radio<Gender>(
                                          value: Gender.female,
                                          groupValue: _gender,
                                          onChanged: (Gender? value) {
                                            setState(() {
                                              _gender = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.date_range,
                                size: 24,
                                color: Colors.blue,
                              ),
                              const Text(
                                "Ngày sinh",
                                style: TextStyle(fontSize: 16),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: GestureDetector(
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1975),
                                              lastDate: DateTime(2030))
                                          .then((value) {
                                        setState(() {
                                          _dateTime = value;
                                        });
                                      });
                                    },
                                    child: Text(
                                      _dateTime == null
                                          ? "Chọn ngày sinh"
                                          : _dateTime
                                                  .toString()
                                                  .substring(0, 10) +
                                              " (chạm để thay đổi)",
                                      style: const TextStyle(fontSize: 16),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.lock,
                                    size: 24,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    "Mật khẩu mới",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 375,
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  keyboardType: TextInputType.text,
                                  maxLength: 20,
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.enforced,
                                  validator: (input) => input != ""
                                      ? input!.length < 8
                                          ? "Mật khẩu phải chứa 8 đến 20 ký tự"
                                          : !_validator.isPasswordValid(input)
                                              ? "Mật khẩu chứa ít nhất 1 chữ hoa, 1 chữ thường và 1 chữ số"
                                              : null
                                      : null,
                                  onSaved: (input) => _newPassword = input,
                                  obscureText: true,
                                  decoration:
                                      const InputDecoration(hintText: ""),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.lock,
                                    size: 24,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    "Xác nhận mật khẩu mới",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 375,
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  keyboardType: TextInputType.text,
                                  onSaved: (input) =>
                                      _confirmedPassword = input,
                                  obscureText: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            _changeProfile();
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              fixedSize: MaterialStateProperty.all<Size>(
                                  const Size(330, 50))),
                          child: const Text(
                            "Lưu thông tin",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement<void, void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const SignIn(),
                              ),
                            );
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              fixedSize: MaterialStateProperty.all<Size>(
                                  const Size(330, 50)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                          child: const Text(
                            "Đăng xuất",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom))
                      ],
                    )),
              ),
            ),
          );
        },
      ),
    );
  }

  String _getTheFirstLetterOfName(String name) {
    List<String> splittedName = name.split(" ");
    return splittedName[splittedName.length - 1][0];
  }

  bool _validateAndSave() {
    final form = _globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _changeProfile() {
    if (_validateAndSave()) {
      ChangeProfileRequest request = ChangeProfileRequest(
          name: _name!,
          imageUrl: _avtUrl,
          gender: _gender?.toString().substring(7),
          birthdate: _dateTime?.toString().substring(0, 10),
          newPassword: _newPassword,
          confirmedPassword: _confirmedPassword);
      _userService.changeProfile(request).then((value) => {
            if (value is Exception)
              {_toastBuilder.build(value.message)}
            else
              {_toastBuilder.build("Cập nhật thông tin thành công")}
          });
    }
  }
}
