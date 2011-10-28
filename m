Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RJj3o-0003ST-2g
	for kexec@lists.infradead.org; Fri, 28 Oct 2011 09:49:13 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 66E223EE0AE
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:49:10 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 4A57045DE4E
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:49:10 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 2A4C045DE4D
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:49:10 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 15FC41DB802C
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:49:10 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.240.81.147])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id CC4191DB803A
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:49:09 +0900 (JST)
Received: from m107.css.fujitsu.com (m107 [127.0.0.1])
	by m107.s.css.fujitsu.com (Postfix) with ESMTP id A2869860021
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:49:09 +0900 (JST)
Received: from localhost6.localdomain6 (unknown [10.124.63.45])
	by m107.s.css.fujitsu.com (Postfix) with ESMTP id 4D77F86001E
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:49:09 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 12/14] Read kexec backup region
Date: Fri, 28 Oct 2011 18:49:09 +0900
Message-ID: <20111028094909.20940.48359.stgit@localhost6.localdomain6>
In-Reply-To: <20111028094454.20940.1209.stgit@localhost6.localdomain6>
References: <20111028094454.20940.1209.stgit@localhost6.localdomain6>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Deal with the first 640kB memory backed up by kdump by interpreting
the read request to the region as the request to the backup region
that is specially prepared to preserve the original first kernel's
memory situtation.

The first 640kB memory contains the data necessary for paging: PTE,
for example. So, initialization must be done before trying to read
memory requiring paging to read such as VMALLOC'ed data.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |   45 +++++++++++----
 makedumpfile.h |   41 ++++++++++++++
 sadump_info.c  |  168 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sadump_info.h  |    6 ++
 4 files changed, 249 insertions(+), 11 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 44f6ee6..df82a48 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -829,6 +829,7 @@ get_symbol_info(void)
 	SYMBOL_INIT(cpu_online_mask, "cpu_online_mask");
 	if (SYMBOL(cpu_online_mask) == NOT_FOUND_SYMBOL)
 		SYMBOL_INIT(cpu_online_mask, "cpu_online_map");
+	SYMBOL_INIT(kexec_crash_image, "kexec_crash_image");
 
 	if (SYMBOL(node_data) != NOT_FOUND_SYMBOL)
 		SYMBOL_ARRAY_TYPE_INIT(node_data, "node_data");
@@ -1115,6 +1116,23 @@ get_structure_info(void)
 	}
 #endif /* __x86_64__ */
 
+	OFFSET_INIT(kimage.segment, "kimage", "segment");
+
+	MEMBER_ARRAY_LENGTH_INIT(kimage.segment, "kimage", "segment");
+
+	SIZE_INIT(kexec_segment, "kexec_segment");
+	OFFSET_INIT(kexec_segment.mem, "kexec_segment", "mem");
+
+	OFFSET_INIT(elf64_hdr.e_phnum, "elf64_hdr", "e_phnum");
+	OFFSET_INIT(elf64_hdr.e_phentsize, "elf64_hdr", "e_phentsize");
+	OFFSET_INIT(elf64_hdr.e_phoff, "elf64_hdr", "e_phoff");
+
+	SIZE_INIT(elf64_hdr, "elf64_hdr");
+	OFFSET_INIT(elf64_phdr.p_type, "elf64_phdr", "p_type");
+	OFFSET_INIT(elf64_phdr.p_offset, "elf64_phdr", "p_offset");
+	OFFSET_INIT(elf64_phdr.p_paddr, "elf64_phdr", "p_paddr");
+	OFFSET_INIT(elf64_phdr.p_memsz, "elf64_phdr", "p_memsz");
+
 	return TRUE;
 }
 
@@ -2619,6 +2637,16 @@ out:
 		if (!get_versiondep_info())
 			return FALSE;
 
+		/*
+		 * NOTE: This must be done before refering to
+		 * VMALLOC'ed memory. The first 640kB contains data
+		 * necessary for paging, like PTE. The absence of the
+		 * region affects reading VMALLOC'ed memory such as
+		 * module data.
+		 */
+		if (info->flag_sadump)
+			sadump_kdump_backup_region_init();
+
 		if (!get_numnodes())
 			return FALSE;
 
