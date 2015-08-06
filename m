Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZNEQx-00041W-NX
 for kexec@lists.infradead.org; Thu, 06 Aug 2015 06:13:48 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t766BW6Z031150
 for <kexec@lists.infradead.org>; Thu, 6 Aug 2015 14:11:32 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v4 10/10] Add usage and manual about multiple threads process
Date: Thu, 6 Aug 2015 14:08:11 +0800
Message-ID: <1438841291-30378-11-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1438841291-30378-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1438841291-30378-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
Cc: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>

From: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>

Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
Signed-off-by: Zhou wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 makedumpfile.8 | 13 +++++++++++++
 print_info.c   | 10 ++++++++++
 2 files changed, 23 insertions(+)

diff --git a/makedumpfile.8 b/makedumpfile.8
index 2d38cd0..155cc4c 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -12,6 +12,8 @@ makedumpfile \- make a small dumpfile of kdump
 .br
 \fBmakedumpfile\fR \-\-split [\fIOPTION\fR] [\-x \fIVMLINUX\fR|\-i \fIVMCOREINFO\fR] \fIVMCORE\fR \fIDUMPFILE1\fR \fIDUMPFILE2\fR [\fIDUMPFILE3\fR ..]
 .br
+\fBmakedumpfile\fR [\fIOPTION\fR] [\-x \fIVMLINUX\fR|\-i \fIVMCOREINFO\fR] \-\-num\-threads \fITHREADNUM\fR \fIVMCORE\fR \fIDUMPFILE\fR
+.br
 \fBmakedumpfile\fR \-\-reassemble \fIDUMPFILE1\fR \fIDUMPFILE2\fR [\fIDUMPFILE3\fR ..] \fIDUMPFILE\fR
 .br
 \fBmakedumpfile\fR \-g \fIVMCOREINFO\fR \-x \fIVMLINUX\fR
@@ -371,6 +373,17 @@ the kdump\-compressed format.
 # makedumpfile \-\-split \-d 31 \-x vmlinux /proc/vmcore dumpfile1 dumpfile2
 
 .TP
+\fB\-\-num\-threads\fR \fITHREADNUM\fR
+Using multiple threads to read and compress data of each page in parallel.
+And it will reduces time for saving \fIDUMPFILE\fR.
+This feature only supports creating \fIDUMPFILE\fR in kdump\-comressed
+format from \fIVMCORE\fR in kdump\-compressed format or elf format.
+.br
+.B Example:
+.br
+# makedumpfile \-d 31 \-\-num\-threads 4 /proc/vmcore dumpfile
+
+.TP
 \fB\-\-reassemble\fR
 Reassemble multiple \fIDUMPFILE\fRs, which are created by \-\-split option,
 into one \fIDUMPFILE\fR. dumpfile1 and dumpfile2 are reassembled into dumpfile
diff --git a/print_info.c b/print_info.c
index 9c36bec..ed4451c 100644
--- a/print_info.c
+++ b/print_info.c
@@ -76,6 +76,10 @@ print_usage(void)
 	MSG("  # makedumpfile --split [OPTION] [-x VMLINUX|-i VMCOREINFO] VMCORE DUMPFILE1\n");
 	MSG("    DUMPFILE2 [DUMPFILE3 ..]\n");
 	MSG("\n");
+	MSG("  Using multiple threads to create DUMPFILE in parallel:\n");
+	MSG("  # makedumpfile [OPTION] [-x VMLINUX|-i VMCOREINFO] --num-threads THREADNUM\n");
+	MSG("    VMCORE DUMPFILE1\n");
+	MSG("\n");
 	MSG("  Reassemble multiple DUMPFILEs:\n");
 	MSG("  # makedumpfile --reassemble DUMPFILE1 DUMPFILE2 [DUMPFILE3 ..] DUMPFILE\n");
 	MSG("\n");
@@ -184,6 +188,12 @@ print_usage(void)
 	MSG("      by the number of DUMPFILEs.\n");
 	MSG("      This feature supports only the kdump-compressed format.\n");
 	MSG("\n");
+	MSG("  [--num-threads THREADNUM]:\n");
+	MSG("      Using multiple threads to read and compress data of each page in parallel.\n");
+	MSG("      And it will reduces time for saving DUMPFILE.\n");
+	MSG("      This feature only supports creating DUMPFILE in kdump-comressed format from\n");
+	MSG("      VMCORE in kdump-compressed format or elf format.\n");
+	MSG("\n");
 	MSG("  [--reassemble]:\n");
 	MSG("      Reassemble multiple DUMPFILEs, which are created by --split option,\n");
 	MSG("      into one DUMPFILE. dumpfile1 and dumpfile2 are reassembled into dumpfile.\n");
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
