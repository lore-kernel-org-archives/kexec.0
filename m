Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo200.gate.nec.co.jp ([210.143.35.50])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Isr2o-0007iY-BR
	for kexec@lists.infradead.org; Thu, 15 Nov 2007 21:35:05 -0500
Received: from tyo202.gate.nec.co.jp ([10.7.69.202])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id lAG2Yppp005616
	for <kexec@lists.infradead.org>; Fri, 16 Nov 2007 11:34:51 +0900 (JST)
Message-Id: <473D016A.7010107@mxs.nes.nec.co.jp>
Date: Fri, 16 Nov 2007 11:33:14 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: [PATCH 3/5] Add "VMCOREINFO_" to all the call for
	vmcoreinfo_append_str()
References: <473CFE14.3010400@mxs.nes.nec.co.jp>
In-Reply-To: <473CFE14.3010400@mxs.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1953167750=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: lkml <linux-kernel@vger.kernel.org>, kexec-ml <kexec@lists.infradead.org>

--===============1953167750==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


For readability, all the calls to vmcoreinfo_append_str() are changed to macros
having a prefix "VMCOREINFO_".

This discussion is the following:
http://www.ussg.iu.edu/hypermail/linux/kernel/0709.3/0584.html

Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
---
diff -rpuN a/include/linux/kexec.h b/include/linux/kexec.h
--- a/include/linux/kexec.h	2007-11-12 11:04:09.000000000 +0900
+++ b/include/linux/kexec.h	2007-11-12 11:04:22.000000000 +0900
@@ -127,6 +127,10 @@ void vmcoreinfo_append_str(const char *f
 	__attribute__ ((format (printf, 1, 2)));
 unsigned long paddr_vmcoreinfo_note(void);
 
+#define VMCOREINFO_OSRELEASE(name) \
+	vmcoreinfo_append_str("OSRELEASE=%s\n", #name)
+#define VMCOREINFO_PAGESIZE(value) \
+	vmcoreinfo_append_str("PAGESIZE=%ld\n", value)
 #define VMCOREINFO_SYMBOL(name) \
 	vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned long)&name)
 #define VMCOREINFO_SIZE(name) \
diff -rpuN a/kernel/kexec.c b/kernel/kexec.c
--- a/kernel/kexec.c	2007-11-12 11:04:11.000000000 +0900
+++ b/kernel/kexec.c	2007-11-12 11:04:22.000000000 +0900
@@ -1361,8 +1361,8 @@ unsigned long __attribute__ ((weak)) pad
 
 static int __init crash_save_vmcoreinfo_init(void)
 {
-	vmcoreinfo_append_str("OSRELEASE=%s\n", init_uts_ns.name.release);
-	vmcoreinfo_append_str("PAGESIZE=%ld\n", PAGE_SIZE);
+	VMCOREINFO_OSRELEASE(init_uts_ns.name.release);
+	VMCOREINFO_PAGESIZE(PAGE_SIZE);
 
 	VMCOREINFO_SYMBOL(init_uts_ns);
 	VMCOREINFO_SYMBOL(node_online_map);
_




--===============1953167750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1953167750==--
