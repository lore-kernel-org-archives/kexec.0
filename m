Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i18Km-0007rZ-Ez
 for kexec@lists.infradead.org; Fri, 23 Aug 2019 12:06:25 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 3/4 v2] Cleanup: move it back from util_lib/elf_info.c
Date: Fri, 23 Aug 2019 20:05:38 +0800
Message-Id: <20190823120539.18330-4-lijiang@redhat.com>
In-Reply-To: <20190823120539.18330-1-lijiang@redhat.com>
References: <20190823120539.18330-1-lijiang@redhat.com>
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
Cc: kasong@redhat.com, bhe@redhat.com, piliu@redhat.com, bhsharma@redhat.com, junw99@yahoo.com, horms@verge.net.au, dyoung@redhat.com

Some code related to vmcore-dmesg.c is put into the util_lib, which
is not very reasonable, so lets move it back and tidy up those code.

In addition, that will also help to limit the size of vmcore-dmesg.txt
in vmcore-dmesg.c instead of elf_info.c.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 util_lib/elf_info.c         | 48 +++++++++----------------------------
 util_lib/include/elf_info.h |  2 +-
 vmcore-dmesg/vmcore-dmesg.c | 30 ++++++++++++++++++++++-
 3 files changed, 41 insertions(+), 39 deletions(-)

diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
index 5d0efaafab53..2bce5cb1713c 100644
--- a/util_lib/elf_info.c
+++ b/util_lib/elf_info.c
@@ -531,19 +531,7 @@ static int32_t read_file_s32(int fd, uint64_t addr)
 	return read_file_u32(fd, addr);
 }
 
-static void write_to_stdout(char *buf, unsigned int nr)
-{
-	ssize_t ret;
-
-	ret = write(STDOUT_FILENO, buf, nr);
-	if (ret != nr) {
-		fprintf(stderr, "Failed to write out the dmesg log buffer!:"
-			" %s\n", strerror(errno));
-		exit(54);
-	}
-}
-
-static void dump_dmesg_legacy(int fd)
+static void dump_dmesg_legacy(int fd, void (*handler)(char*, unsigned int))
 {
 	uint64_t log_buf, log_buf_offset;
 	unsigned log_end, logged_chars, log_end_wrapped;
@@ -604,7 +592,8 @@ static void dump_dmesg_legacy(int fd)
 	 */
 	logged_chars = log_end < log_buf_len ? log_end : log_buf_len;
 
-	write_to_stdout(buf + (log_buf_len - logged_chars), logged_chars);
+	if (handler)
+		handler(buf + (log_buf_len - logged_chars), logged_chars);
 }
 
 static inline uint16_t struct_val_u16(char *ptr, unsigned int offset)
@@ -623,7 +612,7 @@ static inline uint64_t struct_val_u64(char *ptr, unsigned int offset)
 }
 
 /* Read headers of log records and dump accordingly */
-static void dump_dmesg_structured(int fd)
+static void dump_dmesg_structured(int fd, void (*handler)(char*, unsigned int))
 {
 #define OUT_BUF_SIZE	4096
 	uint64_t log_buf, log_buf_offset, ts_nsec;
@@ -733,7 +722,8 @@ static void dump_dmesg_structured(int fd)
 				out_buf[len++] = c;
 
 			if (len >= OUT_BUF_SIZE - 64) {
-				write_to_stdout(out_buf, len);
+				if (handler)
+					handler(out_buf, len);
 				len = 0;
 			}
 		}
@@ -752,16 +742,16 @@ static void dump_dmesg_structured(int fd)
 			current_idx += loglen;
 	}
 	free(buf);
-	if (len)
-		write_to_stdout(out_buf, len);
+	if (len && handler)
+		handler(out_buf, len);
 }
 
-static void dump_dmesg(int fd)
+void dump_dmesg(int fd, void (*handler)(char*, unsigned int))
 {
 	if (log_first_idx_vaddr)
-		dump_dmesg_structured(fd);
+		dump_dmesg_structured(fd, handler);
 	else
-		dump_dmesg_legacy(fd);
+		dump_dmesg_legacy(fd, handler);
 }
 
 int read_elf(int fd)
@@ -808,22 +798,6 @@ int read_elf(int fd)
 	return 0;
 }
 
-int read_elf_vmcore(int fd)
-{
-	int ret;
-
-	ret = read_elf(fd);
-	if (ret > 0) {
-		fprintf(stderr, "Unable to read ELF information"
-			" from vmcore\n");
-		return ret;
-	}
-
-	dump_dmesg(fd);
-
-	return 0;
-}
-
 int read_phys_offset_elf_kcore(int fd, unsigned long *phys_off)
 {
 	int ret;
diff --git a/util_lib/include/elf_info.h b/util_lib/include/elf_info.h
index c328a1b0ecf2..4bc9279ba603 100644
--- a/util_lib/include/elf_info.h
+++ b/util_lib/include/elf_info.h
@@ -30,6 +30,6 @@ int get_pt_load(int idx,
 	unsigned long long *virt_end);
 int read_phys_offset_elf_kcore(int fd, unsigned long *phys_off);
 int read_elf(int fd);
-int read_elf_vmcore(int fd);
+void dump_dmesg(int fd, void (*handler)(char*, unsigned int));
 
 #endif /* ELF_INFO_H */
diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
index bebc348a657e..fe7df8ec372c 100644
--- a/vmcore-dmesg/vmcore-dmesg.c
+++ b/vmcore-dmesg/vmcore-dmesg.c
@@ -5,6 +5,34 @@ typedef Elf32_Nhdr Elf_Nhdr;
 
 extern const char *fname;
 
+static void write_to_stdout(char *buf, unsigned int nr)
+{
+	ssize_t ret;
+
+	ret = write(STDOUT_FILENO, buf, nr);
+	if (ret != nr) {
+		fprintf(stderr, "Failed to write out the dmesg log buffer!:"
+			" %s\n", strerror(errno));
+		exit(54);
+	}
+}
+
+static int read_vmcore_dmesg(int fd, void (*handler)(char*, unsigned int))
+{
+	int ret;
+
+	ret = read_elf(fd);
+	if (ret > 0) {
+		fprintf(stderr, "Unable to read ELF information"
+			" from vmcore\n");
+		return ret;
+	}
+
+	dump_dmesg(fd, handler);
+
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	ssize_t ret;
@@ -23,7 +51,7 @@ int main(int argc, char **argv)
 		return 2;
 	}
 
-	ret = read_elf_vmcore(fd);
+	ret = read_vmcore_dmesg(fd, write_to_stdout);
 	
 	close(fd);
 
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
