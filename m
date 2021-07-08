Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-dm6nam11on2065.outbound.protection.outlook.com
 ([40.107.223.65] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1O8M-00GAwr-TK
 for kexec@lists.infradead.org; Thu, 08 Jul 2021 07:07:45 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
Subject: [PATCH v2 makedumpfile 2/3] Dump dmesg using write_and_check_space()
Date: Thu, 8 Jul 2021 16:06:10 +0900
Message-ID: <20210708070611.291260-3-bpoirier@nvidia.com>
In-Reply-To: <20210708070611.291260-1-bpoirier@nvidia.com>
References: <20210708070611.291260-1-bpoirier@nvidia.com>
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

Detect incomplete writes which may happen due to insufficient space on the
output filesystem.

Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 makedumpfile.c | 36 ++++++++++++++++++++----------------
 makedumpfile.h |  3 ++-
 printk.c       | 24 +++++++++++++++---------
 3 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index aa05be7..9175a6a 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4713,7 +4713,8 @@ is_bigendian(void)
 }
 
 int
-write_and_check_space(int fd, void *buf, size_t buf_size, char *file_name)
+write_and_check_space(int fd, void *buf, size_t buf_size, const char* desc,
+		      const char *file_name)
 {
 	int status, written_size = 0;
 
@@ -4731,8 +4732,8 @@ write_and_check_space(int fd, void *buf, size_t buf_size, char *file_name)
 		}
 		if (errno == ENOSPC)
 			info->flag_nospace = TRUE;
-		MSG("\nCan't write the dump file(%s). %s\n",
-		    file_name, strerror(errno));
+		MSG("\nCan't write the %s file(%s). %s\n", desc, file_name,
+		    strerror(errno));
 		return FALSE;
 	}
 	return TRUE;
@@ -4757,7 +4758,8 @@ write_buffer(int fd, off_t offset, void *buf, size_t buf_size, char *file_name)
 			fdh.offset   = bswap_64(offset);
 			fdh.buf_size = bswap_64(buf_size);
 		}
-		if (!write_and_check_space(fd, &fdh, sizeof(fdh), file_name))
+		if (!write_and_check_space(fd, &fdh, sizeof(fdh), "dump",
+					   file_name))
 			return FALSE;
 	} else if (!info->flag_dry_run &&
 		    lseek(fd, offset, SEEK_SET) == failed) {
@@ -4765,7 +4767,7 @@ write_buffer(int fd, off_t offset, void *buf, size_t buf_size, char *file_name)
 		return FALSE;
 	}
 
-	if (!write_and_check_space(fd, buf, buf_size, file_name))
+	if (!write_and_check_space(fd, buf, buf_size, "dump", file_name))
 		return FALSE;
 
 	return TRUE;
@@ -5281,7 +5283,7 @@ reset_bitmap_of_free_pages(unsigned long node_zones, struct cycle *cycle)
 }
 
 static int
