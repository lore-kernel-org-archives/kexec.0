Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K0MZT-0006Zv-4v
	for kexec@lists.infradead.org; Sun, 25 May 2008 20:11:59 +0000
Received: from Relay1.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 9C92F45E46
	for <kexec@lists.infradead.org>; Sun, 25 May 2008 22:11:56 +0200 (CEST)
Date: Sun, 25 May 2008 22:11:54 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Use 'long long' for printf() format string and ELF64 numbers.
Message-ID: <20080525221154.2fd2e432@kopernikus.site>
Mime-Version: 1.0
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
To: kexec@lists.infradead.org

Since 'long long' is 64 bit wide on almost any platform, especially on
32 bit platforms (like i386) while 'long long' is only 64 bit on 64 bit
platforms but 32 bit on 32 bit platforms, 'long long' is more suited and
fixes compiler warnings like

  kexec/crashdump-elf.c:160: warning: format '%lx' expects type \
        'long unsigned int', but argument 4 has type 'Elf64_Off'
  kexec/crashdump-elf.c:160: warning: format '%lx' expects type \
        'long unsigned int', but argument 5 has type 'Elf64_Addr'
  ...
  kexec/crashdump-elf.c:248: warning: format '%lx' expects type \
        'long unsigned int', but argument 8 has type 'Elf64_Xword'

Tested on i686-pc-linux-gnu.

Signed-off-by: Bernhard Walle <bwalle@suse.de>

diff --git a/kexec/crashdump-elf.c b/kexec/crashdump-elf.c
index 7d2befe..f01accb 100644
--- a/kexec/crashdump-elf.c
+++ b/kexec/crashdump-elf.c
@@ -4,12 +4,12 @@
 #endif
 
 #if (ELF_WIDTH == 64)
-#define dbgprintf_phdr(prefix, phdr)					\
-do {									\
-	dbgprintf("%s: p_type = %u, p_offset = 0x%lx p_paddr = 0x%lx "	\
-		"p_vaddr = 0x%lx p_filesz = 0x%lx p_memsz = 0x%lx\n",	\
-		(prefix), (phdr)->p_type, (phdr)->p_offset, (phdr)->p_paddr, \
-		(phdr)->p_vaddr, (phdr)->p_filesz, (phdr)->p_memsz);	\
+#define dbgprintf_phdr(prefix, phdr)						\
+do {										\
+	dbgprintf("%s: p_type = %u, p_offset = 0x%llx p_paddr = 0x%llx "	\
+		"p_vaddr = 0x%llx p_filesz = 0x%llx p_memsz = 0x%llx\n",	\
+		(prefix), (phdr)->p_type, (phdr)->p_offset, (phdr)->p_paddr, 	\
+		(phdr)->p_vaddr, (phdr)->p_filesz, (phdr)->p_memsz);		\
 } while(0)
 #else
 #define dbgprintf_phdr(prefix, phdr)					\

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
