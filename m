Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp18.uk.ibm.com ([195.75.94.114])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UZLBS-00042z-FO
 for kexec@lists.infradead.org; Mon, 06 May 2013 13:10:29 +0000
Received: from /spool/local
 by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Mon, 6 May 2013 14:05:57 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 58A141B08069
 for <kexec@lists.infradead.org>; Mon,  6 May 2013 14:10:00 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r46D9oai37028058
 for <kexec@lists.infradead.org>; Mon, 6 May 2013 13:09:50 GMT
Received: from d06av05.portsmouth.uk.ibm.com (loopback [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r46D9xd2021274
 for <kexec@lists.infradead.org>; Mon, 6 May 2013 07:10:00 -0600
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH 3/4] s390/kdump: Use ELFCORE_ADDR_NEWMEM for zfcpdump
Date: Mon,  6 May 2013 15:09:58 +0200
Message-Id: <1367845799-29125-4-git-send-email-holzheu@linux.vnet.ibm.com>
In-Reply-To: <1367845799-29125-1-git-send-email-holzheu@linux.vnet.ibm.com>
References: <1367845799-29125-1-git-send-email-holzheu@linux.vnet.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Jan Willeke <willeke@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>

From: Jan Willeke <willeke@de.ibm.com>

This patch modifies the s390 copy_oldmem_page() function for zfcpdump
to read from the HSA memory if memory below HSA_SIZE bytes is requested.
Otherwise from real memory is read.

Signed-off-by: Jan Willeke <willeke@de.ibm.com>
Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 arch/s390/Kconfig             |  3 +-
 arch/s390/include/asm/sclp.h  |  1 +
 arch/s390/kernel/crash_dump.c | 77 +++++++++++++++++++++++++++++++++----------
 drivers/s390/char/zcore.c     |  6 ++--
 4 files changed, 65 insertions(+), 22 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 2c9789d..a0d78f1 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -516,6 +516,7 @@ config CRASH_DUMP
 	bool "kernel crash dumps"
 	depends on 64BIT && SMP
 	select KEXEC
+	select ZFCPDUMP
 	help
 	  Generate crash dump after being started by kexec.
 	  Crash dump kernels are loaded in the main kernel with kexec-tools
@@ -526,7 +527,7 @@ config CRASH_DUMP
 config ZFCPDUMP
 	def_bool n
 	prompt "zfcpdump support"
-	select SMP
+	depends on SMP
 	help
 	  Select this option if you want to build an zfcpdump enabled kernel.
 	  Refer to <file:Documentation/s390/zfcpdump.txt> for more details on this.
diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index 06a1361..7dc7f9c 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -56,5 +56,6 @@ bool sclp_has_linemode(void);
 bool sclp_has_vt220(void);
 int sclp_pci_configure(u32 fid);
 int sclp_pci_deconfigure(u32 fid);
+int memcpy_hsa(void *dest, unsigned long src, size_t count, int mode);
 
 #endif /* _ASM_S390_SCLP_H */
diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index f1feaaa..1522dfc 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -16,27 +16,40 @@
 #include <asm/os_info.h>
 #include <asm/elf.h>
 #include <asm/ipl.h>
+#include <asm/sclp.h>
 
 #define PTR_ADD(x, y) (((char *) (x)) + ((unsigned long) (y)))
 #define PTR_SUB(x, y) (((char *) (x)) - ((unsigned long) (y)))
 #define PTR_DIFF(x, y) ((unsigned long)(((char *) (x)) - ((unsigned long) (y))))
 
 /*
- * Copy one page from "oldmem"
- *
+ * For pages below ZFCPDUMP_HSA_SIZE memory from the HSA is copied. Otherwise
+ * real memory copy is used.
+ */
+static ssize_t copy_oldmem_page_zfcpdump(char *buf, size_t csize,
+					 unsigned long src, int userbuf)
+{
+	if (src < ZFCPDUMP_HSA_SIZE) {
+		if (memcpy_hsa(buf, src, csize, userbuf) < 0)
+			return -EINVAL;
+	} else {
+		if (userbuf)
+			copy_to_user_real((void __force __user *) buf,
+					  (void *) src, csize);
+		else
+			memcpy_real(buf, (void *) src, csize);
+	}
+	return csize;
+}
+
+/*
  * For the kdump reserved memory this functions performs a swap operation:
  *  - [OLDMEM_BASE - OLDMEM_BASE + OLDMEM_SIZE] is mapped to [0 - OLDMEM_SIZE].
  *  - [0 - OLDMEM_SIZE] is mapped to [OLDMEM_BASE - OLDMEM_BASE + OLDMEM_SIZE]
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-			 size_t csize, unsigned long offset, int userbuf)
+static ssize_t copy_oldmem_page_kdump(char *buf, size_t csize,
+				      unsigned long src, int userbuf)
 {
-	unsigned long src;
-
-	if (!csize)
-		return 0;
-
-	src = (pfn << PAGE_SHIFT) + offset;
 	if (src < OLDMEM_SIZE)
 		src += OLDMEM_BASE;
 	else if (src > OLDMEM_BASE &&
@@ -51,6 +64,23 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 }
 
 /*
+ * Copy one page from "oldmem"
+ */
+ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
+			 unsigned long offset, int userbuf)
+{
+	unsigned long src;
+
+	if (!csize)
+		return 0;
+	src = (pfn << PAGE_SHIFT) + offset;
+	if (OLDMEM_BASE)
+		return copy_oldmem_page_kdump(buf, csize, src, userbuf);
+	else
+		return copy_oldmem_page_zfcpdump(buf, csize, src, userbuf);
+}
+
+/*
  * Copy memory from old kernel
  */
 int copy_from_oldmem(void *dest, void *src, size_t count)
