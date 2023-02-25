// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_Hant locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_Hant';

  static String m0(curVersion, newVersion, releaseNote) =>
      "當前版本: ${curVersion}\n最新版本: ${newVersion}\n更新內容:\n${releaseNote}";

  static String m1(url) =>
      "Chaldea——一款跨平台的Fate/GO素材規劃客戶端，支持遊戲資訊瀏覽、從者練度/活動/素材規劃、周常規劃、抽卡模擬器等功能。\n\n詳情請見: \n${url}\n";

  static String m2(version) => "App版本需不低於${version}";

  static String m3(n) => "最多${n}池";

  static String m4(n, total) => "聖杯替換為傳承結晶 ${n}/${total} 個";

  static String m15(filename, hash, localHash) =>
      "文件${filename}未找到或錯誤: ${hash} - ${localHash}";

  static String m16(rarity) => "${rarity}星禮裝PickUp";

  static String m17(rarity) => "${rarity}星從者PickUp";

  static String m5(error) => "導入失敗，Error:\n${error}";

  static String m6(name) => "${name}已存在";

  static String m7(site) => "跳轉到${site}";

  static String m18(shown, total) => "顯示${shown}/總計${total}";

  static String m19(shown, ignore, total) =>
      "顯示${shown}/忽略${ignore}/總計${total}";

  static String m8(first) => "${Intl.select(first, {
            'true': '已經是第一張',
            'false': '已經是最後一張',
            'other': '已經到頭了',
          })}";

  static String m20(layer) => "第${layer}層";

  static String m9(n) => "第${n}節";

  static String m21(region) => "出現錯誤或${region}無此關卡資料";

  static String m22(unknown, dup, valid, total, selected) =>
      "${unknown}不明, ${dup}重複, ${valid}/${total}有效, ${selected}已選";

  static String m10(region) => "${region}公告";

  static String m11(n) => "重置規劃${n}(所有)";

  static String m12(n) => "重置規劃${n}(已顯示)";

  static String m23(battles, ap) => "總計${battles}次戰鬥, ${ap} AP";

  static String m13(n) => "個人資料${n}";

  static String m24(color, trait) => "此寶具顯示為${color}卡，但不持有[${trait}]特性";

  static String m25(trait) => "這是一個寶具，但不持有[${trait}]特性";

  static String m14(a, b) => "${a}${b}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about_app": MessageLookupByLibrary.simpleMessage("關於"),
        "about_app_declaration_text": MessageLookupByLibrary.simpleMessage(
            "本應用所使用資料均來源於遊戲及以下網站，遊戲圖片文本原文等版權屬於TYPE MOON/FGO PROJECT。\n 程序功能與介面設計參考微信小程序\"素材規劃\"以及iOS版Guda。"),
        "about_data_source": MessageLookupByLibrary.simpleMessage("資料來源"),
        "about_data_source_footer":
            MessageLookupByLibrary.simpleMessage("若存在未標註的來源或侵權敬請告知"),
        "about_feedback": MessageLookupByLibrary.simpleMessage("回饋"),
        "about_update_app_detail": m0,
        "account_title": MessageLookupByLibrary.simpleMessage("帳號"),
        "active_skill": MessageLookupByLibrary.simpleMessage("主動技能"),
        "active_skill_short": MessageLookupByLibrary.simpleMessage("主動"),
        "add": MessageLookupByLibrary.simpleMessage("添加"),
        "add_condition": MessageLookupByLibrary.simpleMessage("添加條件"),
        "add_feedback_details_warning":
            MessageLookupByLibrary.simpleMessage("請填寫回饋內容"),
        "add_mission": MessageLookupByLibrary.simpleMessage("添加任務"),
        "add_to_blacklist": MessageLookupByLibrary.simpleMessage("加入黑名單"),
        "anniversary": MessageLookupByLibrary.simpleMessage("周年"),
        "ap": MessageLookupByLibrary.simpleMessage("AP"),
        "ap_campaign_time_mismatch_hint":
            MessageLookupByLibrary.simpleMessage("關卡AP等相關活動顯示的時間(日服除外)可能不準確"),
        "ap_efficiency": MessageLookupByLibrary.simpleMessage("AP效率"),
        "app_data_folder": MessageLookupByLibrary.simpleMessage("數據目錄"),
        "app_data_use_external_storage":
            MessageLookupByLibrary.simpleMessage("使用外部儲存(SD卡)"),
        "append_skill": MessageLookupByLibrary.simpleMessage("追加技能"),
        "append_skill_short": MessageLookupByLibrary.simpleMessage("追加"),
        "april_fool": MessageLookupByLibrary.simpleMessage("愚人節"),
        "ascension": MessageLookupByLibrary.simpleMessage("靈基"),
        "ascension_short": MessageLookupByLibrary.simpleMessage("靈基"),
        "ascension_up": MessageLookupByLibrary.simpleMessage("靈基再臨"),
        "attach_from_files": MessageLookupByLibrary.simpleMessage("從文件選取"),
        "attach_from_photos": MessageLookupByLibrary.simpleMessage("從相簿選取"),
        "attach_help":
            MessageLookupByLibrary.simpleMessage("如果圖片模式存在問題，請使用文件模式"),
        "attachment": MessageLookupByLibrary.simpleMessage("附件"),
        "attack_np_rate": MessageLookupByLibrary.simpleMessage("攻擊NP率"),
        "auth_data_hints": MessageLookupByLibrary.simpleMessage(
            "提醒:\n- 此處userId並非登入/好友頁看到的用戶ID(py碼)\n- 請勿分享上述金鑰(keys)或截圖給其他任何人!!!\n- 以下3種方法選擇其一導入"),
        "auto_reset": MessageLookupByLibrary.simpleMessage("自動重設"),
        "auto_update": MessageLookupByLibrary.simpleMessage("自動更新"),
        "autoplay": MessageLookupByLibrary.simpleMessage("自動播放"),
        "background": MessageLookupByLibrary.simpleMessage("背景"),
        "backup": MessageLookupByLibrary.simpleMessage("備份"),
        "backup_failed": MessageLookupByLibrary.simpleMessage("備份失敗"),
        "backup_history": MessageLookupByLibrary.simpleMessage("歷史備份"),
        "bgm": MessageLookupByLibrary.simpleMessage("BGM"),
        "blacklist": MessageLookupByLibrary.simpleMessage("黑名單"),
        "bond": MessageLookupByLibrary.simpleMessage("羈絆"),
        "bond_craft": MessageLookupByLibrary.simpleMessage("羈絆禮裝"),
        "bond_eff": MessageLookupByLibrary.simpleMessage("羈絆效率"),
        "bond_limit": MessageLookupByLibrary.simpleMessage("羈絆上限"),
        "bootstrap_page_title": MessageLookupByLibrary.simpleMessage("引導頁"),
        "branch_quest": MessageLookupByLibrary.simpleMessage("分支關卡"),
        "bronze": MessageLookupByLibrary.simpleMessage("銅"),
        "buff_check_opponent": MessageLookupByLibrary.simpleMessage("對方"),
        "buff_check_self": MessageLookupByLibrary.simpleMessage("自身"),
        "cache_icons": MessageLookupByLibrary.simpleMessage("暫存圖標"),
        "calc_weight": MessageLookupByLibrary.simpleMessage("權重"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "card_asset_chara_figure": MessageLookupByLibrary.simpleMessage("立繪差分"),
        "card_asset_command": MessageLookupByLibrary.simpleMessage("指令卡"),
        "card_asset_face": MessageLookupByLibrary.simpleMessage("頭像框"),
        "card_asset_narrow_figure":
            MessageLookupByLibrary.simpleMessage("編隊立繪"),
        "card_asset_status": MessageLookupByLibrary.simpleMessage("再臨階段圖標"),
        "card_collection_status": MessageLookupByLibrary.simpleMessage("圖鑑狀態"),
        "card_description": MessageLookupByLibrary.simpleMessage("解說"),
        "card_info": MessageLookupByLibrary.simpleMessage("資料"),
        "card_name": MessageLookupByLibrary.simpleMessage("卡牌名稱"),
        "card_status_met": MessageLookupByLibrary.simpleMessage("已遭遇"),
        "card_status_not_met": MessageLookupByLibrary.simpleMessage("未遭遇"),
        "card_status_owned": MessageLookupByLibrary.simpleMessage("已擁有"),
        "carousel_setting": MessageLookupByLibrary.simpleMessage("輪播設置"),
        "cc_equipped_svt": MessageLookupByLibrary.simpleMessage("已裝備從者"),
        "ce_max_limit_break": MessageLookupByLibrary.simpleMessage("滿破"),
        "chaldea_account": MessageLookupByLibrary.simpleMessage("Chaldea帳號"),
        "chaldea_account_system_hint": MessageLookupByLibrary.simpleMessage(
            "  與V1數據不互通。\n  一個簡易的用於數據備份及多設備同步的帳號系統。\n  沒有安全性保障，請不要設置常用密碼！\n  若不需要上述功能，則無需註冊。"),
        "chaldea_backup": MessageLookupByLibrary.simpleMessage("Chaldea應用備份"),
        "chaldea_gate": MessageLookupByLibrary.simpleMessage("迦勒底之門"),
        "chaldea_server": MessageLookupByLibrary.simpleMessage("Chaldea伺服器"),
        "chaldea_server_cn": MessageLookupByLibrary.simpleMessage("中國"),
        "chaldea_server_global": MessageLookupByLibrary.simpleMessage("國際"),
        "chaldea_server_hint":
            MessageLookupByLibrary.simpleMessage("用於遊戲數據和截圖識別"),
        "chaldea_share_msg": m1,
        "change_log": MessageLookupByLibrary.simpleMessage("更新歷史"),
        "characters_in_card": MessageLookupByLibrary.simpleMessage("出場角色"),
        "check_file_hash": MessageLookupByLibrary.simpleMessage("驗證文件完整性"),
        "check_update": MessageLookupByLibrary.simpleMessage("檢查更新"),
        "clear": MessageLookupByLibrary.simpleMessage("清空"),
        "clear_cache": MessageLookupByLibrary.simpleMessage("清除暫存"),
        "clear_cache_finish": MessageLookupByLibrary.simpleMessage("暫存已清除"),
        "clear_cache_hint": MessageLookupByLibrary.simpleMessage("包括卡面語音等"),
        "clear_data": MessageLookupByLibrary.simpleMessage("清除資料"),
        "coin_summon_num": MessageLookupByLibrary.simpleMessage("召喚所得"),
        "command_code": MessageLookupByLibrary.simpleMessage("指令紋章"),
        "common_release_group_hint": MessageLookupByLibrary.simpleMessage(
            "當存在多組(Group)時，僅需滿足其中一組(Group)條件即可"),
        "condition": MessageLookupByLibrary.simpleMessage("條件"),
        "confirm": MessageLookupByLibrary.simpleMessage("確定"),
        "consumed": MessageLookupByLibrary.simpleMessage("已消耗"),
        "contact_information_not_filled":
            MessageLookupByLibrary.simpleMessage("聯繫方式未填寫"),
        "contact_information_not_filled_warning":
            MessageLookupByLibrary.simpleMessage("將無法無法無法無法無法回覆你的問題"),
        "copied": MessageLookupByLibrary.simpleMessage("已複製"),
        "copy": MessageLookupByLibrary.simpleMessage("複製"),
        "copy_plan_menu": MessageLookupByLibrary.simpleMessage("複製自其他規劃"),
        "cost": MessageLookupByLibrary.simpleMessage("消耗"),
        "costume": MessageLookupByLibrary.simpleMessage("靈衣"),
        "costume_unlock": MessageLookupByLibrary.simpleMessage("靈衣開放"),
        "count_rare_enemy": MessageLookupByLibrary.simpleMessage("計算稀有敵人"),
        "counts": MessageLookupByLibrary.simpleMessage("計數"),
        "craft_essence": MessageLookupByLibrary.simpleMessage("概念禮裝"),
        "create_account_textfield_helper":
            MessageLookupByLibrary.simpleMessage("稍後在設置中可以添加更多遊戲帳號"),
        "create_duplicated_svt": MessageLookupByLibrary.simpleMessage("生成2號機"),
        "crit_star_mod": MessageLookupByLibrary.simpleMessage("爆擊星補正"),
        "cur_account": MessageLookupByLibrary.simpleMessage("當前帳號"),
        "current_": MessageLookupByLibrary.simpleMessage("當前"),
        "current_version": MessageLookupByLibrary.simpleMessage("當前版本"),
        "custom_mission": MessageLookupByLibrary.simpleMessage("自訂任務"),
        "custom_mission_mixed_type_hint":
            MessageLookupByLibrary.simpleMessage("同一任務中敵人類條件與關卡類條件不可一起使用"),
        "custom_mission_nothing_hint":
            MessageLookupByLibrary.simpleMessage("無任務，點擊+添加"),
        "custom_mission_source_mission":
            MessageLookupByLibrary.simpleMessage("原任務"),
        "daily_ember_quest": MessageLookupByLibrary.simpleMessage("蒐集種火"),
        "daily_qp_quest": MessageLookupByLibrary.simpleMessage("打開寶物庫之門"),
        "daily_training_quest": MessageLookupByLibrary.simpleMessage("修練場"),
        "damage_rate": MessageLookupByLibrary.simpleMessage("傷害係數"),
        "dark_mode": MessageLookupByLibrary.simpleMessage("深色模式"),
        "dark_mode_dark": MessageLookupByLibrary.simpleMessage("深色"),
        "dark_mode_light": MessageLookupByLibrary.simpleMessage("淺色"),
        "dark_mode_system": MessageLookupByLibrary.simpleMessage("系統"),
        "database": MessageLookupByLibrary.simpleMessage("Database"),
        "database_not_downloaded":
            MessageLookupByLibrary.simpleMessage("資料庫未下載，仍然繼續?"),
        "dataset_version": MessageLookupByLibrary.simpleMessage("數據版本"),
        "date": MessageLookupByLibrary.simpleMessage("日期"),
        "debug": MessageLookupByLibrary.simpleMessage("Debug"),
        "debug_fab": MessageLookupByLibrary.simpleMessage("Debug FAB"),
        "debug_menu": MessageLookupByLibrary.simpleMessage("Debug Menu"),
        "def_np_gain_mod": MessageLookupByLibrary.simpleMessage("敵攻擊補正"),
        "defense_np_rate": MessageLookupByLibrary.simpleMessage("受擊NP率"),
        "delete": MessageLookupByLibrary.simpleMessage("刪除"),
        "delete_unreleased_card":
            MessageLookupByLibrary.simpleMessage("刪除未實裝卡牌"),
        "demands": MessageLookupByLibrary.simpleMessage("需求"),
        "desktop_only": MessageLookupByLibrary.simpleMessage("僅限桌面版"),
        "details": MessageLookupByLibrary.simpleMessage("詳細"),
        "detective_mission": MessageLookupByLibrary.simpleMessage("偵探任務"),
        "detective_rank": MessageLookupByLibrary.simpleMessage("偵探等級"),
        "display_grid": MessageLookupByLibrary.simpleMessage("網格"),
        "display_list": MessageLookupByLibrary.simpleMessage("列表"),
        "display_setting": MessageLookupByLibrary.simpleMessage("顯示設置"),
        "display_show_window_fab":
            MessageLookupByLibrary.simpleMessage("顯示多分頁按鈕"),
        "done": MessageLookupByLibrary.simpleMessage("完成"),
        "download": MessageLookupByLibrary.simpleMessage("下載"),
        "download_latest_gamedata_hint":
            MessageLookupByLibrary.simpleMessage("為確保兼容性，更新前請升級至最新版APP"),
        "download_source": MessageLookupByLibrary.simpleMessage("下載源"),
        "download_source_hint":
            MessageLookupByLibrary.simpleMessage("大陸地區請選擇大陸節點"),
        "downloaded": MessageLookupByLibrary.simpleMessage("已下載"),
        "downloading": MessageLookupByLibrary.simpleMessage("下載中"),
        "drop_calc_empty_hint":
            MessageLookupByLibrary.simpleMessage("點擊 + 添加素材"),
        "drop_calc_min_ap": MessageLookupByLibrary.simpleMessage("最低AP"),
        "drop_calc_solve": MessageLookupByLibrary.simpleMessage("求解"),
        "drop_rate": MessageLookupByLibrary.simpleMessage("掉率"),
        "duplicated_servant": MessageLookupByLibrary.simpleMessage("2號機"),
        "duplicated_servant_duplicated":
            MessageLookupByLibrary.simpleMessage("2號機"),
        "duplicated_servant_primary":
            MessageLookupByLibrary.simpleMessage("初號機"),
        "edit": MessageLookupByLibrary.simpleMessage("編輯"),
        "effect_scope": MessageLookupByLibrary.simpleMessage("效果範圍"),
        "effect_search": MessageLookupByLibrary.simpleMessage("效果檢索"),
        "effect_search_trait_hint": MessageLookupByLibrary.simpleMessage(
            "Func/Buff的生效條件，其中毒/詛咒/灼傷也篩選含有該特性的buff"),
        "effect_target": MessageLookupByLibrary.simpleMessage("效果對象"),
        "effect_type": MessageLookupByLibrary.simpleMessage("效果類型"),
        "effective_condition": MessageLookupByLibrary.simpleMessage("生效條件"),
        "efficiency": MessageLookupByLibrary.simpleMessage("效率"),
        "efficiency_type": MessageLookupByLibrary.simpleMessage("效率類型"),
        "efficiency_type_ap": MessageLookupByLibrary.simpleMessage("20AP效率"),
        "efficiency_type_drop": MessageLookupByLibrary.simpleMessage("每場掉率"),
        "email": MessageLookupByLibrary.simpleMessage("郵箱"),
        "empty_hint": MessageLookupByLibrary.simpleMessage("空無一物"),
        "enemy": MessageLookupByLibrary.simpleMessage("敵人"),
        "enemy_filter_trait_hint":
            MessageLookupByLibrary.simpleMessage("特性篩選僅適用於主線FQ的敵人"),
        "enemy_leader_hint":
            MessageLookupByLibrary.simpleMessage("首領:被擊敗時戰鬥結束"),
        "enemy_list": MessageLookupByLibrary.simpleMessage("敵人一覽"),
        "enemy_summary": MessageLookupByLibrary.simpleMessage("敵人彙總"),
        "enhance": MessageLookupByLibrary.simpleMessage("強化"),
        "enhance_warning": MessageLookupByLibrary.simpleMessage("強化將扣除以下素材"),
        "error": MessageLookupByLibrary.simpleMessage("錯誤"),
        "error_no_data_found": MessageLookupByLibrary.simpleMessage("未找到數據文件"),
        "error_no_internet": MessageLookupByLibrary.simpleMessage("無網路連接"),
        "error_required_app_version": m2,
        "error_widget_hint":
            MessageLookupByLibrary.simpleMessage("錯誤! 請點擊返回 >_<"),
        "event": MessageLookupByLibrary.simpleMessage("活動"),
        "event_ap_cost_half": MessageLookupByLibrary.simpleMessage("AP消費減半"),
        "event_bonus": MessageLookupByLibrary.simpleMessage("加成"),
        "event_bulletin_board": MessageLookupByLibrary.simpleMessage("咕咕報"),
        "event_campaign": MessageLookupByLibrary.simpleMessage("活動"),
        "event_collect_item_confirm":
            MessageLookupByLibrary.simpleMessage("所有素材添加到素材倉庫，並將該活動移出規劃"),
        "event_collect_items": MessageLookupByLibrary.simpleMessage("收取素材"),
        "event_cooltime": MessageLookupByLibrary.simpleMessage("冷卻時間"),
        "event_custom_item": MessageLookupByLibrary.simpleMessage("自訂可獲得素材"),
        "event_custom_item_empty_hint":
            MessageLookupByLibrary.simpleMessage("點擊+按鈕自訂可獲得素材"),
        "event_digging": MessageLookupByLibrary.simpleMessage("發掘"),
        "event_fortification": MessageLookupByLibrary.simpleMessage("強化"),
        "event_item_extra": MessageLookupByLibrary.simpleMessage("額外素材"),
        "event_item_fixed_extra":
            MessageLookupByLibrary.simpleMessage("額外固定素材"),
        "event_lottery": MessageLookupByLibrary.simpleMessage("獎池"),
        "event_lottery_limit_hint": m3,
        "event_lottery_limited": MessageLookupByLibrary.simpleMessage("有限池"),
        "event_lottery_unit": MessageLookupByLibrary.simpleMessage("池"),
        "event_lottery_unlimited": MessageLookupByLibrary.simpleMessage("無限池"),
        "event_not_planned": MessageLookupByLibrary.simpleMessage("活動未列入規劃"),
        "event_only_trait_hint": MessageLookupByLibrary.simpleMessage(
            "這可能是一個活動限定的特性。\n常規從者/敵人可能不包含此特性，但可能包含同名但不同ID的特性。\n部分特性雖未翻譯出從者，但活動中可能是從者限定特性。"),
        "event_point": MessageLookupByLibrary.simpleMessage("活動點數"),
        "event_point_reward": MessageLookupByLibrary.simpleMessage("點數"),
        "event_progress": MessageLookupByLibrary.simpleMessage("進度"),
        "event_quest": MessageLookupByLibrary.simpleMessage("活動關卡"),
        "event_recipe": MessageLookupByLibrary.simpleMessage("配方"),
        "event_rerun_replace_grail": m4,
        "event_shop": MessageLookupByLibrary.simpleMessage("活動商店"),
        "event_skill": MessageLookupByLibrary.simpleMessage("活動技能"),
        "event_tower": MessageLookupByLibrary.simpleMessage("塔"),
        "event_treasure_box": MessageLookupByLibrary.simpleMessage("寶箱"),
        "exchange_count": MessageLookupByLibrary.simpleMessage("可交換次數"),
        "exchange_ticket": MessageLookupByLibrary.simpleMessage("素材交換券"),
        "exchange_ticket_short": MessageLookupByLibrary.simpleMessage("交換券"),
        "exp_card_plan_lv": MessageLookupByLibrary.simpleMessage("等級"),
        "exp_card_plan_next": MessageLookupByLibrary.simpleMessage("距離下一級"),
        "exp_card_same_class": MessageLookupByLibrary.simpleMessage("相同職階"),
        "exp_card_title": MessageLookupByLibrary.simpleMessage("種火需求"),
        "failed": MessageLookupByLibrary.simpleMessage("失敗"),
        "faq": MessageLookupByLibrary.simpleMessage("FAQ"),
        "favorite": MessageLookupByLibrary.simpleMessage("關注"),
        "feedback_add_attachments":
            MessageLookupByLibrary.simpleMessage("e.g. 截圖等文件"),
        "feedback_contact": MessageLookupByLibrary.simpleMessage("聯繫方式"),
        "feedback_content_hint": MessageLookupByLibrary.simpleMessage("回饋與建議"),
        "feedback_form_alert":
            MessageLookupByLibrary.simpleMessage("回饋表未提交，仍然退出?"),
        "feedback_info": MessageLookupByLibrary.simpleMessage(
            "提交回饋前，請先查閱<**FAQ**>。回饋時請詳細描述:\n- 如何再現/期望表現\n- 應用/數據版本、使用設備系統及版本\n- 附加截圖日誌\n- 以及最好能夠提供聯繫方式(郵箱等)"),
        "feedback_send": MessageLookupByLibrary.simpleMessage("發送"),
        "feedback_subject": MessageLookupByLibrary.simpleMessage("主題"),
        "ffo_body": MessageLookupByLibrary.simpleMessage("身體"),
        "ffo_crop": MessageLookupByLibrary.simpleMessage("裁剪"),
        "ffo_head": MessageLookupByLibrary.simpleMessage("頭部"),
        "ffo_missing_data_hint":
            MessageLookupByLibrary.simpleMessage("請先下載或導入FGO資源包↗"),
        "ffo_same_svt": MessageLookupByLibrary.simpleMessage("同一從者"),
        "fgo_domus_aurea": MessageLookupByLibrary.simpleMessage("效率劇場"),
        "field_ai": MessageLookupByLibrary.simpleMessage("場地AI"),
        "file_not_found_or_mismatched_hash": m15,
        "filename": MessageLookupByLibrary.simpleMessage("文件名"),
        "fill_email_warning": MessageLookupByLibrary.simpleMessage(
            "建議填寫郵件聯繫方式，否則將無法得到回覆！！！請勿填寫Whatsapp/Line/電話號碼！"),
        "filter": MessageLookupByLibrary.simpleMessage("篩選"),
        "filter_atk_hp_type": MessageLookupByLibrary.simpleMessage("屬性"),
        "filter_attribute": MessageLookupByLibrary.simpleMessage("陣營"),
        "filter_category": MessageLookupByLibrary.simpleMessage("分類"),
        "filter_effects": MessageLookupByLibrary.simpleMessage("效果"),
        "filter_match_all": MessageLookupByLibrary.simpleMessage("全匹配"),
        "filter_obtain": MessageLookupByLibrary.simpleMessage("獲取方式"),
        "filter_plan_not_reached": MessageLookupByLibrary.simpleMessage("規劃未滿"),
        "filter_plan_reached": MessageLookupByLibrary.simpleMessage("已滿"),
        "filter_revert": MessageLookupByLibrary.simpleMessage("反向匹配"),
        "filter_shown_type": MessageLookupByLibrary.simpleMessage("顯示"),
        "filter_skill_lv": MessageLookupByLibrary.simpleMessage("技能等級"),
        "filter_sort": MessageLookupByLibrary.simpleMessage("排序"),
        "filter_sort_number": MessageLookupByLibrary.simpleMessage("序號"),
        "filter_sort_rarity": MessageLookupByLibrary.simpleMessage("星級"),
        "foukun": MessageLookupByLibrary.simpleMessage("芙芙"),
        "fq_plan_decimal_hint":
            MessageLookupByLibrary.simpleMessage("小數不顯示，顯示結果計算結果可能存在±1誤差"),
        "free_progress": MessageLookupByLibrary.simpleMessage("FQ進度"),
        "free_progress_newest": MessageLookupByLibrary.simpleMessage("日服最新"),
        "free_quest": MessageLookupByLibrary.simpleMessage("Free Quest"),
        "free_quest_calculator": MessageLookupByLibrary.simpleMessage("FQ速查"),
        "free_quest_calculator_short":
            MessageLookupByLibrary.simpleMessage("FQ速查"),
        "gacha_prob_calc": MessageLookupByLibrary.simpleMessage("卡池機率計算"),
        "gacha_prob_ce_pickup": m16,
        "gacha_prob_custom_rate": MessageLookupByLibrary.simpleMessage("自訂機率"),
        "gacha_prob_precision_hint": MessageLookupByLibrary.simpleMessage(
            "數值過大或過小時由於double精度問題造成計算結果不準確"),
        "gacha_prob_svt_pickup": m17,
        "gallery_tab_name": MessageLookupByLibrary.simpleMessage("首頁"),
        "game_account": MessageLookupByLibrary.simpleMessage("遊戲帳號"),
        "game_data_not_found":
            MessageLookupByLibrary.simpleMessage("數據加載失敗, 請先前往遊戲數據頁面下載"),
        "game_drop": MessageLookupByLibrary.simpleMessage("掉落"),
        "game_experience": MessageLookupByLibrary.simpleMessage("經驗"),
        "game_kizuna": MessageLookupByLibrary.simpleMessage("羈絆"),
        "game_rewards": MessageLookupByLibrary.simpleMessage("獎勵"),
        "game_server": MessageLookupByLibrary.simpleMessage("遊戲區服"),
        "gamedata": MessageLookupByLibrary.simpleMessage("遊戲數據"),
        "gender": MessageLookupByLibrary.simpleMessage("性別"),
        "general_all": MessageLookupByLibrary.simpleMessage("所有"),
        "general_close": MessageLookupByLibrary.simpleMessage("關閉"),
        "general_custom": MessageLookupByLibrary.simpleMessage("自訂"),
        "general_default": MessageLookupByLibrary.simpleMessage("預設"),
        "general_others": MessageLookupByLibrary.simpleMessage("其他"),
        "general_special": MessageLookupByLibrary.simpleMessage("特殊"),
        "general_type": MessageLookupByLibrary.simpleMessage("類型"),
        "global_text_selection":
            MessageLookupByLibrary.simpleMessage("全局文本可選擇"),
        "glpk_error_no_valid_target":
            MessageLookupByLibrary.simpleMessage("無相關目標"),
        "gold": MessageLookupByLibrary.simpleMessage("金"),
        "grail": MessageLookupByLibrary.simpleMessage("聖杯"),
        "grail_up": MessageLookupByLibrary.simpleMessage("聖杯轉臨"),
        "growth_curve": MessageLookupByLibrary.simpleMessage("成長曲線"),
        "guda_female": MessageLookupByLibrary.simpleMessage("咕噠子"),
        "guda_male": MessageLookupByLibrary.simpleMessage("咕噠夫"),
        "help": MessageLookupByLibrary.simpleMessage("幫助"),
        "hide": MessageLookupByLibrary.simpleMessage("隱藏"),
        "hide_outdated": MessageLookupByLibrary.simpleMessage("隱藏已過期"),
        "hide_svt_plan_details": MessageLookupByLibrary.simpleMessage("隱藏規劃項目"),
        "hide_svt_plan_details_hint": MessageLookupByLibrary.simpleMessage(
            "僅僅是在從者詳情規劃頁不顯示，實際仍計入素材規劃與統計。"),
        "hide_unreleased_card": MessageLookupByLibrary.simpleMessage("隱藏未實裝卡牌"),
        "high_difficulty_quest": MessageLookupByLibrary.simpleMessage("高難度關卡"),
        "history": MessageLookupByLibrary.simpleMessage("歷史紀錄"),
        "http_sniff_hint":
            MessageLookupByLibrary.simpleMessage("(簡中/繁中/日/美)帳號登入時的數據"),
        "https_sniff": MessageLookupByLibrary.simpleMessage("Https監聽"),
        "hunting_quest": MessageLookupByLibrary.simpleMessage("狩獵關卡"),
        "icons": MessageLookupByLibrary.simpleMessage("圖示"),
        "ignore": MessageLookupByLibrary.simpleMessage("忽略"),
        "illustration": MessageLookupByLibrary.simpleMessage("卡面"),
        "illustrator": MessageLookupByLibrary.simpleMessage("畫師"),
        "image": MessageLookupByLibrary.simpleMessage("圖片"),
        "import_active_skill_hint":
            MessageLookupByLibrary.simpleMessage("強化 - 從者技能強化"),
        "import_active_skill_screenshots":
            MessageLookupByLibrary.simpleMessage("主動技能截圖解析"),
        "import_append_skill_hint":
            MessageLookupByLibrary.simpleMessage("強化 - 被動技能強化"),
        "import_append_skill_screenshots":
            MessageLookupByLibrary.simpleMessage("追加技能截圖解析"),
        "import_auth_file": MessageLookupByLibrary.simpleMessage("引繼文件"),
        "import_backup": MessageLookupByLibrary.simpleMessage("導入備份"),
        "import_csv_export_all": MessageLookupByLibrary.simpleMessage("所有從者"),
        "import_csv_export_empty": MessageLookupByLibrary.simpleMessage("空模板"),
        "import_csv_export_favorite":
            MessageLookupByLibrary.simpleMessage("僅關注從者"),
        "import_csv_export_template":
            MessageLookupByLibrary.simpleMessage("導出模板"),
        "import_csv_load_csv": MessageLookupByLibrary.simpleMessage("載入CSV"),
        "import_csv_title": MessageLookupByLibrary.simpleMessage("CSV模板"),
        "import_data": MessageLookupByLibrary.simpleMessage("導入"),
        "import_data_error": m5,
        "import_data_success": MessageLookupByLibrary.simpleMessage("成功導入資料"),
        "import_from_clipboard": MessageLookupByLibrary.simpleMessage("從剪切板"),
        "import_from_file": MessageLookupByLibrary.simpleMessage("從文件"),
        "import_http_body_duplicated":
            MessageLookupByLibrary.simpleMessage("允許2號機"),
        "import_http_body_hint": MessageLookupByLibrary.simpleMessage(
            "點擊右上角導入解密的HTTPS回應包以導入帳戶資料\n點擊幫助以查看如何捕獲並解密HTTPS回應內容"),
        "import_http_body_hint_hide":
            MessageLookupByLibrary.simpleMessage("點擊從者可隱藏/取消隱藏該從者"),
        "import_http_body_locked": MessageLookupByLibrary.simpleMessage("僅鎖定"),
        "import_image": MessageLookupByLibrary.simpleMessage("導入圖片"),
        "import_item_hint": MessageLookupByLibrary.simpleMessage("個人空間 - 道具一覽"),
        "import_item_screenshots":
            MessageLookupByLibrary.simpleMessage("素材截圖解析"),
        "import_screenshot": MessageLookupByLibrary.simpleMessage("導入截圖"),
        "import_screenshot_hint":
            MessageLookupByLibrary.simpleMessage("僅更新識別成功的結果"),
        "import_screenshot_update_items":
            MessageLookupByLibrary.simpleMessage("更新素材"),
        "import_source_file": MessageLookupByLibrary.simpleMessage("導入源資料"),
        "import_userdata_more": MessageLookupByLibrary.simpleMessage("更多導入方式"),
        "info_agility": MessageLookupByLibrary.simpleMessage("敏捷"),
        "info_alignment": MessageLookupByLibrary.simpleMessage("屬性"),
        "info_bond_points": MessageLookupByLibrary.simpleMessage("羈絆點數"),
        "info_bond_points_single": MessageLookupByLibrary.simpleMessage("點數"),
        "info_bond_points_sum": MessageLookupByLibrary.simpleMessage("累積"),
        "info_cards": MessageLookupByLibrary.simpleMessage("配卡"),
        "info_charge": MessageLookupByLibrary.simpleMessage("充能"),
        "info_critical_rate": MessageLookupByLibrary.simpleMessage("爆擊權重"),
        "info_cv": MessageLookupByLibrary.simpleMessage("聲優"),
        "info_death_rate": MessageLookupByLibrary.simpleMessage("即死率"),
        "info_endurance": MessageLookupByLibrary.simpleMessage("耐久"),
        "info_luck": MessageLookupByLibrary.simpleMessage("幸運"),
        "info_mana": MessageLookupByLibrary.simpleMessage("魔力"),
        "info_np": MessageLookupByLibrary.simpleMessage("寶具"),
        "info_np_rate": MessageLookupByLibrary.simpleMessage("NP獲得率"),
        "info_star_rate": MessageLookupByLibrary.simpleMessage("產星率"),
        "info_strength": MessageLookupByLibrary.simpleMessage("筋力"),
        "info_value": MessageLookupByLibrary.simpleMessage("數值"),
        "input_invalid_hint": MessageLookupByLibrary.simpleMessage("輸入無效"),
        "install": MessageLookupByLibrary.simpleMessage("安裝"),
        "interlude": MessageLookupByLibrary.simpleMessage("幕間物語"),
        "interlude_and_rankup": MessageLookupByLibrary.simpleMessage("幕間&強化"),
        "invalid_input": MessageLookupByLibrary.simpleMessage("無效輸入"),
        "invalid_startup_path": MessageLookupByLibrary.simpleMessage("無效啟動路徑!"),
        "invalid_startup_path_info": MessageLookupByLibrary.simpleMessage(
            "請解壓文件至非系統目錄再重新啟動應用。\"C:\\\", \"C:\\Program Files\"等路徑為無效路徑."),
        "ios_app_path":
            MessageLookupByLibrary.simpleMessage("\"文件\"應用/我的iPhone/Chaldea"),
        "issues": MessageLookupByLibrary.simpleMessage("常見問題"),
        "item": MessageLookupByLibrary.simpleMessage("素材"),
        "item_already_exist_hint": m6,
        "item_apple": MessageLookupByLibrary.simpleMessage("蘋果"),
        "item_category_ascension": MessageLookupByLibrary.simpleMessage("職階棋子"),
        "item_category_bronze": MessageLookupByLibrary.simpleMessage("銅素材"),
        "item_category_event_svt_ascension":
            MessageLookupByLibrary.simpleMessage("活動從者靈基再臨素材"),
        "item_category_gem": MessageLookupByLibrary.simpleMessage("輝石"),
        "item_category_gems": MessageLookupByLibrary.simpleMessage("技能石"),
        "item_category_gold": MessageLookupByLibrary.simpleMessage("金素材"),
        "item_category_magic_gem": MessageLookupByLibrary.simpleMessage("魔石"),
        "item_category_monument": MessageLookupByLibrary.simpleMessage("金像"),
        "item_category_others": MessageLookupByLibrary.simpleMessage("其他"),
        "item_category_piece": MessageLookupByLibrary.simpleMessage("銀棋"),
        "item_category_secret_gem": MessageLookupByLibrary.simpleMessage("秘石"),
        "item_category_silver": MessageLookupByLibrary.simpleMessage("銀素材"),
        "item_category_special": MessageLookupByLibrary.simpleMessage("特殊素材"),
        "item_category_usual": MessageLookupByLibrary.simpleMessage("普通素材"),
        "item_edit_owned_amount": MessageLookupByLibrary.simpleMessage("修改庫存"),
        "item_eff": MessageLookupByLibrary.simpleMessage("素材效率"),
        "item_exceed_hint": MessageLookupByLibrary.simpleMessage(
            "計算規劃遷，可以設置不同材料的剩餘量(僅用於于FQ規劃)"),
        "item_grail2crystal": MessageLookupByLibrary.simpleMessage("聖杯→傳承結晶"),
        "item_left": MessageLookupByLibrary.simpleMessage("剩餘"),
        "item_no_free_quests": MessageLookupByLibrary.simpleMessage("無FQ"),
        "item_only_show_lack": MessageLookupByLibrary.simpleMessage("僅顯示不足"),
        "item_own": MessageLookupByLibrary.simpleMessage("擁有"),
        "item_screenshot": MessageLookupByLibrary.simpleMessage("素材截圖"),
        "item_stat_include_owned": MessageLookupByLibrary.simpleMessage("包含庫存"),
        "item_stat_sub_event": MessageLookupByLibrary.simpleMessage("減去活動所得"),
        "item_stat_sub_owned": MessageLookupByLibrary.simpleMessage("減去庫存"),
        "item_total_demand": MessageLookupByLibrary.simpleMessage("共需"),
        "join_beta": MessageLookupByLibrary.simpleMessage("加入Beta版"),
        "jump_to": m7,
        "language": MessageLookupByLibrary.simpleMessage("繁體中文"),
        "language_en":
            MessageLookupByLibrary.simpleMessage("Traditional Chinese"),
        "level": MessageLookupByLibrary.simpleMessage("等級"),
        "limited_event": MessageLookupByLibrary.simpleMessage("限時活動"),
        "limited_time": MessageLookupByLibrary.simpleMessage("限時"),
        "link": MessageLookupByLibrary.simpleMessage("連結"),
        "list_count_shown_all": m18,
        "list_count_shown_hidden_all": m19,
        "list_end_hint": m8,
        "load_ffo_data": MessageLookupByLibrary.simpleMessage("加載FFO資料"),
        "logic_type": MessageLookupByLibrary.simpleMessage("邏輯關係"),
        "logic_type_and": MessageLookupByLibrary.simpleMessage("且"),
        "logic_type_or": MessageLookupByLibrary.simpleMessage("或"),
        "login_auth": MessageLookupByLibrary.simpleMessage("登入憑證(Auth)"),
        "login_change_name": MessageLookupByLibrary.simpleMessage("修改用戶名"),
        "login_change_password": MessageLookupByLibrary.simpleMessage("修改密碼"),
        "login_confirm_password": MessageLookupByLibrary.simpleMessage("確認密碼"),
        "login_first_hint": MessageLookupByLibrary.simpleMessage("請先登入"),
        "login_forget_pwd": MessageLookupByLibrary.simpleMessage("忘記密碼"),
        "login_login": MessageLookupByLibrary.simpleMessage("登入"),
        "login_logout": MessageLookupByLibrary.simpleMessage("登出"),
        "login_new_name": MessageLookupByLibrary.simpleMessage("新用戶名"),
        "login_new_password": MessageLookupByLibrary.simpleMessage("新密碼"),
        "login_password": MessageLookupByLibrary.simpleMessage("密碼"),
        "login_password_error":
            MessageLookupByLibrary.simpleMessage("6-18位字母和數字，至少包含一個字母"),
        "login_password_error_same_as_old":
            MessageLookupByLibrary.simpleMessage("不能與舊密碼相同"),
        "login_signup": MessageLookupByLibrary.simpleMessage("註冊"),
        "login_state_not_login": MessageLookupByLibrary.simpleMessage("未登入"),
        "login_username": MessageLookupByLibrary.simpleMessage("用戶名"),
        "login_username_error":
            MessageLookupByLibrary.simpleMessage("只能包含字母與數字，字母開頭，不少於4位"),
        "long_press_to_save_hint": MessageLookupByLibrary.simpleMessage("長按保存"),
        "lottery_cost_per_roll": MessageLookupByLibrary.simpleMessage("每抽消耗"),
        "lucky_bag": MessageLookupByLibrary.simpleMessage("福袋"),
        "lucky_bag_best": MessageLookupByLibrary.simpleMessage("最佳"),
        "lucky_bag_expectation": MessageLookupByLibrary.simpleMessage("期望值"),
        "lucky_bag_expectation_short":
            MessageLookupByLibrary.simpleMessage("期望"),
        "lucky_bag_rating": MessageLookupByLibrary.simpleMessage("評分"),
        "lucky_bag_tooltip_unwanted":
            MessageLookupByLibrary.simpleMessage("非常不想要"),
        "lucky_bag_tooltip_wanted":
            MessageLookupByLibrary.simpleMessage("非常想要!"),
        "lucky_bag_worst": MessageLookupByLibrary.simpleMessage("最差"),
        "main_interlude": MessageLookupByLibrary.simpleMessage("主線分支"),
        "main_quest": MessageLookupByLibrary.simpleMessage("主線關卡"),
        "main_story": MessageLookupByLibrary.simpleMessage("主線記錄"),
        "main_story_chapter": MessageLookupByLibrary.simpleMessage("章節"),
        "map_gimmicks": MessageLookupByLibrary.simpleMessage("小部件"),
        "map_layer_n": m20,
        "map_show_fq_spots_only":
            MessageLookupByLibrary.simpleMessage("僅有Free Quest地點"),
        "map_show_header_image": MessageLookupByLibrary.simpleMessage("顯示標題圖"),
        "map_show_roads": MessageLookupByLibrary.simpleMessage("顯示道路"),
        "map_show_spots": MessageLookupByLibrary.simpleMessage("顯示地點"),
        "master_detail_width":
            MessageLookupByLibrary.simpleMessage("Master-Detail width"),
        "master_mission": MessageLookupByLibrary.simpleMessage("御主任務"),
        "master_mission_related_quest":
            MessageLookupByLibrary.simpleMessage("關聯關卡"),
        "master_mission_solution": MessageLookupByLibrary.simpleMessage("方案"),
        "master_mission_tasklist": MessageLookupByLibrary.simpleMessage("任務列表"),
        "master_mission_weekly": MessageLookupByLibrary.simpleMessage("每週任務"),
        "max_enemy_act_count": MessageLookupByLibrary.simpleMessage("敵方最多行動次數"),
        "max_enemy_on_stage": MessageLookupByLibrary.simpleMessage("場上最大敵人數"),
        "media_assets": MessageLookupByLibrary.simpleMessage("資源"),
        "migrate_external_storage_btn_no":
            MessageLookupByLibrary.simpleMessage("不轉移"),
        "migrate_external_storage_btn_yes":
            MessageLookupByLibrary.simpleMessage("轉移"),
        "migrate_external_storage_manual_warning":
            MessageLookupByLibrary.simpleMessage("請手動移動數據, 否則啟動後為空數據"),
        "migrate_external_storage_title":
            MessageLookupByLibrary.simpleMessage("轉移資料"),
        "mission": MessageLookupByLibrary.simpleMessage("任務"),
        "move_down": MessageLookupByLibrary.simpleMessage("下移"),
        "move_up": MessageLookupByLibrary.simpleMessage("上移"),
        "mystic_code": MessageLookupByLibrary.simpleMessage("魔術禮裝"),
        "network_cur_connection": MessageLookupByLibrary.simpleMessage("當前連接"),
        "network_force_online": MessageLookupByLibrary.simpleMessage("強制在線模式"),
        "network_force_online_hint":
            MessageLookupByLibrary.simpleMessage("當未檢測到網絡連接時，App將預設處於離線模式"),
        "network_settings": MessageLookupByLibrary.simpleMessage("網路設置"),
        "new_account": MessageLookupByLibrary.simpleMessage("新建帳號"),
        "new_data_available": MessageLookupByLibrary.simpleMessage("有可用數據更新"),
        "new_drop_data_6th": MessageLookupByLibrary.simpleMessage("新掉落數據"),
        "next_card": MessageLookupByLibrary.simpleMessage("下一張"),
        "next_page": MessageLookupByLibrary.simpleMessage("下一頁"),
        "no_servant_quest_hint":
            MessageLookupByLibrary.simpleMessage("無幕間或強化關卡"),
        "no_servant_quest_hint_subtitle":
            MessageLookupByLibrary.simpleMessage("點擊♡查看所有從者任務"),
        "noble_phantasm": MessageLookupByLibrary.simpleMessage("寶具"),
        "noble_phantasm_level": MessageLookupByLibrary.simpleMessage("寶具等級"),
        "not_found": MessageLookupByLibrary.simpleMessage("Not Found"),
        "not_implemented": MessageLookupByLibrary.simpleMessage("尚未實現"),
        "not_outdated": MessageLookupByLibrary.simpleMessage("未過期"),
        "np_charge": MessageLookupByLibrary.simpleMessage("NP充能"),
        "np_charge_type_instant": MessageLookupByLibrary.simpleMessage("直充"),
        "np_charge_type_instant_sum":
            MessageLookupByLibrary.simpleMessage("直充總計"),
        "np_charge_type_perturn": MessageLookupByLibrary.simpleMessage("緩充"),
        "np_gain_mod": MessageLookupByLibrary.simpleMessage("敵受擊補正"),
        "np_short": MessageLookupByLibrary.simpleMessage("寶具"),
        "obtain_time": MessageLookupByLibrary.simpleMessage("時間"),
        "ok": MessageLookupByLibrary.simpleMessage("確定"),
        "one_off_quest": MessageLookupByLibrary.simpleMessage("一次性關卡"),
        "only_show_main_story_enemy":
            MessageLookupByLibrary.simpleMessage("僅顯示主線FQ敵人"),
        "open": MessageLookupByLibrary.simpleMessage("打開"),
        "open_condition": MessageLookupByLibrary.simpleMessage("開放條件"),
        "open_in_file_manager":
            MessageLookupByLibrary.simpleMessage("請用文件管理器打開"),
        "opening_time": MessageLookupByLibrary.simpleMessage("開放時間"),
        "outdated": MessageLookupByLibrary.simpleMessage("已過期"),
        "overview": MessageLookupByLibrary.simpleMessage("概覽"),
        "passive_skill": MessageLookupByLibrary.simpleMessage("被動技能"),
        "passive_skill_short": MessageLookupByLibrary.simpleMessage("被動"),
        "permanent": MessageLookupByLibrary.simpleMessage("永久"),
        "plan": MessageLookupByLibrary.simpleMessage("規劃"),
        "plan_list_only_unlock_append":
            MessageLookupByLibrary.simpleMessage("僅已解鎖追加"),
        "plan_list_set_all": MessageLookupByLibrary.simpleMessage("批量設置"),
        "plan_list_set_all_current": MessageLookupByLibrary.simpleMessage("當前"),
        "plan_list_set_all_target": MessageLookupByLibrary.simpleMessage("目標"),
        "plan_max10": MessageLookupByLibrary.simpleMessage("規劃最大化(310)"),
        "plan_max9": MessageLookupByLibrary.simpleMessage("規劃最大化(999)"),
        "plan_objective": MessageLookupByLibrary.simpleMessage("規劃目標"),
        "plan_title": MessageLookupByLibrary.simpleMessage("規劃"),
        "planning_free_quest_btn": MessageLookupByLibrary.simpleMessage("規劃FQ"),
        "prefer_april_fool_icon":
            MessageLookupByLibrary.simpleMessage("優先愚人節頭像"),
        "preferred_translation": MessageLookupByLibrary.simpleMessage("首選翻譯"),
        "preferred_translation_footer": MessageLookupByLibrary.simpleMessage(
            "拖動以更改順序。\n用於遊戲數據的顯示而非應用UI語言。部分語言存在未翻譯的部分。"),
        "prev_page": MessageLookupByLibrary.simpleMessage("上一頁"),
        "preview": MessageLookupByLibrary.simpleMessage("預覽"),
        "previous_card": MessageLookupByLibrary.simpleMessage("上一張"),
        "priority": MessageLookupByLibrary.simpleMessage("優先級"),
        "priority_tagging_hint":
            MessageLookupByLibrary.simpleMessage("建議備註不要太長, 否則可能顯示不全"),
        "probability": MessageLookupByLibrary.simpleMessage("概率"),
        "probability_expectation": MessageLookupByLibrary.simpleMessage("期望"),
        "project_homepage": MessageLookupByLibrary.simpleMessage("項目主頁"),
        "quest": MessageLookupByLibrary.simpleMessage("關卡"),
        "quest_chapter_n": m9,
        "quest_condition": MessageLookupByLibrary.simpleMessage("開放條件"),
        "quest_detail_btn": MessageLookupByLibrary.simpleMessage("詳情"),
        "quest_enemy_summary_hint": MessageLookupByLibrary.simpleMessage(
            "主線FQ中敵人資訊的匯總, 任何屬性均可能被伺服器所覆蓋, 僅供參考。\n*特殊*特性指僅部分敵人擁有的特性。"),
        "quest_fields": MessageLookupByLibrary.simpleMessage("場地"),
        "quest_fixed_drop": MessageLookupByLibrary.simpleMessage("固定掉落"),
        "quest_fixed_drop_short": MessageLookupByLibrary.simpleMessage("掉落"),
        "quest_not_found_error": m21,
        "quest_prefer_region": MessageLookupByLibrary.simpleMessage("首選區服"),
        "quest_prefer_region_hint":
            MessageLookupByLibrary.simpleMessage("若該關卡所屬活動在所選區服尚未開放，則預設顯示日服"),
        "quest_region_has_enemy_hint": MessageLookupByLibrary.simpleMessage(
            "僅日服(2020/11之後)和美服(2020/12之後)可能含有敵方資料"),
        "quest_restriction": MessageLookupByLibrary.simpleMessage("編成限制"),
        "quest_reward": MessageLookupByLibrary.simpleMessage("通關獎勵"),
        "quest_reward_short": MessageLookupByLibrary.simpleMessage("獎勵"),
        "quest_timeline_sort_campaign_open":
            MessageLookupByLibrary.simpleMessage("AP消耗活動開放時間"),
        "quest_timeline_sort_quest_open":
            MessageLookupByLibrary.simpleMessage("關卡開放時間"),
        "quit": MessageLookupByLibrary.simpleMessage("退出"),
        "raid_quest": MessageLookupByLibrary.simpleMessage("伐柱戰"),
        "random": MessageLookupByLibrary.simpleMessage("隨機"),
        "random_mission": MessageLookupByLibrary.simpleMessage("隨機任務"),
        "rankup_quest": MessageLookupByLibrary.simpleMessage("強化關卡"),
        "rankup_timeline_hint": MessageLookupByLibrary.simpleMessage(
            "部分關卡時間與實際開放時間不符\n若按AP消耗活動時間排序，則只使用日服時間"),
        "rare_enemy_hint": MessageLookupByLibrary.simpleMessage("稀有敵人 機率出現"),
        "rarity": MessageLookupByLibrary.simpleMessage("稀有度"),
        "rate_app_store": MessageLookupByLibrary.simpleMessage("App Store評分"),
        "rate_play_store":
            MessageLookupByLibrary.simpleMessage("Google Play評分"),
        "recognizer_result_count": m22,
        "refresh": MessageLookupByLibrary.simpleMessage("重新整理"),
        "refresh_data_no_update": MessageLookupByLibrary.simpleMessage("無新增卡牌"),
        "region_cn": MessageLookupByLibrary.simpleMessage("簡中服"),
        "region_jp": MessageLookupByLibrary.simpleMessage("日服"),
        "region_kr": MessageLookupByLibrary.simpleMessage("韓服"),
        "region_na": MessageLookupByLibrary.simpleMessage("美服"),
        "region_notice": m10,
        "region_tw": MessageLookupByLibrary.simpleMessage("繁中服"),
        "related_traits": MessageLookupByLibrary.simpleMessage("關聯特性"),
        "remove_condition": MessageLookupByLibrary.simpleMessage("刪除條件"),
        "remove_duplicated_svt": MessageLookupByLibrary.simpleMessage("銷毀2號機"),
        "remove_from_blacklist": MessageLookupByLibrary.simpleMessage("移出黑名單"),
        "remove_mission": MessageLookupByLibrary.simpleMessage("刪除任務"),
        "rename": MessageLookupByLibrary.simpleMessage("重命名"),
        "rerun_event": MessageLookupByLibrary.simpleMessage("復刻活動"),
        "reset": MessageLookupByLibrary.simpleMessage("重置"),
        "reset_custom_ascension_icon":
            MessageLookupByLibrary.simpleMessage("重置自訂從者頭像"),
        "reset_plan_all": m11,
        "reset_plan_shown": m12,
        "resettable_digged_num":
            MessageLookupByLibrary.simpleMessage("重置所需發掘數目"),
        "restart_to_apply_changes":
            MessageLookupByLibrary.simpleMessage("重啟以使配置生效"),
        "restart_to_upgrade_hint": MessageLookupByLibrary.simpleMessage(
            "重啟以更新應用，若更新失敗，請手動複製source文件夾到destination"),
        "restore": MessageLookupByLibrary.simpleMessage("恢復"),
        "results": MessageLookupByLibrary.simpleMessage("結果"),
        "saint_quartz_plan": MessageLookupByLibrary.simpleMessage("掙石"),
        "same_event_plan": MessageLookupByLibrary.simpleMessage("保持相同活動規劃"),
        "save": MessageLookupByLibrary.simpleMessage("保存"),
        "save_as": MessageLookupByLibrary.simpleMessage("另存新檔"),
        "save_to_photos": MessageLookupByLibrary.simpleMessage("保存到相簿"),
        "saved": MessageLookupByLibrary.simpleMessage("已保存"),
        "screen_size": MessageLookupByLibrary.simpleMessage("螢幕尺寸"),
        "screenshots": MessageLookupByLibrary.simpleMessage("截圖"),
        "script_choice": MessageLookupByLibrary.simpleMessage("選項"),
        "script_choice_end": MessageLookupByLibrary.simpleMessage("選項分歧結束"),
        "script_player_name": MessageLookupByLibrary.simpleMessage("藤丸"),
        "script_story": MessageLookupByLibrary.simpleMessage("劇情"),
        "search": MessageLookupByLibrary.simpleMessage("搜索"),
        "search_option_basic": MessageLookupByLibrary.simpleMessage("基礎資訊"),
        "search_options": MessageLookupByLibrary.simpleMessage("搜索範圍"),
        "select_copy_plan_source":
            MessageLookupByLibrary.simpleMessage("選擇複製來源"),
        "select_item_title": MessageLookupByLibrary.simpleMessage("選擇素材"),
        "select_lang": MessageLookupByLibrary.simpleMessage("選擇語言"),
        "select_plan": MessageLookupByLibrary.simpleMessage("選擇規劃"),
        "send_email_to": MessageLookupByLibrary.simpleMessage("發送郵件到"),
        "sending": MessageLookupByLibrary.simpleMessage("正在發送..."),
        "sending_failed": MessageLookupByLibrary.simpleMessage("發送失敗"),
        "sent": MessageLookupByLibrary.simpleMessage("已發送"),
        "servant": MessageLookupByLibrary.simpleMessage("從者"),
        "servant_coin": MessageLookupByLibrary.simpleMessage("從者硬幣"),
        "servant_coin_short": MessageLookupByLibrary.simpleMessage("硬幣"),
        "servant_detail_page": MessageLookupByLibrary.simpleMessage("從者詳情頁"),
        "servant_list_page": MessageLookupByLibrary.simpleMessage("從者列表頁"),
        "set_plan_name": MessageLookupByLibrary.simpleMessage("設置規劃名稱"),
        "setting_always_on_top": MessageLookupByLibrary.simpleMessage("置頂顯示"),
        "setting_auto_rotate": MessageLookupByLibrary.simpleMessage("自動旋轉"),
        "setting_auto_turn_on_plan_not_reach":
            MessageLookupByLibrary.simpleMessage("預設顯示\"規劃未滿\""),
        "setting_drag_by_mouse":
            MessageLookupByLibrary.simpleMessage("允許滑鼠拖動及滾動"),
        "setting_home_plan_list_page":
            MessageLookupByLibrary.simpleMessage("首頁-規劃列表頁"),
        "setting_only_change_second_append_skill":
            MessageLookupByLibrary.simpleMessage("僅更改追加技能2"),
        "setting_priority_tagging":
            MessageLookupByLibrary.simpleMessage("優先級備註"),
        "setting_servant_class_filter_style":
            MessageLookupByLibrary.simpleMessage("從者職階篩選樣式"),
        "setting_setting_favorite_button_default":
            MessageLookupByLibrary.simpleMessage("「關注」按紐預設篩選"),
        "setting_show_account_at_homepage":
            MessageLookupByLibrary.simpleMessage("首頁顯示當前帳號"),
        "setting_split_ratio": MessageLookupByLibrary.simpleMessage("畫面分割比例"),
        "setting_split_ratio_hint":
            MessageLookupByLibrary.simpleMessage("僅適用於寬屏模式"),
        "setting_tabs_sorting": MessageLookupByLibrary.simpleMessage("標籤頁排序"),
        "settings_data": MessageLookupByLibrary.simpleMessage("資料"),
        "settings_documents": MessageLookupByLibrary.simpleMessage("使用文檔"),
        "settings_general": MessageLookupByLibrary.simpleMessage("通用"),
        "settings_language": MessageLookupByLibrary.simpleMessage("語言"),
        "settings_tab_name": MessageLookupByLibrary.simpleMessage("設置"),
        "settings_userdata_footer": MessageLookupByLibrary.simpleMessage(
            "更新資料/版本/bug較多時，建議提前備份資料，移除應用將導致內部備份丟失，即時轉移到可靠的儲存位置"),
        "share": MessageLookupByLibrary.simpleMessage("分享"),
        "shop": MessageLookupByLibrary.simpleMessage("商店"),
        "show": MessageLookupByLibrary.simpleMessage("顯示"),
        "show_carousel": MessageLookupByLibrary.simpleMessage("顯示輪播圖"),
        "show_empty_event": MessageLookupByLibrary.simpleMessage("顯示無內容活動"),
        "show_frame_rate": MessageLookupByLibrary.simpleMessage("顯示刷新率"),
        "show_fullscreen": MessageLookupByLibrary.simpleMessage("全螢幕顯示"),
        "show_outdated": MessageLookupByLibrary.simpleMessage("顯示已過期"),
        "show_system_tray": MessageLookupByLibrary.simpleMessage("在系統圖示顯示"),
        "silver": MessageLookupByLibrary.simpleMessage("銀"),
        "simulator": MessageLookupByLibrary.simpleMessage("模擬器"),
        "skill": MessageLookupByLibrary.simpleMessage("技能"),
        "skill_rankup": MessageLookupByLibrary.simpleMessage("技能強化"),
        "skill_up": MessageLookupByLibrary.simpleMessage("技能升級"),
        "skilled_max10": MessageLookupByLibrary.simpleMessage("練度最大化(310)"),
        "solution_battle_count": MessageLookupByLibrary.simpleMessage("次數"),
        "solution_target_count": MessageLookupByLibrary.simpleMessage("目標數"),
        "solution_total_battles_ap": m23,
        "sort_order": MessageLookupByLibrary.simpleMessage("排序"),
        "sound_effect": MessageLookupByLibrary.simpleMessage("音效"),
        "special_reward_hide": MessageLookupByLibrary.simpleMessage("隱藏特殊報酬"),
        "special_reward_show": MessageLookupByLibrary.simpleMessage("顯示特殊報酬"),
        "spoiler_setting": MessageLookupByLibrary.simpleMessage("劇透設置"),
        "sprites": MessageLookupByLibrary.simpleMessage("模型"),
        "sq_buy_pack_unit": MessageLookupByLibrary.simpleMessage("單"),
        "sq_fragment_convert":
            MessageLookupByLibrary.simpleMessage("21聖晶片=3聖晶石"),
        "sq_short": MessageLookupByLibrary.simpleMessage("石"),
        "stage_opening_movie": MessageLookupByLibrary.simpleMessage("開場影片"),
        "statistics_title": MessageLookupByLibrary.simpleMessage("統計"),
        "still_send": MessageLookupByLibrary.simpleMessage("仍然發送"),
        "success": MessageLookupByLibrary.simpleMessage("成功"),
        "summon": MessageLookupByLibrary.simpleMessage("卡池"),
        "summon_daily": MessageLookupByLibrary.simpleMessage("日替"),
        "summon_expectation_btn": MessageLookupByLibrary.simpleMessage("期待計算"),
        "summon_gacha_footer":
            MessageLookupByLibrary.simpleMessage("僅供娛樂, 如有雷同, 純屬巧合"),
        "summon_gacha_result": MessageLookupByLibrary.simpleMessage("抽卡結果"),
        "summon_pull_unit": MessageLookupByLibrary.simpleMessage("抽"),
        "summon_show_banner": MessageLookupByLibrary.simpleMessage("顯示橫幅"),
        "summon_ticket_short": MessageLookupByLibrary.simpleMessage("呼符"),
        "super_effective_damage": MessageLookupByLibrary.simpleMessage("特攻"),
        "support_chaldea": MessageLookupByLibrary.simpleMessage("支持與捐贈"),
        "support_servant": MessageLookupByLibrary.simpleMessage("助戰"),
        "support_servant_forced": MessageLookupByLibrary.simpleMessage("限定"),
        "support_servant_short": MessageLookupByLibrary.simpleMessage("助戰"),
        "svt_ai": MessageLookupByLibrary.simpleMessage("從者AI"),
        "svt_ascension_icon": MessageLookupByLibrary.simpleMessage("從者頭像"),
        "svt_basic_info": MessageLookupByLibrary.simpleMessage("資料"),
        "svt_card_deck_incorrect":
            MessageLookupByLibrary.simpleMessage("敵方配卡及卡色可能不準確，以Hits分布為準"),
        "svt_class": MessageLookupByLibrary.simpleMessage("職階"),
        "svt_class_dist": MessageLookupByLibrary.simpleMessage("職階分佈"),
        "svt_class_filter_auto": MessageLookupByLibrary.simpleMessage("自動適配"),
        "svt_class_filter_hide": MessageLookupByLibrary.simpleMessage("隱藏"),
        "svt_class_filter_single_row":
            MessageLookupByLibrary.simpleMessage("單行不展開Extra職階"),
        "svt_class_filter_single_row_expanded":
            MessageLookupByLibrary.simpleMessage("單行並展開Extra職階"),
        "svt_class_filter_two_row":
            MessageLookupByLibrary.simpleMessage("Extra職階顯示在第二行"),
        "svt_fav_btn_remember": MessageLookupByLibrary.simpleMessage("記住選擇"),
        "svt_fav_btn_show_all": MessageLookupByLibrary.simpleMessage("顯示全部"),
        "svt_fav_btn_show_favorite":
            MessageLookupByLibrary.simpleMessage("顯示已關注"),
        "svt_not_planned": MessageLookupByLibrary.simpleMessage("未關注"),
        "svt_plan_hidden": MessageLookupByLibrary.simpleMessage("已隱藏"),
        "svt_profile": MessageLookupByLibrary.simpleMessage("羈絆故事"),
        "svt_profile_info": MessageLookupByLibrary.simpleMessage("角色詳情"),
        "svt_profile_n": m13,
        "svt_related_ce": MessageLookupByLibrary.simpleMessage("關聯禮裝"),
        "svt_reset_plan": MessageLookupByLibrary.simpleMessage("重置規劃"),
        "svt_second_archive": MessageLookupByLibrary.simpleMessage("保管室"),
        "svt_stat_own_total":
            MessageLookupByLibrary.simpleMessage("(999)擁有/總計"),
        "svt_switch_slider_dropdown":
            MessageLookupByLibrary.simpleMessage("切換滾動條/下拉框"),
        "switch_region": MessageLookupByLibrary.simpleMessage("切換區服"),
        "system_tray_close_hint":
            MessageLookupByLibrary.simpleMessage("關閉視窗時最小化"),
        "td_animation": MessageLookupByLibrary.simpleMessage("宝具动画"),
        "td_base_hits_hint":
            MessageLookupByLibrary.simpleMessage("同一寶具不同持有者可能擁有不同的色卡和Hit分布"),
        "td_cardcolor_hint": m24,
        "td_cardnp_hint": m25,
        "td_rankup": MessageLookupByLibrary.simpleMessage("寶具強化"),
        "test_info_pad": MessageLookupByLibrary.simpleMessage("測試資訊"),
        "testing": MessageLookupByLibrary.simpleMessage("測試中"),
        "time_close": MessageLookupByLibrary.simpleMessage("關閉"),
        "time_end": MessageLookupByLibrary.simpleMessage("結束"),
        "time_start": MessageLookupByLibrary.simpleMessage("開始"),
        "toggle_dark_mode": MessageLookupByLibrary.simpleMessage("切換深色模式"),
        "tooltip_refresh_sliders":
            MessageLookupByLibrary.simpleMessage("刷新輪播圖"),
        "total_ap": MessageLookupByLibrary.simpleMessage("總AP"),
        "total_counts": MessageLookupByLibrary.simpleMessage("總數"),
        "trait": MessageLookupByLibrary.simpleMessage("特性"),
        "treasure_box_draw_cost": MessageLookupByLibrary.simpleMessage("每抽消耗"),
        "treasure_box_extra_gift":
            MessageLookupByLibrary.simpleMessage("每箱額外禮物"),
        "treasure_box_max_draw_once":
            MessageLookupByLibrary.simpleMessage("單次最多抽數"),
        "trial_quest": MessageLookupByLibrary.simpleMessage("體驗關卡"),
        "turn_remain_limit": MessageLookupByLibrary.simpleMessage("剩餘回合限制"),
        "turn_remain_limit_lose":
            MessageLookupByLibrary.simpleMessage("回合倒數結束後視為敗北"),
        "turn_remain_limit_win":
            MessageLookupByLibrary.simpleMessage("回合倒數結束後視為通關"),
        "unlock_quest": MessageLookupByLibrary.simpleMessage("解鎖關卡"),
        "update": MessageLookupByLibrary.simpleMessage("更新"),
        "update_already_latest":
            MessageLookupByLibrary.simpleMessage("已經是最新版本"),
        "update_data_at_start": MessageLookupByLibrary.simpleMessage("啟動時更新"),
        "update_data_at_start_off_hint":
            MessageLookupByLibrary.simpleMessage("讀取本地資料並在背景更新,下次啟動時更新"),
        "update_data_at_start_on_hint":
            MessageLookupByLibrary.simpleMessage("啟動時間可能變長"),
        "update_dataset": MessageLookupByLibrary.simpleMessage("更新資源包"),
        "update_msg_error": MessageLookupByLibrary.simpleMessage("更新失敗"),
        "update_msg_no_update": MessageLookupByLibrary.simpleMessage("無可用更新"),
        "updated": MessageLookupByLibrary.simpleMessage("已更新"),
        "upload": MessageLookupByLibrary.simpleMessage("上傳"),
        "upload_and_close_app": MessageLookupByLibrary.simpleMessage("上傳並關閉"),
        "upload_and_close_app_alert":
            MessageLookupByLibrary.simpleMessage("是否上傳資料再關閉?"),
        "upload_before_close_app":
            MessageLookupByLibrary.simpleMessage("關閉前上傳"),
        "usage": MessageLookupByLibrary.simpleMessage("使用方法"),
        "userdata": MessageLookupByLibrary.simpleMessage("用戶資料"),
        "userdata_download_backup":
            MessageLookupByLibrary.simpleMessage("下載備份"),
        "userdata_download_choose_backup":
            MessageLookupByLibrary.simpleMessage("選擇一個備份"),
        "userdata_local": MessageLookupByLibrary.simpleMessage("用戶資料(本地)"),
        "userdata_sync": MessageLookupByLibrary.simpleMessage("同步數據"),
        "userdata_sync_hint":
            MessageLookupByLibrary.simpleMessage("僅更新帳號數據，不包含本地設置"),
        "userdata_sync_server":
            MessageLookupByLibrary.simpleMessage("同步數據(伺服器)"),
        "userdata_upload_backup": MessageLookupByLibrary.simpleMessage("上傳備份"),
        "valentine_craft": MessageLookupByLibrary.simpleMessage("情人節禮裝"),
        "valentine_script": MessageLookupByLibrary.simpleMessage("情人節劇情"),
        "version": MessageLookupByLibrary.simpleMessage("版本"),
        "video": MessageLookupByLibrary.simpleMessage("影片"),
        "view_illustration": MessageLookupByLibrary.simpleMessage("查看卡面"),
        "voice": MessageLookupByLibrary.simpleMessage("語音"),
        "war": MessageLookupByLibrary.simpleMessage("關卡配置"),
        "war_age": MessageLookupByLibrary.simpleMessage("年代"),
        "war_banner": MessageLookupByLibrary.simpleMessage("標題圖"),
        "war_board": MessageLookupByLibrary.simpleMessage("聖杯戰線"),
        "war_map": MessageLookupByLibrary.simpleMessage("地圖"),
        "warning": MessageLookupByLibrary.simpleMessage("警告"),
        "web_renderer": MessageLookupByLibrary.simpleMessage("Web渲染器"),
        "words_separate": m14
      };
}
