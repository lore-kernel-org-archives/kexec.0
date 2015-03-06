Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YXQRJ-0001Zx-TR
 for kexec@lists.infradead.org; Mon, 16 Mar 2015 08:32:00 +0000
Message-Id: <49262b665ac12e29f338ba450799a58c696ecf9d.1426494404.git.ptesarik@suse.cz>
In-Reply-To: <cover.1426494404.git.ptesarik@suse.cz>
References: <cover.1426494404.git.ptesarik@suse.cz>
From: Petr Tesarik <ptesarik@suse.cz>
Date: Fri, 6 Mar 2015 14:23:34 +0100
Subject: [PATCH v3 7/7] cache: store mapped regions directly in the cache
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec mailing list <kexec@lists.infradead.org>, Jan Willeke <willeke@de.ibm.com>

Avoid copying data between the mmapped region and the cache. To do that,
readmem() tries to map the page before reading it. The mmap path and
the read path are separated: mappage_elf() uses the mmap syscall, and
readpage_elf() uses the read syscall.

If mmap is successful, readmem() stores the mmap address in the cache
entry. Of course, the mapping must not be removed until the cache entry
is evicted, but the cache code has no knowledge about mmap. To solve that
in a flexible way, a discard callback is added to struct cache_entry and
called by cache eviction code.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
---
 cache.c        |   3 ++
 cache.h        |   2 ++
 makedumpfile.c | 105 ++++++++++++++++++++++++++++++++-------------------------
 3 files changed, 64 insertions(+), 46 deletions(-)

diff --git a/cache.c b/cache.c
index 938eda6..963eb76 100644
--- a/cache.c
+++ b/cache.c
@@ -108,6 +108,8 @@ cache_alloc(unsigned long long paddr)
 	} else if (used.tail) {
 		entry = used.tail;
 		remove_entry(&used, entry);
+		if (entry->discard)
+			entry->discard(entry);
 	} else
 		return NULL;
 
@@ -115,6 +117,7 @@ cache_alloc(unsigned long long paddr)
 	entry->paddr = paddr;
 	entry->bufptr = cachebuf + idx * info->page_size;
 	entry->buflen = info->page_size;
+	entry->discard = NULL;
 	add_entry(&pending, entry);
 
 	return entry;
diff --git a/cache.h b/cache.h
index 792ba6c..c55cec4 100644
--- a/cache.h
+++ b/cache.h
@@ -24,6 +24,8 @@ struct cache_entry {
 	void *bufptr;
 	unsigned long buflen;
 	struct cache_entry *next, *prev;
+
+	void (*discard)(struct cache_entry *);
 };
 
 int cache_init(void);
diff --git a/makedumpfile.c b/makedumpfile.c
index f1aad08..32f5459 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -294,6 +294,12 @@ read_page_desc(unsigned long long paddr, page_desc_t *pd)
 	return TRUE;
 }
 
