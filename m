Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jocu1-0003DC-OI
	for kexec@lists.infradead.org; Wed, 23 Apr 2008 11:12:42 +0000
Message-ID: <480F1987.9010501@ah.jp.nec.com>
Date: Wed, 23 Apr 2008 20:12:07 +0900
From: Takenori Nagano <t-nagano@ah.jp.nec.com>
MIME-Version: 1.0
Subject: [PATCH 3/3] Move crash_kexec() into panic_notifier, take4
References: <480DD85C.7060200@ah.jp.nec.com>
In-Reply-To: <480DD85C.7060200@ah.jp.nec.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1572226327=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, k-miyoshi@cb.jp.nec.com, greg@kroah.com, bwalle@suse.de, kdb@oss.sgi.com, kexec@lists.infradead.org, Randy Dunlap <rdunlap@xenotime.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>, vgoyal@redhat.com

--===============1572226327==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

This patch moves crash_kexec() into panic_notifier. If you want to use it,
you have to set config option DUMP_ON_PANIC_NOTIFIER to Y. Its default value
is N. If you set DUMP_ON_PANIC_NOTIFIER to N, kdump has no difference before.

Thanks,

---

Signed-off-by: Takenori Nagano <t-nagano@ah.jp.nec.com>

---
diff -uprN linux-2.6.25.orig/arch/ia64/Kconfig linux-2.6.25/arch/ia64/Kconfig
--- linux-2.6.25.orig/arch/ia64/Kconfig	2008-04-22 20:34:42.567581801 +0900
+++ linux-2.6.25/arch/ia64/Kconfig	2008-04-22 18:54:05.168734196 +0900
@@ -541,6 +541,14 @@ config CRASH_DUMP
 	  help
 	    Generate crash dump after being started by kexec.
 
+config DUMP_ON_PANIC_NOTIFIER
+	bool "Call crash dump function from panic notifier"
+	depends on CRASH_DUMP
+	default n
+	help
+	  Say Y here to be able to call crash dump function from panic_notifier.
+	  It makes a chance to do something before taking crash dump.
+
 source "drivers/firmware/Kconfig"
 
 source "fs/Kconfig.binfmt"
diff -uprN linux-2.6.25.orig/arch/powerpc/Kconfig linux-2.6.25/arch/powerpc/Kconfig
--- linux-2.6.25.orig/arch/powerpc/Kconfig	2008-04-22 20:34:43.115578199 +0900
+++ linux-2.6.25/arch/powerpc/Kconfig	2008-04-22 18:51:03.085855052 +0900
@@ -304,6 +304,14 @@ config CRASH_DUMP
 
 	  Don't change this unless you know what you are doing.
 
+config DUMP_ON_PANIC_NOTIFIER
+	bool "Call crash dump function from panic notifier (EXPERIMENTAL)"
+	depends on CRASH_DUMP
+	default n
+	help
+	  Say Y here to be able to call crash dump function from panic_notifier.
+	  It makes a chance to do something before taking crash dump.
+
 config PHYP_DUMP
 	bool "Hypervisor-assisted dump (EXPERIMENTAL)"
 	depends on PPC_PSERIES && EXPERIMENTAL
diff -uprN linux-2.6.25.orig/arch/sh/Kconfig linux-2.6.25/arch/sh/Kconfig
--- linux-2.6.25.orig/arch/sh/Kconfig	2008-04-22 20:34:44.167571856 +0900
+++ linux-2.6.25/arch/sh/Kconfig	2008-04-22 18:53:51.152813154 +0900
@@ -695,6 +695,14 @@ config CRASH_DUMP
 
 	  For more details see Documentation/kdump/kdump.txt
 
+config DUMP_ON_PANIC_NOTIFIER
+	bool "Call crash dump function from panic notifier"
+	depends on CRASH_DUMP
+	default n
+	help
+	  Say Y here to be able to call crash dump function from panic_notifier.
+	  It makes a chance to do something before taking crash dump.
+
 config SMP
 	bool "Symmetric multi-processing support"
 	depends on SYS_SUPPORTS_SMP
diff -uprN linux-2.6.25.orig/arch/x86/Kconfig linux-2.6.25/arch/x86/Kconfig
--- linux-2.6.25.orig/arch/x86/Kconfig	2008-04-22 20:34:44.367570179 +0900
+++ linux-2.6.25/arch/x86/Kconfig	2008-04-22 18:55:42.372136199 +0900
@@ -1159,6 +1159,14 @@ config CRASH_DUMP
 	  (CONFIG_RELOCATABLE=y).
 	  For more details see Documentation/kdump/kdump.txt
 
+config DUMP_ON_PANIC_NOTIFIER
+	bool "Call crash dump function from panic notifier"
+	depends on CRASH_DUMP
+	default n
+	help
+	  Say Y here to be able to call crash dump function from panic_notifier.
+	  It makes a chance to do something before taking crash dump.
+
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded" if (EMBEDDED || CRASH_DUMP)
 	default "0x1000000" if X86_NUMAQ
diff -uprN linux-2.6.25.orig/kernel/kexec.c linux-2.6.25/kernel/kexec.c
--- linux-2.6.25.orig/kernel/kexec.c	2008-04-22 20:35:03.099455119 +0900
+++ linux-2.6.25/kernel/kexec.c	2008-04-22 20:54:37.324228945 +0900
@@ -1133,6 +1133,25 @@ void crash_save_cpu(struct pt_regs *regs
 	final_note(buf);
 }
 
+#ifdef CONFIG_DUMP_ON_PANIC_NOTIFIER
+static int panic_kexec(struct notifier_block *nb, unsigned long e, void *ptr)
+{
+	crash_kexec(NULL);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block panic_block_base = {
+	.notifier_call	= panic_kexec,
+	.next		= NULL,
+	.priority	= INT_MAX
+};
+
+static struct tunable_atomic_notifier_block panic_block = {
+	.nb		= &panic_block_base,
+};
+#endif
+
 static int __init crash_notes_memory_init(void)
 {
 	/* Allocate memory for saving cpu registers. */
@@ -1142,6 +1161,11 @@ static int __init crash_notes_memory_ini
 		" states failed\n");
 		return -ENOMEM;
 	}
+#ifdef CONFIG_DUMP_ON_PANIC_NOTIFIER
+	tunable_atomic_notifier_chain_register(&panic_notifier_list,
+					       &panic_block,
+		"kdump", "Generate crash dump after being started by kexec.");
+#endif
 	return 0;
 }
 module_init(crash_notes_memory_init)



--===============1572226327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1572226327==--
