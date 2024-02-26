import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/data_model.dart';
import '../pages/sample_page.dart';

class GetController extends GetxController {
  var height = 0.0.obs;
  var width = 0.0.obs;
  var fullName = 'Dilshodjon Haydarov'.obs;

  var isLoading = false.obs;

  void setHeightWidth(BuildContext context) {
    height.value = MediaQuery.of(context).size.height;
    width.value = MediaQuery.of(context).size.width;
  }

  final TextEditingController searchController = TextEditingController();
  final TextEditingController importController = TextEditingController();

  var dataModel = DataModel().obs;
  var dataModelList = <DataModel>[].obs;

  void setDataModel(DataModel data) {
    dataModel.value = data;
  }

  void setDataModelList(List<DataModel> data) {
    dataModelList.value = data;
  }

//[
//     {
//         "id": 1,
//         "character": "A",
//         "character2": "\nAA看\n",
//         "pinyin": "AA kàn",
//         "comment": "AA表示尝试一下。AA Sinab ko‘rishlikni bildiradi. “…qilib ko‘rchi” deb tarjima qilamiz.",
//         "reminder": "表示重叠的动词，多是单音节动词。\n        ikkilangan fe’lni ko‘rsatib, odatda ular bir bog‘inlik fe’llar bo‘ladi.",
//         "examples": " 你有什么好建议，先说说看。\n         这些菜都是我做的，不知道合不合你的口味，你吃吃看。\n         甲：这电视机你能修好吗？"
//     },
//     {
//         "id": 2,
//         "character": "A",
//         "character2": "A不A B不B的 ",
//         "pinyin": "A bu A B bu B de",
//         "comment": "强调两方面的特点都不突出，让人难以分清。\n    Har ikkala tomonning xususiyatiga zarar yetkazmagan holda, ajratish qiyinligini ko‘rsatib keladi. “Na u va na bu” kabi tarjima qilinsa bo‘ladi.\n    ",
//         "reminder": "A和B一般是有对比意义的词语。2) 有时后面的“的”可以省略。（多含贬义）\n    A va B o‘rnida qiyoslanadigan (qarama-qarshi) so‘zlar bo‘ladi. 2) Ba’zi holatlarda oxiridagi 的 tushib qolishi ham mumkin (ko‘proq salbiy bo‘yoqdorlikka ega bo‘lganda).\n",
//         "examples": " 我不喜欢这种样式的衣服，中不中洋不洋的。\n 你怎么爱吃这种点心？甜不甜咸不咸的。\n 你理的是什么发型的？男不男女不女（的），真难看！\n 我真看不惯那些人的打扮，人不人鬼不鬼（的），像什么样子！\n"
//     },
//     {
//         "id": 3,
//         "character": "A",
//         "character2": "A 不了几 B",
//         "pinyin": "A bù liǎo jǐ B\n",
//         "comment": "强调数量少，时间短。\nMiqdorning kamligi, vaqtning ozligini ko‘rsatadi.",
//         "reminder": "A是动词或形容词，B是量词。\nBu yerda A fe’l yoki sifat bo‘lsa, B esa hisob so‘z bo‘ladi.\n",
//         "examples": " 咱们学校的食堂挺便宜的，吃一顿饭花不了几块钱。\n 咱们在这儿住不了几天（就走），用不着买家具。\n 邮局离这儿不远，走不了几步就到了。\n 我的房子是比你的大一点儿，可大不了几平米。\n\n\n"
//     },
//     {
//         "id": 4,
//         "character": "A",
//         "character2": "A 不说，还B\t",
//         "pinyin": "A bùshuō, hái B",
//         "comment": "表示除了A部分所说的，还有B部分的情况。\nA ning xususiyatlarini ta’riflashdan tashqari, yana B ning ham holati keltirib o‘tiladi. “Uni aytmasa ham bo‘ladi, yana  bu” tarzida tarjima qilamiz.",
//         "reminder": "不说”有时也用“不算”，这时多用于不如意的事情。\n“不说” ba’zi holatlarda “不算” shaklida kelishi ham mumkin. Bu holatda esa ko‘ngilsizlik nazarda tutilgan bo‘ladi.",
//         "examples": " 周末咱么去温泉度假村吧，能洗温泉不说，还能钓鱼呢。\n我不想和他住一个房间，抽烟不说，睡觉还打呼噜。\n我可不喜欢去哪个饭馆儿，饭菜贵不说，还不好吃。\n昨天我家被盗，小偷偷了钱不算，还打坏了不少东西。\n。\n\n\n"
//     },
//     {
//         "id": 5,
//         "character": "A",
//         "character2": "A 得不能再A 了",
//         "pinyin": "A dé bù néng zài A le",
//         "comment": "强调程度很高，到了极点。\nDarajaning eng yuqori cho‘qqiga chiqqanligini bildiradi. “O‘tib tushgan darajada” deb tarjima qilinsa bo‘ladi.",
//         "reminder": "1) A一般是形容词。2) 有夸张的语气，有时也用于讽刺。\n 1) A odatda sifat bo‘lib keladi. 2) Maqtash ma’nosida bo‘lib, kulgili holatlarda  ham qo‘llaniladi. ",
//         "examples": "你怎么在哪个小区买房子？那儿的房子贵得不能再贵了\n 这孩子胖得不能再胖了，该让他减减肥了！\n 甲：我这么做有什么不好吗？\n 乙：好，真是好得不能再好了！\n\n\n"
//     },
//     {
//         "id": 6,
//         "character": "A",
//         "character2": "A 的 A, B的 B",
//         "pinyin": "A de A, B de B\n",
//         "comment": "指有的这样，有的那样，合起来有时可以概指全部。\nBa’zilari unday, ba’zilari bunday holatda ekanligini ko‘rsatib, birgalikda kelganda umumiylikni bildiradi. “Unisi unday, bunisi bunday” deb tarjima qilamiz.\n",
//         "reminder": "A和B 一般是形容词、动词或动词词组。\nA va B odatda sifat, fe’l yoki fe’l birikmasi bo‘lib kelishi mumkin.\n",
//         "examples": "这些衣服肥的肥，瘦的瘦，没有一件适合我穿的。\n晚会上，大家说的说，笑的笑，非常热闹。\n为了准备这次聚餐，我们买菜的买菜，打扫的打扫，忙了一下午。\n"
//     },
//     {
//         "id": 7,
//         "character": "A",
//         "character2": "A 就 A 吧",
//         "pinyin": "A jiù A ba\n",
//         "comment": "表示没关系或不要紧。\nDeyarli ahamiyatsiz hamda nazarda tutilgan ish hozir bo‘lmasa-da keyin bitishi yoki umuman qilinmasligi ham  mumkinligini bildiradi “Qilsa qilibdi”, “bo‘lsa bo‘libdi” deb tarjima qilamiz.\n",
//         "reminder": "1) A可以是动词、形容词或名词。2) 当A是动词并且重读时，表示态度坚决，后面一般不用“吧”。有容忍、无所谓或无奈的语气。\n1) A fe’l, sifat yoki ot bo‘lib kelishi mumkin. 2) A fe’l bo‘lib kelgan holatda vaziyatni keskinligini bildirib, oxiridagi 吧 tushib qolishi ham mumkin. Ushbu shaklda befarqlik, chorasizlik kabi ma’nolar yotadi.\n",
//         "examples": "甲：孩子还没写完作业就去玩儿了。\n乙：去就去吧，今天是周末，让他玩会儿吧。\n甲：你敢和我比一比吗？\n乙：比就比，我怕你吗？\n"
//     },
//     {
//         "id": 8,
//         "character": "A",
//         "character2": "A 是 A",
//         "pinyin": "A shì A\n",
//         "comment": "表示让步，有“虽然”的意思。\n\tRozilik ma’nosini ifodalab, “garchi” degan ma’noni bildiradi.\n",
//         "reminder": "第二个A可以是和第一个A完全相同的成分，也可以有附加成分。\n2) 第二小句常有表示转折“可（是），但（是），就是，只是“等词语\nIkkinchi A birinchi A dek bo‘lishi yoki boshqa bo‘laklarni ham o‘z ichiga olishi mumkin. 2) Gapning ikkinchi qismida “lekin, ammo, biroq” kabi bog‘lovchilar kelishi mumkin.\n",
//         "examples": "这个饭馆儿的菜便宜是便宜，可并不好吃。\n咱们朋友是朋友，但我可不能帮你做违法的事儿。\n他唱是能唱，就是今天感冒了，嗓子不太好。"
//     },
//     {
//         "id": 9,
//         "character": "A",
//         "character2": "A 也不是，B 也不是 ",
//         "pinyin": "A yě bú shì, B yě bú shì\n",
//         "comment": "表示这样不合适，那样也不合适，左右为难。\nBunday qilish ham, unday qilish ham to‘g‘ri kelmasligini, ikki o‘t orasida qolganligini ko‘rsatadi. “na…, na…” deb tarjima qilsak to‘g‘ri bo‘ladi.\n",
//         "reminder": "1) A和B是相对的词语，B也可以是“不A”。2) 有时A后面的“也”可以省略。\n1) A va B qarama-qarshi so‘zlar bo‘lib, ba’zi holatlarda B “不A” shaklida ham qo‘llanishini uchratamiz. 2) Ba’zi holatlarda A dan keyin 也 so‘zi tushib qolishi mumkin.\n",
//         "examples": " 甲：你不是对这个项目有意见吗？为什么讨论的时候你不提出来呢？\n乙：可这项目是我的导师负责的，我怎么办？同意不是，反对也不是。\n 给孩子买衣服可真难，大了（也）不是，小了也不是。\n 甲：他是你的朋友，请你参加生日晚会，你不去不合适吧？\n乙：可是我实在是没时间哪，真是去也不是，不去也不是。"
//     },
//     {
//         "id": 10,
//         "character": "A",
//         "character2": "A 也得 A， 不A也是A",
//         "pinyin": "A yě déi A, bù A yě shì A\n",
//         "comment": "表示无论如何必须做或只能这样做。\nNima bo‘lishidan qat’iy nazar, shu ishni qilish zarurligini ko‘rsatadi. “Qilsang ham qilasan, qilmasang ham qilasan” deb tarjima qilsa to‘g‘ri bo‘ladi.\n",
//         "reminder": "1) A一般是动词。2)有强迫或无奈的语气。\n1) A odatda fe’l bo‘ladi. 2) Majburlik yoki chorasizlik ma’nosini beradi.\n",
//         "examples": " 甲：今天我有急事，晚上的演出我可能参加不了。\n乙：那怎么行？你来也得来，不来也得来。你是主角，你不来怎么演呀？\n 你们都商量好了，还问我干什么？我同意也得同意，不同意也得不同意。\n"
//     },
//     {
//         "id": 11,
//         "character": "A",
//         "character2": "A 也好，B 也好",
//         "pinyin": "A yě hǎo, B yě hǎo\n",
//         "comment": "表示任何情况或任何事物都如此。\nHar qanday holatda yoki har qanday predmetning shunday ekanligini bildiradi.\n",
//         "reminder": "A和B在这里是例举不同的情况、不同的事物或事物的不同的方面，“好”并不表示肯定。\nA va B bu yerda umuman bir-biridan farq qiladigan holat, predmet yoki tomonni ko‘rsatib keladi. “好” ning bu yerda tasdiq “yaxshi” degan ma’nosi yo‘q.\n",
//         "examples": "ollar:\n明天我们打算一起去郊区，你去也好，不去也好，今天晚上告诉我一下。\n篮球也好，足球也好，我都没什么兴趣。\n"
//     },
//     {
//         "id": 12,
//         "character": "A",
//         "character2": "爱 A 不 A",
//         "pinyin": "ài A bù A",
//         "comment": "表示听凭或容忍某种行为或情况。\nIxtiyoriylik yoki sabr qilish, ko‘nish kabi turdagi harakat yoki holatni ko‘rsatadi. “Xohlasang unday, xohlamasang bunday” deb tarjima qilsa bo‘ladi.\n",
//         "reminder": "1) A一般是动词、助动词或形容词。2) 有不在乎或不满的语气。\nA odatda fe’l, yordamchi fe’l yoki sifat bo‘ladi. 2) E’tiborsizlik yoki qoniqmaslik ma’nosida keladi.\n",
//         "examples": "(1) 甲：他说最近很忙，帮不了你。\n乙：爱帮不帮，没有他，我一个人也能能行。\n(2) 甲：他好像不太喜欢你的发型。\n乙：反正我觉得好看，他爱喜欢不喜欢。\n"
//     },
//     {
//         "id": 13,
//         "character": "A",
//         "character2": "爱 A (就) A",
//         "pinyin": "ài A (jiù) A\n",
//         "comment": "表示他人完全可以按照自己的愿意做事。\nBiror-bir shaxs o‘z xohishga ko‘ra, ma’lum bir ishni qilishni ko‘rsatadi.\n",
//         "reminder": "1) A是带疑问词的词组。2) “就”在口语中经常省略。3)有时不耐烦的语气。\nA odatda so‘roq olmoshlari o‘rnida qo‘llanadi.\n2) “就” esa og‘zakida ko‘p hollarda tushib qoladi. 3) Ba’zi hollarda sabrsizlik  ma’nosini bildiradi.\n",
//         "examples": "这个饭馆儿是自助的，菜都在那边，你们爱吃什么（就）吃什么。\n 甲：你们这儿的服务太差了，我要找你们领导反映反映。\n乙：你爱找谁找谁。\n"
//     },
//     {
//         "id": 14,
//         "character": "B",
//         "character2": "把·····放在一边\t",
//         "pinyin": "bǎ….. fàngzài yìbiān",
//         "comment": "表示暂时不去做或不考虑。\nVaqtincha qila olmaslik yoki bu haqida o‘ylamaslik (fikrlamaslik)ni bildiradi. “Buni bir chekkaga qo‘yib turaylik” deb tarjima qilinadi.\n",
//         "reminder": "受事做主语时可说成“……先放在一边”\nAgar ega bilan kelganda, “····先放在一边” ko‘rinishida kelishi ham mumkin.\n",
//         "examples": " 你们先把手头的事放在一边，都到处外面去卸货。\n 甲：明年的员工假期安排你是怎么考虑的？\n乙：这事先放在一边吧，我现在实在是没空儿。\n"
//     },
//     {
//         "id": 15,
//         "character": "B",
//         "character2": "把话放在这儿",
//         "pinyin": "bǎ huà fàngzài zhèer\n",
//         "comment": "断定某种行为肯定会导致不如意的结果。\nMa’lum bir harakatdan ko‘ngildagidek natija chiqmaganligini ifodalaydi. “Gapning dangalini aytib qo‘yay” deb tarjima qilinadi.\n",
//         "reminder": "一般用于第一人称。2) 有警告的语气。3) 后面给出所警告的内容。有时“把话放在这儿”也可用于句尾作补充。\nOdatda birinchi shaxs tomonidan qo‘llaniladi. 2) Ogohlantirish ma’nosida keladi. 3) Uning ortidan keladigan so‘zlarning barchasi ogohlantirish so‘zlari bo‘lib, ba’zi hollarda “把话放在这儿” jumlaning oxirida kelishi mumkin.\n",
//         "examples": "不经过市场调查就贸然投资，能行吗？我把话放在这儿，总有一天你会后悔的。\n依他们两个人的性格，结婚以后肯定过不到一块儿。咱们今天把话放在这儿，不出一年，他们非离婚不可。\n你这么一意孤行，不会有好结果的。我把话放在这儿。\n"
//     },
//     {
//         "id": 16,
//         "character": "B",
//         "character2": "把话说清楚",
//         "pinyin": "bǎ huà shuō qīngchǔ",
//         "comment": "1) 要求对方作出明确的解释，不能含糊笼统。2) 指出事情在不正常情况下会出现的后果或表示不希望出现这种不正常的情况。\nQarshi tomonga aniq talablarni tushuntirib, mujmal gap qilmaslikni; 2) ishdan kutilayotgan natijani aniq bayon etishni ko‘rsatadi. “Gapni aniq qilib olaylik”, “kelishib olaylik” deb tarjima qilinadi.\n",
//         "reminder": "有时也可以说“话说清楚”。1) 用于第一项释义时，有质问或不满的语气。2) 用于第二项释义时，有提醒或警告的语气。\nBa’zi hollarda “话说清楚” bo‘lib kelishi mumkin. 1) Birinchi qo‘llanilayotgan holatda, muammo borligini yoki qoniqmaslik holatini ko‘rsatadi. 2) Ikkinchida esa ogohlantirish yoki eslatish ma’nosida keladi.\n",
//         "examples": "(1) 甲：有人老在领导面前说我的坏话，别以为我不知道。\n乙：把话说清楚，你说的“有人”指的是谁？\n(2) 在正常情况下，这种产品可以使用十年，不过咱们把话说清楚，如果你们使用不当，就会大大缩短它的寿命。\n(3) 大家如果有困难，我一定会尽力帮助解决。不过话说清楚，谁要是想让我帮他做违法的事，想都别想。"
//     },
//     {
//         "id": 17,
//         "character": "B",
//         "character2": "把话说在前面",
//         "pinyin": "bǎ huà shuōzài qiánmian\n",
//         "comment": "指出事情存在或可能出现某些不如意的情况，并表明这种情况的存在或发生，自己不承担责任。\nIshda ma’lum bir ko‘ngilsiz holatning yuz berishini ko‘rsatib, o‘zidan ma’lum mas’uliyatni soqit qilishni bildiradi. “Gapni ochiq aytadigan bo‘lsak” deb tarjima qilamiz.\n",
//         "reminder": "一般用于第一人称。2) 有警告的语气。\nOdatda birinchi shaxs nutqida qo‘llaniladi. 2) Ogohlantirish ma’nosi mavjud.\n",
//         "examples": "我帮你找了一个工作，不过咱们把话说在前面，这工作可挺辛苦的，待遇也不太高，你看要不要干？\n甲：大夫，我女儿非要做个整容手术不可，我有点儿担心。\n乙：一般情况下，做这种手术还是比较安全的。但我想应该把话说在前面，做任何手术都有一定的风险，你们对此也得有个思想"
//     },
//     {
//         "id": 18,
//         "character": "B",
//         "character2": "罢了",
//         "pinyin": "bàle",
//         "comment": "“算了” shakliga qarang.\n",
//         "reminder": null,
//         "examples": "甲：这次升职又没有你？你应该去跟主管说说呀。\n乙：罢了，事情都决定了，说有什么用？\n甲：我知道这事让你很为难，可我实在是走投无路了，你要是再不帮忙，我真是死定了！\n乙：唉，罢了，看在我们是老同学，我就再帮你一次。"
//     },
//     {
//         "id": 19,
//         "character": "B",
//         "character2": "拜托",
//         "pinyin": "bàituō",
//         "comment": "请求对方为自己做某事。\nQarshi tomonga ma’lum bir ish yuzasidan iltimos qilishlik ma’nosini bildiradi. “Iltimos”, “iltimos qilaman”, “yolvoraman” deb tarjima qilsa bo‘ladi.\n",
//         "reminder": "1) “拜托”以ABAB 形式出现或后面有“了”时，常用于嘱托的内容之后，希望引起对方的重视，兼有感谢的语气。2) 有时用于请求对方停止某种自己不喜欢的行为，有恳求的语气。\n拜托 ABAB shaklida ikkilansa, yoki uning ortidan “了” keladigan bo‘lsa, uning mazmuni, asosan, qarshi tomonga kuchli e’tibor qaratish bo‘lib, minnatdorchilik ma’nosida ham keladi. 2) Ba’zi hollarda qarshi tomonga iltimos qilishlikni o‘zi xohlamagan holda bajarayotganligini va yolvorish ma’nosini bildiradi.\n",
//         "examples": "(1) 你见到王经理的时候，一定要亲自这份文件交给他，拜托拜托。\n(2) 这几天就请你帮我们照顾一下我们的小狗吧，拜托了。\n(3) 拜托！你可不可以把车开慢一点哪！\n(4) 你们别吵了好不好？拜托！\n"
//     },
//     {
//         "id": 20,
//         "character": "B",
//         "character2": "办不到",
//         "pinyin": "bàn bù dào",
//         "comment": "认为对方的言行没有道理或无法容忍，表示决不答应。有时用于拒绝敌方或对手的要求。\nQarshi tomonning iltimos yoki talabini rad etishni bildirib, “qo‘lidan kelmaslik”, “bajara olmaslik”, “uddalay olmaslik” ma’nolarini beradi.\n",
//         "reminder": null,
//         "examples": "甲：万一警察问到你，你可别说是董事长开车撞了人，就说是你。\n乙：办不到，你这不是害我吗？\n甲：你们公司仗着自己财大气粗，就想逼我们退出玩具市场？办不到！\n甲：如果你肯为我们做事，我们就不杀你。、\n乙：只有“断头将军”，没有“投降将军”，要我投降，办不到！\n"
//     },
//     {
//         "id": 21,
//         "character": "B",
//         "character2": "包在我身上",
//         "pinyin": "bāozài wǒ shēnshàng\n",
//         "comment": "表示自己完全有把握帮对方解决问题。\nQarshi tomon muammolarining yechimini o‘z zimmasiga olishni bildiradi. “Bo‘ynimga olaman”, “mas’ulman”, “mening zimmamda” deb tarjima qilinadi.\n",
//         "reminder": null,
//         "examples": "甲：你能帮我找一个辅导吗？\n乙：行，包在我身上，你就放心吧。\n甲：我觉得老板对我有点儿误解，你能不能找个机会，帮我向他解释一下？\n乙：没问题，这件事就包在我身上了。\n"
//     },
//     {
//         "id": 22,
//         "character": "B",
//         "character2": "本来嘛",
//         "pinyin": "běnlái ma\n",
//         "comment": "表示按道理当然会如此或就该这样。\nGapda asosan shunday yoki bundayligini bildirib, “aslida shunday ekan, shunday ekanda” deb tarjima qilinadi.\n",
//         "reminder": null,
//         "examples": "甲：我上课的时候听老师说话还可以，一到学校外面听别人说，就听不懂。\n乙：本来嘛，你才来不到两个月，能听懂多少哇。\n甲：我考大学的时候，天天学到晚上十二点。\n乙：本来嘛，不下功夫，怎么能得到好成绩呢。\n"
//     },
//     {
//         "id": 23,
//         "character": "B",
//         "character2": "比 A 还 A",
//         "pinyin": "bǐ A hái A\n",
//         "comment": "表示极力强调某人的特点或能力。\nKimdirning xususiyati yoki qobiliyatini eng yuqori darajaga ko‘tarilganligini ta’kidlaydi.\n",
//         "reminder": "1) A多时具有某方面特点或能力的人。2) 带有夸张的语气。有时有讽刺的意味。\nA ko‘proq xususiyat yoki qobiliyatga ega odam bo‘ladi. 2) Birovni maqtash, ba’zida esa kesatish ma’nosiga ega bo‘ladi.\n",
//         "examples": "他的篮球打得才棒呢，比乔丹还乔丹。\n这种定论是专家做出来的，可是让他一口就否定了，他比专家还专家呢。\n"
//     },
//     {
//         "id": 24,
//         "character": "B",
//         "character2": "彼此彼此\n",
//         "pinyin": "bǐcǐ bǐcǐ",
//         "comment": "表示大家都一样。\nHamma bir xil ekanligini ko‘rsatadi. “Sizga ham”, “siz ham” deb tarjima qilsa bo‘ladi.\n",
//         "reminder": "多用于客套话。\nKo‘proq takalluf so‘z hisoblanadi.\n",
//         "examples": "甲：他说我自私，我看他比谁都自私。\n乙：算了，你们谁也别说谁了，彼此彼此\n甲：您辛苦了！\n乙：彼此彼此\n甲：你考上本科了？祝贺你呀。\n乙：彼此彼此，你不是也考上了吗？"
//     },
//     {
//         "id": 25,
//         "character": "B",
//         "character2": "别的不说，就说···吧 ",
//         "pinyin": "biéde bù shuō，jiù shuō… ba",
//         "comment": "表示无须举很多例子，只需举一个例子就可以说明问题。\nJuda ko‘p misollar bo‘lsa-da, lekin birgina misolni keltirib, butun muammoni tasvirlashni ko‘rsatadi. “Boshqasini qo‘ying, buni ayting” kabi tarjima qilinadi.\n",
//         "reminder": null,
//         "examples": "甲：听说最近水果很贵呀。\n乙：可不是嘛，别的不说，就是香蕉吧，每斤比原来贵了一块多钱呢。\n甲：大家都说他这个人挺爱帮助人。\n乙：没错儿，别的不说，就说昨天吧，他帮老王修了一上午的车，连午饭都没吃。\n"
//     },
//     {
//         "id": 26,
//         "character": "B",
//         "character2": "别逗了",
//         "pinyin": "biédòule",
//         "comment": "表示不相信，认为对方所说的事情绝不存在。\nIshonchsizlikni bildirib, qarshi tomonning fikri noto‘g‘ri ekanligini tasdiqlaydi. “Qo‘ysangchi”, “hazillashma” deb tarjima qilinadi.\n",
//         "reminder": "多用于朋友之间，口气比较随便。\nUshbu ibora ko‘proq og‘zaki nutqda do‘stona muloqotda qo‘llaniladi.\n",
//         "examples": "甲：昨天晚上我在酒吧看见你男朋友了。\n乙：别逗了，我们晚上一直在一起的，你看错人了吧？\n甲：听说公司要给咱们加薪。\n乙：别逗了，老板给咱们加薪？除非太阳从西边出来"
//     },
//     {
//         "id": 27,
//         "character": "B",
//         "character2": "别放在心上",
//         "pinyin": "bié fàngzài xīnshàng",
//         "comment": "让对方不要把这件事看得太重。\nQarshi tomonga ma’lum bir ishga bunchalik kuchli e’tibor bermaslikka chaqiradi. “Ko‘nglingga olma”, “ahamiyat berma” deb tarjima qilinsa, maqsadga muvofiq bo‘ladi.\n",
//         "reminder": "有时用于客气，有时用于安慰对方。\nBa’zi paytda mulozamatni bildirishda, ba’zida qarshi tomonni yupatish, tinchlantirish maqsadida qo‘llaniladi.\n",
//         "examples": "甲：你帮了我这么大的忙，总也没有机会感谢你。\n乙：举手之劳，您别老放在心上。\n甲：他怎么能用这种口气跟我说话！\n乙：他就是这么个人，一着急就什么都说，过后就忘。你别放在心上。\n"
//     },
//     {
//         "id": 28,
//         "character": "B",
//         "character2": "别看····，····",
//         "pinyin": "biékàn…，….",
//         "comment": "指不能从表面或习惯认识上判断。\nTashqi ko‘rinish yoki odatlarga qarab, xulosa chiqarmaslikni ko‘rsatadi. “…ga qarama” deb tarjima qilinadi.\n",
//         "reminder": "第二小句多指出别人想不到甚至相反的一面，常有表示转折的词语。\nGapning ikkinchi qismida boshqa odamlar tomonidan kutilmagan fikrlar kelishi yoki birinchi qismning teskarisi bo‘lishi mumkin.\n",
//         "examples": "甲：这活儿让他去干最合适了。\n乙：别看他又高又壮，可一点儿劲儿也没有。\n甲：外面风很大，肯定冷得要命，多穿点儿吧。\n乙：别看风那么大，其实并不太冷。\n"
//     },
//     {
//         "id": 29,
//         "character": "B",
//         "character2": "别来这一套",
//         "pinyin": " bié lái zhè yī tào",
//         "comment": "表示自己不接受或不相信某人的言行。\nMa’lum bir insonning xatti-harakatini qabul qila olmaslik yoki unga ishonmaslikni bildiradi.\n",
//         "reminder": "一般用于拒绝或制止。2) 有批评或斥责的语气。\nOdatda rad etish yoki to‘xtatish uchun foydalaniladi. 2) Tanqid yoki ayblash ma’nosida keladi.\n",
//         "examples": "甲：这个项目的顺利完成，多亏了您的支持。这是我们家乡的土产，请您收下。\n乙：别别别，咱们工作归工作，别来这一套。\n甲：他说现在资金紧张，暂时发不出工资来。\n乙：叫他别来这一套，他要是在拖欠我们的工资，我们就他告他！\n"
//     },
//     {
//         "id": 30,
//         "character": "B",
//         "character2": "别是·····吧",
//         "pinyin": "bié shì …. ba",
//         "comment": "猜测可能发生某事。\nQandaydir ish sodir bo‘lganligini taxmin qilishni bildiradi. “Shunday bo‘lmagan bo‘lsin-a” deb tarjima qilsak bo‘ladi.\n",
//         "reminder": "猜测的结果是不好的，语气比较委婉，表示不希望这一结果真的出现。2) 猜测的结果是好的，有意外、惊喜的语气。\nTaxminning natijasi yomon, eng muhimi shu ishni sodir bo‘lishini xohlamaslikni ko‘rsatadi. Aksincha, 2) Taxminning natijasi yaxshi bo‘lib, kutilmaganlik  ma’nosida keladi.\n",
//         "examples": "他到现在还不来，别是出什么事了吧。\n信寄出一个月还没收到，别是寄丢了吧？\n甲：最近怎么老有人给我送花呀？\n乙：别是什么人看上你来吧？\n"
//     },
//     {
//         "id": 31,
//         "character": "B",
//         "character2": "别提多··· 了",
//         "pinyin": "biétí duō…le",
//         "comment": "表示程度极高。\nSifatning yuqori darajasini ko‘rsatadi. Uni “chidab bo‘lmas”, “o‘ta yuqori” deb tarjima qilsak bo‘ladi.\n",
//         "reminder": "搭配的词语一般为形容词或表示心理活动的动词。2) 有感叹的语气。\nAsosan sifat yoki holat ifodalovchi fe’llar bilan birga keladi. 2) Hissiy ohangdorlikka ega bo‘ladi.\n",
//         "examples": "今天别提多热了。\n他要结婚了，心里别提多高兴了。\n看到大家都这样热心地帮助他，他别提多感动了。\n"
//     },
//     {
//         "id": 32,
//         "character": "B",
//         "character2": "别提了",
//         "pinyin": "biétí le",
//         "comment": "表示对方问到的情况自己觉得很糟糕，不愿多谈。有时表示程度高到极点，无需过多说明。\nQarshi tomon taklif qilgan holat yoki harakatni yoqtirmaslik, undan bezor bo‘lganligi, uni eslashni xohlamasligini ko‘rsatib, “eslatmasangchi”, “qo‘ysangchi buni” deb tarjima qilamiz.\n",
//         "reminder": null,
//         "examples": "甲：喂，你那儿天气怎么样？\n乙：别提了，这几天不是刮风就是下雨。\n甲：你儿子上大学了吗？\n乙：唉！别提了！一提这事我就心烦。\n中了大奖以后，全家那股高兴劲儿就别提了。"
//     },
//     {
//         "id": 33,
//         "character": "B",
//         "character2": "别往心里去",
//         "pinyin": "bié wǎng xīnli qù\n",
//         "comment": "劝某人对某种不顺心的事不必过分在意。\nBiror insonni ma’lum bir ishni o‘ziga unchalik yaqin olmaslik, ahamiyat bermaslikka chaqiradi. “O‘zingga yaqin olma” deb tarjima qilsa bo‘ladi.\n",
//         "reminder": "有安慰或劝解的语气。\nTinchlantirish yoki nasihat qilish ma’nosiga ega bo‘ladi.\n",
//         "examples": "他对人还是挺热心的，就是有时候说话太直，你别往心里去。\n我在会上批评的是一种普遍存在的现象，并不是针对某个人的，你可千万别往心里去。\n"
//     },
//     {
//         "id": 34,
//         "character": "B",
//         "character2": "别这么说",
//         "pinyin": "bié zhème shuō\n",
//         "comment": "表示认为对方说的话不适当。\nQarshi tomonning gapini ma’qullamaslikni bildiradi. “Unday demasangchi” deb tarjima qilinadi.\n",
//         "reminder": "对方说道歉、感谢的话时，表示客气。2) 表示制止或警告。\nQarshi tomon uzr so‘rayotgan, minnatdorchilik bildirayotgan paytda mulozamatni ko‘rsatadi. 2) Ba’zida to‘xtatish yoki ogohlantirishni ham bildiradi.\n",
//         "examples": "甲：我真不知道该怎么感谢你。\n乙：别这么说，朋友之间，不用这么客气。\n甲：这个老师每天都留那么多作业，就怕咱们过得苦吗？\n乙：别这么说，咱们的作业他都得批改，不是也很辛苦吗？\n甲：老板要是不给加班费，咱们就都不干了！\n乙：可别这么说，当心让老板听见，炒你的鱿鱼。\n"
//     },
//     {
//         "id": 35,
//         "character": "B",
//         "character2": "不·····不行啊",
//         "pinyin": "bù……bùxíng",
//         "comment": "表示不得不这样做。\nMajburan shunday qilganligini ko‘rsatadi. “Qilmasam bo‘lmasdi” deb tarjima qilsa bo‘ladi.\n",
//         "reminder": "有无奈的语气。\nChorasizlik manosida keladi.\n",
//         "examples": "甲：你为什么一定要买车呢？\n乙：不买不行啊，工作的地方离家太远，交通也不方便。\n我也不想开除他，可是这件事乙经造成了很坏的影响，不开除他不行啊。\n"
//     },
//     {
//         "id": 36,
//         "character": "B",
//         "character2": "不A是不A",
//         "pinyin": "bù A shì bù A",
//         "comment": "表示某人在一般情况下不显露自己在某方面的特点，一旦显露，就有惊人的表现。\nBiror kishi odatdagi holatidan boshqacha ko‘rinishda bo‘lishi hamda boshqalarning ajablanishiga sabab bo‘lishini bildiradi. “Qilmasa qilmaydi, bo‘lmasa” deb tarjima qilsa bo‘ladi.\n",
//         "reminder": null,
//         "examples": "甲：今天会上老张怎么没说话呀？\n乙：幸亏他没说话。他呀，不说是不说，一说就是一个多小时。\n甲：你丈夫平时不做饭吧？\n乙：他不做是不做，一做就能做出一桌席来。\n甲：老听别人说你会唱京剧，怎么从来没听你唱过呀？\n乙：我不唱是不唱，要唱就得去电视台唱。\n"
//     },
//     {
//         "id": 37,
//         "character": "B",
//         "character2": "不把····当回事",
//         "pinyin": "bù bǎ…. dānghuí shì\n",
//         "comment": "指对所说的事物不重视，没有严肃认真的态度。\nSodir bo‘layotgan ishlarga e’tiborsiz bo‘lishni, holatga unchalik jiddiy qaramaslikni ko‘rsatadi.\n",
//         "reminder": "“不”有时也可换成“没”。\n“不” ni ba’zida “没” bilan almashtirish mumkin.\n",
//         "examples": "他老不把复习当回事，考完又后悔。\n甲：他上班总是迟到，你也应该说说他。\n乙：我说他多少次了，可他根本不（没）把我的话当回事。\n平时在我们班，谁都没（不）把他当回事，没想到这次作文比赛他得了个一等奖。\n"
//     },
//     {
//         "id": 38,
//         "character": "B",
//         "character2": "不把·····放在眼里",
//         "pinyin": "bù bǎ….. fàngzài yǎnlǐ",
//         "comment": "表示对某人不重视，有轻视的意思。\nMa’lum bir kimsaga nisbatan e’tibor qaratmaslik, ko‘zdan qochirishni bildiradi. “Ko‘zi ilg‘amaydi”, “mensimaydi” deb tarjima qilamiz.\n",
//         "reminder": "有时也说“没把……放在眼里”。\nBa’zi hollarda “没把·····放在眼里” shaklida kelishi mumkin.\n",
//         "examples": "我是副总经理，可他什么事都不跟我打招呼，简直不（没）把我放在眼里。\n他刚从学校毕业，就想跟我竞争？我根本没（不）他放在眼里。\n"
//     },
//     {
//         "id": 39,
//         "character": "B",
//         "character2": "不必了",
//         "pinyin": "búbì le",
//         "comment": "表示不需要，用不着。\nKerak emas, hojati yo‘q, shart emas ma’nolarini bildiradi.\n",
//         "reminder": "有时可以说“不必”。2) 有时用于认为对方虚情假意而拒绝对方的提议，有冷淡的语气。\nBa’zi hollarda “不必”ning o‘zi ham kelishi mumkin. 2) Qarshi tomonning samimiy taklifini rad etib, ba’zida sovuq ohangda javob qaytarishda ishlatiladi.\n",
//         "examples": "甲：搬家的时候要不要我们帮忙？\n乙：不必了，我已经请了搬家公司。\n甲：你真够可以的！看着两个流氓打我，你见死不救！\n乙：我是想救你的，可是他们都拿着刀呢。伤在哪儿了？我送你去医院吧？\n甲：不必！我没有你这样的朋友！\n"
//     },
//     {
//         "id": 40,
//         "character": "B",
//         "character2": "····不到哪儿去",
//         "pinyin": "……bù dào nǎr qù",
//         "comment": "表示即使有某种情况，程度也不会很高。\nMa’lum bir holatda jarayon unchalik ham yuqori bo‘lmaganligini ko‘rsatadi.\n",
//         "reminder": "1) 搭配的词语一般时形容词。2) 当用于比较句中时，指两者在程度上差不多。有时甚至有否定的语气。\nOdatda nuqtalar o‘rnida sifat bo‘ladi. 2) qiyoslanuvchi holatda ikki tomonning darajasi deyarli bir xil ko‘riladi. Ba’zi hollarda inkor ma’nosida q‘llanadi.\n",
//         "examples": "立秋以后，天就热不到哪儿去了。\n甲：这儿的比别的地方贵吧？\n乙：贵不到哪儿去，就在这儿卖了吧。\n甲：我觉得他的发音比你好。\n乙：他比我好不到哪儿去。\n她呀，就是化了妆也漂亮不到哪儿去"
//     },
//     {
//         "id": 41,
//         "character": "B",
//         "character2": "不得了了",
//         "pinyin": "bù déliao le",
//         "comment": "表示情况严重。\nHolatning jiddiyligini bildirib, “bo‘lishi mumkin emas” deb tarjima qilsa bo‘ladi.\n",
//         "reminder": null,
//         "examples": "不得了了，工地砸伤人了！\n什么？宿舍楼着火了？那可不得了了，我儿子还在家里睡觉呢！\n"
//     },
//     {
//         "id": 42,
//         "character": "B",
//         "character2": "不对呀",
//         "pinyin": "bú duì ya\n",
//         "comment": "表示发觉不正常的情况或怀疑某种现象。\nMa’lum bir holatga shubha bilan qarash, ishonchsizlikni bildiradi. “Yo‘g‘a”, “bo‘lishi mumkin emas” , “nahotki”deb tarjima qilinadi.\n",
//         "reminder": "后面一般要给出所察觉或怀疑的情况。\nOdatda ushbu iboraning ortidan shubhali holatlar keladi.\n",
//         "examples": "甲：我给他家打过电话，他家里人说他一个小时以前就出来了。\n乙：不对呀，他家离这儿就是十分钟的路，怎么现在还没到哇？\n不对呀，都上课了，怎么一个人也没有哇？"
//     },
//     {
//         "id": 43,
//         "character": "B",
//         "character2": "不敢当",
//         "pinyin": "bùgǎndāng",
//         "comment": "表示对对方给予的称号或待遇承受不起。\nQarshi tomonning maqtoviga loyiq emasligini ifodalaydi. “Bunday iltifotlarga loyiq emasman”, “bunday atashingizga loyiq emasman” deb tarjima qilinadi.\n",
//         "reminder": null,
//         "examples": "(1) 甲：我看你都快成“中国通”了。\n      乙：不敢当，不敢当。\n(2) 甲：您是我们今天最尊贵的客人，请你入席。\n      乙：那可不敢当。您比我岁数大，还是您先请吧。"
//     },
//     {
//         "id": 44,
//         "character": "B",
//         "character2": "不管怎么说，……",
//         "pinyin": "bùguǎn zěnme shuō, …….",
//         "comment": "表示在任何情况下结果或结论都不会改变或不应该改变。\nHar qanday holat bo‘lishidan qat’iy nazar, natijani o‘zgartirmaslikni ko‘rsatadi. “Nima bo‘lishidan qat’iy nazar” deb tarjima qilinadi.\n",
//         "reminder": "有时也可以说“不管怎么样，……”。\nBa’zi hollarda “不管怎么样，……” bo‘lib kelishi ham mumkin.\n",
//         "examples": "不管怎么说/不管怎么样，你今天一定要去开会。\n虽然你爸爸对你说的话有些过分，可不管怎么说/不管怎么样，他是你爸爸，你不应该气他。\n"
//     },
//     {
//         "id": 45,
//         "character": "B",
//         "character2": "不好了",
//         "pinyin": "bù hǎo le\n",
//         "comment": "表示发现了意外的不好的情况。\nKo‘ngildagidek bo‘lmagan, yomon holat yuzaga kelganligini ko‘rsatadi. “Yomon bo‘ldi-ya” deb tarjima qilamiz.\n",
//         "reminder": "多有惊慌的语气。\nKo‘p hollarda xavotir ma’nosida keladi.\n",
//         "examples": "不好了！病人昏过去了！\n不好了，小王和小李打起来了，\n"
//     },
//     {
//         "id": 46,
//         "character": "B",
//         "character2": "不好说",
//         "pinyin": "bùhǎoshuō",
//         "comment": "表示对所说的事情不能确定或没有把握。\nIsh-harakatning barchasi aniq emasligini bildiradi. “Aytish qiyin”, “bir narsa deya olmayman” tarzida tarjima qilsa bo‘ladi.\n",
//         "reminder": null,
//         "examples": "甲：天阴得这么厉害，你说会不会下雪呀？\n乙：那可不好说。\n甲：你卖得这么便宜，这东西会不会是假的？\n乙：不好说，要不咱们找个懂行的人来看看？\n"
//     },
//     {
//         "id": 47,
//         "character": "B",
//         "character2": "不好意思",
//         "pinyin": "bù hǎo yìsi",
//         "comment": "为自己给别人带来的或可能带来的不便表示歉意。\nSo‘zlovchining boshqalarga olib kelgan yoki olib kelmoqchi bo‘lgan noqulayliklari uchun uzr so‘rash ma’nosini anglatadi. “Kechirasiz” deb tarjima qilinadi.\n",
//         "reminder": null,
//         "examples": "甲：你怎么还不睡呀？\n乙：不好意思，打扰你休息了。\n不好意思，用一下你的笔行吗？"
//     },
//     {
//         "id": 48,
//         "character": "B",
//         "character2": "不会吧",
//         "pinyin": "bú huì ba",
//         "comment": "表示不相信对方所说的。\nQarshi tomonning gaplariga ishonmaslikni ko‘rsatadi. “Bo‘lishi mumkin emas” tarzida tarjima qilamiz.\n",
//         "reminder": "1) 如果对方所说的是糟糕的情况，表示非常不希望这种情况真的发生。2) 如果情况是好的，表示由于不敢相信是真的而感到惊喜。3) 有时强调对方所说的情况不可能发生。\n(1) Agar qarshi tomon keltirayotgan holat juda ham yomon bo‘lsa, yuqoridagi ibora, o‘sha holatni amalga oshmasligi uchun umid qilishini ko‘rsatadi. 2) Agar qarshi tomon yaxshi holatni keltirsa, unga ishonmaslik yoki qandaydir kutilmagan holat sodir bo‘lishiga umid qilishini bildiradi. 3) Ba’zi hollarda qarshi tomonning keltirgan holati amalga oshmasligiga urg‘u beriladi.\n",
//         "examples": "甲：今天下午咱们的邻居被警察带走了，好像他跟一起杀人案有关系。\n乙：不会吧？他是那么老实的一个人。\n甲：那边那个男生说想请你做她的舞伴。\n乙：不会吧？你说的是那个帅哥？\n甲：他说昨天是因为拉肚子才没来上课的。\n乙：不会吧？昨天晚上我还在烤肉店看见他了呢！"
//     },
//     {
//         "id": 49,
//         "character": "B",
//         "character2": "不会呀",
//         "pinyin": "bú huì ya",
//         "comment": "对对方所说的表示否定，认为这种情况不可能发生。\nSo‘zlovchining qarshi tomonning aytgan so‘zlarini inkor qilib, unday ish sodir bo‘lmaganligini ifodalash maqsadida qo‘llaniladi. “Bo‘lmagan gap” deb tarjima qilsa bo‘ladi.\n",
//         "reminder": "后面一般要给出否定的理由。\nIboraning ketidan inkor qilayotganligining sababi keltiriladi.\n",
//         "examples": "甲：你直达吗？小王和女朋友分手了。\n乙：不会呀，昨天我还看见他们手拉手一起出去呢。\n甲：小美说他不知道今天有考试。\n乙：不会呀，我亲自告诉过她，她怎么会不知道呢？\n"
//     },
//     {
//         "id": 50,
//         "character": "B",
//         "character2": "不简单",
//         "pinyin": "bù jiǎndān",
//         "comment": "表示某人有不平凡的经历或与众不同的能力。\nBiror-bir kishining odatdagi yoki boshqalarga nisbatan yuqori bo‘lgan qobiliyatini ko‘rsatadi. So‘zma-so‘z tarjimasi: “oddiy emas”.\n",
//         "reminder": null,
//         "examples": "他可真不简单，美洲的几大高峰都爬过了。\n甲：这孩子会说好几种语言。\n乙：是吗？真不简单！\n"
//     },
//     {
//         "id": 51,
//         "character": "B",
//         "character2": "不见不散",
//         "pinyin": "bú jiàn bù sàn",
//         "comment": "相约某时在某地见面，先到者如果没见到对方就不离开。\nMa’lum bir uchrashuv ma’lum bir joyda belgilangandan so‘ng, birinchi kelgan insonni ikkinchisi kelmaguncha o‘sha yerni tark etmaslikni so‘rash ma’nosida qo‘llaniladi. “Borgunimcha ketib qolmagin” deb tarjima qilinadi.\n",
//         "reminder": "常用于与人约定见面时。\nMazkur shakl ko‘proq uchrashuv belgilayotgan paytda foydalaniladi.\n",
//         "examples": "咱们今天下午两点动物园门口见，不见不散。\n甲：明天我去机场接你。\n乙：好，不见不散。\n"
//     },
//     {
//         "id": 52,
//         "character": "B",
//         "character2": "不见得",
//         "pinyin": "bú jiàndé\n",
//         "comment": "表示事实和某种说法不完全一样。\nMa’lum bir dalil bilan aytilayotgan so‘z unchalik to‘g‘ri kelmasligini ko‘rsatadi.\n",
//         "reminder": "用于否定对方的看法时，语气比较婉转。\nQarshi tomonning fikrini inkor qilayotganda, ohang nisbatan yumshoq bo‘ladi.\n",
//         "examples": "甲：有了钱什么都能得到。\n乙：不见得吧，真正的爱情能用钱买到吗？\n你打这场官司是为了得到赔偿吗？\n乙：那倒不见得，主要是想得到一个公平的说法。\n有人说“便宜没好货”，我看不见得，现在物美价廉的东西也不少。\n"
//     }
// ]

  //get GetStorage json. return List<DataModel>

  List<DataModel> getData() {
    GetStorage box = GetStorage();
    String text = box.read('json') ?? '';
    print(text);
    if (text.isEmpty) {
      return List<DataModel>.empty();
    } else {
      List<DataModel> data = jsonDecode(text).map<DataModel>((json) => DataModel.fromJson(json)).toList();
      setDataModelList(data);
      return data;
    }
  }

  void saveData(String text) {
    GetStorage box = GetStorage();
    box.write('json', text);
  }

  //search data by character, return List<DataModel> with character contains search string
  List<DataModel> searchByCharacter(String search) {
    List<DataModel> result = getData()
        .where((element) =>
            element.character!.toLowerCase().contains(search.toLowerCase()) ||
            element.pinyin!.toLowerCase().contains(search.toLowerCase()) ||
            element.character2!.toLowerCase().contains(search.toLowerCase()))
        .toList();
    setDataModelList(result);
    return result;
  }
}
