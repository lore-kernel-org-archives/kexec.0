Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDbUG-00025z-Ku
 for kexec@lists.infradead.org; Thu, 07 Mar 2013 14:08:02 +0000
Received: from g1t0038.austin.hp.com (g1t0038.austin.hp.com [16.236.32.44])
 by g1t0029.austin.hp.com (Postfix) with ESMTP id DAE1D38189
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 14:07:58 +0000 (UTC)
Subject: [RFC PATCH] patch for crash dump bitmap
From: Jingbai Ma <jingbai.ma@hp.com>
Date: Thu, 07 Mar 2013 22:07:54 +0800
Message-ID: <20130307140753.28652.69709.stgit@k.asiapacific.hpqcorp.net>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: lisa.mitchell@hp.com

Use the crash dump bitmap to speedup memory pages classification process.

Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
---
 makedumpfile.c |  122 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.h |   38 +++++++++++++++++
 2 files changed, 157 insertions(+), 3 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index acb1b21..f29b6a5 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -34,6 +34,10 @@ struct srcfile_table	srcfile_table;
 struct vm_table		vt = { 0 };
 struct DumpInfo		*info = NULL;
 
+struct crash_dump_bitmap_info	crash_dump_bitmap_info;
+
+const unsigned int CURRENT_BITMAP_INFO_VERSION = 1;
+
 char filename_stdout[] = FILENAME_STDOUT;
 
 /*
@@ -892,6 +896,7 @@ get_symbol_info(void)
 	SYMBOL_INIT(node_remap_start_vaddr, "node_remap_start_vaddr");
 	SYMBOL_INIT(node_remap_end_vaddr, "node_remap_end_vaddr");
 	SYMBOL_INIT(node_remap_start_pfn, "node_remap_start_pfn");
+	SYMBOL_INIT(crash_dump_bitmap_info, "crash_dump_bitmap_info");
 
 	if (SYMBOL(node_data) != NOT_FOUND_SYMBOL)
 		SYMBOL_ARRAY_TYPE_INIT(node_data, "node_data");
@@ -1704,6 +1709,8 @@ read_vmcoreinfo(void)
 	READ_SYMBOL("node_remap_end_vaddr", node_remap_end_vaddr);
 	READ_SYMBOL("node_remap_start_pfn", node_remap_start_pfn);
 
+	READ_SYMBOL("crash_dump_bitmap_info", crash_dump_bitmap_info);
+
 	READ_STRUCTURE_SIZE("page", page);
 	READ_STRUCTURE_SIZE("mem_section", mem_section);
 	READ_STRUCTURE_SIZE("pglist_data", pglist_data);
@@ -4423,6 +4430,74 @@ copy_bitmap(void)
 int
 create_2nd_bitmap(void)
 {
+	off_t offset_page;
+	char buf1[info->page_size], buf2[info->page_size];
+	int i;
+
+	if (info->flag_crash_dump_bitmap) {
+		offset_page = 0;
+		while (offset_page < (info->len_bitmap / 2)) {
+			if (lseek(info->bitmap1->fd, info->bitmap1->offset
+				+ offset_page, SEEK_SET) < 0) {
+				ERRMSG("Can't seek the bitmap(%s). %s\n",
+				    info->bitmap1->file_name, strerror(errno));
+				return FALSE;
+			}
+
+			if (read(info->bitmap1->fd, buf1, info->page_size)
+				!= info->page_size) {
+					ERRMSG("Can't read bitmap(%s). %s\n",
+					info->bitmap1->file_name,
+					strerror(errno));
+				return FALSE;
+			}
+
+			if (readmem(PADDR, crash_dump_bitmap_info.bitmap
+				+ offset_page, buf2, info->page_size)
+				!= info->page_size) {
+				ERRMSG("Can't read bitmap1! addr=%llx\n",
+					crash_dump_bitmap_info.bitmap
+					+ offset_page);
+				return FALSE;
+			}
+
+			if (crash_dump_bitmap_info.version
+				!= CURRENT_BITMAP_INFO_VERSION) {
+				ERRMSG("bitmap version! expected=%d, got=%d\n",
+					CURRENT_BITMAP_INFO_VERSION,
+					crash_dump_bitmap_info.version);
+				return FALSE;
+			}
+
+			for (i = 0; i < info->page_size; i++)
+				buf2[i] = buf1[i] & buf2[i];
+
+			if (lseek(info->bitmap2->fd, info->bitmap2->offset
+				+ offset_page, SEEK_SET) < 0) {
+				ERRMSG("Can't seek the bitmap(%s). %s\n",
+				    info->bitmap2->file_name, strerror(errno));
+				return FALSE;
+			}
+
+			if (write(info->bitmap2->fd, buf2, info->page_size)
+				!= info->page_size) {
+				ERRMSG("Can't write the bitmap(%s). %s\n",
+				    info->bitmap2->file_name, strerror(errno));
+				return FALSE;
+			}
+
+			offset_page += info->page_size;
+		}
+
+		pfn_cache = crash_dump_bitmap_info.cache_pages;
+		pfn_cache_private = crash_dump_bitmap_info.cache_private_pages;
+		pfn_user = crash_dump_bitmap_info.user_pages;
+		pfn_free = crash_dump_bitmap_info.free_pages;
+		pfn_hwpoison = crash_dump_bitmap_info.hwpoison_pages;
+
+		return TRUE;
+	}
+
 	/*
 	 * Copy 1st-bitmap to 2nd-bitmap.
 	 */
@@ -4587,6 +4662,46 @@ create_dump_bitmap(void)
 		if (!prepare_bitmap_buffer())
 			goto out;
 
