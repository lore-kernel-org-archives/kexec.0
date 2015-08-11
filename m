Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZOyZv-0003OT-Ri
 for kexec@lists.infradead.org; Tue, 11 Aug 2015 01:42:12 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t7B1cRc3001055
 for <kexec@lists.infradead.org>; Tue, 11 Aug 2015 09:38:27 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v5 04/10] Add read_pfn_parallel
Date: Tue, 11 Aug 2015 09:35:16 +0800
Message-ID: <1439256922-8781-5-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1439256922-8781-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1439256922-8781-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
Cc: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>

From: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>

read_pfn_parallel is used to enable reading pages from vmcore parallely.
Current supported format is kdump-compressed and elf, mmap elf format
is also supported.

Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
---
 Makefile       |  2 ++
 makedumpfile.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/Makefile b/Makefile
index fc21a3f..b1daf5b 100644
--- a/Makefile
+++ b/Makefile
@@ -67,6 +67,8 @@ LIBS := -lsnappy $(LIBS)
 CFLAGS += -DUSESNAPPY
 endif
 
+LIBS := -lpthread $(LIBS)
+
 all: makedumpfile
 
 $(OBJ_PART): $(SRC_PART)
diff --git a/makedumpfile.c b/makedumpfile.c
index 44c78b4..e15855b 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -6349,6 +6349,40 @@ read_pfn(mdf_pfn_t pfn, unsigned char *buf)
 }
 
 int
+read_pfn_parallel(int fd_memory, mdf_pfn_t pfn, unsigned char *buf,
+		  struct dump_bitmap* bitmap_memory_parallel,
+		  struct mmap_cache *mmap_cache)
+{
+	unsigned long long paddr;
+	unsigned long long pgaddr;
+
+	paddr = pfn_to_paddr(pfn);
+
+	pgaddr = PAGEBASE(paddr);
+
+	if (info->flag_refiltering) {
+		if (!readpage_kdump_compressed_parallel(fd_memory, pgaddr, buf,
+						      bitmap_memory_parallel)) {
+			ERRMSG("Can't get the page data.\n");
+			return FALSE;
+		}
+	} else {
+		char *mapbuf = mappage_elf_parallel(fd_memory, pgaddr,
+						    mmap_cache);
+		if (mapbuf) {
+			memcpy(buf, mapbuf, info->page_size);
+		} else {
+			if (!readpage_elf_parallel(fd_memory, pgaddr, buf)) {
+				ERRMSG("Can't get the page data.\n");
+				return FALSE;
+			}
+		}
+	}
+
+	return TRUE;
+}
+
+int
 get_loads_dumpfile_cyclic(void)
 {
 	int i, phnum, num_new_load = 0;
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
