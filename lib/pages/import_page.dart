import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/get_controller.dart';

class ImportPage extends StatelessWidget {
  ImportPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '说明\n'
                  '一、条目选取原则\n'
                  '口语句式不同于成语及俗语，它的存在吴现多样化。由于受各地区方言和语调等诸多因素的影响，同一个义项可能有不同的说法。我们从不方便外国学习者学习汉语的目的出发，对所收集句式接以下原则作了取舍：\n'
                  '1. 选取生活中常用的口语短句。\n'
                  '2. 选取常用的口语固定格式、口语固定词组。这类句式主要选自各类对外汉语教学大纲及当前流行的影视作品。\n'
                  '3. 选取能单独成句的习用语。\n'
                  '4. 虽然书面性较强，但是在口语中仍使用较多的语句，如：“下不为例”“一言为定”等。\n'
                  '5. 选取能单独成句的词语。某些词语在使用中有时需与其他词语搭配成句，有时也可独立成句，有完整的语义，我们选取后者。如“做梦”：\n'
                  '   (1) 我每天晚上都做梦。\n'
                  '   (2) 你想跟我结婚？做梦！\n'
                  '   我们只选取例（2）\n'
                  '6. 对一些释义简单，在生活中使用率极高，几乎人人皆知的词语，如“对不起”“没关系”这样的语句，基本上没有收入。\n'
                  '7. 一些语句在认知上没有难度，学习者认识了句中每一个词语，就理解看全句的含义，这样的语句一般不收入；而有的语句看似简单，但词语组合之后产生了新的义项，有认知上的难度，容易产生歧义，这样的语句是我们的收录对象，如“看你说的”“给……点儿颜色看看”。\n'
                  '8. 虽在某一地区流行，但过于地方化的语句没有收入。\n'
                  '二、编写体例\n'
                  '1. 条目：按音序排列，并注有汉语拼音。\n'
                  '2. 释义：对所选条目从整体上加以说明，不作具体的语法分析。释义配有乌兹别克语翻译。\n'
                  '3. 用法提示：对该句式的使用特点及容易出现的偏误进行提示，包括两方面的内容：一是结构方面的提示，如固定格式词语在句中的位置、语句的使用场合、可搭配哪些词语及词性、句式的反问形式等等。二是在句式的词用方面进行提示，比如使用者的身份、性别，表达时的感情色彩、语气等等。用法提示也配有乌兹别克语翻译。\n'
                  '4. 实列：根据释义和用法提示，给出常见情景下的使用范例，以利于学习者更具体地了解该句式的使用方法及其特点。\n'
                  '\n'
                  'IZOH\n'
                  'I. Turg‘un birikmalarni tanlab olish prinsiplari.\n'
                  'Xitoy og‘zaki tilida juda ko‘p maqol va iboralar uchraydi va ular xilma-xilligi bilan ajralib turadi. Turli xil sheva va ohanglar omili ta’sirda turli xil fikrlar kelib chiqadi. Biz o‘quvchiga nisbatan qiyinchilik olib keladigan tomonlarni tahlil qilib chiqdik va  quyidagi turg‘un birikmalarni  ushbu qo‘llanmaga  kiritdik:\n'
                  '1. Kundalik hayotda og‘zaki nutqda ko‘p uchraydigan turg‘un birikmalari tanlab olindi.\n'
                  '2. Og‘zaki nutqda nisbatan turg‘unlikka ega birikmalar tanlab olindi. Bunday so‘z-gap shakllari xitoy tilida nisbatan keng o‘ringa egadir.\n'
                  '3. Mustaqil gap ko‘rinishidagi iboralar tanlab olindi.\n'
                  '4. Garchi adabiy xususiyatga ega bo‘lsa-da, lekin og‘zaki nutqda nisbatan ko‘p ishlatiladigan iboralar tanlab olindi. Misol uchun: “下不为例”, “一言为定” va boshqalar.\n'
                  '5. Mustaqil bo‘la oladigan so‘z birikmalari tanlab olindi. Ma’lum bir so‘zlar o‘zining asl ma’nosini anglatishdan tashqari, ko‘chma ma’noga ham egadir. Misol uchun “做梦”. Bu so‘z birikmasi “tush ko‘rmoq” ma’nosidan tashqari “xom-hayol” ma’nosiga ham ega.\n'
                  '   (1) 我每天晚上都做梦。(2) 你想跟我结婚？做梦！\n'
                  '   Biz ikkinchisini tanlab oldik.\n'
                  '6. Ma’lum bir turg‘un birikmalari juda ham oddiy, kundalik hayotda ko‘p foydalaniladi, deyarli barcha biladi, shuning uchun bunday birikmalar kitobga kiritilmadi. Misol uchun: “对不起”, “没关系” va boshqalar.\n'
                  '7. Ba’zi bir birikmalar unchalik qiyin emas. Bunday gap shakllarini o‘quvchi bir ko‘rganda tushunib olgani uchun, kitobga kiritilmadi. Aksincha, ko‘rinishidan ma’nosini chiqarsa bo‘ladi-yu, lekin umuman boshqa ma’noga ega bo‘lgan turg‘un birikmalar qo‘llanmadan o‘rin egalladi. Misol uchun: “看你说的”, “给……点儿颜色看看”.\n'
                  '8. Ma’lum bir hududdagina ommabop bo‘lib, boshqa hududda tushunarsiz bo‘lgan iboralar ham kitobga kirtilmadi.\n'
                  'II. Yozilish tartibi\n'
                  '•	Turg‘un birikmalar: Xitoy tili transkripsiya alifbosi tartibi asosida terib chiqildi.\n'
                  '2. Har bir turg‘un birikma alohida til nuqtai nazari bilan tahlil etildi va o‘zbek tiliga tarjima qilindi.\n'
                  '3. Ma’lum bir turg‘un birikmalarni foydalanishda xatolikka yo‘l qo‘ymaslik uchun eslatma qismi keltirildi. Bundan ko‘zlangan maqsad ikkita: birinchidan, shunday turg‘un birikmalar mavjudki, ularning ishlatishda o‘zining o‘rni, joyi va ritorik ko‘rinishi mavjud. Ikkinchidan, ma’lum bir turg‘un birikmalar foydalanuvchi shaxs, uning jinsi, ifoda etish ohangi bilan ajralib turadi. Shu boisdan eslatma qismiga ham ahamiyat berish darkor. Ushbu eslatma qismi ham o‘zbek tiliga tarjima qilindi.\n'
                  '4. Har bir turg‘un birikma izoh va eslatmaga asoslangan tarzda, misollar bilan izohlandi.',

              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
      )
    );
  }
}