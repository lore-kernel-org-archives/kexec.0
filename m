Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fnGv5-0000yM-Uk
 for kexec@lists.infradead.org; Wed, 08 Aug 2018 05:22:05 +0000
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCHv3] makedumpfile: when using refiltering,
 initialize refiltered bitmap2 from the kdump file's bitmap2
Date: Wed,  8 Aug 2018 13:21:44 +0800
Message-Id: <1533705704-13805-1-git-send-email-piliu@redhat.com>
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
bitmap2 from the kdump file's bitmap2. As for the statics of pfn_hole, it
should be calculated and discount the bits in kdump file's bitmap1.

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
v2 -> v3: fix the statics of pfn_hole
 makedumpfile.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 915cbf4..edb7687 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5516,6 +5516,26 @@ out:
 			  "follow free lists instead of mem_map array.\n");
 }
 
+static mdf_pfn_t count_bits(char *buf, int sz)
+{
+	char *p = buf;
+	int i, j;
+	mdf_pfn_t cnt = 0;
+	for (i = 0; i < sz; i++, p++) {
+		if (*p == 0)
+			continue;
+		else if (*p == 0xff) {
+			cnt += 8;
+			continue;
+		}
+		for (j = 0; j < 8; j++) {
+			if (*p & 1<<j)
+				cnt++;
+		}
+	}
+	return cnt;
+}
+
 /*
  * If using a dumpfile in kdump-compressed format as a source file
  * instead of /proc/vmcore, 1st-bitmap of a new dumpfile must be
@@ -5549,6 +5569,7 @@ copy_1st_bitmap_from_memory(void)
 					info->name_memory, strerror(errno));
 			return FALSE;
 		}
+		pfn_memhole -= count_bits(buf, sizeof(buf));
 		if (write(info->bitmap1->fd, buf, sizeof(buf)) != sizeof(buf)) {
 			ERRMSG("Can't write the bitmap(%s). %s\n",
 			    info->bitmap1->file_name, strerror(errno));
@@ -6093,19 +6114,27 @@ copy_bitmap_buffer(void)
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
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
