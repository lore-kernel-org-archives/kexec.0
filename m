Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RDe4l-0003H2-Po
	for kexec@lists.infradead.org; Tue, 11 Oct 2011 15:17:05 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id A7B1A3EE0AE
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:01 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 90DFC45DEA6
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:01 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7B88145DE9E
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:01 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 6F3621DB803E
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:01 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 31BE61DB803B
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:01 +0900 (JST)
Received: from ml14.css.fujitsu.com (ml14 [127.0.0.1])
	by ml14.s.css.fujitsu.com (Postfix) with ESMTP id 0C9FF9F7277
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:01 +0900 (JST)
Received: from localhost (unknown [10.124.102.140])
	by ml14.s.css.fujitsu.com (Postfix) with ESMTP id B56289F726F
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:00 +0900 (JST)
Date: Wed, 12 Oct 2011 00:16:56 +0900 (   )
Message-Id: <20111012.001656.59656773.d.hatayama@jp.fujitsu.com>
Subject: [PATCH 08/12] Implement readmem() interface on sadump-related formats
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20111012.001338.193691420.d.hatayama@jp.fujitsu.com>
References: <20111012.001338.193691420.d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
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

Very similar to the ones in kdump-compressed format.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 makedumpfile.c |    8 +++-
 sadump_info.c  |  144 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sadump_info.h  |   13 +++++
 3 files changed, 164 insertions(+), 1 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 4044bce..e4b3b38 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -346,6 +346,9 @@ readmem(int type_addr, unsigned long long addr, void *bufptr, size_t size)
 	if (info->flag_refiltering)
 		return readpmem_kdump_compressed(paddr, bufptr, read_size);
 
