Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KNa6N-0001U1-IW
	for kexec@lists.infradead.org; Mon, 28 Jul 2008 21:17:55 +0000
Date: Mon, 28 Jul 2008 17:11:56 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 2/5] x86: Define elfcorehdr_addr in arch dependent section
Message-ID: <20080728211156.GB9985@redhat.com>
References: <20080727234529.GM6175@verge.net.au>
	<20080728015117.GA12055@verge.net.au>
	<20080728024526.GB3334@verge.net.au>
	<20080728034007.GA30450@verge.net.au>
	<20080728211025.GA9985@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080728211025.GA9985@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Chandru <chandru@in.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Terry Loftin <terry.loftin@hp.com>, Paul Mundt <lethal@linux-sh.org>, Paul Mackerras <paulus@samba.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>



o Move elfcorehdr_addr definition in arch dependent crash dump file. This is
  equivalent to defining elfcorehdr_addr under CONFIG_CRASH_DUMP instead of
  CONFIG_PROC_VMCORE. This is needed by is_kdump_kernel() which can be
  used irrespective of the fact whether CONFIG_PROC_VMCORE is enabled or
  not.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---

 arch/x86/kernel/crash_dump_32.c |    3 +++
 arch/x86/kernel/crash_dump_64.c |    3 +++
 arch/x86/kernel/setup.c         |    8 +++++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff -puN arch/x86/kernel/setup.c~fix-elfcorehdr_addr-parsing-x86 arch/x86/kernel/setup.c
--- linux-2.6.27-pre-rc1/arch/x86/kernel/setup.c~fix-elfcorehdr_addr-parsing-x86	2008-07-28 12:01:35.000000000 -0400
+++ linux-2.6.27-pre-rc1-root/arch/x86/kernel/setup.c	2008-07-28 12:01:35.000000000 -0400
@@ -558,7 +558,13 @@ static void __init reserve_standard_io_r
 
 }
 
-#ifdef CONFIG_PROC_VMCORE
+/*
+ * Note: elfcorehdr_addr is not just limited to vmcore. It is also used by
+ * is_kdump_kernel() to determine if we are booting after a panic. Hence
+ * ifdef it under CONFIG_CRASH_DUMP and not CONFIG_PROC_VMCORE.
+ */
+
+#ifdef CONFIG_CRASH_DUMP
 /* elfcorehdr= specifies the location of elf core header
  * stored by the crashed kernel. This option will be passed
  * by kexec loader to the capture kernel.
diff -puN arch/x86/kernel/crash_dump_32.c~fix-elfcorehdr_addr-parsing-x86 arch/x86/kernel/crash_dump_32.c
--- linux-2.6.27-pre-rc1/arch/x86/kernel/crash_dump_32.c~fix-elfcorehdr_addr-parsing-x86	2008-07-28 12:01:35.000000000 -0400
+++ linux-2.6.27-pre-rc1-root/arch/x86/kernel/crash_dump_32.c	2008-07-28 12:01:35.000000000 -0400
@@ -13,6 +13,9 @@
 
 static void *kdump_buf_page;
 
+/* Stores the physical address of elf header of crash image. */
+unsigned long long elfcorehdr_addr = ELFCORE_ADDR_MAX;
+
 /**
  * copy_oldmem_page - copy one page from "oldmem"
  * @pfn: page frame number to be copied
diff -puN arch/x86/kernel/crash_dump_64.c~fix-elfcorehdr_addr-parsing-x86 arch/x86/kernel/crash_dump_64.c
--- linux-2.6.27-pre-rc1/arch/x86/kernel/crash_dump_64.c~fix-elfcorehdr_addr-parsing-x86	2008-07-28 12:01:35.000000000 -0400
+++ linux-2.6.27-pre-rc1-root/arch/x86/kernel/crash_dump_64.c	2008-07-28 12:01:35.000000000 -0400
@@ -11,6 +11,9 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
+/* Stores the physical address of elf header of crash image. */
+unsigned long long elfcorehdr_addr = ELFCORE_ADDR_MAX;
+
 /**
  * copy_oldmem_page - copy one page from "oldmem"
  * @pfn: page frame number to be copied
_

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
