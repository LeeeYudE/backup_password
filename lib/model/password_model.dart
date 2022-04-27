
import 'package:remember_password/utils/json_parse_utils.dart';

class PasswordModel{

	static const TABLE_NAME = 'Password';

	int? ID;
	String? lable;
	String? account;
	String? password;
	int? createTime;

	PasswordModel({this.password,this.lable,this.account,this.createTime});

	Map<String, dynamic> toJson() {
		return Map<String, dynamic>()
			..put('password',this.password)
			..put('lable',this.lable)
			..put('account',this.account)
			..put('createTime',this.createTime)
			..put('ID',this.ID);
	}

	PasswordModel.fromJson(Map json) {
		this.account=json.asString('account');
		this.password=json.asString('password');
		this.lable=json.asString('lable');
		this.createTime=json.asInt('createTime');
		this.ID=json.asInt('ID');
	}

	static PasswordModel toBean(Map json) => PasswordModel.fromJson(json);
}