@@ -2756,6 +2784,12 @@ set_bit_on_1st_bitmap(unsigned long long pfn)
 }
 
 int
+clear_bit_on_1st_bitmap(unsigned long long pfn)
+{
+	return set_bitmap(info->bitmap1, pfn, 0);
+}
+
+int
 clear_bit_on_2nd_bitmap(unsigned long long pfn)
 {
 	return set_bitmap(info->bitmap2, pfn, 0);
@@ -2796,17 +2830,6 @@ is_in_segs(unsigned long long paddr)
 		return FALSE;
 }
 
-static inline int
-is_zero_page(unsigned char *buf, long page_size)
-{
-	size_t i;
-
-	for (i = 0; i < page_size; i++)
-		if (buf[i])
-			return FALSE;
-	return TRUE;
-}
-
 int
 read_cache(struct cache_data *cd)
 {
diff --git a/makedumpfile.h b/makedumpfile.h
index 020d99c..6ae37d9 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -181,6 +181,7 @@ isAnon(unsigned long mapping)
 #define STRNEQ(A, B)	(A && B && \
 	(strncmp((char *)(A), (char *)(B), strlen((char *)(B))) == 0))
 
+#define USHORT(ADDR)	*((unsigned short *)(ADDR))
 #define UINT(ADDR)	*((unsigned int *)(ADDR))
 #define ULONG(ADDR)	*((unsigned long *)(ADDR))
 
@@ -996,6 +997,7 @@ struct symbol_table {
 	unsigned long long	__per_cpu_offset;
 	unsigned long long	__per_cpu_load;
 	unsigned long long	cpu_online_mask;
+	unsigned long long	kexec_crash_image;
 };
 
 struct size_table {
@@ -1027,6 +1029,8 @@ struct size_table {
 	long	user_regs_struct;
 	long	cpumask;
 	long	cpumask_t;
+	long	kexec_segment;
+	long	elf64_hdr;
 };
 
 struct offset_table {
@@ -1135,6 +1139,27 @@ struct offset_table {
 		long	fs;
 		long	gs;
 	} user_regs_struct;
+
+	struct kimage_s {
+		long	segment;
+	} kimage;
+
+	struct kexec_segment_s {
+		long	mem;
+	} kexec_segment;
+
+	struct elf64_hdr_s {
+		long	e_phnum;
+		long	e_phentsize;
+		long	e_phoff;
+	} elf64_hdr;
+
+	struct elf64_phdr_s {
+		long	p_type;
+		long	p_offset;
+		long	p_paddr;
+		long	p_memsz;
+	} elf64_phdr;
 };
 
 /*
@@ -1159,6 +1184,9 @@ struct array_table {
 	struct free_area_at {
 		long	free_list;
 	} free_area;
+	struct kimage_at {
+		long	segment;
+	} kimage;
 };
 
 struct number_table {
@@ -1331,7 +1359,20 @@ is_dumpable(struct dump_bitmap *bitmap, unsigned long long pfn)
 	return is_on(bitmap->buf, pfn%PFN_BUFBITMAP);
 }
 
+static inline int
+is_zero_page(unsigned char *buf, long page_size)
+{
+	size_t i;
+
+	for (i = 0; i < page_size; i++)
+		if (buf[i])
+			return FALSE;
+	return TRUE;
+}
+
 void write_vmcoreinfo_data(void);
+int set_bit_on_1st_bitmap(unsigned long long pfn);
+int clear_bit_on_1st_bitmap(unsigned long long pfn);
 
 #ifdef __x86__
 
diff --git a/sadump_info.c b/sadump_info.c
index 2538da6..69296ce 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -77,6 +77,12 @@ struct sadump_info {
 	FILE *file_elf_note;
 	char *cpu_online_mask_buf;
 	size_t cpumask_size;
+/* Backup Region, First 640K of System RAM. */
+#define KEXEC_BACKUP_SRC_END    0x0009ffff
+        unsigned long long backup_src_start;
+        unsigned long backup_src_size;
+        unsigned long long backup_offset;
+	int kdump_backed_up;
 };
 
 static char *guid_to_str(efi_guid_t *guid, char *buf, size_t buflen);
