Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QEvVe-0007rZ-MM
	for kexec@lists.infradead.org; Wed, 27 Apr 2011 03:33:51 +0000
From: Amerigo Wang <amwang@redhat.com>
Subject: [Patch] kexec: remove duplicated backup_src_start field from struct
	crash_elf_info
Date: Wed, 27 Apr 2011 11:33:27 +0800
Message-Id: <1303875207-9273-1-git-send-email-amwang@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>, WANG Cong <amwang@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Vivek pointed out that we have duplicated ->backup_src_start
in struct crash_elf_info and struct kexec_info.

This patch removes the ->backup_src_start and ->backup_src_end
from struct crash_elf_info.

I tested it on both i686 and ppc64, and used a test case from
Dave Anderson to confirm the backup region is correct on i686.

Signed-off-by: WANG Cong <amwang@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Simon Horman <horms@verge.net.au>

---
diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 01f470d..98cda72 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -721,16 +721,15 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	struct memory_range *mem_range, *memmap_p;
 	struct crash_elf_info elf_info;
 	unsigned kexec_arch;
+	unsigned long tmp_backup_end = 0;
 
 	memset(&elf_info, 0x0, sizeof(elf_info));
 
 	/* Constant parts of the elf_info */
 	memset(&elf_info, 0, sizeof(elf_info));
 	elf_info.data             = ELFDATA2LSB;
-	get_backup_area(&elf_info.backup_src_start, &elf_info.backup_src_end);
-	info->backup_src_start = elf_info.backup_src_start;
-	info->backup_src_size = elf_info.backup_src_end
-				- elf_info.backup_src_start + 1;
+	get_backup_area(&info->backup_src_start, &tmp_backup_end);
+	info->backup_src_size = tmp_backup_end - info->backup_src_start + 1;
 
 	/* Get the architecture of the running kernel */
 	kexec_arch = info->kexec_flags & KEXEC_ARCH_MASK;
@@ -785,15 +784,13 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	sz = (sizeof(struct memory_range) * (KEXEC_MAX_SEGMENTS + 1));
 	memmap_p = xmalloc(sz);
 	memset(memmap_p, 0, sz);
-	add_memmap(memmap_p, elf_info.backup_src_start,
-		   elf_info.backup_src_end - elf_info.backup_src_start + 1);
+	add_memmap(memmap_p, info->backup_src_start, info->backup_src_size);
 	sz = crash_reserved_mem.end - crash_reserved_mem.start +1;
 	add_memmap(memmap_p, crash_reserved_mem.start, sz);
 
 	/* Create a backup region segment to store backup data*/
 	if (!(info->kexec_flags & KEXEC_PRESERVE_CONTEXT)) {
-		sz = (elf_info.backup_src_end - elf_info.backup_src_start + align)
-		     & ~(align - 1);
+		sz = (info->backup_src_size + align) & ~(align - 1);
 		tmp = xmalloc(sz);
 		memset(tmp, 0, sz);
 		info->backup_start = add_buffer(info, tmp, sz, sz, align,
diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index aa50109..4fd6c30 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -329,8 +329,6 @@ static struct crash_elf_info elf_info64 = {
 	class: ELFCLASS64,
 	data : ELFDATA2MSB,
 	machine : EM_MIPS,
-	backup_src_start : BACKUP_SRC_START,
-	backup_src_end : BACKUP_SRC_END,
 	page_offset : PAGE_OFFSET,
 	lowmem_limit : MAXMEM,
 };
@@ -339,8 +337,6 @@ static struct crash_elf_info elf_info32 = {
 	class: ELFCLASS32,
 	data : ELFDATA2MSB,
 	machine : EM_MIPS,
-	backup_src_start : BACKUP_SRC_START,
-	backup_src_end : BACKUP_SRC_END,
 	page_offset : PAGE_OFFSET,
 	lowmem_limit : MAXMEM,
 };
diff --git a/kexec/arch/ppc/crashdump-powerpc.c b/kexec/arch/ppc/crashdump-powerpc.c
index 7bfad20..eb82122 100644
--- a/kexec/arch/ppc/crashdump-powerpc.c
+++ b/kexec/arch/ppc/crashdump-powerpc.c
@@ -21,8 +21,6 @@ static struct crash_elf_info elf_info64 = {
 class: ELFCLASS64,
 data: ELFDATA2MSB,
 machine: EM_PPC64,
-backup_src_start: BACKUP_SRC_START,
-backup_src_end: BACKUP_SRC_END,
 page_offset: PAGE_OFFSET,
 lowmem_limit: MAXMEM,
 };
@@ -35,8 +33,6 @@ machine: EM_PPC64,
 #else
 machine: EM_PPC,
 #endif
-backup_src_start: BACKUP_SRC_START,
-backup_src_end: BACKUP_SRC_END,
 page_offset: PAGE_OFFSET,
 lowmem_limit: MAXMEM,
 };
diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index 0176bc7..6a66f2a 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -40,8 +40,6 @@ static struct crash_elf_info elf_info64 =
 	class: ELFCLASS64,
 	data: ELFDATA2MSB,
 	machine: EM_PPC64,
-	backup_src_start: BACKUP_SRC_START,
-	backup_src_end: BACKUP_SRC_END,
 	page_offset: PAGE_OFFSET,
 	lowmem_limit: MAXMEM,
 };
@@ -51,8 +49,6 @@ static struct crash_elf_info elf_info32 =
 	class: ELFCLASS32,
 	data: ELFDATA2MSB,
 	machine: EM_PPC64,
-	backup_src_start: BACKUP_SRC_START,
-	backup_src_end: BACKUP_SRC_END,
 	page_offset: PAGE_OFFSET,
 	lowmem_limit: MAXMEM,
 };
diff --git a/kexec/crashdump-elf.c b/kexec/crashdump-elf.c
index 954d670..8d82db9 100644
--- a/kexec/crashdump-elf.c
+++ b/kexec/crashdump-elf.c
@@ -227,8 +227,8 @@ int FUNC(struct kexec_info *info,
 		phdr->p_flags	= PF_R|PF_W|PF_X;
 		phdr->p_offset	= mstart;
 
-		if (mstart == elf_info->backup_src_start
-		    && mend == elf_info->backup_src_end)
+		if (mstart == info->backup_src_start
+		    && (mend - mstart + 1) == info->backup_src_size)
 			phdr->p_offset	= info->backup_start;
 
 		/* We already prepared the header for kernel text. Map
diff --git a/kexec/crashdump.h b/kexec/crashdump.h
index 5a597eb..0f7c2ea 100644
--- a/kexec/crashdump.h
+++ b/kexec/crashdump.h
@@ -23,9 +23,6 @@ struct crash_elf_info {
 	unsigned long data;
 	unsigned long machine;
 
-	unsigned long backup_src_start;
-	unsigned long backup_src_end;
-
 	unsigned long long page_offset;
 	unsigned long long kern_vaddr_start;
 	unsigned long long kern_paddr_start;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