+	if (info->flag_sadump)
+		return readpmem_sadump(paddr, bufptr, read_size);
+
 	if (!(offset = paddr_to_offset(paddr))) {
 		ERRMSG("Can't convert a physical address(%llx) to offset.\n",
 		    paddr);
@@ -3436,6 +3439,9 @@ create_1st_bitmap(void)
 	if (info->flag_refiltering)
 		return copy_1st_bitmap_from_memory();
 
+	if (info->flag_sadump)
+		return sadump_copy_1st_bitmap_from_memory();
+
 	/*
 	 * At first, clear all the bits on the 1st-bitmap.
 	 */
@@ -4535,7 +4541,7 @@ read_pfn(unsigned long long pfn, unsigned char *buf)
 	size_t size1, size2;
 
 	paddr = pfn_to_paddr(pfn);
-	if (info->flag_refiltering) {
+	if (info->flag_refiltering || info->flag_sadump) {
 		if (!readmem(PADDR, paddr, buf, info->page_size)) {
 			ERRMSG("Can't get the page data.\n");
 			return FALSE;
diff --git a/sadump_info.c b/sadump_info.c
index 6b2b7bc..c4806c4 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -50,6 +50,9 @@ static int read_device_diskset(struct sadump_diskset_info *sdi, void *buf,
 			       size_t bytes, ulong *offset);
 static int read_sadump_header(char *filename);
 static int read_sadump_header_diskset(int diskid, struct sadump_diskset_info *sdi);
+static unsigned long pfn_to_block(unsigned long pfn);
+static int lookup_diskset(unsigned long whole_offset, int *diskid,
+			  unsigned long *disk_offset);
 
 static struct sadump_info sadump_info = {};
 static struct sadump_info *si = &sadump_info;
@@ -88,6 +91,45 @@ check_and_get_sadump_header_info(char *filename)
 	return TRUE;
 }
 
+int
+sadump_copy_1st_bitmap_from_memory(void)
+{
+	struct sadump_header *sh = si->sh_memory;
+	char buf[si->sh_memory->block_size];
+	off_t offset_page;
+	unsigned long bitmap_offset, bitmap_len;
+
+	bitmap_offset =	si->sub_hdr_offset + sh->block_size*sh->sub_hdr_size;
+	bitmap_len = sh->block_size * sh->bitmap_blocks;
+
+	if (lseek(info->fd_memory, bitmap_offset, SEEK_SET) < 0) {
+		ERRMSG("Can't seek %s. %s\n",
+		       info->name_memory, strerror(errno));
+		return FALSE;
+	}
+	if (lseek(info->bitmap1->fd, info->bitmap1->offset, SEEK_SET) < 0) {
+		ERRMSG("Can't seek the bitmap(%s). %s\n",
+		       info->bitmap1->file_name, strerror(errno));
+		return FALSE;
+	}
+	offset_page = 0;
+	while (offset_page < bitmap_len) {
+		if (read(info->fd_memory, buf, sizeof(buf)) != sizeof(buf)) {
+			ERRMSG("Can't read %s. %s\n",
+			       info->name_memory, strerror(errno));
+			return FALSE;
+		}
+		if (write(info->bitmap1->fd, buf, sizeof(buf)) != sizeof(buf)) {
+			ERRMSG("Can't write the bitmap(%s). %s\n",
+			       info->bitmap1->file_name, strerror(errno));
+			return FALSE;
+		}
+		offset_page += sizeof(buf);
+	}
+
+	return TRUE;
+}
+
 static char *
 guid_to_str(efi_guid_t *guid, char *buf, size_t buflen)
 {
@@ -625,6 +667,108 @@ sadump_get_max_mapnr(void)
 }
 
 int
+readpmem_sadump(unsigned long long paddr, void *bufptr, size_t size)
+{
+	unsigned long pfn, page_offset, block, whole_offset, perdisk_offset;
+	char buf[info->page_size];
+	int fd_memory;
+
+	pfn = paddr_to_pfn(paddr);
+	page_offset = paddr % info->page_size;
+
+	if (pfn >= si->sh_memory->max_mapnr)
+		goto error;
+
+	if (!is_dumpable(info->bitmap_memory, pfn)) {
+		ERRMSG("pfn(%lx) is excluded from %s.\n", pfn,
+		       info->name_memory);
+		goto error;
+	}
+
+	block = pfn_to_block(pfn);
+	whole_offset = block * si->sh_memory->block_size;
+
+	if (info->flag_sadump == SADUMP_DISKSET) {
+		int diskid;
+
+		if (!lookup_diskset(whole_offset, &diskid, &perdisk_offset))
+			goto error;
+
+		fd_memory = si->diskset_info[diskid].fd_memory;
+		perdisk_offset += si->diskset_info[diskid].data_offset;
+
+	} else {
+		fd_memory = info->fd_memory;
+		perdisk_offset = whole_offset + si->data_offset;
+
+	}
+
+	if (lseek(fd_memory, perdisk_offset, SEEK_SET) < 0)
+		goto error;
+
+	if (read(fd_memory, buf, sizeof(buf)) != sizeof(buf))
+		goto error;
+
+	memcpy(bufptr, buf + page_offset, size);
+
+	return size;
+
+error:
+	DEBUG_MSG("type_addr: %d, addr:%llx, size:%zd\n", PADDR, paddr, size);
+
+	return FALSE;
+}
+
+static unsigned long
+pfn_to_block(unsigned long pfn)
+{
+	unsigned long block, section, p;
+
+	section = pfn / SADUMP_PF_SECTION_NUM;
+
+	if (section)
+		block = si->block_table[section - 1];
+	else
+		block = 0;
+
+	for (p = section * SADUMP_PF_SECTION_NUM; p < pfn; ++p)
+		if (is_dumpable(info->bitmap_memory, p))
+			block++;
+
+	return block;
+}
+
+static int
+lookup_diskset(unsigned long whole_offset, int *diskid,
+	       unsigned long *disk_offset)
+{
+	ulong offset = whole_offset;
+	int i;
+
+	for (i = 0; i < si->num_disks; ++i) {
+		struct sadump_diskset_info *sdi = &si->diskset_info[i];
+		ulong used_device_i, data_offset_i, ram_size;
+
+		used_device_i = sdi->sph_memory->used_device;
+		data_offset_i = sdi->data_offset;
+
+		ram_size = used_device_i - data_offset_i;
+
+		if (offset < ram_size)
+			break;
+		offset -= ram_size;
+	}
+
+	if (i == si->num_disks)
+		return FALSE;
+
+	*diskid = i;
+	*disk_offset = offset;
+
+	return TRUE;
+}
+
+int
 sadump_add_diskset_info(char *name_memory)
 {
 	si->num_disks++;
diff --git a/sadump_info.h b/sadump_info.h
index 0a04141..b6b9cdd 100644
--- a/sadump_info.h
+++ b/sadump_info.h
@@ -25,10 +25,12 @@
 #if defined(__x86__) || defined(__x86_64__)
 
 int check_and_get_sadump_header_info(char *filename);
+int sadump_copy_1st_bitmap_from_memory(void);
 int sadump_initialize_bitmap_memory(void);
 int sadump_get_nr_cpus(int *nr_cpus);
 int sadump_set_timestamp(struct timeval *ts);
 unsigned long long sadump_get_max_mapnr(void);
+int readpmem_sadump(unsigned long long paddr, void *bufptr, size_t size);
 int sadump_add_diskset_info(char *name_memory);
 long sadump_page_size(void);
 char *sadump_head_disk_name_memory(void);
@@ -51,6 +53,11 @@ static inline int check_and_get_sadump_header_info(char *filename)
 	return TRUE;
 }
 
+static inline int sadump_copy_1st_bitmap_from_memory(void)
+{
+	return FALSE;
+}
+
 static inline int sadump_initialize_bitmap_memory(void)
 {
 	return FALSE;
@@ -71,6 +78,12 @@ static inline unsigned long long sadump_get_max_mapnr(void)
 	return 0;
 }
 
+static inline int readpmem_sadump(unsigned long long paddr,
+				  void *bufptr, size_t size)
+{
+	return FALSE;
+}
+
 static inline int sadump_add_diskset_info(char *name_memory)
 {
 	return TRUE;
-- 
1.7.4.4



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
