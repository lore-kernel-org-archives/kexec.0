Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XNBFA-0000bR-4f
 for kexec@lists.infradead.org; Fri, 29 Aug 2014 01:44:49 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.160])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id s7T1iN4E007139
 for <kexec@lists.infradead.org>; Fri, 29 Aug 2014 10:44:23 +0900 (JST)
Received: from mailsv.nec.co.jp (imss61.nec.co.jp [10.7.69.156]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id s7T1iM202780 for <kexec@lists.infradead.org>;
 Fri, 29 Aug 2014 10:44:22 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id s7T1iMjA019177
 for <kexec@lists.infradead.org>; Fri, 29 Aug 2014 10:44:22 +0900 (JST)
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH] makedumpfile: Fix dmesg format after crash utility
Date: Fri, 29 Aug 2014 01:43:31 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE97250ADB@BPXM01GP.gisp.nec.co.jp>
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

I made a trivial patch for v1.5.7.
This isn't essential but it's better than nothing.


Thanks
Atsushi Kumagai

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Thu, 28 Aug 2014 18:58:38 +0900
Subject: [PATCH] Fix dmesg format after crash utility.

Add some spaces before a new line as much as the length
of the timestamp like crash utility as:

    $ diff -u  current.dmesg fixed.dmesg
    --- current.dmesg       2014-08-28 17:39:53.000000000 +0900
    +++ fixed.dmesg 2014-08-27 16:46:09.000000000 +0900
    @@ -150,8 +150,8 @@
     [    0.015251] Disabled fast string operations
     [    0.015285] mce: CPU supports 10 MCE banks
     [    0.015402] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
    -Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
    -tlb_flushall_shift: 6
    +               Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
    +               tlb_flushall_shift: 6
     [    0.015535] Freeing SMP alternatives memory: 20K (ffffffff81964000 - ffffffff81969000)
     [    0.018265] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
     [    0.028286] smpboot: CPU0: Intel QEMU Virtual CPU version (cpu64-rhel6) (fam: 06, model: 0d, stepping: 03)
    $

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index b4b6eca..632daba 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3950,6 +3950,7 @@ dump_log_entry(char *logptr, int fp)
 {
 	char *msg, *p, *bufp;
 	unsigned int i, text_len;
+	unsigned int indent_len;
 	unsigned long long ts_nsec;
 	char buf[BUFSIZE];
 	ulonglong nanos;
@@ -3965,6 +3966,7 @@ dump_log_entry(char *logptr, int fp)
 
 	bufp = buf;
 	bufp += sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
+	indent_len = strlen(buf);
 
 	for (i = 0, p = msg; i < text_len; i++, p++) {
 		/* 6bytes = "\\x%02x" + '\n' + '\0' */
@@ -3974,7 +3976,9 @@ dump_log_entry(char *logptr, int fp)
 			bufp = buf;
 		}
 
-		if (isprint(*p) || isspace(*p))
+		if (*p == '\n')
+			bufp += sprintf(bufp, "\n%-*s", indent_len, "");
+		else if (isprint(*p) || isspace(*p))
 			*bufp++ = *p;
 		else
 			bufp += sprintf(bufp, "\\x%02x", *p);
-- 
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
