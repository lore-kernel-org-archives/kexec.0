Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.245])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KXwSt-00071v-0G
	for kexec@lists.infradead.org; Tue, 26 Aug 2008 11:11:59 +0000
Received: by rv-out-0708.google.com with SMTP id b17so1911060rvf.42
	for <kexec@lists.infradead.org>; Tue, 26 Aug 2008 04:11:58 -0700 (PDT)
From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 26 Aug 2008 20:12:11 +0900
Message-Id: <20080826111211.615.66730.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080826111150.615.97501.sendpatchset@rx1.opensource.se>
References: <20080826111150.615.97501.sendpatchset@rx1.opensource.se>
Subject: [PATCH 03/06] sh: Add virtual addresses support
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@igel.co.jp>

Implement virtual-to-physical address conversion functions for SuperH.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 kexec/arch/sh/Makefile          |    4 ++++
 kexec/arch/sh/kexec-sh.c        |   29 +++++++++++++++++++++++++++++
 kexec/arch/sh/kexec-zImage-sh.c |    4 ++--
 3 files changed, 35 insertions(+), 2 deletions(-)

--- 0001/kexec/arch/sh/Makefile
+++ work/kexec/arch/sh/Makefile	2008-08-22 11:07:45.000000000 +0900
@@ -7,6 +7,10 @@ sh_KEXEC_SRCS += kexec/arch/sh/kexec-net
 sh_KEXEC_SRCS += kexec/arch/sh/kexec-elf-rel-sh.c
 sh_KEXEC_SRCS += kexec/arch/sh/netbsd_booter.S
 
+sh_ADD_BUFFER =
+sh_ADD_SEGMENT =
+sh_VIRT_TO_PHYS =
+
 dist += kexec/arch/sh/Makefile $(sh_KEXEC_SRCS)				\
 	kexec/arch/sh/kexec-sh.h					\
 	kexec/arch/sh/include/arch/options.h
--- 0003/kexec/arch/sh/kexec-sh.c
+++ work/kexec/arch/sh/kexec-sh.c	2008-08-22 11:10:31.000000000 +0900
@@ -168,3 +168,32 @@ int is_crashkernel_mem_reserved(void)
 	return 0; /* kdump is not supported on this platform (yet) */
 }
 
+unsigned long virt_to_phys(unsigned long addr)
+{
+	unsigned long seg = addr & 0xe0000000;
+	if (seg != 0x80000000 && seg != 0xc0000000)
+		die("Virtual address %p is not in P1 or P2\n", (void *)addr);
+
+	return addr - seg;
+}
+
+/*
+ * add_segment() should convert base to a physical address on superh,
+ * while the default is just to work with base as is */
+void add_segment(struct kexec_info *info, const void *buf, size_t bufsz,
+		 unsigned long base, size_t memsz)
+{
+	add_segment_phys_virt(info, buf, bufsz, base, memsz, 1);
+}
+
+/*
+ * add_buffer() should convert base to a physical address on superh,
+ * while the default is just to work with base as is */
+unsigned long add_buffer(struct kexec_info *info, const void *buf,
+			 unsigned long bufsz, unsigned long memsz,
+			 unsigned long buf_align, unsigned long buf_min,
+			 unsigned long buf_max, int buf_end)
+{
+	return add_buffer_phys_virt(info, buf, bufsz, memsz, buf_align,
+				    buf_min, buf_max, buf_end, 1);
+}
--- 0001/kexec/arch/sh/kexec-zImage-sh.c
+++ work/kexec/arch/sh/kexec-zImage-sh.c	2008-08-22 11:10:43.000000000 +0900
@@ -96,8 +96,8 @@ int zImage_sh_load(int argc, char **argv
         paraml = (unsigned long *)param;
 	// paraml[0] = 1;  // readonly flag is set as default
 
-	add_segment(info, param, 4096, empty_zero, 4096);
-	add_segment(info, buf,   len,  (area | 0x00210000), len);
+	add_segment(info, param, 4096, 0x80000000 | empty_zero, 4096);
+	add_segment(info, buf,   len,  (area | 0x80210000), len);
 
 	/* For now we don't have arguments to pass :( */
 	info->entry = (void *)(0x80210000 | area);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
