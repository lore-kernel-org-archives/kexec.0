From: Baoquan He <bhe@redhat.com>
Date: Fri, 18 Mar 2022 17:37:04 +0800
Subject: [PATCH v4 2/4] vmcore: Convert __read_vmcore to use an iov_iter
In-Reply-To: <20220318093706.161534-1-bhe@redhat.com>
References: <20220318093706.161534-1-bhe@redhat.com>
Message-ID: <20220318093706.161534-3-bhe@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This gets rid of copy_to() and let us use proc_read_iter() instead
of proc_read().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Baoquan He <bhe@redhat.com>
---
 fs/proc/vmcore.c | 81 +++++++++++++++++-------------------------------
 1 file changed, 29 insertions(+), 52 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 7e7252e162c2..cebf49160ea5 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -246,22 +246,8 @@ ssize_t __weak copy_oldmem_page_encrypted(struct iov_iter *iter,
 	return copy_oldmem_page(iter, pfn, csize, offset);
 }
 
-/*
- * Copy to either kernel or user space
- */
-static int copy_to(void *target, void *src, size_t size, int userbuf)
-{
-	if (userbuf) {
-		if (copy_to_user((char __user *) target, src, size))
-			return -EFAULT;
-	} else {
-		memcpy(target, src, size);
-	}
-	return 0;
-}
-
 #ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
-static int vmcoredd_copy_dumps(void *dst, u64 start, size_t size, int userbuf)
+static int vmcoredd_copy_dumps(struct iov_iter *iter, u64 start, size_t size)
 {
 	struct vmcoredd_node *dump;
 	u64 offset = 0;
@@ -274,14 +260,13 @@ static int vmcoredd_copy_dumps(void *dst, u64 start, size_t size, int userbuf)
 		if (start < offset + dump->size) {
 			tsz = min(offset + (u64)dump->size - start, (u64)size);
 			buf = dump->buf + start - offset;
-			if (copy_to(dst, buf, tsz, userbuf)) {
+			if (copy_to_iter(buf, tsz, iter) < tsz) {
 				ret = -EFAULT;
 				goto out_unlock;
 			}
 
 			size -= tsz;
 			start += tsz;
-			dst += tsz;
 
 			/* Leave now if buffer filled already */
 			if (!size)
@@ -337,33 +322,28 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
 /* Read from the ELF header and then the crash dump. On error, negative value is
  * returned otherwise number of bytes read are returned.
  */
-static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
-			     int userbuf)
+static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 {
 	ssize_t acc = 0, tmp;
 	size_t tsz;
 	u64 start;
 	struct vmcore *m = NULL;
 
-	if (buflen == 0 || *fpos >= vmcore_size)
+	if (iter->count == 0 || *fpos >= vmcore_size)
 		return 0;
 
-	/* trim buflen to not go beyond EOF */
-	if (buflen > vmcore_size - *fpos)
-		buflen = vmcore_size - *fpos;
+	iov_iter_truncate(iter, vmcore_size - *fpos);
 
 	/* Read ELF core header */
 	if (*fpos < elfcorebuf_sz) {
-		tsz = min(elfcorebuf_sz - (size_t)*fpos, buflen);
-		if (copy_to(buffer, elfcorebuf + *fpos, tsz, userbuf))
+		tsz = min(elfcorebuf_sz - (size_t)*fpos, iter->count);
+		if (copy_to_iter(elfcorebuf + *fpos, tsz, iter) < tsz)
 			return -EFAULT;
-		buflen -= tsz;
 		*fpos += tsz;
-		buffer += tsz;
 		acc += tsz;
 
 		/* leave now if filled buffer already */
-		if (buflen == 0)
+		if (iter->count == 0)
 			return acc;
 	}
 
@@ -384,35 +364,31 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 		/* Read device dumps */
 		if (*fpos < elfcorebuf_sz + vmcoredd_orig_sz) {
 			tsz = min(elfcorebuf_sz + vmcoredd_orig_sz -
-				  (size_t)*fpos, buflen);
+				  (size_t)*fpos, iter->count);
 			start = *fpos - elfcorebuf_sz;
-			if (vmcoredd_copy_dumps(buffer, start, tsz, userbuf))
+			if (vmcoredd_copy_dumps(iter, start, tsz))
 				return -EFAULT;
 
-			buflen -= tsz;
 			*fpos += tsz;
-			buffer += tsz;
 			acc += tsz;
 
 			/* leave now if filled buffer already */
-			if (!buflen)
+			if (!iter->count)
 				return acc;
 		}
 #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
 
 		/* Read remaining elf notes */
-		tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)*fpos, buflen);
+		tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)*fpos, iter->count);
 		kaddr = elfnotes_buf + *fpos - elfcorebuf_sz - vmcoredd_orig_sz;