+		if (info->flag_crash_dump_bitmap
+			&& (SYMBOL(crash_dump_bitmap_info)
+			!= NOT_FOUND_SYMBOL)) {
+			/* Read crash_dump_bitmap_info from old kernel */
+			readmem(VADDR, SYMBOL(crash_dump_bitmap_info),
+				&crash_dump_bitmap_info,
+				sizeof(struct crash_dump_bitmap_info));
+
+			if (!crash_dump_bitmap_info.bitmap_size
+				|| !crash_dump_bitmap_info.bitmap) {
+				ERRMSG("Can't get crash_dump bitmap info! ");
+				ERRMSG("Failback to legacy mode.\n");
+				ERRMSG("crash_dump_bitmap_info=0x%llx, ",
+					SYMBOL(crash_dump_bitmap_info));
+				ERRMSG("bitmap=0x%llx, ",
+					crash_dump_bitmap_info.bitmap);
+				ERRMSG("bitmap_size=%lld\n",
+					crash_dump_bitmap_info.bitmap_size);
+
+				info->flag_crash_dump_bitmap = FALSE;
+			} else {
+				MSG("crash_dump_bitmap: ");
+				MSG("crash_dump_bitmap_info=0x%llx, ",
+					SYMBOL(crash_dump_bitmap_info));
+				MSG("bitmap=0x%llx, ",
+					crash_dump_bitmap_info.bitmap);
+				MSG("bitmap_size=%lld, ",
+					crash_dump_bitmap_info.bitmap_size);
+				MSG("cache_pages=0x%lx, ",
+					crash_dump_bitmap_info.cache_pages);
+				MSG("cache_private_pages=0x%lx, ",
+					crash_dump_bitmap_info
+					.cache_private_pages);
+				MSG("user_pages=0x%lx, ",
+					crash_dump_bitmap_info.user_pages);
+				MSG("free_pages=0x%lx\n",
+					crash_dump_bitmap_info.free_pages);
+			}
+		}
+
 		if (!create_1st_bitmap())
 			goto out;
 
@@ -8454,7 +8569,8 @@ main(int argc, char *argv[])
 	
 	info->block_order = DEFAULT_ORDER;
 	message_level = DEFAULT_MSG_LEVEL;
-	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:lMpRrsvXx:", longopts,
+	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:lMpqRrsvXx:",
+		longopts,
 	    NULL)) != -1) {
 		switch (opt) {
 		case 'b':
@@ -8518,6 +8634,10 @@ main(int argc, char *argv[])
 		case 'P':
 			info->xen_phys_start = strtoul(optarg, NULL, 0);
 			break;
+		case 'q':
+			info->flag_crash_dump_bitmap = TRUE;
+			info->flag_cyclic = FALSE;
+			break;
 		case 'R':
 			info->flag_rearrange = 1;
 			break;
diff --git a/makedumpfile.h b/makedumpfile.h
index 272273e..6404b16 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -41,6 +41,8 @@
 #include "dwarf_info.h"
 #include "diskdump_mod.h"
 #include "sadump_mod.h"
+#include "print_info.h"
+
 
 /*
  * Result of command
@@ -889,6 +891,7 @@ struct DumpInfo {
 	int		flag_refiltering;    /* refilter from kdump-compressed file */
 	int		flag_force;	     /* overwrite existing stuff */
 	int		flag_exclude_xen_dom;/* exclude Domain-U from xen-kdump */
+	int		flag_crash_dump_bitmap;/* crash dump bitmap */
 	int             flag_dmesg;          /* dump the dmesg log out of the vmcore file */
 	int		flag_nospace;	     /* the flag of "No space on device" error */
 	unsigned long	vaddr_for_vtop;      /* virtual address for debugging */
@@ -1153,6 +1156,11 @@ struct symbol_table {
 	unsigned long long	__per_cpu_load;
 	unsigned long long	cpu_online_mask;
 	unsigned long long	kexec_crash_image;
+
+	/*
+	 * for crash_dump_bitmap
+ 	 */
+	unsigned long long	crash_dump_bitmap_info;
 };
 
 struct size_table {
@@ -1381,6 +1389,20 @@ struct srcfile_table {
 	char	pud_t[LEN_SRCFILE];
 };
 
+/*
+ * for crash_dump_bitmap
+ */
+struct crash_dump_bitmap_info {
+	unsigned int version;
+	unsigned long long bitmap;
+	unsigned long long bitmap_size;
+	unsigned long cache_pages;
+	unsigned long cache_private_pages;
+	unsigned long user_pages;
+	unsigned long free_pages;
+	unsigned long hwpoison_pages;
+};
+
 extern struct symbol_table	symbol_table;
 extern struct size_table	size_table;
 extern struct offset_table	offset_table;
@@ -1541,8 +1563,20 @@ is_dumpable(struct dump_bitmap *bitmap, unsigned long long pfn)
 	off_t offset;
 	if (pfn == 0 || bitmap->no_block != pfn/PFN_BUFBITMAP) {
 		offset = bitmap->offset + BUFSIZE_BITMAP*(pfn/PFN_BUFBITMAP);
-		lseek(bitmap->fd, offset, SEEK_SET);
-		read(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP);
+		if (lseek(bitmap->fd, offset, SEEK_SET) < 0) {
+			ERRMSG("Can't seek bitmap file %s:(%d), ",
+				bitmap->file_name, bitmap->fd);
+			ERRMSG("offset=%ld, error: %s\n",
+				offset, strerror(errno));
+		}
+
+		if (read(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP) < 0) {
+			ERRMSG("Can't read bitmap file %s:(%d), ",
+				bitmap->file_name, bitmap->fd);
+			ERRMSG("offset=%ld, error: %s\n",
+				offset, strerror(errno));
+		}
+
 		if (pfn == 0)
 			bitmap->no_block = 0;
 		else


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
