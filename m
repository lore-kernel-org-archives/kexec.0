From: Philipp Rudo <prudo@redhat.com>
Date: Mon,  7 Mar 2022 18:23:22 +0100
Subject: [PATCH 3/3] makedumpfile: use cycle detection when parsing the prink
 log_buf
In-Reply-To: <20220307172322.7909-1-prudo@redhat.com>
References: <20220307172322.7909-1-prudo@redhat.com>
Message-ID: <20220307172322.7909-4-prudo@redhat.com>
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

Fixes: 36c2458 ("[PATCH] --dump-dmesg fix for post 3.5 kernels.")
Reported-by: Audra Mitchell <aubaker@redhat.com>
Suggested-by: Dave Wysochanski <dwysocha@redhat.com>
Signed-off-by: Philipp Rudo <prudo@redhat.com>
---
 makedumpfile.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index edf128b..2738d16 100644
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
-	char *idx;
+	char *idx, *next_idx;
 
 	/*
 	 * log_end has been changed to "unsigned" since linux-2.6.25.
@@ -5679,12 +5681,47 @@ dump_dmesg()
 			goto out;
 		}
 		idx = log_buffer + log_first_idx;
+		dc = dc_init(idx, log_buffer, log_next);
 		while (idx != log_buffer + log_next_idx) {
 			log_ptr = log_from_idx(idx, log_buffer);
 			if (!dump_log_entry(log_ptr, info->fd_dumpfile,
 					    info->name_dumpfile))
 				goto out;
-			idx = log_next(idx, log_buffer);
+			if (dc_next(dc, (void **) &next_idx)) {
+				unsigned long len;
+				char *first;
+
+				/* Clear everything we have already written... */
+				ftruncate(info->fd_dumpfile, 0);
+				lseek(info->fd_dumpfile, 0, SEEK_SET);
+
+				/* ...and only write up to the corruption. */
+				dc_find_start(dc, (void **) &first, &len);
+				idx = log_buffer + log_first_idx;
+				while (len) {
+					log_ptr = log_from_idx(idx, log_buffer);
+					if (!dump_log_entry(log_ptr,
+							    info->fd_dumpfile,
+							    info->name_dumpfile))
+						goto out;
+					idx = log_next(idx, log_buffer);
+					len--;
+				}
+				ERRMSG("Cycle when parsing dmesg detected.\n");
+				ERRMSG("The printk log_buf is most likely corrupted.\n");
+				ERRMSG("log_buf = 0x%lx, idx = 0x%lx\n", log_buf, idx - log_buffer);
+				close_files_for_creating_dumpfile();
+				goto out;
+			}
+			if (next_idx < log_buffer ||
+			    next_idx > log_buffer + log_buf_len - SIZE(printk_log)) {
+				ERRMSG("Index outside log_buf detected.\n");
+				ERRMSG("The printk log_buf is most likely corrupted.\n");
+				ERRMSG("log_buf = 0x%lx, idx = 0x%lx\n", log_buf, idx - log_buffer);
+				close_files_for_creating_dumpfile();
+				goto out;
+			}
+			idx = next_idx;
 		}
 		if (!close_files_for_creating_dumpfile())
 			goto out;
@@ -5694,6 +5731,7 @@ dump_dmesg()
 out:
 	if (log_buffer)
 		free(log_buffer);
+	free(dc);
 
 	return ret;
 }
-- 
2.35.1


