Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VsRMO-0001C4-DQ
 for kexec@lists.infradead.org; Mon, 16 Dec 2013 06:08:58 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH] makedumpfile: Add a existence check of symbols for
 --dump-dmesg
Date: Mon, 16 Dec 2013 06:07:05 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971D2896@BPXM01GP.gisp.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: "louis.bouchard@canonical.com" <louis.bouchard@canonical.com>

Hello,

I found a bug while testing for makedumpfile-1.5.5.
I'll release v1.5.5 after retesting with this patch, it will be
a few days later.


Thanks
Atsushi Kumagai

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Mon, 16 Dec 2013 14:00:51 +0900
Subject: [PATCH] Add a existence check of symbols for --dump-dmesg.

Since the format of the kernel log buffer was changed in kernel 3.5,
some symbols related to the format have been needed for --dump-dmesg
option. However, the functions for it use the symbols without
existence check, so makedumpfile can run into unexpected error.
In practice, this is a definite issue since kernel 3.5 doesn't
export SIZE(log) to VMCOREINFO.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 20f107e..23251a1 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4036,6 +4036,14 @@ dump_dmesg()
 		if (!close_files_for_creating_dumpfile())
 			goto out;
 	} else {
+		if (SIZE(printk_log) == NOT_FOUND_STRUCTURE ||
+		    OFFSET(printk_log.len) == NOT_FOUND_STRUCTURE ||
+		    OFFSET(printk_log.text_len) == NOT_FOUND_STRUCTURE ||
+		    OFFSET(printk_log.ts_nsec) == NOT_FOUND_STRUCTURE) {
+			ERRMSG("Can't get necessary structures for extracting dmesg log.\n");
+			goto out;
+		}
+
 		if (!readmem(VADDR, log_buf, log_buffer, log_buf_len)) {
 			ERRMSG("Can't read indexed dmesg log.\n");
 			goto out;
-- 
1.8.0.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