@@ -188,6 +194,30 @@ sadump_copy_1st_bitmap_from_memory(void)
 		offset_page += sizeof(buf);
 	}
 
+	/*
+	 * kdump uses the first 640kB on the 2nd kernel. But both
+	 * bitmaps should reflect the 1st kernel memory situation. We
+	 * modify bitmap accordingly.
+	 */
+	if (si->kdump_backed_up) {
+		unsigned long long paddr, pfn, backup_src_pfn;
+
+		for (paddr = si->backup_src_start;
+		     paddr < si->backup_src_start + si->backup_src_size;
+		     paddr += info->page_size) {
+
+			pfn = paddr_to_pfn(paddr);
+			backup_src_pfn = paddr_to_pfn(paddr +
+						      si->backup_offset -
+						      si->backup_src_start);
+
+			if (is_dumpable(info->bitmap_memory, backup_src_pfn))
+				set_bit_on_1st_bitmap(pfn);
+			else
+				clear_bit_on_1st_bitmap(pfn);
+		}
+	}
+
 	return TRUE;
 }
 
@@ -920,6 +950,11 @@ readpmem_sadump(unsigned long long paddr, void *bufptr, size_t size)
 	char buf[info->page_size];
 	int fd_memory;
 
+	if (si->kdump_backed_up &&
+	    paddr >= si->backup_src_start &&
+	    paddr < si->backup_src_start + si->backup_src_size)
+		paddr += si->backup_offset - si->backup_src_start;
+
 	pfn = paddr_to_pfn(paddr);
 	page_offset = paddr % info->page_size;
 
@@ -1774,4 +1809,137 @@ free_sadump_info(void)
 		free(si->cpu_online_mask_buf);
 }
 
