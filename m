Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fkQHU-0002S8-7h
 for kexec@lists.infradead.org; Tue, 31 Jul 2018 08:45:25 +0000
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCH] makedumpfile: when using refiltering,
 initialize bitmap1 from the kdump file's bitmap2
Date: Tue, 31 Jul 2018 16:44:55 +0800
Message-Id: <1533026695-14819-1-git-send-email-piliu@redhat.com>
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
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>

When refiltering on kdump format file, there is no info about pt_load[] for
exclude_nodata_pages(), and also we can not expect more data than the kdump
file can provide, hence this patch suggests to initialize the refiltered
bitmap1 from the kdump file's bitmap2.

Note about the bug reported by the following ops:
  makedumpfile -l --message-level 1 -d 31 /proc/vmcore /path/to/vmcore
  makedumpfile  --split  -d 31 ./vmcore dumpfile_{1,2,3} 2>&1
and hit the following error:
  Excluding unnecessary pages                       : [100.0 %] \
  readpage_kdump_compressed: pfn(9b) is excluded from /var/crash/127.0.0.1-2018-07-02-22:10:38/vmcore.
  readmem: type_addr: 1, addr:9b000, size:4096
  read_pfn: Can't get the page data.
  writeout_multiple_dumpfiles: Child process(2277) finished incompletely.(256)
  Copying data                                      : [ 24.6 %] -           eta: 2s
  makedumpfile Failed.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
---
 makedumpfile.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 101fa7c..af24359 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5544,6 +5544,7 @@ copy_1st_bitmap_from_memory(void)
 
 	bitmap_offset = (DISKDUMP_HEADER_BLOCKS + dh->sub_hdr_size)
 			 * dh->block_size;
+	bitmap_offset += info->len_bitmap / 2;
 
 	if (lseek(info->fd_memory, bitmap_offset, SEEK_SET) < 0) {
 		ERRMSG("Can't seek %s. %s\n",
@@ -5593,8 +5594,11 @@ create_1st_bitmap_file(void)
 	struct timespec ts_start;
 	off_t offset_page;
 
-	if (info->flag_refiltering)
+	if (info->flag_refiltering) {
+		/* no hole info in kdump file, set it as 0 for refiltering */
+		pfn_memhole = 0;
 		return copy_1st_bitmap_from_memory();
+	}
 
 	if (info->flag_sadump)
 		return sadump_copy_1st_bitmap_from_memory();
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
