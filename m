Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 3/3] vmcore: Convert read_from_oldmem() to take an iov_iter
Date: Mon, 13 Dec 2021 00:06:36 +0000
Message-Id: <20211213000636.2932569-4-willy@infradead.org>
In-Reply-To: <20211213000636.2932569-1-willy@infradead.org>
References: <20211213000636.2932569-1-willy@infradead.org>
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
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@arm.com>, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org

Remove the read_from_oldmem() wrapper introduced earlier and convert
all the remaining callers to pass an iov_iter.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/x86/kernel/crash_dump_64.c |  7 +++++-
 fs/proc/vmcore.c                | 40 +++++++++++++--------------------
 include/linux/crash_dump.h      | 10 ++++-----
 3 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index 8d91e5f2e14d..991e09b80852 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -68,6 +68,11 @@ ssize_t copy_oldmem_page_encrypted(struct iov_iter *iter, unsigned long pfn,
 
 ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0,
+	struct kvec kvec = { .iov_base = buf, .iov_len = count };
+	struct iov_iter iter;
+
+	iov_iter_kvec(&iter, READ, &kvec, 1, count);
+
+	return read_from_oldmem(&iter, count, ppos,
 				cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT));
 }
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 443cbaf16ec8..986474f02a02 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -132,7 +132,7 @@ static int open_vmcore(struct inode *inode, struct file *file)
 }
 
 /* Reads a page from the oldmem device from given offset. */
-ssize_t read_from_oldmem_iter(struct iov_iter *iter, size_t count,
+ssize_t read_from_oldmem(struct iov_iter *iter, size_t count,
 			 u64 *ppos, bool encrypted)
 {
 	unsigned long pfn, offset;
@@ -180,27 +180,6 @@ ssize_t read_from_oldmem_iter(struct iov_iter *iter, size_t count,
 	return read;
 }
 
-ssize_t read_from_oldmem(char *buf, size_t count,
-			 u64 *ppos, int userbuf,
-			 bool encrypted)
-{
-	struct iov_iter iter;
-	struct iovec iov;
-	struct kvec kvec;
-
-	if (userbuf) {
-		iov.iov_base = (__force void __user *)buf;
-		iov.iov_len = count;
-		iov_iter_init(&iter, READ, &iov, 1, count);
-	} else {
-		kvec.iov_base = buf;
-		kvec.iov_len = count;
-		iov_iter_kvec(&iter, READ, &kvec, 1, count);
-	}
-
-	return read_from_oldmem_iter(&iter, count, ppos, encrypted);
-}
-
 /*
  * Architectures may override this function to allocate ELF header in 2nd kernel
  */
@@ -220,7 +199,12 @@ void __weak elfcorehdr_free(unsigned long long addr)
  */
 ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0, false);
+	struct kvec kvec = { .iov_base = buf, .iov_len = count };
+	struct iov_iter iter;
+
+	iov_iter_kvec(&iter, READ, &kvec, 1, count);
+
+	return read_from_oldmem(&iter, count, ppos, false);
 }
 
 /*
@@ -228,7 +212,13 @@ ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
  */
 ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0, cc_platform_has(CC_ATTR_MEM_ENCRYPT));
+	struct kvec kvec = { .iov_base = buf, .iov_len = count };
+	struct iov_iter iter;
+
+	iov_iter_kvec(&iter, READ, &kvec, 1, count);
+
+	return read_from_oldmem(&iter, count, ppos,
+			cc_platform_has(CC_ATTR_MEM_ENCRYPT));
 }
 
 /*
@@ -405,7 +395,7 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 					    m->offset + m->size - *fpos,
 					    iter->count);
 			start = m->paddr + *fpos - m->offset;
-			tmp = read_from_oldmem_iter(iter, tsz, &start,
+			tmp = read_from_oldmem(iter, tsz, &start,
 					cc_platform_has(CC_ATTR_MEM_ENCRYPT));
 			if (tmp < 0)
 				return tmp;
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index a1cf7d5c03c7..0f3a656293b0 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -134,13 +134,11 @@ static inline int vmcore_add_device_dump(struct vmcoredd_data *data)
 #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
 
 #ifdef CONFIG_PROC_VMCORE
-ssize_t read_from_oldmem(char *buf, size_t count,
-			 u64 *ppos, int userbuf,
-			 bool encrypted);
+ssize_t read_from_oldmem(struct iov_iter *iter, size_t count,
+			 u64 *ppos, bool encrypted);
 #else
-static inline ssize_t read_from_oldmem(char *buf, size_t count,
-				       u64 *ppos, int userbuf,
-				       bool encrypted)
+static inline ssize_t read_from_oldmem(struct iov_iter *iter, size_t count,
+				       u64 *ppos, bool encrypted)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.33.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
