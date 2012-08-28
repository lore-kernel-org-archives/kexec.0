Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6PvJ-0003dn-LI
 for kexec@lists.infradead.org; Tue, 28 Aug 2012 17:49:59 +0000
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id A7A6CA3BA5
 for <kexec@lists.infradead.org>; Tue, 28 Aug 2012 19:49:53 +0200 (CEST)
Subject: [PATCH] makedumpfile: keep dumpfile pages in a cache
From: Petr Tesarik <ptesarik@suse.cz>
Date: Tue, 28 Aug 2012 19:49:49 +0200
MIME-Version: 1.0
Message-Id: <201208281949.50286.ptesarik@suse.cz>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Petr Tesarik <ptesarik@suse.cz>

Add a simple cache for pages read from the dumpfile.

This is a big win if we read consecutive data from one page, e.g.
page descriptors, or even page table entries.

Note that makedumpfile now always reads a complete page. This was already
the case with kdump-compressed and sadump formats, but makedumpfile was
throwing most of the data away. For the kdump-compressed case, we may
actually save a lot of decompression, too.

I tried to keep the cache small to minimize memory footprint, but it should
be big enough to hold all pages to do 4-level paging plus some data. This
is needed e.g. for vmalloc areas or Xen page frame table data, which are not
contiguous in physical memory.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

---
 Makefile       |    4 -
 cache.c        |  119 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 cache.h        |   26 ++++++++++++
 makedumpfile.c |  113 +++++++++++++++++++++++++++++++-----------------------
 sadump_info.c  |   24 +++--------
 sadump_info.h  |    2 
 6 files changed, 222 insertions(+), 66 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -40,8 +40,8 @@ CFLAGS_ARCH += -m32
 endif
 
 SRC	= makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h 
sadump_info.h
-SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c
-OBJ_PART = print_info.o dwarf_info.o elf_info.o erase_info.o sadump_info.o
+SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c 
cache.c
+OBJ_PART = print_info.o dwarf_info.o elf_info.o erase_info.o sadump_info.o 
cache.o
 SRC_ARCH = arch/arm.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c 
arch/s390x.c arch/ppc.c
 OBJ_ARCH = arch/arm.o arch/x86.o arch/x86_64.o arch/ia64.o arch/ppc64.o 
arch/s390x.o arch/ppc.o
 
--- /dev/null
+++ b/cache.c
@@ -0,0 +1,119 @@
+/*
+ * cache.h
+ *
+ * Created by: Petr Tesarik <ptesarik@suse.cz>
+ *
+ * Copyright (c) 2012 SUSE LINUX Products GmbH, Nuernberg, Germany.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include "makedumpfile.h"
+#include "cache.h"
+
+struct cache_entry {
+	unsigned long long paddr;
+	void *bufptr;
+	struct cache_entry *next, *prev;
+};
+
+struct cache {
+	struct cache_entry *head, *tail;
+};
+
+/* 8 pages covers 4-level paging plus 4 data pages */
+#define CACHE_SIZE	8
+static struct cache_entry pool[CACHE_SIZE];
+static int avail = CACHE_SIZE;
+
+static struct cache used, pending;
+
+static void
+add_entry(struct cache *cache, struct cache_entry *entry)
+{
+	entry->next = cache->head;
+	entry->prev = NULL;
+	if (cache->head)
+		cache->head->prev = entry;
+	cache->head = entry;
+	if (!cache->tail)
+		cache->tail = entry;
+}
+
+static void
+remove_entry(struct cache *cache, struct cache_entry *entry)
+{
+	if (entry->next)
+		entry->next->prev = entry->prev;
+	else
+		cache->tail = entry->prev;
+
+	if (entry->prev)
+		entry->prev->next = entry->next;
+	else
+		cache->head = entry->next;
+}
+
+void *
+cache_search(unsigned long long paddr)
+{
+	struct cache_entry *entry;
+	for (entry = used.head; entry; entry = entry->next)
+		if (entry->paddr == paddr) {
+			if (entry != used.head) {
+				remove_entry(&used, entry);
+				add_entry(&used, entry);
+			}
+			return entry->bufptr;
+		}
+
+	return NULL;		/* cache miss */
+}
+
+void *
+cache_alloc(unsigned long long paddr)
+{
+	struct cache_entry *entry = NULL;
+
+	if (avail) {
+		void *bufptr = malloc(info->page_size);
+		if (bufptr) {
+			entry = &pool[--avail];
+			entry->bufptr = bufptr;
+		}
+	}
+
+	if (!entry) {
+		if (used.tail) {
+			entry = used.tail;
+			remove_entry(&used, entry);
+		} else
+			return NULL;
+	}
+
+	entry->paddr = paddr;
+	add_entry(&pending, entry);
+
+	return entry->bufptr;
+}
+
+void
+cache_add(unsigned long long paddr)
+{
+	struct cache_entry *entry;
+	for (entry = pending.head; entry; entry = entry->next) {
+		if (entry->paddr == paddr) {
+			remove_entry(&pending, entry);
+			add_entry(&used, entry);
+			break;
+		}
+	}
+}
--- /dev/null
+++ b/cache.h
@@ -0,0 +1,26 @@
+/*
+ * cache.h
+ *
+ * Written by: Petr Tesarik <ptesarik@suse.cz>
+ *
+ * Copyright (c) 2012 SUSE LINUX Products GmbH, Nuernberg, Germany.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _CACHE_H
+#define _CACHE_H
+
+void *cache_search(unsigned long long paddr);
+void *cache_alloc(unsigned long long paddr);
+void cache_add(unsigned long long paddr);
+
+#endif	/* _CACHE_H */
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -19,6 +19,7 @@
 #include "elf_info.h"
 #include "erase_info.h"
 #include "sadump_info.h"
