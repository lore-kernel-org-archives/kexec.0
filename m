From: Baoquan He <bhe@redhat.com>
Date: Fri, 18 Mar 2022 17:37:06 +0800
Subject: [PATCH v4 4/4] fs/proc/vmcore: Use iov_iter_count()
In-Reply-To: <20220318093706.161534-1-bhe@redhat.com>
References: <20220318093706.161534-1-bhe@redhat.com>
Message-ID: <20220318093706.161534-5-bhe@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

To replace open coded iter->count. This makes code cleaner.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 fs/proc/vmcore.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 4cbb8db7c507..ed58a7edc821 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -319,21 +319,21 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 	u64 start;
 	struct vmcore *m = NULL;
 
-	if (iter->count == 0 || *fpos >= vmcore_size)
+	if (!iov_iter_count(iter) || *fpos >= vmcore_size)
 		return 0;
 
 	iov_iter_truncate(iter, vmcore_size - *fpos);
 
 	/* Read ELF core header */
 	if (*fpos < elfcorebuf_sz) {
-		tsz = min(elfcorebuf_sz - (size_t)*fpos, iter->count);
+		tsz = min(elfcorebuf_sz - (size_t)*fpos, iov_iter_count(iter));
 		if (copy_to_iter(elfcorebuf + *fpos, tsz, iter) < tsz)
 			return -EFAULT;
 		*fpos += tsz;
 		acc += tsz;
 
 		/* leave now if filled buffer already */
-		if (iter->count == 0)
+		if (!iov_iter_count(iter))
 			return acc;
 	}
 
@@ -354,7 +354,7 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 		/* Read device dumps */
 		if (*fpos < elfcorebuf_sz + vmcoredd_orig_sz) {
 			tsz = min(elfcorebuf_sz + vmcoredd_orig_sz -
-				  (size_t)*fpos, iter->count);
+				  (size_t)*fpos, iov_iter_count(iter));
 			start = *fpos - elfcorebuf_sz;
 			if (vmcoredd_copy_dumps(iter, start, tsz))
 				return -EFAULT;
@@ -363,13 +363,14 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 			acc += tsz;
 
 			/* leave now if filled buffer already */
-			if (!iter->count)
+			if (!iov_iter_count(iter))
 				return acc;
 		}
 #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
 
 		/* Read remaining elf notes */
-		tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)*fpos, iter->count);
+		tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)*fpos,
+			  iov_iter_count(iter));
 		kaddr = elfnotes_buf + *fpos - elfcorebuf_sz - vmcoredd_orig_sz;
 		if (copy_to_iter(kaddr, tsz, iter) < tsz)
 			return -EFAULT;
@@ -378,7 +379,7 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 		acc += tsz;
 
 		/* leave now if filled buffer already */
-		if (iter->count == 0)
+		if (!iov_iter_count(iter))
 			return acc;
 	}
 
@@ -386,7 +387,7 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 		if (*fpos < m->offset + m->size) {
 			tsz = (size_t)min_t(unsigned long long,
 					    m->offset + m->size - *fpos,
-					    iter->count);
+					    iov_iter_count(iter));
 			start = m->paddr + *fpos - m->offset;
 			tmp = read_from_oldmem(iter, tsz, &start,
 					cc_platform_has(CC_ATTR_MEM_ENCRYPT));
@@ -396,7 +397,7 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 			acc += tsz;
 
 			/* leave now if filled buffer already */
-			if (iter->count == 0)
+			if (!iov_iter_count(iter))
 				return acc;
 		}
 	}
-- 
2.34.1


