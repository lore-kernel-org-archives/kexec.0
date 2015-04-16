Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YiezL-0002jq-79
 for kexec@lists.infradead.org; Thu, 16 Apr 2015 08:17:32 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.197])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id t3G8H57I000896
 for <kexec@lists.infradead.org>; Thu, 16 Apr 2015 17:17:05 +0900 (JST)
Received: from mailsv.nec.co.jp (imss63.nec.co.jp [10.7.69.158]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id t3G8H5c23263 for <kexec@lists.infradead.org>;
 Thu, 16 Apr 2015 17:17:05 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id t3G8H5Q1006324
 for <kexec@lists.infradead.org>; Thu, 16 Apr 2015 17:17:05 +0900 (JST)
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH] makedumpfile: Free pages aren't removed in non-cyclic mode.
Date: Thu, 16 Apr 2015 08:14:07 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DA4CB5@BPXM01GP.gisp.nec.co.jp>
Content-Language: ja-JP
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello,

This is a bug since v1.5.4, it will mainly affect re-filtering
feature since the current makedumpfile generally works in cyclic
mode by default.

Note: these codes will be removed in the next version by merging
      the codes of cyclic mode and non-cyclic mode.


Thanks,
Atsushi Kumagai


From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Date: Tue, 14 Apr 2015 13:12:37 +0900
Subject: [PATCH] Free pages aren't removed in non-cyclic mode.

If the dump level is 16 (exclude only free pages), free pages will
not be removed in non-cyclic mode because exclude_unnecessary_pages()
will be never called in that case. This issue happens when
page_is_buddy is enabled, otherwise free pages will be removed
by using free list.

Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 makedumpfile.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 32f5459..cb172b4 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5223,7 +5223,8 @@ create_2nd_bitmap(void)
 	if (info->dump_level & DL_EXCLUDE_CACHE ||
 	    info->dump_level & DL_EXCLUDE_CACHE_PRI ||
 	    info->dump_level & DL_EXCLUDE_USER_DATA ||
-	    NUMBER(PG_hwpoison) != NOT_FOUND_NUMBER) {
+	    NUMBER(PG_hwpoison) != NOT_FOUND_NUMBER ||
+	    ((info->dump_level & DL_EXCLUDE_FREE) && info->page_is_buddy)) {
 		if (!exclude_unnecessary_pages()) {
 			ERRMSG("Can't exclude unnecessary pages.\n");
 			return FALSE;
-- 
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
