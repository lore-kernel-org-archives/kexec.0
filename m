Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZOyZc-0003Ng-TQ
 for kexec@lists.infradead.org; Tue, 11 Aug 2015 01:41:54 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t7B1cQbP001052
 for <kexec@lists.infradead.org>; Tue, 11 Aug 2015 09:38:26 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v5 03/10] Add readpage_elf_parallel
Date: Tue, 11 Aug 2015 09:35:15 +0800
Message-ID: <1439256922-8781-4-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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

readpage_elf_parallel is used to enable reading pages from elf format
parallelly. fd_memory should be initialize and offered  to each threads
individually to avoid conflict.

Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
---
 makedumpfile.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index d1b4bc2..44c78b4 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -575,6 +575,27 @@ read_from_vmcore(off_t offset, void *bufptr, unsigned long size)
 	return TRUE;
 }
 
+static int
+read_from_vmcore_parallel(int fd_memory, off_t offset, void *bufptr,
+			  unsigned long size)
+{
+	const off_t failed = (off_t)-1;
+
+	if (lseek(fd_memory, offset, SEEK_SET) == failed) {
+		ERRMSG("Can't seek the dump memory(%s). (offset: %llx) %s\n",
+		       info->name_memory, (unsigned long long)offset, strerror(errno));
+		return FALSE;
+	}
+
+	if (read(fd_memory, bufptr, size) != size) {
+		ERRMSG("Can't read the dump memory(%s). %s\n",
+		       info->name_memory, strerror(errno));
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
 /*
  * This function is specific for reading page from ELF.
  *
@@ -669,6 +690,83 @@ readpage_elf(unsigned long long paddr, void *bufptr)
 }
 
 static int
+readpage_elf_parallel(int fd_memory, unsigned long long paddr, void *bufptr)
+{
+	off_t offset1, offset2;
+	size_t size1, size2;
+	unsigned long long phys_start, phys_end, frac_head = 0;
+
+	offset1 = paddr_to_offset(paddr);
+	offset2 = paddr_to_offset(paddr + info->page_size);
+	phys_start = paddr;
+	phys_end = paddr + info->page_size;
+
+	/*
+	 * Check the case phys_start isn't aligned by page size like below:
+	 *
+	 *                           phys_start
+	 *                           = 0x40ffda7000
+	 *         |<-- frac_head -->|------------- PT_LOAD -------------
+	 *     ----+-----------------------+---------------------+----
+	 *         |         pfn:N         |       pfn:N+1       | ...
+	 *     ----+-----------------------+---------------------+----
+	 *         |
+	 *     pfn_to_paddr(pfn:N)               # page size = 16k
+	 *     = 0x40ffda4000
+	 */
+	if (!offset1) {
+		phys_start = page_head_to_phys_start(paddr);
+		offset1 = paddr_to_offset(phys_start);
+		frac_head = phys_start - paddr;
+		memset(bufptr, 0, frac_head);
+	}
+
+	/*
+	 * Check the case phys_end isn't aligned by page size like the
+	 * phys_start's case.
+	 */
+	if (!offset2) {
+		phys_end = page_head_to_phys_end(paddr);
+		offset2 = paddr_to_offset(phys_end);
+		memset(bufptr + (phys_end - paddr), 0, info->page_size
+							- (phys_end - paddr));
+	}
+
+	/*
+	 * Check the separated page on different PT_LOAD segments.
+	 */
+	if (offset1 + (phys_end - phys_start) == offset2) {
+		size1 = phys_end - phys_start;
+	} else {
+		for (size1 = 1; size1 < info->page_size - frac_head; size1++) {
+			offset2 = paddr_to_offset(phys_start + size1);
+			if (offset1 + size1 != offset2)
+				break;
+		}
+	}
+
+	if(!read_from_vmcore_parallel(fd_memory, offset1, bufptr + frac_head,
+								size1)) {
+		ERRMSG("Can't read the dump memory(%s).\n",
+		       info->name_memory);
+		return FALSE;
+	}
+
+	if (size1 + frac_head != info->page_size) {
+		size2 = phys_end - (phys_start + size1);
+
+		if(!read_from_vmcore_parallel(fd_memory, offset2,
+					bufptr + frac_head + size1, size2)) {
+			ERRMSG("Can't read the dump memory(%s).\n",
+			       info->name_memory);
+			return FALSE;
+		}
+	}
+
+	return TRUE;
+}
+
+static int
 readpage_kdump_compressed(unsigned long long paddr, void *bufptr)
 {
 	page_desc_t pd;
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
