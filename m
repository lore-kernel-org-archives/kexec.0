Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XWiz5-0004Wk-2A
 for kexec@lists.infradead.org; Wed, 24 Sep 2014 09:35:39 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s8O9ZGqW025352
 for <kexec@lists.infradead.org>; Wed, 24 Sep 2014 17:35:16 +0800
From: Wang Xiao <wangx.fnst@cn.fujitsu.com>
Subject: [PATCH resend v2 1/3] makedumpfile: make
 get_elf64_phdr()/get_elf32_phdr() public
Date: Wed, 24 Sep 2014 17:35:02 +0800
Message-ID: <1411551304-5776-1-git-send-email-wangx.fnst@cn.fujitsu.com>
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

Move the following two functions from internal function to external
function.

get_elf64_phdr(int fd, char *filename, int index, Elf64_Phdr *phdr)
get_elf32_phdr(int fd, char *filename, int index, Elf32_Phdr *phdr)

Signed-of-by: Wang Xiao <wangx.fnst@cn.fujitsu.com>
---
 elf_info.c | 71 +++++++++++++++++++++++++++++++-------------------------------
 elf_info.h |  2 ++
 2 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/elf_info.c b/elf_info.c
index 5be1990..24936d4 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -95,42 +95,6 @@ static unsigned long		size_xen_crash_info;
  * Internal functions.
  */
 static int
-get_elf64_phdr(int fd, char *filename, int index, Elf64_Phdr *phdr)
-{
-	off_t offset;
-
-	offset = sizeof(Elf64_Ehdr) + sizeof(Elf64_Phdr) * index;
-
-	if (lseek(fd, offset, SEEK_SET) < 0) {
-		ERRMSG("Can't seek %s. %s\n", filename, strerror(errno));
-		return FALSE;
-	}
-	if (read(fd, phdr, sizeof(Elf64_Phdr)) != sizeof(Elf64_Phdr)) {
-		ERRMSG("Can't read %s. %s\n", filename, strerror(errno));
-		return FALSE;
-	}
-	return TRUE;
-}
-
-static int
-get_elf32_phdr(int fd, char *filename, int index, Elf32_Phdr *phdr)
-{
-	off_t offset;
-
-	offset = sizeof(Elf32_Ehdr) + sizeof(Elf32_Phdr) * index;
-
-	if (lseek(fd, offset, SEEK_SET) < 0) {
-		ERRMSG("Can't seek %s. %s\n", filename, strerror(errno));
-		return FALSE;
-	}
-	if (read(fd, phdr, sizeof(Elf32_Phdr)) != sizeof(Elf32_Phdr)) {
-		ERRMSG("Can't read %s. %s\n", filename, strerror(errno));
-		return FALSE;
-	}
-	return TRUE;
-}
-
-static int
 check_elf_format(int fd, char *filename, int *phnum, unsigned int *num_load)
 {
 	int i;
@@ -446,6 +410,41 @@ int set_kcore_vmcoreinfo(uint64_t vmcoreinfo_addr, uint64_t vmcoreinfo_len)
 /*
  * External functions.
  */
+int
+get_elf64_phdr(int fd, char *filename, int index, Elf64_Phdr *phdr)
+{
+	off_t offset;
+
+	offset = sizeof(Elf64_Ehdr) + sizeof(Elf64_Phdr) * index;
+
+	if (lseek(fd, offset, SEEK_SET) < 0) {
+		ERRMSG("Can't seek %s. %s\n", filename, strerror(errno));
+		return FALSE;
+	}
+	if (read(fd, phdr, sizeof(Elf64_Phdr)) != sizeof(Elf64_Phdr)) {
+		ERRMSG("Can't read %s. %s\n", filename, strerror(errno));
+		return FALSE;
+	}
+	return TRUE;
+}
+
+int
+get_elf32_phdr(int fd, char *filename, int index, Elf32_Phdr *phdr)
+{
+	off_t offset;
+
+	offset = sizeof(Elf32_Ehdr) + sizeof(Elf32_Phdr) * index;
+
+	if (lseek(fd, offset, SEEK_SET) < 0) {
+		ERRMSG("Can't seek %s. %s\n", filename, strerror(errno));
+		return FALSE;
+	}
+	if (read(fd, phdr, sizeof(Elf32_Phdr)) != sizeof(Elf32_Phdr)) {
+		ERRMSG("Can't read %s. %s\n", filename, strerror(errno));
+		return FALSE;
+	}
+	return TRUE;
+}
 
 /*
  * Convert Physical Address to File Offset.
diff --git a/elf_info.h b/elf_info.h
index cbabf8a..e712253 100644
--- a/elf_info.h
+++ b/elf_info.h
@@ -27,6 +27,8 @@
 
 #define MAX_SIZE_NHDR	MAX(sizeof(Elf64_Nhdr), sizeof(Elf32_Nhdr))
 
+int get_elf64_phdr(int fd, char *filename, int index, Elf64_Phdr *phdr);
+int get_elf32_phdr(int fd, char *filename, int index, Elf32_Phdr *phdr);
 
 off_t paddr_to_offset(unsigned long long paddr);
 off_t paddr_to_offset2(unsigned long long paddr, off_t hint);
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
