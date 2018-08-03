Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1flQaF-0008U8-6U
 for kexec@lists.infradead.org; Fri, 03 Aug 2018 03:16:56 +0000
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCHv2] makedumpfile: when using refiltering,
 initialize refiltered bitmap2 from the kdump file's bitmap2
Date: Fri,  3 Aug 2018 11:16:38 +0800
Message-Id: <1533266198-14693-1-git-send-email-piliu@redhat.com>
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
To: kexec@lists.infradead.org
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Pingfan Liu <piliu@redhat.com>

When refiltering on kdump format file, there is no info about pt_load[] for
exclude_nodata_pages(), and also we can not expect more data than the kdump
file can provide, hence this patch suggests to initialize the refiltered
bitmap2 from the kdump file's bitmap2. As for the statics original_pfn, it
should also be calculated based on kdump file's bitmap2.

Note about the bug reported by the following ops:
  makedumpfile -l --message-level 1 -d 31 /proc/vmcore /path/to/vmcore
  makedumpfile  --split  -d 31 ./vmcore dumpfile_{1,2,3} 2>&1
And get the following error:
  Excluding unnecessary pages                       : [100.0 %] \
  readpage_kdump_compressed: pfn(9b) is excluded from /var/crash/127.0.0.1-2018-07-02-22:10:38/vmcore.
  readmem: type_addr: 1, addr:9b000, size:4096
  read_pfn: Can't get the page data.
  writeout_multiple_dumpfiles: Child process(2277) finished incompletely.(256)
  Copying data                                      : [ 24.6 %] -           eta: 2s
  makedumpfile Failed.

Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Signed-off-by: Pingfan Liu <piliu@redhat.com>
---
v1 -> v2
 initialized refiltered bitmap2 from file's bitmap2
 improve statics of original_pfn

 makedumpfile.c | 54 +++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 915cbf4..bf2f806 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -6090,26 +6090,59 @@ copy_bitmap_buffer(void)
 	return TRUE;
 }
 
+static mdf_pfn_t count_bits(unsigned char *buf, int sz)
+{
+	unsigned char *p = buf;
+	int i, j;
+	mdf_pfn_t cnt = 0;
+	for (i = 0; i < sz; i++, p++) {
+		if (*p == 0)
+			continue;
+		else if (*p == 0xff)
+			cnt += 8;
+		for (j = 0; j < 8; j++) {
+			if (*p & 1<<j)
+				cnt++;
+		}
+	}
+	return cnt;
+}
+
+static mdf_pfn_t orig_pfn = 0;
+
 int
 copy_bitmap_file(void)
 {
-	off_t offset;
+	off_t base, offset = 0;
 	unsigned char buf[info->page_size];
  	const off_t failed = (off_t)-1;
+	int fd;
+	struct disk_dump_header *dh = info->dh_memory;
 
-	offset = 0;
+	if (info->flag_refiltering) {
+		fd = info->fd_memory;
+		base = info->len_bitmap / 2;
+		base +=  (DISKDUMP_HEADER_BLOCKS + dh->sub_hdr_size) * dh->block_size;
+		orig_pfn = 0;
+	} else {
+		fd = info->bitmap1->fd;
+		base = info->bitmap1->offset;
+	}
 	while (offset < (info->len_bitmap / 2)) {
-		if (lseek(info->bitmap1->fd, info->bitmap1->offset + offset,
-		    SEEK_SET) == failed) {
+		if (lseek(fd,  base + offset, SEEK_SET) == failed) {
 			ERRMSG("Can't seek the bitmap(%s). %s\n",
 			    info->name_bitmap, strerror(errno));
 			return FALSE;
 		}
-		if (read(info->bitmap1->fd, buf, sizeof(buf)) != sizeof(buf)) {
+		if (read(fd, buf, sizeof(buf)) != sizeof(buf)) {
 			ERRMSG("Can't read the dump memory(%s). %s\n",
 			    info->name_memory, strerror(errno));
 			return FALSE;
 		}
+		/* counting the original pfn */
+		if (info->flag_refiltering) {
+			orig_pfn += count_bits(buf,  sizeof(buf));
+		}
 		if (lseek(info->bitmap2->fd, info->bitmap2->offset + offset,
 		    SEEK_SET) == failed) {
 			ERRMSG("Can't seek the bitmap(%s). %s\n",
@@ -9713,10 +9746,13 @@ print_report(void)
 {
 	mdf_pfn_t pfn_original, pfn_excluded, shrinking;
 
-	/*
-	 * /proc/vmcore doesn't contain the memory hole area.
-	 */
-	pfn_original = info->max_mapnr - pfn_memhole;
+	if (info->flag_refiltering)
+		pfn_original = orig_pfn;
+	else
+		/*
+		 * /proc/vmcore doesn't contain the memory hole area.
+		 */
+		pfn_original = info->max_mapnr - pfn_memhole;
 
 	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
 	    + pfn_user + pfn_free + pfn_hwpoison;
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
