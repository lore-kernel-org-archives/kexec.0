Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bSyaE-0007xQ-8g
 for kexec@lists.infradead.org; Fri, 29 Jul 2016 03:35:34 +0000
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH] makedumpfile: Add more descriptions of multi-threads feature
Date: Fri, 29 Jul 2016 11:34:02 +0800
Message-ID: <1469763242-2221-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
Cc: ats-kumagai@wm.jp.nec.com, dyoung@redhat.com, d.hatayama@jp.fujitsu.com, bhe@redhat.com

It will have a bad performance if the threads number is larger than
the usable cpu number. So we should remind user of it.

Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 makedumpfile.8 | 2 ++
 print_info.c   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/makedumpfile.8 b/makedumpfile.8
index 3b6f7e2..f74abea 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -376,6 +376,8 @@ the kdump\-compressed format.
 \fB\-\-num\-threads\fR \fITHREADNUM\fR
 Using multiple threads to read and compress data of each page in parallel.
 And it will reduces time for saving \fIDUMPFILE\fR.
+Note that if the usable cpu number is less than the thread number, it may
+lead to great performance degradation.
 This feature only supports creating \fIDUMPFILE\fR in kdump\-comressed
 format from \fIVMCORE\fR in kdump\-compressed format or elf format.
 .br
diff --git a/print_info.c b/print_info.c
index 1a9f70c..2fbfb12 100644
--- a/print_info.c
+++ b/print_info.c
@@ -200,6 +200,8 @@ print_usage(void)
 	MSG("  [--num-threads THREADNUM]:\n");
 	MSG("      Using multiple threads to read and compress data of each page in parallel.\n");
 	MSG("      And it will reduces time for saving DUMPFILE.\n");
+	MSG("      Note that if the usable cpu number is less than the thread number, it may\n");
+	MSG("      lead to great performance degradation.\n");
 	MSG("      This feature only supports creating DUMPFILE in kdump-comressed format from\n");
 	MSG("      VMCORE in kdump-compressed format or elf format.\n");
 	MSG("\n");
-- 
1.8.3.1




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
