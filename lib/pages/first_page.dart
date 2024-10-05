import 'package:flutter/material.dart';
import 'package:freshers/util/smart_device_box.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'subject_page.dart';

import 'info.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final double horizontalPadding = 40;
  final double verticalPadding = 25;
  String user_name_input = '';

  List<Pdf> mathPdfs = [];
  List<Pdf> chemistryPdfs = [];
  List<Pdf> emPdfs = [];
  List<Pdf> bcePdfs = [];
  List<Pdf> pyqPdfs = [];
  List<Pdf> engPdfs = [];
  List<Pdf> beePdfs = [];
  List<Pdf> plcPdfs = [];
  List<Pdf> bmePdfs = [];
  List<Pdf> phyPdfs = [];
  List<Pdf> bePdfs = [];
  List<Pdf> edPdfs = [];


  List mySmartDevices = [];

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _initializeSmartDevices();
  }

  void _loadUserName() async {
    String userName = await getUserName();
    setState(() {
      user_name_input = userName;
    });
  }

  void _initializeSmartDevices() {
    mathPdfs = [
      Pdf(name: "B V Ramana", url: "https://drive.google.com/file/d/1g3qelDEhxIrnchZKTNP1aLRlGrsinSKV/view?usp=sharing", icon: Icons.picture_as_pdf),
      Pdf(name: "Differential Equations - i", url: "https://drive.google.com/file/d/160JtdpvtxXFMrrFBVL7MxCULx4vhbCvn/view?usp=drive_link", icon: Icons.picture_as_pdf),
      Pdf(name: "Differential Equations - ii", url: "https://drive.google.com/file/d/1U8l6MQ7EhndmCINCOUGtV4tM8DV8TzWZ/view?usp=drive_link", icon: Icons.picture_as_pdf),
      Pdf(name: "Matrix - i", url: "https://drive.google.com/file/d/1AhfuC6Z4A03l3hfEXg1KbwI4S3poEx4D/view?usp=sharing", icon: Icons.picture_as_pdf),
      Pdf(name: "Matrix - ii", url: "https://drive.google.com/file/d/18rRymd-Z-2B1MnUb4IAiYWNxpj7wti1b/view?usp=drive_link", icon: Icons.picture_as_pdf),
      Pdf(name: "Vector Differential Calculus", url: "https://drive.google.com/file/d/1Dm-k7ClcIohJiaL49r5yMvk7gy-Ajc4v/view?usp=drive_link", icon: Icons.picture_as_pdf),
      Pdf(name: "Semester - ii", url: "https://drive.google.com/file/d/1RItYfRjUft_8BGSnnCwPqq8c2iqqwBd5/view?usp=drive_link", icon: Icons.picture_as_pdf),
      Pdf(name: "Dr.Gajendra Purohit", url: "https://youtube.com/playlist?list=PLU6SqdYcYsfINU_Y9CMp1pZ827ZB1U-Xn&si=th4FTjQyY6hHJFby", icon: Icons.play_circle),
      Pdf(name: "Pradeep Giri Academy", url: "https://youtube.com/playlist?list=PLT3bOBUU3L9hsRRQi1X_4kn6Lw6K_-9cq&si=51ofQ7J4MDDvATgg", icon: Icons.play_circle),
    ];
  chemistryPdfs = [
    Pdf(name: "Corrosion", url: "https://drive.google.com/file/d/191OS9ImtS_1hTHcO7yEooianqsaCXbKd/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Fuel", url: "https://drive.google.com/file/d/19B84Ph4nYhHpfxzdx1Ms_2KtCO8_Omza/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Nanochemistry", url: "https://drive.google.com/file/d/1M5VwpvnAAeCgx0XK6bfVNcKW1lVu3a5q/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Quantum Chemistry", url: "https://drive.google.com/file/d/1HwjYytXGFPw7cvQugBt3ntPuyHnsoJ8G/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Spectroscopy", url: "https://drive.google.com/file/d/1Mlj0W2eId7KCVVlGKatgcBPs5vC4Z_5V/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Complete Chemistry Notes", url: "https://drive.google.com/file/d/1MNVpCz84rHxgUP4Mr09gUulcMVDcaWc7/view?usp=sharing", icon: Icons.picture_as_pdf),
    Pdf(name: "Chemistry Lab Manual", url: "https://drive.google.com/file/d/1Anloj5QAzffNTiNCrX7IVmbiNMVS9PBG/view?usp=sharing", icon: Icons.picture_as_pdf),
  ];
  phyPdfs = [
    Pdf(name: "Principles of Engineering Physics", url: "https://drive.google.com/file/d/1MjStV2NNnaKXe4wTObZyLjt2fDZ3bOAz/view?usp=sharing", icon: Icons.picture_as_pdf),
    Pdf(name: "Newtons Laws Of Motion", url: "https://drive.google.com/file/d/1AmLVa7KQ2VONfU-xMQAPuDi42ucEnBB-/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Laser", url: "https://drive.google.com/file/d/1AchtLtd-BF85l_3dIazOYkOoZ-0grKL1/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Vector Calculus", url: "https://drive.google.com/file/d/1Ao82a-aluZ7PbgkSHaJBv4x8-S2Xra0z/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Vector Calculus - ii", url: "https://drive.google.com/file/d/1Res22UGEgr6Z1hq_pNGyUhT4lvL1bFpw/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Quantum Physics", url: "https://drive.google.com/file/d/11CQgSR81jA-TcIT2Cub8tPLfEqBC3ZUu/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Oscillation", url: "https://drive.google.com/file/d/1dhRAwF--MLawpPDxBzK5W2EpM8RQwLlg/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Oscillation waves", url: "https://drive.google.com/file/d/1hH0Y1a4ibm5EWna4FqcpPG9u4R8cG2Ge/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Optics", url: "https://drive.google.com/file/d/11LUmx0kd83do73D3B4DEvFHF8popaDCj/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Laser - ii", url: "https://drive.google.com/file/d/1PzuB9p5h6n6yy09WUVKr0nMtilV90nJP/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Laser and Fibre Optics", url: "https://drive.google.com/file/d/1bY4WIIFQHRJoWvEAOJQ10amio0ZAQ1L2/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Electromagnetism", url: "https://drive.google.com/file/d/1rVLIWjtMs-YMFZvGDGu9AC4Z2bD6HYdh/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Black Body", url: "https://drive.google.com/file/d/13tkWt40GulUsU5dCv-16xGL8TlEYkQj7/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Black Body Radiation", url: "https://drive.google.com/file/d/1gDhqf1SKkTy_WT1E_GdhHbwVqJdN0xMq/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Wave nature of particle", url: "https://drive.google.com/file/d/1TOFDrsSE5xeuE5ANfyopYSyh7wJrKGwq/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Compton Effect", url: "https://drive.google.com/file/d/1nbxCc0rAzQLItMRCuhLAijtDPSHi0p5B/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Damped Harmonic Oscillation", url: "https://drive.google.com/file/d/13ut22WBgspjBessSbO-IemCSHzuB5Jh8/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Lab Manual", url: "https://drive.google.com/file/d/1Fay8vy0x9XVJKPu9vgHi3TO4hPYr2n-W/view?usp=sharing", icon: Icons.picture_as_pdf),

  ];
  emPdfs = [
    Pdf(name: "Engineering Mechanics By R S Khurmi", url: "https://drive.google.com/file/d/1nf2X3NVkdqzrYff2TrdJ48klPwZ7J_Dm/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Module 1", url: "https://drive.google.com/file/d/1eTPh2QaRq9Id_56CrZi8fNAOn1LGC50P/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Module 2", url: "https://drive.google.com/file/d/1d7rql9xl8zDPY5P7JFRqVubZnA0KcLoI/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Module 3", url: "https://drive.google.com/file/d/1boRY3Or7Zw5LlK_d9LIrVzpyhcAdEoo_/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Module 4", url: "https://drive.google.com/file/d/15xBwo7DIHbJM261kf5ASRN5nBJDHKxv4/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Module 5 & 7", url: "https://drive.google.com/file/d/1tGd3y89Mt0P3BrjMotycpEMBf6hlT5dw/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Module 6", url: "https://drive.google.com/file/d/1Lpm9qxq2gLGZejYFwbFEE1dgt5KID3mJ/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Questions", url: "https://drive.google.com/file/d/1ioRgAJw2_AB5dyGDLIdm53Sn5yX__lrm/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "GATE Wallah", url: "https://youtube.com/playlist?list=PLPvaSRcEQh4lfyQYKBRuTiLekgVIw2jvC&si=gwtBaMRjRC8cSm5_", icon: Icons.play_circle),
    Pdf(name: "TIKLE'S ACADEMY", url: "https://youtube.com/playlist?list=PLDN15nk5uLiAyM7MbRBF1eIFC8y5vMRxI&si=TmqSINOwS6iG6jL2", icon: Icons.play_circle),
  ];
  bcePdfs = [
    Pdf(name: "Module 3 & 4", url: "https://drive.google.com/file/d/1dA3S8-VK8AmYQI5IJ4EPKWjtIB48T9Bk/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Complete BCE notes", url: "https://drive.google.com/file/d/18EunJ-Byz-DAHLOPDb-qTuMnb1LklYhg/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Building materials", url: "https://drive.google.com/file/d/1A7uhs8Q5wox-pwVZplwu6k3O1vSLzmiV/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Mechanics 1", url: "https://drive.google.com/file/d/1ERwoP5K6k8VyGBJVny8KChjF0i4kgrUE/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Mechanics 2", url: "https://drive.google.com/file/d/1EXiY40WhCQivylO7pZY6HUjiG87gE-M3/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Mechanics 3", url: "https://drive.google.com/file/d/1GUnyQhz4Nh_yF-ab5NvsMsoiTXQUckNy/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Mechanics 4", url: "https://drive.google.com/file/d/1M0T7P_SYtk5dKKDcEeudt8H3ZRauJYaj/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Mechanics 5", url: "https://drive.google.com/file/d/1M4O7Jd0Oj12Xh2L4ZwXnNczIW3t3qdd5/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Lab Manual", url: "https://drive.google.com/file/d/1CK60LFTARFjOuOVydkpqdemKir4r9tlB/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Lab Record", url: "https://drive.google.com/file/d/1v6wtmsww7ghFtEXJgxkCMrQig6zyr7VH/view?usp=sharing", icon: Icons.picture_as_pdf),
    Pdf(name: "TIKLE'S ACADEMY", url: "https://youtube.com/playlist?list=PLDN15nk5uLiAyM7MbRBF1eIFC8y5vMRxI&si=TmqSINOwS6iG6jL2", icon: Icons.play_circle),
  ];
  pyqPdfs = [
    Pdf(name: "2019-20 (1st)", url: "https://drive.google.com/file/d/1CCNpq5oKQem1dXS6-LxkOi514J8soSdy/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "2021-22 (1st)", url: "https://drive.google.com/file/d/1KJtCu8F-ANEh18zNRqcTplyWrpxjMnKc/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "2021-22 (2nd)", url: "https://drive.google.com/file/d/1FYhkuFSQl6yUWn6CycCXmZsSk2q8fE3E/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "2022-23 (2nd)", url: "https://drive.google.com/file/d/1BV2OhpvCJrcD1X5ARkAEdSdj5VQo-ivW/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "2023-24 (1st)", url: "https://drive.google.com/file/d/1CU70gmWN0PNa1u6rBJrP7yIpCOMEspi3/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "2023-24 (2nd)", url: "https://drive.google.com/file/d/154zl6p-D026LuHehpCiUrmx2PNFpSQxj/view?usp=sharing", icon: Icons.picture_as_pdf),
    Pdf(name: "Folder 1", url: "https://drive.google.com/drive/folders/1Eb8aQ-4G_-yp5f0D9Xxo_LJyOztH4axY", icon: Icons.folder),
    Pdf(name: "Internal - i", url: "https://drive.google.com/file/d/1N4fv7xc-A0DYmfbBsHjWvLIJqxNxKZZm/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Internal - ii", url: "https://drive.google.com/file/d/1S7vd69VO6uO6rTJuEHhjWw2VVDJj6ypW/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Internal - iii", url: "https://drive.google.com/file/d/1g2oeQ9zYkjTDaT7M9CfZYH-RwA0puCyY/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Internal - iv", url: "https://drive.google.com/file/d/1-11WZicmbVMLkmwewxKWtCd4VxL85Jhs/view?usp=drive_link", icon: Icons.picture_as_pdf),

  ];
  engPdfs = [
    Pdf(name: "Complete English notes", url: "https://drive.google.com/file/d/1ao9N9wbm1M6hevVqPTjtkWLapsRfkplC/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Communication", url: "https://drive.google.com/file/d/1HLJRpQdXejj8-wWp00iBTsETfmpeL50o/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Notes - ii", url: "https://drive.google.com/file/d/1T8SRjm1cQRfR8Dd5FgKkpJdEPyVc5ZaS/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Module - 4", url: "https://drive.google.com/file/d/1HHijPrqDs-XPWBj3k7WIebaM93cDz6EY/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Module - 2", url: "https://drive.google.com/file/d/1YXizI3z4KV9ZlTfPcYY3f5R0dRAzyBGh/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Handwritten notes", url: "https://drive.google.com/file/d/1RNiSbxGiJKkpIk71eCcDQb6tI6Xe5ZW8/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Writing", url: "https://drive.google.com/file/d/178Csg1nerwS7uBNy6NUNY1Bx-Prs5YXc/view?usp=drive_link", icon: Icons.picture_as_pdf),
  ];
  edPdfs = [
    Pdf(name: "Development of surfaces", url: "https://drive.google.com/file/d/1I5TjHpiwV-uBMi3evn-GTKMNs4cQBBa-/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Projection of Plane & Solid", url: "https://drive.google.com/file/d/1rBYYttlYnBm-_ETBGRZxP-1uU7fRDcD8/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Folder 1", url: "https://drive.google.com/drive/folders/16hfgIWOv97w8M4xkREgYLOg1fkdTUv-z", icon: Icons.folder),
    Pdf(name: "Folder 2", url: "https://drive.google.com/drive/folders/1rytQzlDB8r-AsBYQTOE07XAvgFRJgM74", icon: Icons.folder),

  ];
  bePdfs = [
    Pdf(name: "Signal", url: "https://drive.google.com/file/d/17xrCZLPUtr0GMqEuwmsg0pVfANOeX22Y/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "OpAmp", url: "https://drive.google.com/file/d/1828IQpmgxjP5pP0I24D3EYZeruSWOaQA/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Semiconductor", url: "https://drive.google.com/file/d/182NHwACgjK4LRVihvo53YAdynWq3_to0/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "BJT", url: "https://drive.google.com/file/d/183USvFvrw-Nlb0ADcFBrnfS6D55cOOdx/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Digital Electronics", url: "https://drive.google.com/file/d/186JHxMFvu8BjTMgSYtaYKOE7FqRFNX98/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Mosfet", url: "https://drive.google.com/file/d/186TA222D1rMlwb8RTBNZH9uOh0travoS/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Lab manual", url: "https://drive.google.com/file/d/1G8QKoG057P3qEMCtfZVWNHXCxIwjhxl_/view?usp=sharing", icon: Icons.picture_as_pdf),
    Pdf(name: "Lab experiments", url: "https://drive.google.com/drive/folders/1L0iNGnPamTqZXJzWtTNoEKJJZnsMMsS3", icon: Icons.folder),
    Pdf(name: "ALL ABOUT ELECTRONICS", url: "https://www.youtube.com/@ALLABOUTELECTRONICS", icon: Icons.play_circle),
    Pdf(name: "Neso Academy", url: "https://www.youtube.com/playlist?list=PLBlnK6fEyqRiw-GZRqfnlVIBz9dxrqHJS", icon: Icons.play_circle),

  ];
  beePdfs = [
    Pdf(name: "Module - 1", url: "https://drive.google.com/file/d/1Ow5cexHCnRkM1ESPPMglLAgVWVl2Q4oV/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Module - 2", url: "https://drive.google.com/file/d/1PERMPxMBSWIlYtaxoQeF_TZYvm6yb4iy/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Module - 3", url: "https://drive.google.com/file/d/1PFLu7tqv_bz-4e5Pgib2VfmFW-ukN1m-/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Module - 4", url: "https://drive.google.com/file/d/13zCJ-jSqe7lkqW2MfqD3bSxUyo_HSq56/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "BEE Complete notes", url: "https://drive.google.com/file/d/1s6-fIlARcS18_8E3K4MKPHMfDqmcuZiy/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Induction Motor", url: "https://drive.google.com/file/d/1WSPYkL-sRxuQgho5a_zbuZjsju1Z3xtO/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Engineers ki Pathshala", url: "https://www.youtube.com/playlist?list=PL9RcWoqXmzaLTYUdnzKhF4bYug3GjGcEc", icon: Icons.play_circle),

  ];
  bmePdfs = [
    Pdf(name: "Engine", url: "https://drive.google.com/file/d/17SgRVNpAUxw_i9qdnkkLbCghBeTgPJpC/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Power Plant - i", url: "https://drive.google.com/file/d/17TCmZKoNFTTKlLYHXWH0Ev47V4bBCrf1/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Power Plant - ii", url: "https://drive.google.com/file/d/1hUjQCOBuh_qBrtoghO1JoukYt5nkRRkX/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Cam and Follower", url: "https://drive.google.com/file/d/17YDpaJQhcmHwQGOeIasdJUg6Po3CAUQ8/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Belt drive", url: "https://drive.google.com/file/d/17YKnvWEca6xyUF4plOtj7pAKOFnGKAuq/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Gear - i", url: "https://drive.google.com/file/d/17a4DFNJsOyz7cGxEfx9THbgb4HwKKc3x/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Gear - ii", url: "https://drive.google.com/file/d/17Q0ALob-u_YyIzKgCdXAszL0TpbfXVJd/view?usp=sharing", icon: Icons.picture_as_pdf),
    Pdf(name: "engine", url: "https://drive.google.com/file/d/17SgRVNpAUxw_i9qdnkkLbCghBeTgPJpC/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Gear Train", url: "https://drive.google.com/file/d/17hYcEYRjrfErVNhLNE84rUbtXxA67BOz/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Lathe", url: "https://drive.google.com/file/d/17fX5ShSb7sjA0WxYsB0ZDEveGM2Lo7oq/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Extra", url: "https://drive.google.com/file/d/17hn_FVfzbvoWXhRiVsTYNHrd6DdOAl7j/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Pratical(old)", url: "https://drive.google.com/file/d/18sIpMR-h-JbaIl9BaEXx8vj_IMcWHYdY/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Energy Sources", url: "https://drive.google.com/file/d/1_wwa5KhMIYL5APnCcRjlKmamHf2RQtvR/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Manufacturing process", url: "https://drive.google.com/file/d/1zuJUgWzcf0lGgY2iv2AlEdcpNLW3qQIZ/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Sheet Metal Operations", url: "https://drive.google.com/file/d/19HFxpN3Qld3Rg3u3HdyQEvONgKMz4A3Q/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Spring - i", url: "https://drive.google.com/file/d/17UQ1HY7zG0G7Y2DQwOYS4Z2z-NqFRTNA/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Spring - ii", url: "https://drive.google.com/file/d/19HFxpN3Qld3Rg3u3HdyQEvONgKMz4A3Q/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Welding", url: "https://drive.google.com/file/d/1I8LzOVtbsxdSUXfYVuCHV9wxSdIepVCy/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Cockran and Wilcox", url: "https://drive.google.com/file/d/1ExvaK2v7xrfYSR0YGhQ90005juXsU6UF/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Centrifugal Pump", url: "https://drive.google.com/file/d/1gvRBmvJ-eroSafTmQwTDPdnxU6tWUDqk/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Workshop - i", url: "https://drive.google.com/file/d/1sjT3sB6DSih5r5g2iIwcVyr5K80foz_Y/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Workshop - ii", url: "https://drive.google.com/file/d/1WUwfdi_sAV4pjlJwCoQHOn_QtKwUgy0f/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Workshop - iii", url: "https://drive.google.com/file/d/14_zKqXFX_b9YgnLT1rJkWC6KrFudE5n7/view?usp=drive_link", icon: Icons.picture_as_pdf),
   
  ];
  plcPdfs = [
    Pdf(name: "9's and 10's Complement.pdf", url: "https://drive.google.com/file/d/1Mt0zR_WHANVKUnR-cTTYI0DKt96192-E/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Assignment 1", url: "https://drive.google.com/file/d/1xVsNgv63yeDl6cRqCy4YBlSExefWje7y/view?usp=sharing", icon: Icons.picture_as_pdf),
    Pdf(name: "Assignment 2", url: "https://drive.google.com/file/d/1IwbrR_dimvi9s6alxH1uVET2lNAexzEF/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Assignment 3", url: "https://drive.google.com/file/d/1Kz8j9_ZHZ87vuFs50uPQM1erJFrSOWS3/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Assignment 4", url: "https://drive.google.com/file/d/1O7B-16DzC_twTD0tdYjI-gDrzGn-QzNK/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Binary number system", url: "https://drive.google.com/file/d/1BEztuLl7rmGaDmlRgAkC5o4xyzn1wvI0/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "C_programming_Question_Module_4", url: "https://drive.google.com/file/d/18A2KzExkpzenrJ_HayloVXQS28NW1sbn/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Command Line Arguments", url: "https://drive.google.com/file/d/1ZFRGkPK1I873_TRZ694Qk9ZjL8bCX5zm/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "File Concept in C", url: "https://drive.google.com/file/d/1Mb8758qGWitXsyXCI_PJ9wp84_8CZszG/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Functions", url: "https://drive.google.com/file/d/1sWzJpRVpASUhcC1HyAgOhscJOIB0fB9d/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Module_II_Arrays in C programming", url: "https://drive.google.com/file/d/1csoSEWNfL-GQP1Tnpr8eaNMGVWpjLpbD/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Module_II_Control Statements", url: "https://drive.google.com/file/d/1gnH42cGpTE3F1bjCevSW9FxuG6HjuwKO/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Module_II_Looping", url: "https://drive.google.com/file/d/19yDxLJBKldVesC8JttofKRJWNyg7tCec/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Module_II_String", url: "https://drive.google.com/file/d/1af3YmrBWoTuTKJkDox63jEUdcUwyOWmC/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Pointers", url: "https://drive.google.com/file/d/1OtAgi2vZzpuqyUxvZWNAoA-ojE3REuIT/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Practice c program", url: "https://drive.google.com/file/d/1Af1WCkKWpWmbOSbTlr9dNeFZKVTftACk/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Preprocessor_directive", url: "https://drive.google.com/file/d/197J0vWlgKoTJ6QoKgOCYR0URQ8DOXDpF/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "programs_ module 1", url: "https://drive.google.com/file/d/1H_wzsLsLAF3csjVATk_vthvs7gru52iZ/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Questions using Arrays", url: "https://drive.google.com/file/d/1ZxCG3_Mq5A1E6bgq8tlt0Soc8oj8WoIt/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Questions using control statements", url: "https://drive.google.com/file/d/167JY45qz1TA9mwSvvjb4ssHevs4Mah-V/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Questions using String", url: "https://drive.google.com/file/d/1XD177PhNceXUw0H9RclIzExoANaj4kRn/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Questions_function_recursion_pointe", url: "https://drive.google.com/file/d/1aPybbNOc-8BGE1DjGxWqOAnGVcM7JPV_/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Questions_using_loop", url: "https://drive.google.com/file/d/1r9opDwHdxzDgyix2nGDxTMvWvblxLytC/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "Structures-union_Enumerated-data-type", url: "https://drive.google.com/file/d/1QTM6Mb_LMMD2ViNpIBLz6yp3d6SCbFrH/view?usp=drive_link", icon: Icons.picture_as_pdf),
    Pdf(name: "cwh", url: "https://youtube.com/playlist?list=PLu0W_9lII9aiXlHcLx-mDH1Qul38wD3aR&si=Losrn-0yFCPr3--d", icon: Icons.play_circle),
    Pdf(name: "BroCode", url: "https://youtu.be/87SH2Cn0s9A?si=rVxP0EpDdblpEJVM", icon: Icons.play_circle),
    Pdf(name: "freeCodeCamp", url: "https://youtu.be/KJgsSFOSQv0?si=na8__mKjW8UNVVrE", icon: Icons.play_circle),
  ];

    mySmartDevices = [
      ["Math", Icons.calculate_rounded, true, SubjectPage(pageName: "Math Page", pdfs: mathPdfs)],
      ["Physics", Icons.lightbulb, false, SubjectPage(pageName: "Physics Page", pdfs: phyPdfs)], 
      ["Chemistry", Icons.science, false, SubjectPage(pageName: "Chemistry Page", pdfs: chemistryPdfs)], 
      ["PLC", Icons.code, false, SubjectPage(pageName: "PLC Page", pdfs: plcPdfs)], 
      ["BEE", Icons.electrical_services, false, SubjectPage(pageName: "BEE Page", pdfs: beePdfs)],
      ["BME", Icons.build, false, SubjectPage(pageName: "BME Page", pdfs: bmePdfs)], 
      ["EM", Icons.square_foot, false, SubjectPage(pageName: "EM Page", pdfs: emPdfs)], 
      ["BE", Icons.bolt, false, SubjectPage(pageName: "BE Page", pdfs: bePdfs)], 
      ["English", Icons.auto_stories, false, SubjectPage(pageName: "English Page", pdfs: engPdfs)], 
      ["BCE", Icons.engineering, false, SubjectPage(pageName: "BCE Page", pdfs: bcePdfs)], 
      ["ED", Icons.draw, false, SubjectPage(pageName: "ED Page", pdfs: edPdfs)], 
      ["Pyqs", Icons.pages, false, SubjectPage(pageName: "Pyq Page", pdfs: pyqPdfs)], 
    ];

    setState(() {});
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Helper function to build rows of smart devices
  List<Widget> _buildSmartDeviceRows() {
    List<Widget> rows = [];
    for (int i = 0; i < mySmartDevices.length; i += 6) {
      List<Widget> rowItems = [];
      for (int j = i; j < i + 6 && j < mySmartDevices.length; j++) {
        rowItems.add(
          SmartDeviceBox(
            smartDeviceName: mySmartDevices[j][0],
            iconData: mySmartDevices[j][1],
            powerOn: mySmartDevices[j][2],
            page: mySmartDevices[j][3],
          ),
        );
      }
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: rowItems,
        ),
      );
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 55),
            // welcome home PRITAM
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      getTimeBasedGreeting(),
                      style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                    ),
                    Text(
                      getFirstName(user_name_input),
                      style: GoogleFonts.bebasNeue(
                        fontSize: 72,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 35),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Divider(
                color: Theme.of(context).colorScheme.primary,
                thickness: 1,
              ),
            ),
            const SizedBox(height: 35),
            // smart devices horizontal list
            Expanded(
              child: Column(
                children: [
                  // First row
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _buildSmartDeviceRows().sublist(0, 1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 0),
                  // Second row
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _buildSmartDeviceRows().sublist(1, 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