@@ -58,11 +88,20 @@ int copy_from_oldmem(void *dest, void *src, size_t count)
 	unsigned long copied = 0;
 	int rc;
 
-	if ((unsigned long) src < OLDMEM_SIZE) {
-		copied = min(count, OLDMEM_SIZE - (unsigned long) src);
-		rc = memcpy_real(dest, src + OLDMEM_BASE, copied);
-		if (rc)
-			return rc;
+	if (OLDMEM_BASE) {
+		if ((unsigned long) src < OLDMEM_SIZE) {
+			copied = min(count, OLDMEM_SIZE - (unsigned long) src);
+			rc = memcpy_real(dest, src + OLDMEM_BASE, copied);
+			if (rc)
+				return rc;
+		}
+	} else {
+		if ((unsigned long) src < ZFCPDUMP_HSA_SIZE) {
+			copied = min(count, ZFCPDUMP_HSA_SIZE - (unsigned long) src);
+			rc = memcpy_hsa(dest, (unsigned long) src, copied, 0);
+			if (rc)
+				return rc;
+		}
 	}
 	return memcpy_real(dest + copied, src + copied, count - copied);
 }
@@ -418,12 +457,14 @@ int arch_vmcore_get_elf_hdr(char **elfcorebuf, size_t *elfcorebuf_sz)
 
 /*
  * Create kdump ELF core header in new kernel, if it has not been passed via
- * the "elfcorehdr" kernel parameter
+ * the "elfcorehdr" kernel parameter or if we run as zfcpdump.
  */
 static int setup_kdump_elfcorehdr(void)
 {
-	if (!OLDMEM_BASE || is_kdump_kernel())
-		return -EINVAL;
+	if (!OLDMEM_BASE && (ipl_info.type != IPL_TYPE_FCP_DUMP))
+		return -EINVAL; /* No kdump and no zfcpdump */
+	if (is_kdump_kernel())
+		return -EINVAL; /* "elfcorehdr=" has been set by kexec */
 	elfcorehdr_addr = ELFCORE_ADDR_NEWMEM;
 	return 0;
 }
diff --git a/drivers/s390/char/zcore.c b/drivers/s390/char/zcore.c
index 2282061..e1e1663 100644
--- a/drivers/s390/char/zcore.c
+++ b/drivers/s390/char/zcore.c
@@ -30,8 +30,8 @@
 
 #define TRACE(x...) debug_sprintf_event(zcore_dbf, 1, x)
 
-#define TO_USER		0
-#define TO_KERNEL	1
+#define TO_USER		1
+#define TO_KERNEL	0
 #define CHUNK_INFO_SIZE	34 /* 2 16-byte char, each followed by blank */
 
 enum arch_id {
@@ -73,7 +73,7 @@ static struct ipl_parameter_block *ipl_block;
  * @count: Size of buffer, which should be copied
  * @mode:  Either TO_KERNEL or TO_USER
  */
-static int memcpy_hsa(void *dest, unsigned long src, size_t count, int mode)
+int memcpy_hsa(void *dest, unsigned long src, size_t count, int mode)
 {
 	int offs, blk_num;
 	static char buf[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
-- 
1.8.1.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
