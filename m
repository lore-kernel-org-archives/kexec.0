Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UfDJZ-0008Fa-59
 for kexec@lists.infradead.org; Wed, 22 May 2013 17:59:06 +0000
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Wed, 22 May 2013 18:56:40 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9FCA217D801A
 for <kexec@lists.infradead.org>; Wed, 22 May 2013 18:59:49 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4MHwS0b57737374
 for <kexec@lists.infradead.org>; Wed, 22 May 2013 17:58:28 GMT
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4MHwcOK013117
 for <kexec@lists.infradead.org>; Wed, 22 May 2013 11:58:38 -0600
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH v2 2/3] s390/kdump: Use arch function call for kdump
Date: Wed, 22 May 2013 19:58:36 +0200
Message-Id: <1369245517-16204-3-git-send-email-holzheu@linux.vnet.ibm.com>
In-Reply-To: <1369245517-16204-1-git-send-email-holzheu@linux.vnet.ibm.com>
References: <1369245517-16204-1-git-send-email-holzheu@linux.vnet.ibm.com>
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
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>

Currently for s390 we create the ELF core header in the 2nd kernel
with a small trick. We relocate the addresses in the ELF header in
a way that for the /proc/vmcore code it seems to be in the 1st kernel
(old) memory and the read_from_oldmem() returns the correct data.
This allows the /proc/vmcore code to use the ELF header in the
2nd kernel.

This patch now exchanges the old mechanism with the new and much
cleaner arch function call override feature that now offcially allows to
create the ELF core header in the 2nd kernel.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 arch/s390/kernel/crash_dump.c | 52 ++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index f703d91..4fe7fa7 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -21,6 +21,9 @@
 #define PTR_SUB(x, y) (((char *) (x)) - ((unsigned long) (y)))
 #define PTR_DIFF(x, y) ((unsigned long)(((char *) (x)) - ((unsigned long) (y))))
 
+static size_t elfcorebuf_sz;
+static char *elfcorebuf;
+
 /*
  * Copy one page from "oldmem"
  *
@@ -325,14 +328,6 @@ static int get_mem_chunk_cnt(void)
 }
 
 /*
- * Relocate pointer in order to allow vmcore code access the data
- */
-static inline unsigned long relocate(unsigned long addr)
-{
-	return OLDMEM_BASE + addr;
-}
-
-/*
  * Initialize ELF loads (new kernel)
  */
 static int loads_init(Elf64_Phdr *phdr, u64 loads_offset)
@@ -383,7 +378,7 @@ static void *notes_init(Elf64_Phdr *phdr, void *ptr, u64 notes_offset)
 	ptr = nt_vmcoreinfo(ptr);
 	memset(phdr, 0, sizeof(*phdr));
 	phdr->p_type = PT_NOTE;
-	phdr->p_offset = relocate(notes_offset);
+	phdr->p_offset = notes_offset;
 	phdr->p_filesz = (unsigned long) PTR_SUB(ptr, ptr_start);
 	phdr->p_memsz = phdr->p_filesz;
 	return ptr;
@@ -392,7 +387,7 @@ static void *notes_init(Elf64_Phdr *phdr, void *ptr, u64 notes_offset)
 /*
  * Create ELF core header (new kernel)
  */
-static void s390_elf_corehdr_create(char **elfcorebuf, size_t *elfcorebuf_sz)
+static int arch_vmcore_get_elf_hdr(char **elfcorebuf, size_t *elfcorebuf_sz)
 {
 	Elf64_Phdr *phdr_notes, *phdr_loads;
 	int mem_chunk_cnt;
@@ -414,13 +409,37 @@ static void s390_elf_corehdr_create(char **elfcorebuf, size_t *elfcorebuf_sz)
 	ptr = PTR_ADD(ptr, sizeof(Elf64_Phdr) * mem_chunk_cnt);
 	/* Init notes */
 	hdr_off = PTR_DIFF(ptr, hdr);
-	ptr = notes_init(phdr_notes, ptr, ((unsigned long) hdr) + hdr_off);
+	ptr = notes_init(phdr_notes, ptr, (unsigned long) hdr + hdr_off);
 	/* Init loads */
 	hdr_off = PTR_DIFF(ptr, hdr);
-	loads_init(phdr_loads, ((unsigned long) hdr) + hdr_off);
+	loads_init(phdr_loads, hdr_off);
 	*elfcorebuf_sz = hdr_off;
-	*elfcorebuf = (void *) relocate((unsigned long) hdr);
+	*elfcorebuf = hdr;
 	BUG_ON(*elfcorebuf_sz > alloc_size);
+	return 0;
+}
+
+/*
+ * If elfcorehdr= has been specified, return 1st kernel ELF header
+ * otherwise return the new 2nd kernel ELF header.
+ */
+unsigned long long arch_get_crash_header(void)
+{
+	if (elfcorehdr_addr != ELFCORE_ADDR_NEWMEM)
+		return elfcorehdr_addr;
+	else
+		return __pa(elfcorebuf);
+}
+
+/*
+ * Free crash header
+ */
+void arch_free_crash_header(void)
+{
+	if (elfcorehdr_addr != ELFCORE_ADDR_NEWMEM)
+		return;
+	kfree(elfcorebuf);
+	elfcorebuf = 0;
 }
 
 /*
@@ -429,13 +448,10 @@ static void s390_elf_corehdr_create(char **elfcorebuf, size_t *elfcorebuf_sz)
  */
 static int setup_kdump_elfcorehdr(void)
 {
-	size_t elfcorebuf_sz;
-	char *elfcorebuf;
-
 	if (!OLDMEM_BASE || is_kdump_kernel())
 		return -EINVAL;
-	s390_elf_corehdr_create(&elfcorebuf, &elfcorebuf_sz);
-	elfcorehdr_addr = (unsigned long long) elfcorebuf;
+	arch_vmcore_get_elf_hdr(&elfcorebuf, &elfcorebuf_sz);
+	elfcorehdr_addr = ELFCORE_ADDR_NEWMEM;
 	elfcorehdr_size = elfcorebuf_sz;
 	return 0;
 }
-- 
1.8.1.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
