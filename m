Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-wa4.frontbridge.com ([216.32.181.16]
	helo=WA4EHSOBE006.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KdbAu-0005NX-43
	for kexec@lists.infradead.org; Thu, 11 Sep 2008 01:40:48 +0000
Message-ID: <48C8771A.2000806@am.sony.com>
Date: Wed, 10 Sep 2008 18:40:42 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: [kexec patch 1/2] Fix build warnings
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
To: horms@verge.net.au
Cc: kexec@lists.infradead.org, Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>

Fix these 64 bit build warnings:

 kexec/firmware_memmap.c:241: warning: format '%d' expects type 'int', but argument 3 has type 'size_t'
 kexec/crashdump-elf.c:160: warning: format '%llx' expects type 'long long unsigned int', but argument 4 has type 'Elf64_Off'
 kexec/crashdump-elf.c:160: warning: format '%llx' expects type 'long long unsigned int', but argument 5 has type 'Elf64_Addr'
 kexec/crashdump-elf.c:160: warning: format '%llx' expects type 'long long unsigned int', but argument 6 has type 'Elf64_Addr'
 kexec/crashdump-elf.c:160: warning: format '%llx' expects type 'long long unsigned int', but argument 7 has type 'Elf64_Xword'
 kexec/crashdump-elf.c:160: warning: format '%llx' expects type 'long long unsigned int', but argument 8 has type 'Elf64_Xword'

Tested on PS3 (ppc64) with 32 and 64 bit builds. 

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 kexec/crashdump-elf.c   |    8 ++++++--
 kexec/firmware_memmap.c |    2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

--- a/kexec/crashdump-elf.c
+++ b/kexec/crashdump-elf.c
@@ -8,8 +8,12 @@
 do {										\
 	dbgprintf("%s: p_type = %u, p_offset = 0x%llx p_paddr = 0x%llx "	\
 		"p_vaddr = 0x%llx p_filesz = 0x%llx p_memsz = 0x%llx\n",	\
-		(prefix), (phdr)->p_type, (phdr)->p_offset, (phdr)->p_paddr, 	\
-		(phdr)->p_vaddr, (phdr)->p_filesz, (phdr)->p_memsz);		\
+		(prefix), (phdr)->p_type,					\
+		(unsigned long long)((phdr)->p_offset),				\
+		(unsigned long long)((phdr)->p_paddr),				\
+		(unsigned long long)((phdr)->p_vaddr),				\
+		(unsigned long long)((phdr)->p_filesz),				\
+		(unsigned long long)((phdr)->p_memsz));				\
 } while(0)
 #else
 #define dbgprintf_phdr(prefix, phdr)					\
--- a/kexec/firmware_memmap.c
+++ b/kexec/firmware_memmap.c
@@ -237,7 +237,7 @@ int get_firmware_memmap_ranges(struct me
 		/* array overflow check */
 		if ((size_t)i >= *ranges) {
 			fprintf(stderr, "The firmware provides more entries "
-				"allowed (%d). Please report that as bug.\n",
+				"allowed (%zd). Please report that as bug.\n",
 				*ranges);
 			goto error;
 		}




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