+void
+sadump_kdump_backup_region_init(void)
+{
+	unsigned char buf[BUFSIZE];
+	unsigned long i, total, kexec_crash_image_p, elfcorehdr_p;
+	Elf64_Off e_phoff;
+	uint16_t e_phnum, e_phentsize;
+	unsigned long long backup_offset;
+	unsigned long backup_src_start, backup_src_size;
+	size_t bufsize;
+	
+	if (!readmem(VADDR, SYMBOL(kexec_crash_image), &kexec_crash_image_p,
+		     sizeof(unsigned long))) {
+		ERRMSG("Can't read kexec_crash_image pointer. %s\n",
+		       strerror(errno));
+		return;
+	}
+
+	if (!kexec_crash_image_p) {
+		DEBUG_MSG("sadump: kexec crash image was not loaded\n");
+		return;
+	}
+
+	if (!readmem(VADDR, kexec_crash_image_p+OFFSET(kimage.segment),
+		     buf, SIZE(kexec_segment)*ARRAY_LENGTH(kimage.segment))) {
+		ERRMSG("Can't read kexec_crash_image->segment. %s\n",
+		       strerror(errno));
+		return;
+	}
+
+	elfcorehdr_p = 0;
+	for (i = 0; i < ARRAY_LENGTH(kimage.segment); ++i) {
+		char e_ident[EI_NIDENT];
+		unsigned mem;
+
+		mem=ULONG(buf+i*SIZE(kexec_segment)+OFFSET(kexec_segment.mem));
+		if (!mem)
+			continue;
+
+		if (!readmem(PADDR, mem, e_ident, SELFMAG)) {
+			DEBUG_MSG("sadump: failed to read elfcorehdr buffer\n");
+			return;
+		}
+
+		if (strncmp(ELFMAG, e_ident, SELFMAG) == 0) {
+			elfcorehdr_p = mem;
+			break;
+		}
+	}
+	if (!elfcorehdr_p) {
+		DEBUG_MSG("sadump: kexec_crash_image contains no elfcorehdr "
+			  "segment\n");
+		return;
+	}
+
+        if (!readmem(PADDR, elfcorehdr_p, buf, SIZE(elf64_hdr))) {
+		ERRMSG("Can't read elfcorehdr ELF header. %s\n",
+		       strerror(errno));
+		return;
+	}
+
+	e_phnum = USHORT(buf + OFFSET(elf64_hdr.e_phnum));
+	e_phentsize = USHORT(buf + OFFSET(elf64_hdr.e_phentsize));
+	e_phoff = ULONG(buf + OFFSET(elf64_hdr.e_phoff));
+
+	backup_src_start = backup_src_size = backup_offset = 0;
+	for (i = 0; i < e_phnum; ++i) {
+		unsigned long p_type, p_offset, p_paddr, p_memsz;
+
+		if (!readmem(PADDR, elfcorehdr_p+e_phoff+i*e_phentsize, buf,
+			     e_phentsize)) {
+			ERRMSG("Can't read elfcorehdr program header. %s\n",
+			       strerror(errno));
+			return;
+		}
+
+		p_type = UINT(buf + OFFSET(elf64_phdr.p_type));
+		p_offset = ULONG(buf + OFFSET(elf64_phdr.p_offset));
+		p_paddr = ULONG(buf + OFFSET(elf64_phdr.p_paddr));
+		p_memsz = ULONG(buf + OFFSET(elf64_phdr.p_memsz));
+
+		if (p_type == PT_LOAD &&
+		    p_paddr <= KEXEC_BACKUP_SRC_END &&
+		    p_paddr + p_memsz <= p_offset) {
+
+			backup_src_start = p_paddr;
+			backup_src_size = p_memsz;
+			backup_offset = p_offset;
+
+DEBUG_MSG("sadump: SRC_START: %#016lx SRC_SIZE: %#016lx SRC_OFFSET: %#016llx\n",
+	  backup_src_start, backup_src_size, backup_offset);
+
+			break;
+		}
+	}
+	if (i == e_phnum) {
+DEBUG_MSG("sadump: No PT_LOAD in elfcorehdr for backup area\n");
+		return;
+	}
+
+	bufsize = BUFSIZE;
+	for (total = 0; total < backup_src_size; total += bufsize) {
+
+		if (backup_src_size - total < BUFSIZE)
+			bufsize = backup_src_size - total;
+
+		if (!readmem(PADDR, backup_offset + total, buf, bufsize)) {
+			ERRMSG("Can't read bacckup region. %s\n",
+			       strerror(errno));
+			return;
+		}
+
+		/*
+		 * We're assuming that the backup region is full of 0
+		 * before kdump saves the first 640kB memory of the
+		 * 1st kernel in the region.
+		 */
+		if (!is_zero_page(buf, bufsize)) {
+
+			si->kdump_backed_up = TRUE;
+			si->backup_src_start = backup_src_start;
+			si->backup_src_size = backup_src_size;
+			si->backup_offset = backup_offset;
+
+			DEBUG_MSG("sadump: kdump backup region used\n");
+
+			return;
+		}
+	}
+
+	DEBUG_MSG("sadump: kdump backup region unused\n");
+}
+
 #endif /* defined(__x86__) && defined(__x86_64__) */
diff --git a/sadump_info.h b/sadump_info.h
index f90ea5a..1f74ee5 100644
--- a/sadump_info.h
+++ b/sadump_info.h
@@ -54,6 +54,7 @@ long sadump_page_size(void);
 char *sadump_head_disk_name_memory(void);
 char *sadump_format_type_name(void);
 void free_sadump_info(void);
+void sadump_kdump_backup_region_init(void);
 
 static inline int sadump_is_supported_arch(void)
 {
@@ -154,6 +155,11 @@ static inline int sadump_is_supported_arch(void)
 	return FALSE;
 }
 
+static inline void sadump_kdump_backup_region_init(void)
+{
+	return;
+}
+
 #endif
 
 #endif /* _SADUMP_INFO_H */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
