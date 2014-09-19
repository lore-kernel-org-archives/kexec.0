Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XUuUL-0004Bq-HF
 for kexec@lists.infradead.org; Fri, 19 Sep 2014 09:28:26 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s8J9SADM023137
 for <kexec@lists.infradead.org>; Fri, 19 Sep 2014 17:28:10 +0800
Message-ID: <541BF725.6010506@cn.fujitsu.com>
Date: Fri, 19 Sep 2014 17:28:05 +0800
From: "Wang, Xiao/Wang Xiao" <wangx.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH 3/3] makedumpfile: implementation of dealing with
 kdump-compressed dumpfile with ENOSPC error
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

kdump-compressed:
Dump the bitmap before any page header and page data. This format use
"status" of "disk_dump_header" to indicate that it has been modified.

Signed-of-by: Wang Xiao <wangx.fnst@cn.fujitsu.com>
---
  diskdump_mod.h |    2 +
  makedumpfile.c |   85 
++++++++++++++++++++++++++++++++++++++++++++++++++++---
  2 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/diskdump_mod.h b/diskdump_mod.h
index dd24eb2..a0d3439 100644
--- a/diskdump_mod.h
+++ b/diskdump_mod.h
@@ -96,6 +96,8 @@ struct kdump_sub_header {
  #define DUMP_DH_COMPRESSED_SNAPPY	0x4
  					/* paged is compressed with snappy */

+#define DUMP_DH_COMPRESSED_INCOMPLETE	0x8 /* this is an incomplete 
dumpfile*/
+
  /* descriptor of each page for vmcore */
  typedef struct page_desc {
  	off_t			offset;		/* the offset of the page data*/
diff --git a/makedumpfile.c b/makedumpfile.c
index 13f0f35..84b26bb 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3771,6 +3771,71 @@ out_close_file:
  }

  int
+check_and_modify_kdump_headers(char *filename) {
+	int fd, ret = FALSE;
+	struct disk_dump_header dh;
+
+	if (!read_disk_dump_header(&dh, filename))
+		return FALSE;
+
+	if ((fd = open(filename, O_RDWR)) < 0) {
+		ERRMSG("Can't open the dump file(%s). %s\n",
+				filename, strerror(errno));
+		return FALSE;
+	}
+
+	/*
+	 * Set the incomplete flag to the status of disk_dump_header.
+	 */
+	dh.status |= DUMP_DH_COMPRESSED_INCOMPLETE;
+
+	/*
+	 * It's safe to overwrite the disk_dump_header.
+	 */
+	if (!write_buffer(fd, 0, &dh, sizeof(struct disk_dump_header), filename))
+		goto out_close_file;
+
+	ret = TRUE;
+out_close_file:
+	if (close(fd) < 0) {
+		ERRMSG("Can't close the dump file(%s). %s\n",
+				filename, strerror(errno));
+	}
+
+	return ret;
+}
+
+int
+check_and_modify_multiple_kdump_headers() {
+	int i, status, ret = TRUE;
+	pid_t pid;
+	pid_t array_pid[info->num_dumpfile];
+
+	for (i = 0; i < info->num_dumpfile; i++) {
+		if ((pid = fork()) < 0) {
+			return FALSE;
+
+		} else if (pid == 0) { /* Child */
+			if (!check_and_modify_kdump_headers(SPLITTING_DUMPFILE(i)))
+				exit(1);
+			exit(0);
+		}
+		array_pid[i] = pid;
+	}
+
+	for (i = 0; i < info->num_dumpfile; i++) {
+		waitpid(array_pid[i], &status, WUNTRACED);
+		if (!WIFEXITED(status) || WEXITSTATUS(status) == 1) {
+			ERRMSG("Check and modify the incomplete dumpfile(%s) failed.\n",
+			       SPLITTING_DUMPFILE(i));
+			ret = FALSE;
+		}
+	}
+
+	return ret;
+}
+
+int
  write_cache_bufsz(struct cache_data *cd)
  {
  	if (!cd->buf_size)
@@ -7113,11 +7178,11 @@ write_kdump_pages_and_bitmap_cyclic(struct 
cache_data *cd_header, struct cache_d
  		if (!exclude_unnecessary_pages_cyclic(&cycle))
  			return FALSE;

-		if (!write_kdump_pages_cyclic(cd_header, cd_page, &pd_zero,
-					&offset_data, &cycle))
+		if (!write_kdump_bitmap2_cyclic(&cycle))
  			return FALSE;

-		if (!write_kdump_bitmap2_cyclic(&cycle))
+		if (!write_kdump_pages_cyclic(cd_header, cd_page, &pd_zero,
+					&offset_data, &cycle))
  			return FALSE;
  	}

@@ -8080,12 +8145,12 @@ writeout_dumpfile(void)
  	} else {
  		if (!write_kdump_header())
  			goto out;
+		if (!write_kdump_bitmap())
+			goto out;
  		if (!write_kdump_pages(&cd_header, &cd_page))
  			goto out;
  		if (!write_kdump_eraseinfo(&cd_page))
  			goto out;
-		if (!write_kdump_bitmap())
-			goto out;
  	}
  	if (info->flag_flatten) {
  		if (!write_end_flat_header())
@@ -8296,6 +8361,16 @@ retry:
  					if (check_and_modify_elf_headers(info->name_dumpfile))
  						MSG("This is an incomplete dumpfile,"
  						    " but might analyzable.\n");
+				} else {
+					if (info->flag_split) {
+						if (check_and_modify_multiple_kdump_headers())
+							MSG("The splited dumpfiles are incomplete,"
+							    " but might analyzable.\n");
+					} else {
+						if (check_and_modify_kdump_headers(info->name_dumpfile))
+							MSG("This is an incomplete dumpfile,"
+							    " but might analyzable.\n");
+					}
  				}
  			}

-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
