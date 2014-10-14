Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XdqmZ-0002WF-5C
 for kexec@lists.infradead.org; Tue, 14 Oct 2014 01:20:12 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s9E1JjZZ025631
 for <kexec@lists.infradead.org>; Tue, 14 Oct 2014 09:19:45 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v3 3/3] implementation of dealing with kdump-compressed
 dumpfile with ENOSPC error
Date: Tue, 14 Oct 2014 09:17:19 +0800
Message-ID: <1413249439-12349-4-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1413249439-12349-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1413249439-12349-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
Cc: Wang Xiao <wangx.fnst@cn.fujitsu.com>

From: Wang Xiao <wangx.fnst@cn.fujitsu.com>

kdump-compressed:
Dump the bitmap before any page header and page data. This format use
"status" of "disk_dump_header" to indicate that it has been modified.

Signed-of-by: Wang Xiao <wangx.fnst@cn.fujitsu.com>
---
 diskdump_mod.h |    2 +
 makedumpfile.c |   80 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/diskdump_mod.h b/diskdump_mod.h
index dd24eb2..275ed83 100644
--- a/diskdump_mod.h
+++ b/diskdump_mod.h
@@ -95,6 +95,8 @@ struct kdump_sub_header {
 #define DUMP_DH_COMPRESSED_LZO	0x2	/* paged is compressed with lzo */
 #define DUMP_DH_COMPRESSED_SNAPPY	0x4
 					/* paged is compressed with snappy */
+#define DUMP_DH_COMPRESSED_INCOMPLETE	0x8
+					/* indicate an incomplete dumpfile */
 
 /* descriptor of each page for vmcore */
 typedef struct page_desc {
diff --git a/makedumpfile.c b/makedumpfile.c
index 141d290..4dba83e 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3847,10 +3847,80 @@ out_close_file:
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
+		       filename, strerror(errno));
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
+		       filename, strerror(errno));
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
 check_and_modify_headers()
 {
 	if (info->flag_elf_dumpfile)
 		return check_and_modify_elf_headers(info->name_dumpfile);
+	else
+		if(info->flag_split)
+			return check_and_modify_multiple_kdump_headers();
+		else
+			return check_and_modify_kdump_headers(info->name_dumpfile);
 	return FALSE;
 }
 
@@ -7123,11 +7193,11 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
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
 
@@ -8127,12 +8197,12 @@ writeout_dumpfile(void)
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
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
