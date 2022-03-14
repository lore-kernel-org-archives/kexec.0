From: Philipp Rudo <prudo@redhat.com>
Date: Mon, 14 Mar 2022 17:04:31 +0100
Subject: [PATCH v2 3/4] makedumpfile: use cycle detection when parsing the
 prink log_buf
In-Reply-To: <20220314160432.9414-1-prudo@redhat.com>
References: <20220314160432.9414-1-prudo@redhat.com>
Message-ID: <20220314160432.9414-4-prudo@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

The old printk mechanism (> v3.5.0 and < v5.10.0) had a fixed size
buffer (log_buf) that contains all messages. The location for the next
message is stored in log_next_idx. In case the log_buf runs full
log_next_idx wraps around and starts overwriting old messages@the
beginning of the buffer. The wraparound is denoted by a message with
msg->len == 0.

Following the behavior described above blindly in makedumpfile is
dangerous as e.g. a memory corruption could overwrite (parts of) the
log_buf. If the corruption adds a message with msg->len == 0 this leads
to an endless loop when dumping the dmesg with makedumpfile appending
the messages up to the corruption over and over again to the output file
until file system is full. Fix this by using cycle detection and aboard
once one is detected.

While at it also verify that the index is within the log_buf and thus
guard against corruptions with msg->len != 0.

Reported-by: Audra Mitchell <aubaker@redhat.com>
Suggested-by: Dave Wysochanski <dwysocha@redhat.com>
Signed-off-by: Philipp Rudo <prudo@redhat.com>
---
 makedumpfile.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 9a05c96..b7ac999 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -15,6 +15,7 @@
  */
 #include "makedumpfile.h"
 #include "print_info.h"
+#include "detect_cycle.h"
 #include "dwarf_info.h"
 #include "elf_info.h"
 #include "erase_info.h"
@@ -5528,10 +5529,11 @@ dump_dmesg()
 	unsigned long index, log_buf, log_end;
 	unsigned int log_first_idx, log_next_idx;
 	unsigned long long first_idx_sym;
+	struct detect_cycle *dc = NULL;
 	unsigned long log_end_2_6_24;
 	unsigned      log_end_2_6_25;
 	char *log_buffer = NULL, *log_ptr = NULL;
-	char *ptr;
+	char *ptr, *next_ptr;
 
 	/*
 	 * log_end has been changed to "unsigned" since linux-2.6.25.
@@ -5679,12 +5681,55 @@ dump_dmesg()
 			goto out;
 		}
 		ptr = log_buffer + log_first_idx;
+		dc = dc_init(ptr, log_buffer, log_next);
 		while (ptr != log_buffer + log_next_idx) {
 			log_ptr = log_from_ptr(ptr, log_buffer);
 			if (!dump_log_entry(log_ptr, info->fd_dumpfile,
 					    info->name_dumpfile))
 				goto out;
 			ptr = log_next(ptr, log_buffer);
+			if (dc_next(dc, (void **) &next_ptr)) {
+				unsigned long len;
+				int in_cycle;
+				char *first;
+
+				/* Clear everything we have already written... */
+				ftruncate(info->fd_dumpfile, 0);
+				lseek(info->fd_dumpfile, 0, SEEK_SET);
+
+				/* ...and only write up to the corruption. */
+				dc_find_start(dc, (void **) &first, &len);
+				ptr = log_buffer + log_first_idx;
+				in_cycle = FALSE;
+				while (len) {
+					log_ptr = log_from_ptr(ptr, log_buffer);
+					if (!dump_log_entry(log_ptr,
+							    info->fd_dumpfile,
+							    info->name_dumpfile))
+						goto out;
+					ptr = log_next(ptr, log_buffer);
+
+					if (log_ptr == first)
+						in_cycle = TRUE;
+
+					if (in_cycle)
+						len--;
+				}
+				ERRMSG("Cycle when parsing dmesg detected.\n");
+				ERRMSG("The printk log_buf is most likely corrupted.\n");
+				ERRMSG("log_buf = 0x%lx, idx = 0x%lx\n", log_buf, ptr - log_buffer);
+				close_files_for_creating_dumpfile();
+				goto out;
+			}
+			if (next_ptr < log_buffer ||
+			    next_ptr > log_buffer + log_buf_len - SIZE(printk_log)) {
+				ERRMSG("Index outside log_buf detected.\n");
+				ERRMSG("The printk log_buf is most likely corrupted.\n");
+				ERRMSG("log_buf = 0x%lx, idx = 0x%lx\n", log_buf, ptr - log_buffer);
+				close_files_for_creating_dumpfile();
+				goto out;
+			}
+			ptr = next_ptr;
 		}
 		if (!close_files_for_creating_dumpfile())
 			goto out;
@@ -5694,6 +5739,7 @@ dump_dmesg()
 out:
 	if (log_buffer)
 		free(log_buffer);
+	free(dc);
 
 	return ret;
 }
-- 
2.35.1


