Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dSnyr-00039h-MQ
 for kexec@lists.infradead.org; Wed, 05 Jul 2017 17:20:51 +0000
Received: by mail-pg0-x243.google.com with SMTP id j186so32936605pge.1
 for <kexec@lists.infradead.org>; Wed, 05 Jul 2017 10:20:29 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch v2] vmcore-dmesg: avoid allocating large memory chunk for log
 buf
Date: Wed,  5 Jul 2017 10:20:14 -0700
Message-Id: <1499275214-32096-1-git-send-email-xiyou.wangcong@gmail.com>
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
Cc: panand@redhat.com, Cong Wang <xiyou.wangcong@gmail.com>, Simon Horman <horms@verge.net.au>, dyoung@redhat.com

In kdump kernel, we got:

    Saving vmcore-dmesg.txt
    Failed to malloc 67108864 bytes for the logbuf: Cannot allocate memory

Apparently 64M is too luxury for a kdump kernel which only has 128M
in total.

We can avoid allocating such a large memory chunk, instead just allocate
a smaller chunk inside the loop each time.

Verify the result by comparing the vmcore-dmesg output with and without
this patch.

Cc: Simon Horman <horms@verge.net.au>
Reviewed-by: Dave Young <dyoung@redhat.com>
Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 vmcore-dmesg/vmcore-dmesg.c | 99 ++++++++++++++++++---------------------------
 1 file changed, 39 insertions(+), 60 deletions(-)

diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
index a8f56df..e340ef4 100644
--- a/vmcore-dmesg/vmcore-dmesg.c
+++ b/vmcore-dmesg/vmcore-dmesg.c
@@ -565,53 +565,12 @@ static inline uint64_t struct_val_u64(char *ptr, unsigned int offset)
 	return(file64_to_cpu(*(uint64_t *)(ptr + offset)));
 }
 
-/* human readable text of the record */
-static char *log_text(char *msg)
-{
-	return msg + log_sz;
-}
-
-/* get record by index; idx must point to valid msg */
-static char *log_from_idx(char *log_buf, uint32_t idx)
-{
-	char *msg = log_buf + idx;
-
-	/*
-	 * A length == 0 record is the end of buffer marker. Wrap around and
-	 * read the message at the start of the buffer.
-	 */
-	if (!struct_val_u16(msg, log_offset_len))
-		return log_buf;
-	return msg;
-}
-
-/* get next record; idx must point to valid msg */
-static uint32_t log_next(char *log_buf, uint32_t idx)
-{
-	char *msg = log_buf + idx;
-	uint16_t len;
-
-	/* length == 0 indicates the end of the buffer; wrap */
-	/*
-	 * A length == 0 record is the end of buffer marker. Wrap around and
-	 * read the message at the start of the buffer as *this* one, and
-	 * return the one after that.
-	 */
-	len = struct_val_u16(msg, log_offset_len);
-	if (!len) {
-		msg = log_buf;
-		return struct_val_u16(msg, log_offset_len);
-	}
-	return idx + len;
-}
-
 /* Read headers of log records and dump accordingly */
 static void dump_dmesg_structured(int fd)
 {
 #define OUT_BUF_SIZE	4096
 	uint64_t log_buf, log_buf_offset, ts_nsec;
 	uint32_t log_first_idx, log_next_idx, current_idx, len = 0, i;
-	int log_buf_len;
 	char *buf, out_buf[OUT_BUF_SIZE];
 	ssize_t ret;
 	char *msg;
@@ -659,34 +618,33 @@ static void dump_dmesg_structured(int fd)
 	}
 
 	log_buf = read_file_pointer(fd, vaddr_to_offset(log_buf_vaddr));
-	log_buf_len = read_file_s32(fd, vaddr_to_offset(log_buf_len_vaddr));
 
 	log_first_idx = read_file_u32(fd, vaddr_to_offset(log_first_idx_vaddr));
 	log_next_idx = read_file_u32(fd, vaddr_to_offset(log_next_idx_vaddr));
 
 	log_buf_offset = vaddr_to_offset(log_buf);
 
-	buf = calloc(1, log_buf_len);
+	buf = calloc(1, log_sz);
 	if (!buf) {
-		fprintf(stderr, "Failed to malloc %d bytes for the logbuf:"
-				" %s\n", log_buf_len, strerror(errno));
+		fprintf(stderr, "Failed to malloc %" PRId64 " bytes for the log:"
+				" %s\n", log_sz, strerror(errno));
 		exit(64);
 	}
 
-	ret = pread(fd, buf, log_buf_len, log_buf_offset);
-	if (ret != log_buf_len) {
-		fprintf(stderr, "Failed to read log buffer of size %d bytes:"
-			" %s\n", log_buf_len, strerror(errno));
-		exit(65);
-	}
-
 	/* Parse records and write out data at standard output */
 
 	current_idx = log_first_idx;
 	len = 0;
 	while (current_idx != log_next_idx) {
-		msg = log_from_idx(buf, current_idx);
-		ts_nsec = struct_val_u64(msg, log_offset_ts_nsec);
+		uint16_t loglen;
+
+		ret = pread(fd, buf, log_sz, log_buf_offset + current_idx);
+		if (ret != log_sz) {
+			fprintf(stderr, "Failed to read log of size %" PRId64 " bytes:"
+				" %s\n", log_sz, strerror(errno));
+			exit(65);
+		}
+		ts_nsec = struct_val_u64(buf, log_offset_ts_nsec);
 		imaxdiv_sec = imaxdiv(ts_nsec, 1000000000);
 		imaxdiv_usec = imaxdiv(imaxdiv_sec.rem, 1000);
 
@@ -695,9 +653,22 @@ static void dump_dmesg_structured(int fd)
 			(long long unsigned int)imaxdiv_usec.quot);
 
 		/* escape non-printable characters */
-		text_len = struct_val_u16(msg, log_offset_text_len);
+		text_len = struct_val_u16(buf, log_offset_text_len);
+		msg = calloc(1, text_len);
+		if (!msg) {
+			fprintf(stderr, "Failed to malloc %u bytes for log text:"
+				" %s\n", text_len, strerror(errno));
+			exit(64);
+		}
+
+		ret = pread(fd, msg, text_len, log_buf_offset + current_idx + log_sz);
+		if (ret != text_len) {
+			fprintf(stderr, "Failed to read log text of size %u bytes:"
+				" %s\n", text_len, strerror(errno));
+			exit(65);
+		}
 		for (i = 0; i < text_len; i++) {
-			unsigned char c = log_text(msg)[i];
+			unsigned char c = msg[i];
 
 			if (!isprint(c) && !isspace(c))
 				len += sprintf(out_buf + len, "\\x%02x", c);
@@ -711,11 +682,19 @@ static void dump_dmesg_structured(int fd)
 		}
 
 		out_buf[len++] = '\n';
-
-		/* Move to next record */
-		current_idx = log_next(buf, current_idx);
+		free(msg);
+		/*
+		 * A length == 0 record is the end of buffer marker. Wrap around
+		 * and read the message at the start of the buffer.
+		 */
+		loglen = struct_val_u16(buf, log_offset_len);
+		if (!loglen)
+			current_idx = log_first_idx;
+		else
+			/* Move to next record */
+			current_idx += loglen;
 	}
-
+	free(buf);
 	if (len)
 		write_to_stdout(out_buf, len);
 }
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
