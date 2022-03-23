From: Philipp Rudo <prudo@redhat.com>
Date: Wed, 23 Mar 2022 16:35:36 +0100
Subject: [PATCH] util_lib/elf_info: harden parsing of printk buffer
Message-ID: <20220323153536.8527-1-prudo@redhat.com>
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

Following the behavior described above blindly is dangerous as e.g. a
memory corruption could overwrite (parts of) the log_buf. If the
corruption adds a message with msg->len == 0 this leads to an endless
loop when dumping the dmesg. Fix this by verifying that not wrapped
around before when it encounters a message with msg->len == 0.

While at it also verify that the index is within the log_buf and thus
guard against corruptions with msg->len != 0.

The same bug has been reported and fixed in makedumpfile [1].

[1] http://lists.infradead.org/pipermail/kexec/2022-March/024272.html

Signed-off-by: Philipp Rudo <prudo@redhat.com>
---
 util_lib/elf_info.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
index d252eff..ce71c60 100644
--- a/util_lib/elf_info.c
+++ b/util_lib/elf_info.c
@@ -763,8 +763,9 @@ static void dump_dmesg_structured(int fd, void (*handler)(char*, unsigned int))
 {
 #define OUT_BUF_SIZE	4096
 	uint64_t log_buf, log_buf_offset, ts_nsec;
-	uint32_t log_first_idx, log_next_idx, current_idx, len = 0, i;
+	uint32_t log_buf_len, log_first_idx, log_next_idx, current_idx, len = 0, i;
 	char *buf, out_buf[OUT_BUF_SIZE];
+	bool has_wrapped_around = false;
 	ssize_t ret;
 	char *msg;
 	uint16_t text_len;
@@ -811,6 +812,7 @@ static void dump_dmesg_structured(int fd, void (*handler)(char*, unsigned int))
 	}
 
 	log_buf = read_file_pointer(fd, vaddr_to_offset(log_buf_vaddr));
+	log_buf_len = read_file_s32(fd, vaddr_to_offset(log_buf_len_vaddr));
 
 	log_first_idx = read_file_u32(fd, vaddr_to_offset(log_first_idx_vaddr));
 	log_next_idx = read_file_u32(fd, vaddr_to_offset(log_next_idx_vaddr));
@@ -882,11 +884,31 @@ static void dump_dmesg_structured(int fd, void (*handler)(char*, unsigned int))
 		 * and read the message at the start of the buffer.
 		 */
 		loglen = struct_val_u16(buf, log_offset_len);
-		if (!loglen)
+		if (!loglen) {
+			if (has_wrapped_around) {
+				if (len && handler)
+					handler(out_buf, len);
+				fprintf(stderr, "Cycle when parsing dmesg detected.\n");
+				fprintf(stderr, "The prink log_buf is most likely corrupted.\n");
+				fprintf(stderr, "log_buf = 0x%lx, idx = 0x%x\n",
+					log_buf, current_idx);
+				exit(68);
+			}
 			current_idx = 0;
-		else
+			has_wrapped_around = true;
+		} else {
 			/* Move to next record */
 			current_idx += loglen;
+			if(current_idx > log_buf_len - log_sz) {
+				if (len && handler)
+					handler(out_buf, len);
+				fprintf(stderr, "Index outside log_buf detected.\n");
+				fprintf(stderr, "The prink log_buf is most likely corrupted.\n");
+				fprintf(stderr, "log_buf = 0x%lx, idx = 0x%x\n",
+					log_buf, current_idx);
+				exit(69);
+			}
+		}
 	}
 	free(buf);
 	if (len && handler)
-- 
2.35.1