+static void
+unmap_cache(struct cache_entry *entry)
+{
+	munmap(entry->bufptr, entry->buflen);
+}
+
 static int
 update_mmap_range(off_t offset, int initial) {
 	off_t start_offset, end_offset;
@@ -301,9 +307,6 @@ update_mmap_range(off_t offset, int initial) {
 	off_t max_offset = get_max_file_offset();
 	off_t pt_load_end = offset_to_pt_load_end(offset);
 
-	munmap(info->mmap_buf,
-	       info->mmap_end_offset - info->mmap_start_offset);
-
 	/*
 	 * offset for mmap() must be page aligned.
 	 */
@@ -357,29 +360,45 @@ initialize_mmap(void) {
 	return TRUE;
 }
 
-static int
-read_with_mmap(off_t offset, void *bufptr, unsigned long size) {
-	size_t read_size;
+static char *
+mappage_elf(unsigned long long paddr)
+{
+	off_t offset, offset2;
 
-next_region:
+	if (info->flag_usemmap != MMAP_ENABLE)
+		return NULL;
 
-	if (!is_mapped_with_mmap(offset))
-		if (!update_mmap_range(offset, 0))
-			return FALSE;
+	offset = paddr_to_offset(paddr);
+	if (!offset || page_is_fractional(offset))
+		return NULL;
+
+	offset2 = paddr_to_offset(paddr + info->page_size);
+	if (!offset2)
+		return NULL;
 
-	read_size = MIN(info->mmap_end_offset - offset, size);
+	if (offset2 - offset != info->page_size)
+		return NULL;
 
-	memcpy(bufptr, info->mmap_buf +
-	       (offset - info->mmap_start_offset), read_size);
+	if (!is_mapped_with_mmap(offset) &&
+	    !update_mmap_range(offset, 0)) {
+		ERRMSG("Can't read the dump memory(%s) with mmap().\n",
+		       info->name_memory);
 
-	offset += read_size;
-	bufptr += read_size;
-	size -= read_size;
+		ERRMSG("This kernel might have some problems about mmap().\n");
+		ERRMSG("read() will be used instead of mmap() from now.\n");
 
-	if (size > 0)
-		goto next_region;
+		/*
+		 * Fall back to read().
+		 */
+		info->flag_usemmap = MMAP_DISABLE;
+		return NULL;
+	}
 
-	return TRUE;
+	if (offset < info->mmap_start_offset ||
+	    offset + info->page_size > info->mmap_end_offset)
+		return NULL;
+
+	return info->mmap_buf + (offset - info->mmap_start_offset);
 }
 
 static int
@@ -387,33 +406,16 @@ read_from_vmcore(off_t offset, void *bufptr, unsigned long size)
 {
 	const off_t failed = (off_t)-1;
 
-	if (info->flag_usemmap == MMAP_ENABLE &&
-	    page_is_fractional(offset) == FALSE) {
-		if (!read_with_mmap(offset, bufptr, size)) {
-			ERRMSG("Can't read the dump memory(%s) with mmap().\n",
-			       info->name_memory);
-
-			ERRMSG("This kernel might have some problems about mmap().\n");
-			ERRMSG("read() will be used instead of mmap() from now.\n");
-
-			/*
-			 * Fall back to read().
-			 */
-			info->flag_usemmap = MMAP_DISABLE;
-			read_from_vmcore(offset, bufptr, size);
-		}
-	} else {
-		if (lseek(info->fd_memory, offset, SEEK_SET) == failed) {
-			ERRMSG("Can't seek the dump memory(%s). (offset: %llx) %s\n",
-			       info->name_memory, (unsigned long long)offset, strerror(errno));
-			return FALSE;
-		}
+	if (lseek(info->fd_memory, offset, SEEK_SET) == failed) {
+		ERRMSG("Can't seek the dump memory(%s). (offset: %llx) %s\n",
+		       info->name_memory, (unsigned long long)offset, strerror(errno));
+		return FALSE;
+	}
 
-		if (read(info->fd_memory, bufptr, size) != size) {
-			ERRMSG("Can't read the dump memory(%s). %s\n",
-			       info->name_memory, strerror(errno));
-			return FALSE;
-		}
+	if (read(info->fd_memory, bufptr, size) != size) {
+		ERRMSG("Can't read the dump memory(%s). %s\n",
+		       info->name_memory, strerror(errno));
+		return FALSE;
 	}
 
 	return TRUE;
@@ -662,7 +664,18 @@ next_page:
 			if (!readpage_sadump(pgaddr, pgbuf))
 				goto error_cached;
 		} else {
-			if (!readpage_elf(pgaddr, pgbuf))
+			char *mapbuf = mappage_elf(pgaddr);
+			size_t mapoff;
+
+			if (mapbuf) {
+				pgbuf = mapbuf;
+				mapoff = mapbuf - info->mmap_buf;
+				cached->paddr = pgaddr - mapoff;
+				cached->bufptr = info->mmap_buf;
+				cached->buflen = info->mmap_end_offset -
+					info->mmap_start_offset;
+				cached->discard = unmap_cache;
+			} else if (!readpage_elf(pgaddr, pgbuf))
 				goto error_cached;
 		}
 		cache_add(cached);
-- 
1.8.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
