Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 6 Dec 2021 14:17:24 +0000
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 01/14] fs/proc/vmcore: Update read_from_oldmem() for
 user pointer
Message-ID: <Ya4bdB0UBJCZhUSo@casper.infradead.org>
References: <20211203104231.17597-1-amit.kachhap@arm.com>
 <20211203104231.17597-2-amit.kachhap@arm.com>
 <20211206140451.GA4936@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211206140451.GA4936@lst.de>
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
To: Christoph Hellwig <hch@lst.de>
Cc: Amit Daniel Kachhap <amit.kachhap@arm.com>, linux-kernel@vger.kernel.org, Vincenzo Frascino <Vincenzo.Frascino@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, kexec <kexec@lists.infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, x86 <x86@kernel.org>

On Mon, Dec 06, 2021 at 03:04:51PM +0100, Christoph Hellwig wrote:
> This looks like a huge mess.  What speak against using an iov_iter
> here?

I coincidentally made a start on this last night.  Happy to stop.
What do you think to adding a generic copy_pfn_to_iter()?  Not sure
which APIs to use to implement it ... some architectures have weird
requirements about which APIs can be used for what kinds of PFNs.

diff --git a/arch/arm/kernel/crash_dump.c b/arch/arm/kernel/crash_dump.c
index 53cb92435392..ed0d806a4d14 100644
--- a/arch/arm/kernel/crash_dump.c
+++ b/arch/arm/kernel/crash_dump.c
@@ -16,39 +16,28 @@
 #include <linux/io.h>
 
 /**
- * copy_oldmem_page() - copy one page from old kernel memory
- * @pfn: page frame number to be copied
- * @buf: buffer where the copied page is placed
- * @csize: number of bytes to copy
- * @offset: offset in bytes into the page
- * @userbuf: if set, @buf is int he user address space
+ * copy_pfn_to_iter() - copy one page from old kernel memory.
+ * @iter: Where to copy the page to.
+ * @pfn: Page frame number to be copied.
+ * @offset: Offset in bytes into the page.
+ * @len: Number of bytes to copy.
  *
- * This function copies one page from old kernel memory into buffer pointed by
- * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
- * copied or negative error in case of failure.
+ * This function copies (part of) one page from old kernel memory into
+ * memory described by @iter.
+ *
+ * Return: Number of bytes copied or negative error in case of failure.
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-			 size_t csize, unsigned long offset,
-			 int userbuf)
+ssize_t copy_pfn_to_iter(struct iov_iter *iter, unsigned long pfn,
+			 size_t offset, size_t len)
 {
 	void *vaddr;
 
-	if (!csize)
-		return 0;
-
 	vaddr = ioremap(__pfn_to_phys(pfn), PAGE_SIZE);
 	if (!vaddr)
 		return -ENOMEM;
 
-	if (userbuf) {
-		if (copy_to_user(buf, vaddr + offset, csize)) {
-			iounmap(vaddr);
-			return -EFAULT;
-		}
-	} else {
-		memcpy(buf, vaddr + offset, csize);
-	}
+	len = copy_to_iter(vadd + offset, len, iter);
 
 	iounmap(vaddr);
-	return csize;
+	return len;
 }
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 620821549b23..2dd3a692bcb7 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -24,8 +24,8 @@ extern int remap_oldmem_pfn_range(struct vm_area_struct *vma,
 				  unsigned long from, unsigned long pfn,
 				  unsigned long size, pgprot_t prot);
 
-extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
-						unsigned long, int);
+ssize_t copy_pfn_to_iter(struct iov_iter *i, unsigned long pfn, size_t offset,
+		size_t len);
 extern ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
 					  size_t csize, unsigned long offset,
 					  int userbuf);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
