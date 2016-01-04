Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aFwVv-0005Mw-S0
 for kexec@lists.infradead.org; Mon, 04 Jan 2016 04:13:00 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.195])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id u044CYq7015219
 for <kexec@lists.infradead.org>; Mon, 4 Jan 2016 13:12:34 +0900 (JST)
Received: from mailsv4.nec.co.jp (imss63.nec.co.jp [10.7.69.158]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id u044CXU15421 for <kexec@lists.infradead.org>;
 Mon, 4 Jan 2016 13:12:33 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id u044CX0Z026182
 for <kexec@lists.infradead.org>; Mon, 4 Jan 2016 13:12:33 +0900 (JST)
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH] makedumpfile: Remove useless definitions of return value. 
Date: Mon, 4 Jan 2016 04:11:51 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E11A46@BPXM01GP.gisp.nec.co.jp>
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

I'll reduce the type of return value in the next version,
please let me know if this change is inconvenient for you.


Thanks,
Atsushi Kumagai

--
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Date: Mon, 28 Dec 2015 16:22:09 +0900
Subject: [PATCH] Remove useless definitions of return value.

The five return values are defined in makedumpfile,
but the latter two are useless.

  #define COMPLETED       (0)
  #define FAILED          (1)
  #define WRONG_RELEASE   (2)     /* utsname.release does not match. */
  #define ANALYSIS_FAILED (3)     /* detected illegal page descriptor. */
  #define OUTPUT_FAILED   (4)     /* detected an output error. */

ANALYSIS_FAILED will be returned only when free_list is broken,
but I can't find any reason to give this case special treatment.
As for OUTPUT_FAILED, it isn't used at all.

Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 makedumpfile.8 | 2 --
 makedumpfile.c | 1 -
 makedumpfile.h | 2 --
 3 files changed, 5 deletions(-)

diff --git a/makedumpfile.8 b/makedumpfile.8
index 6eff4f1..5fda3ed 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -635,8 +635,6 @@ makedumpfile exits with the following value.
 \fB1\fR : makedumpfile failed without the following reasons.
 .TP
 \fB2\fR : makedumpfile failed due to the different version between  \fIVMLINUX\fR and \fIVMCORE\fR.
-.TP
-\fB3\fR : makedumpfile failed due to the analysis error of the memory.
 
 .SH AUTHORS
 .PP
diff --git a/makedumpfile.c b/makedumpfile.c
index a8c9e8b..b802446 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4706,7 +4706,6 @@ reset_bitmap_of_free_pages(unsigned long node_zones, struct cycle *cycle)
 				}
 				if (previous != curr_prev) {
 					ERRMSG("The free list is broken.\n");
-					retcd = ANALYSIS_FAILED;
 					return FALSE;
 				}
 				for (i = 0; i < (1<<order); i++) {
diff --git a/makedumpfile.h b/makedumpfile.h
index c42fc81..e626be8 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -54,8 +54,6 @@
 #define COMPLETED	(0)
 #define FAILED		(1)
 #define WRONG_RELEASE	(2)	/* utsname.release does not match. */
-#define ANALYSIS_FAILED	(3)	/* detected illegal page descriptor. */
-#define OUTPUT_FAILED	(4)	/* detected an output error. */
 
 /*
  * Type of memory management
-- 
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