-		if (copy_to(buffer, kaddr, tsz, userbuf))
+		if (copy_to_iter(kaddr, tsz, iter) < tsz)
 			return -EFAULT;
 
-		buflen -= tsz;
 		*fpos += tsz;
-		buffer += tsz;
 		acc += tsz;
 
 		/* leave now if filled buffer already */
-		if (buflen == 0)
+		if (iter->count == 0)
 			return acc;
 	}
 
@@ -420,19 +396,17 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 		if (*fpos < m->offset + m->size) {
 			tsz = (size_t)min_t(unsigned long long,
 					    m->offset + m->size - *fpos,
-					    buflen);
+					    iter->count);
 			start = m->paddr + *fpos - m->offset;
-			tmp = read_from_oldmem(buffer, tsz, &start,
-					       userbuf, cc_platform_has(CC_ATTR_MEM_ENCRYPT));
+			tmp = read_from_oldmem_iter(iter, tsz, &start,
+					cc_platform_has(CC_ATTR_MEM_ENCRYPT));
 			if (tmp < 0)
 				return tmp;
-			buflen -= tsz;
 			*fpos += tsz;
-			buffer += tsz;
 			acc += tsz;
 
 			/* leave now if filled buffer already */
-			if (buflen == 0)
+			if (iter->count == 0)
 				return acc;
 		}
 	}
@@ -440,15 +414,14 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 	return acc;
 }
 
-static ssize_t read_vmcore(struct file *file, char __user *buffer,
-			   size_t buflen, loff_t *fpos)
+static ssize_t read_vmcore(struct kiocb *iocb, struct iov_iter *iter)
 {
-	return __read_vmcore((__force char *) buffer, buflen, fpos, 1);
+	return __read_vmcore(iter, &iocb->ki_pos);
 }
 
 /*
  * The vmcore fault handler uses the page cache and fills data using the
- * standard __vmcore_read() function.
+ * standard __read_vmcore() function.
  *
  * On s390 the fault handler is used for memory regions that can't be mapped
  * directly with remap_pfn_range().
@@ -458,9 +431,10 @@ static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
 #ifdef CONFIG_S390
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	pgoff_t index = vmf->pgoff;
+	struct iov_iter iter;
+	struct kvec kvec;
 	struct page *page;
 	loff_t offset;
-	char *buf;
 	int rc;
 
 	page = find_or_create_page(mapping, index, GFP_KERNEL);
@@ -468,8 +442,11 @@ static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
 		return VM_FAULT_OOM;
 	if (!PageUptodate(page)) {
 		offset = (loff_t) index << PAGE_SHIFT;
-		buf = __va((page_to_pfn(page) << PAGE_SHIFT));
-		rc = __read_vmcore(buf, PAGE_SIZE, &offset, 0);
+		kvec.iov_base = page_address(page);
+		kvec.iov_len = PAGE_SIZE;
+		iov_iter_kvec(&iter, READ, &kvec, 1, PAGE_SIZE);
+
+		rc = __read_vmcore(&iter, &offset);
 		if (rc < 0) {
 			unlock_page(page);
 			put_page(page);
@@ -719,7 +696,7 @@ static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
 
 static const struct proc_ops vmcore_proc_ops = {
 	.proc_open	= open_vmcore,
-	.proc_read	= read_vmcore,
+	.proc_read_iter	= read_vmcore,
 	.proc_lseek	= default_llseek,
 	.proc_mmap	= mmap_vmcore,
 };
-- 
2.34.1