-dump_log_entry(char *logptr, int fp)
+dump_log_entry(char *logptr, int fp, const char *file_name)
 {
 	char *msg, *p, *bufp;
 	unsigned int i, text_len, indent_len, buf_need;
@@ -5307,7 +5309,8 @@ dump_log_entry(char *logptr, int fp)
 
 	for (i = 0, p = msg; i < text_len; i++, p++) {
 		if (bufp - buf >= sizeof(buf) - buf_need) {
-			if (write(info->fd_dumpfile, buf, bufp - buf) < 0)
+			if (!write_and_check_space(fp, buf, bufp - buf, "log",
+						   file_name))
 				return FALSE;
 			bufp = buf;
 		}
@@ -5322,10 +5325,7 @@ dump_log_entry(char *logptr, int fp)
 
 	*bufp++ = '\n';
 
-	if (write(info->fd_dumpfile, buf, bufp - buf) < 0)
-		return FALSE;
-	else
-		return TRUE;
+	return write_and_check_space(fp, buf, bufp - buf, "log", file_name);
 }
 
 /*
@@ -5507,7 +5507,9 @@ dump_dmesg()
 			ERRMSG("Can't open output file.\n");
 			goto out;
 		}
-		if (write(info->fd_dumpfile, log_buffer, length_log) < 0)
+		if (!write_and_check_space(info->fd_dumpfile, log_buffer,
+					   length_log, "log",
+					   info->name_dumpfile))
 			goto out;
 
 		if (!close_files_for_creating_dumpfile())
@@ -5532,7 +5534,8 @@ dump_dmesg()
 		idx = log_first_idx;
 		while (idx != log_next_idx) {
 			log_ptr = log_from_idx(idx, log_buffer);
-			if (!dump_log_entry(log_ptr, info->fd_dumpfile))
+			if (!dump_log_entry(log_ptr, info->fd_dumpfile,
+					    info->name_dumpfile))
 				goto out;
 			idx = log_next(idx, log_buffer);
 		}
@@ -6947,8 +6950,9 @@ write_start_flat_header()
 	memset(buf, 0, sizeof(buf));
 	memcpy(buf, &fh, sizeof(fh));
 
-	if (!write_and_check_space(info->fd_dumpfile, buf, MAX_SIZE_MDF_HEADER,
-	    info->name_dumpfile))
+	if (!write_and_check_space(info->fd_dumpfile, buf,
+				   MAX_SIZE_MDF_HEADER, "dump",
+				   info->name_dumpfile))
 		return FALSE;
 
 	return TRUE;
@@ -6966,7 +6970,7 @@ write_end_flat_header(void)
 	fdh.buf_size = END_FLAG_FLAT_HEADER;
 
 	if (!write_and_check_space(info->fd_dumpfile, &fdh, sizeof(fdh),
-	    info->name_dumpfile))
+				   "dump", info->name_dumpfile))
 		return FALSE;
 
 	return TRUE;
diff --git a/makedumpfile.h b/makedumpfile.h
index 79046f2..fb23efd 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -2510,7 +2510,8 @@ ulong htol(char *s, int flags);
 int hexadecimal(char *s, int count);
 int decimal(char *s, int count);
 int file_exists(char *file);
-
+int write_and_check_space(int fd, void *buf, size_t buf_size,
+			  const char* desc, const char *file_name);
 int open_dump_file(void);
 int dump_lockless_dmesg(void);
 
diff --git a/printk.c b/printk.c
index 2af8562..e8501c7 100644
--- a/printk.c
+++ b/printk.c
@@ -53,7 +53,7 @@ static enum desc_state get_desc_state(unsigned long id,
 	return DESC_STATE(state_val);
 }
 
-static void
+static int
 dump_record(struct prb_map *m, unsigned long id)
 {
 	unsigned long long ts_nsec;
@@ -80,7 +80,7 @@ dump_record(struct prb_map *m, unsigned long id)
 	state_var = ULONG(desc + OFFSET(prb_desc.state_var) + OFFSET(atomic_long_t.counter));
 	state = get_desc_state(id, state_var);
 	if (state != desc_committed && state != desc_finalized)
-		return;
+		return TRUE;
 
 	begin = ULONG(desc + OFFSET(prb_desc.text_blk_lpos) + OFFSET(prb_data_blk_lpos.begin)) %
 			m->text_data_ring_size;
@@ -89,7 +89,7 @@ dump_record(struct prb_map *m, unsigned long id)
 
 	/* skip data-less text blocks */
 	if (begin == next)
-		return;
+		return TRUE;
 
 	inf = m->infos + ((id % m->desc_ring_count) * SIZE(printk_info));
 
@@ -121,8 +121,10 @@ dump_record(struct prb_map *m, unsigned long id)
 
 	for (i = 0, p = text; i < text_len; i++, p++) {
 		if (bufp - buf >= sizeof(buf) - buf_need) {
-			if (write(info->fd_dumpfile, buf, bufp - buf) < 0)
-				return;
+			if (!write_and_check_space(info->fd_dumpfile, buf,
+						   bufp - buf, "log",
+						   info->name_dumpfile))
+				return FALSE;
 			bufp = buf;
 		}
 
@@ -136,7 +138,8 @@ dump_record(struct prb_map *m, unsigned long id)
 
 	*bufp++ = '\n';
 
-	write(info->fd_dumpfile, buf, bufp - buf);
+	return write_and_check_space(info->fd_dumpfile, buf, bufp - buf,
+				     "log", info->name_dumpfile);
 }
 
 int
@@ -219,11 +222,14 @@ dump_lockless_dmesg(void)
 		goto out_text_data;
 	}
 
-	for (id = tail_id; id != head_id; id = (id + 1) & DESC_ID_MASK)
-		dump_record(&m, id);
+	for (id = tail_id; id != head_id; id = (id + 1) & DESC_ID_MASK) {
+		if (!dump_record(&m, id))
+			goto out_text_data;
+	}
 
 	/* dump head record */
-	dump_record(&m, id);
+	if (!dump_record(&m, id))
+		goto out_text_data;
 
 	if (!close_files_for_creating_dumpfile())
 		goto out_text_data;
-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