+#include "cache.h"
 #include <stddef.h>
 #include <sys/time.h>
 
@@ -222,83 +223,103 @@ read_page_desc(unsigned long long paddr,
 	return TRUE;
 }
 
-int
-readpmem_kdump_compressed(unsigned long long paddr, void *bufptr, size_t 
size)
+static int
+readpage_elf(unsigned long long paddr, void *bufptr)
+{
+	const off_t failed = (off_t)-1;
+	off_t offset = 0;
+
+	if (!(offset = paddr_to_offset(paddr))) {
+		ERRMSG("Can't convert a physical address(%llx) to offset.\n",
+		    paddr);
+		return FALSE;
+	}
+
+	if (lseek(info->fd_memory, offset, SEEK_SET) == failed) {
+		ERRMSG("Can't seek the dump memory(%s). (offset: %llx) %s\n",
+		    info->name_memory, (unsigned long long)offset, strerror(errno));
+		return FALSE;
+	}
+
+	if (read(info->fd_memory, bufptr, info->page_size) != info->page_size) {
+		ERRMSG("Can't read the dump memory(%s). %s\n",
+		    info->name_memory, strerror(errno));
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static int
+readpage_kdump_compressed(unsigned long long paddr, void *bufptr)
 {
 	page_desc_t pd;
-	char buf[info->page_size];
-	char buf2[info->page_size];
+	char buf[info->page_size], *rdbuf;
 	int ret;
-	unsigned long retlen, page_offset;
-
-	page_offset = paddr % info->page_size;
+	unsigned long retlen;
 
 	if (!is_dumpable(info->bitmap_memory, paddr_to_pfn(paddr))) {
 		ERRMSG("pfn(%llx) is excluded from %s.\n",
 				paddr_to_pfn(paddr), info->name_memory);
-		goto error;
+		return FALSE;
 	}
 
 	if (!read_page_desc(paddr, &pd)) {
 		ERRMSG("Can't read page_desc: %llx\n", paddr);
-		goto error;
+		return FALSE;
 	}
 
 	if (lseek(info->fd_memory, pd.offset, SEEK_SET) < 0) {
 		ERRMSG("Can't seek %s. %s\n",
 				info->name_memory, strerror(errno));
-		goto error;
+		return FALSE;
 	}
 
 	/*
 	 * Read page data
 	 */
-	if (read(info->fd_memory, buf, pd.size) != pd.size) {
+	rdbuf = pd.flags & (DUMP_DH_COMPRESSED_ZLIB | DUMP_DH_COMPRESSED_LZO)
+		? buf : bufptr;
+	if (read(info->fd_memory, rdbuf, pd.size) != pd.size) {
 		ERRMSG("Can't read %s. %s\n",
 				info->name_memory, strerror(errno));
-		goto error;
+		return FALSE;
 	}
 
 	if (pd.flags & DUMP_DH_COMPRESSED_ZLIB) {
 		retlen = info->page_size;
-		ret = uncompress((unsigned char *)buf2, &retlen,
+		ret = uncompress((unsigned char *)bufptr, &retlen,
 					(unsigned char *)buf, pd.size);
 		if ((ret != Z_OK) || (retlen != info->page_size)) {
 			ERRMSG("Uncompress failed: %d\n", ret);
-			goto error;
+			return FALSE;
 		}
-		memcpy(bufptr, buf2 + page_offset, size);
 #ifdef USELZO
 	} else if (info->flag_lzo_support
 		   && (pd.flags & DUMP_DH_COMPRESSED_LZO)) {
 		retlen = info->page_size;
 		ret = lzo1x_decompress_safe((unsigned char *)buf, pd.size,
-					    (unsigned char *)buf2, &retlen,
+					    (unsigned char *)bufptr, &retlen,
 					    LZO1X_MEM_DECOMPRESS);
 		if ((ret != LZO_E_OK) || (retlen != info->page_size)) {
 			ERRMSG("Uncompress failed: %d\n", ret);
-			goto error;
+			return FALSE;
 		}
-		memcpy(bufptr, buf2 + page_offset, size);
 #endif
-	} else
-		memcpy(bufptr, buf + page_offset, size);
+	}
 
-	return size;
-error:
-	ERRMSG("type_addr: %d, addr:%llx, size:%zd\n", PADDR, paddr, size);
-	return FALSE;
+	return TRUE;
 }
 
 int
 readmem(int type_addr, unsigned long long addr, void *bufptr, size_t size)
 {
 	size_t read_size, next_size;
-	off_t offset = 0;
 	unsigned long long next_addr;
 	unsigned long long paddr, maddr = NOT_PADDR;
+	unsigned long long pgaddr;
+	void *pgbuf;
 	char *next_ptr;
-	const off_t failed = (off_t)-1;
 
 	switch (type_addr) {
 	case VADDR:
@@ -358,31 +379,29 @@ readmem(int type_addr, unsigned long lon
 			goto error;
 	}
 
-	if (info->flag_refiltering)
-		return readpmem_kdump_compressed(paddr, bufptr, read_size);
-
-	if (info->flag_sadump)
-		return readpmem_sadump(paddr, bufptr, read_size);
-
-	if (!(offset = paddr_to_offset(paddr))) {
-		ERRMSG("Can't convert a physical address(%llx) to offset.\n",
-		    paddr);
-		goto error;
-	}
-
-	if (lseek(info->fd_memory, offset, SEEK_SET) == failed) {
-		ERRMSG("Can't seek the dump memory(%s). (offset: %llx) %s\n",
-		    info->name_memory, (unsigned long long)offset, strerror(errno));
-		goto error;
-	}
+	pgaddr = PAGEBASE(paddr);
+	pgbuf = cache_search(pgaddr);
+	if (!pgbuf) {
+		pgbuf = cache_alloc(pgaddr);
+		if (!pgbuf)
+			goto error;
 
-	if (read(info->fd_memory, bufptr, read_size) != read_size) {
-		ERRMSG("Can't read the dump memory(%s). %s\n",
-		    info->name_memory, strerror(errno));
-		goto error;
+		if (info->flag_refiltering) {
+			if (!readpage_kdump_compressed(pgaddr, pgbuf))
+				goto error;
+		} else if (info->flag_sadump) {
+			if (!readpage_sadump(pgaddr, pgbuf))
+				goto error;
+		} else {
+			if (!readpage_elf(pgaddr, pgbuf))
+				goto error;
+		}
+		cache_add(pgaddr);
 	}
 
+	memcpy(bufptr, pgbuf + PAGEOFFSET(paddr), read_size);
 	return size;
+
 error:
 	ERRMSG("type_addr: %d, addr:%llx, size:%zd\n", type_addr, addr, size);
 	return FALSE;
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -949,11 +949,10 @@ failed:
 #endif /* __x86_64__ */
 
 int
-readpmem_sadump(unsigned long long paddr, void *bufptr, size_t size)
+readpage_sadump(unsigned long long paddr, void *bufptr)
 {
 	unsigned long long pfn, block, whole_offset, perdisk_offset;
 	ulong page_offset;
-	char buf[info->page_size];
 	int fd_memory;
 
 	if (si->kdump_backed_up &&
@@ -965,12 +964,12 @@ readpmem_sadump(unsigned long long paddr
 	page_offset = paddr % info->page_size;
 
 	if (pfn >= si->sh_memory->max_mapnr)
-		goto error;
+		return FALSE;
 
 	if (!is_dumpable(info->bitmap_memory, pfn)) {
 		ERRMSG("pfn(%llx) is excluded from %s.\n", pfn,
 		       info->name_memory);
-		goto error;
+		return FALSE;
 	}
 
 	block = pfn_to_block(pfn);
@@ -980,7 +979,7 @@ readpmem_sadump(unsigned long long paddr
 		int diskid;
 
 		if (!lookup_diskset(whole_offset, &diskid, &perdisk_offset))
-			goto error;
+			return FALSE;
 
 		fd_memory = si->diskset_info[diskid].fd_memory;
 		perdisk_offset += si->diskset_info[diskid].data_offset;
@@ -992,19 +991,12 @@ readpmem_sadump(unsigned long long paddr
 	}
 
 	if (lseek(fd_memory, perdisk_offset, SEEK_SET) < 0)
-		goto error;
+		return FALSE;
 
-	if (read(fd_memory, buf, sizeof(buf)) != sizeof(buf))
-		goto error;
+	if (read(fd_memory, bufptr, info->page_size) != info->page_size)
+		return FALSE;
 
-	memcpy(bufptr, buf + page_offset, size);
-
-	return size;
-
-error:
-	DEBUG_MSG("type_addr: %d, addr:%llx, size:%zd\n", PADDR, paddr, size);
-
-	return FALSE;
+	return TRUE;
 }
 
 int
--- a/sadump_info.h
+++ b/sadump_info.h
@@ -43,7 +43,7 @@ int sadump_initialize_bitmap_memory(void
 int sadump_num_online_cpus(void);
 int sadump_set_timestamp(struct timeval *ts);
 unsigned long long sadump_get_max_mapnr(void);
-int readpmem_sadump(unsigned long long paddr, void *bufptr, size_t size);
+int readpage_sadump(unsigned long long paddr, void *bufptr);
 int sadump_check_debug_info(void);
 int sadump_generate_vmcoreinfo_from_vmlinux(size_t *vmcoreinfo_size);
 int sadump_generate_elf_note_from_dumpfile(void);



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
