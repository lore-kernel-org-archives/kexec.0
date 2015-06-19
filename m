Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z5sA1-0003x4-6H
 for kexec@lists.infradead.org; Fri, 19 Jun 2015 09:00:31 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t5J8wUQw011899
 for <kexec@lists.infradead.org>; Fri, 19 Jun 2015 16:58:30 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v2 02/10] Add mappage_elf_parallel
Date: Fri, 19 Jun 2015 16:56:36 +0800
Message-ID: <1434704204-2634-3-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1434704204-2634-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1434704204-2634-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
Cc: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>

From: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>

mappage_elf_parallel is used to enable mmaping elf format to memory
parallelly. later patch will will use the mmapped memory to get data
of each page. fd_memory and mmap_cache should be initialized and offered
to each threads individually to avoid conflict.

Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
---
 makedumpfile.c |   97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.h |   14 ++++++++
 2 files changed, 111 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 3657d4f..d1b4bc2 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -394,6 +394,46 @@ update_mmap_range(off_t offset, int initial) {
 }
 
 static int
+update_mmap_range_parallel(int fd_memory, off_t offset,
+			   struct mmap_cache *mmap_cache)
+{
+	off_t start_offset, end_offset;
+	off_t map_size;
+	off_t max_offset = get_max_file_offset();
+	off_t pt_load_end = offset_to_pt_load_end(offset);
+
+	/*
+	 * mmap_buf must be cleaned
+	 */
+	if (mmap_cache->mmap_buf != MAP_FAILED)
+		munmap(mmap_cache->mmap_buf, mmap_cache->mmap_end_offset
+					     - mmap_cache->mmap_start_offset);
+
+	/*
+	 * offset for mmap() must be page aligned.
+	 */
+	start_offset = roundup(offset, info->page_size);
+	end_offset = MIN(max_offset, round(pt_load_end, info->page_size));
+
+	if (!pt_load_end || (end_offset - start_offset) <= 0)
+		return FALSE;
+
+	map_size = MIN(end_offset - start_offset, info->mmap_region_size);
+
+	mmap_cache->mmap_buf = mmap(NULL, map_size, PROT_READ, MAP_PRIVATE,
+					fd_memory, start_offset);
+
+	if (mmap_cache->mmap_buf == MAP_FAILED) {
+		return FALSE;
+	}
+
+	mmap_cache->mmap_start_offset = start_offset;
+	mmap_cache->mmap_end_offset = start_offset + map_size;
+
+	return TRUE;
+}
+
+static int
 is_mapped_with_mmap(off_t offset) {
 
 	if (info->flag_usemmap == MMAP_ENABLE
@@ -404,6 +444,15 @@ is_mapped_with_mmap(off_t offset) {
 		return FALSE;
 }
 
+static int
+is_mapped_with_mmap_parallel(off_t offset, struct mmap_cache *mmap_cache) {
+	if (offset >= mmap_cache->mmap_start_offset
+	    && offset < mmap_cache->mmap_end_offset)
+		return TRUE;
+	else
+		return FALSE;
+}
+
 int
 initialize_mmap(void) {
 	unsigned long long phys_start;
@@ -458,6 +507,54 @@ mappage_elf(unsigned long long paddr)
 	return info->mmap_buf + (offset - info->mmap_start_offset);
 }
 
+static char *
+mappage_elf_parallel(int fd_memory, unsigned long long paddr,
+		     struct mmap_cache *mmap_cache)
+{
+	off_t offset, offset2;
+	int flag_usemmap;
+
+	pthread_rwlock_rdlock(&info->usemmap_rwlock);
+	flag_usemmap = info->flag_usemmap;
+	pthread_rwlock_unlock(&info->usemmap_rwlock);
+	if (flag_usemmap != MMAP_ENABLE)
+		return NULL;
+
+	offset = paddr_to_offset(paddr);
+	if (!offset || page_is_fractional(offset))
+		return NULL;
+
+	offset2 = paddr_to_offset(paddr + info->page_size - 1);
+	if (!offset2)
+		return NULL;
+
+	if (offset2 - offset != info->page_size - 1)
+		return NULL;
+
+	if (!is_mapped_with_mmap_parallel(offset, mmap_cache) &&
+	    !update_mmap_range_parallel(fd_memory, offset, mmap_cache)) {
+		ERRMSG("Can't read the dump memory(%s) with mmap().\n",
+		       info->name_memory);
+
+		ERRMSG("This kernel might have some problems about mmap().\n");
+		ERRMSG("read() will be used instead of mmap() from now.\n");
+
+		/*
+		 * Fall back to read().
+		 */
+		pthread_rwlock_wrlock(&info->usemmap_rwlock);
+		info->flag_usemmap = MMAP_DISABLE;
+		pthread_rwlock_unlock(&info->usemmap_rwlock);
+		return NULL;
+	}
+
+	if (offset < mmap_cache->mmap_start_offset ||
+	    offset + info->page_size > mmap_cache->mmap_end_offset)
+		return NULL;
+
+	return mmap_cache->mmap_buf + (offset - mmap_cache->mmap_start_offset);
+}
+
 static int
 read_from_vmcore(off_t offset, void *bufptr, unsigned long size)
 {
diff --git a/makedumpfile.h b/makedumpfile.h
index 3d6661f..bff134e 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -42,6 +42,7 @@
 #include "dwarf_info.h"
 #include "diskdump_mod.h"
 #include "sadump_mod.h"
+#include <pthread.h>
 
 /*
  * Result of command
@@ -956,6 +957,15 @@ typedef unsigned long int ulong;
 typedef unsigned long long int ulonglong;
 
 /*
+ * for parallel process
+ */
+struct mmap_cache {
+	char	*mmap_buf;
+	off_t	mmap_start_offset;
+	off_t   mmap_end_offset;
+};
+
+/*
  * makedumpfile header
  *   For re-arranging the dump data on different architecture, all the
  *   variables are defined by 64bits. The size of signature is aligned
@@ -1219,6 +1229,10 @@ struct DumpInfo {
 	 * for cyclic_splitting mode, setup splitblock_size
 	 */
 	long long splitblock_size;
+	/*
+	 * for parallel process
+	 */
+	pthread_rwlock_t usemmap_rwlock;
 };
 extern struct DumpInfo		*info;
 
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
