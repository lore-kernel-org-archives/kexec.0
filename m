Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a4K08-0000aV-6L
 for kexec@lists.infradead.org; Thu, 03 Dec 2015 02:52:09 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
 by cn.fujitsu.com (Postfix) with ESMTP id 11A8E409255B
 for <kexec@lists.infradead.org>; Thu,  3 Dec 2015 10:51:27 +0800 (CST)
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH] Add more description for --num-threads
Date: Thu, 3 Dec 2015 10:50:11 +0800
Message-ID: <1449111011-21749-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
To: kexec@lists.infradead.org

From the test result, we can see when "-d 31" is specified, using
"--num-threads" always spends more time than not. And it occurs at
most of the time in theory. So it should be mentioned in the
description of "--num-threads".

Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 makedumpfile.8 | 6 ++++--
 print_info.c   | 4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.8 b/makedumpfile.8
index 6eff4f1..ec179a5 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -378,11 +378,13 @@ Using multiple threads to read and compress data of each page in parallel.
 And it will reduces time for saving \fIDUMPFILE\fR.
 This feature only supports creating \fIDUMPFILE\fR in kdump\-comressed
 format from \fIVMCORE\fR in kdump\-compressed format or elf format.
+Note that if too many pages are filtered, \'\-\-num\-threads\' may not improve
+the performance, or even has bad effects. It means if \'\-d 31\' is specified,
+you should think about whether to use \'\-\-num\-threads\'.
 .br
 .B Example:
 .br
-# makedumpfile \-d 31 \-\-num\-threads 4 /proc/vmcore dumpfile
-
+# makedumpfile \-\-num\-threads 4 /proc/vmcore dumpfile
 .TP
 \fB\-\-reassemble\fR
 Reassemble multiple \fIDUMPFILE\fRs, which are created by \-\-split option,
diff --git a/print_info.c b/print_info.c
index d662c0c..d0302a8 100644
--- a/print_info.c
+++ b/print_info.c
@@ -194,6 +194,10 @@ print_usage(void)
 	MSG("      And it will reduces time for saving DUMPFILE.\n");
 	MSG("      This feature only supports creating DUMPFILE in kdump-comressed format from\n");
 	MSG("      VMCORE in kdump-compressed format or elf format.\n");
+	MSG("      Note that if too many pages are filtered, '--num-threads' may not improve\n");
+	MSG("      the performance, or even has bad effects.\n");
+	MSG("      It means if '-d 31' is specified, you should think about whether to use\n");
+	MSG("      '--num-threads'.\n");
 	MSG("\n");
 	MSG("  [--reassemble]:\n");
 	MSG("      Reassemble multiple DUMPFILEs, which are created by --split option,\n");
-- 
1.8.3.1




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
