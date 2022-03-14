From: Philipp Rudo <prudo@redhat.com>
Date: Mon, 14 Mar 2022 17:04:30 +0100
Subject: [PATCH v2 2/4] makedumpfile: use pointer arithmetics for dump_dmesg
In-Reply-To: <20220314160432.9414-1-prudo@redhat.com>
References: <20220314160432.9414-1-prudo@redhat.com>
Message-ID: <20220314160432.9414-3-prudo@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

When parsing the printk buffer for the old printk mechanism (> v3.5.0+ and
< 5.10.0) a log entry is currently specified by the offset into the
buffer where the entry starts. Change this to use a pointers instead.
This is done in preparation for using the new cycle detection mechanism.

Signed-off-by: Philipp Rudo <prudo@redhat.com>
---
 makedumpfile.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 7ed9756..9a05c96 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5482,13 +5482,10 @@ dump_log_entry(char *logptr, int fp, const char *file_name)
  * get log record by index; idx must point to valid message.
  */
 static char *
-log_from_idx(unsigned int idx, char *logbuf)
+log_from_ptr(char *logptr, char *logbuf)
 {
-	char *logptr;
 	unsigned int msglen;
 
-	logptr = logbuf + idx;
-
 	/*
 	 * A length == 0 record is the end of buffer marker.
 	 * Wrap around and return the message at the start of
@@ -5502,14 +5499,13 @@ log_from_idx(unsigned int idx, char *logbuf)
 	return logptr;
 }
 
-static long
-log_next(unsigned int idx, char *logbuf)
+static void *
+log_next(void *_logptr, void *_logbuf)
 {
-	char *logptr;
+	char *logptr = _logptr;
+	char *logbuf = _logbuf;
 	unsigned int msglen;
 
-	logptr = logbuf + idx;
-
 	/*
 	 * A length == 0 record is the end of buffer marker. Wrap around and
 	 * read the message at the start of the buffer as *this* one, and
@@ -5519,10 +5515,10 @@ log_next(unsigned int idx, char *logbuf)
 	msglen = USHORT(logptr + OFFSET(printk_log.len));
 	if (!msglen) {
 		msglen = USHORT(logbuf + OFFSET(printk_log.len));
-		return msglen;
+		return logbuf + msglen;
 	}
 
-	return idx + msglen;
+	return logptr + msglen;
 }
 
 int
@@ -5530,11 +5526,12 @@ dump_dmesg()
 {
 	int log_buf_len, length_log, length_oldlog, ret = FALSE;
 	unsigned long index, log_buf, log_end;
-	unsigned int idx, log_first_idx, log_next_idx;
+	unsigned int log_first_idx, log_next_idx;
 	unsigned long long first_idx_sym;
 	unsigned long log_end_2_6_24;
 	unsigned      log_end_2_6_25;
 	char *log_buffer = NULL, *log_ptr = NULL;
+	char *ptr;
 
 	/*
 	 * log_end has been changed to "unsigned" since linux-2.6.25.
@@ -5681,13 +5678,13 @@ dump_dmesg()
 			ERRMSG("Can't open output file.\n");
 			goto out;
 		}
-		idx = log_first_idx;
-		while (idx != log_next_idx) {
-			log_ptr = log_from_idx(idx, log_buffer);
+		ptr = log_buffer + log_first_idx;
+		while (ptr != log_buffer + log_next_idx) {
+			log_ptr = log_from_ptr(ptr, log_buffer);
 			if (!dump_log_entry(log_ptr, info->fd_dumpfile,
 					    info->name_dumpfile))
 				goto out;
-			idx = log_next(idx, log_buffer);
+			ptr = log_next(ptr, log_buffer);
 		}
 		if (!close_files_for_creating_dumpfile())
 			goto out;
-- 
2.35.1


