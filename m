Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U8aFy-0006AH-Ql
 for kexec@lists.infradead.org; Thu, 21 Feb 2013 17:48:41 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH 4/8] kexec: add infrastructure for handling kexec images
Date: Thu, 21 Feb 2013 17:48:10 +0000
Message-ID: <1361468894-18655-5-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: xen-devel@lists.xen.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>

From: David Vrabel <david.vrabel@citrix.com>

Add the code needed to handle and load kexec images into Xen memory or
into the crash region.  This is needed for the new KEXEC_CMD_load and
KEXEC_CMD_unload hypercall sub-ops.

Much of this code is derived from the Linux kernel.

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
---
 xen/common/Makefile      |    1 +
 xen/common/kimage.c      |  887 ++++++++++++++++++++++++++++++++++++++++++++++
 xen/include/xen/kimage.h |   64 ++++
 3 files changed, 952 insertions(+), 0 deletions(-)
 create mode 100644 xen/common/kimage.c
 create mode 100644 xen/include/xen/kimage.h

diff --git a/xen/common/Makefile b/xen/common/Makefile
index 1677342..4c04018 100644
--- a/xen/common/Makefile
+++ b/xen/common/Makefile
@@ -11,6 +11,7 @@ obj-y += irq.o
 obj-y += kernel.o
 obj-y += keyhandler.o
 obj-$(HAS_KEXEC) += kexec.o
+obj-$(HAS_KEXEC) += kimage.o
 obj-y += lib.o
 obj-y += memory.o
 obj-y += multicall.o
diff --git a/xen/common/kimage.c b/xen/common/kimage.c
new file mode 100644
index 0000000..c5f07c3
--- /dev/null
+++ b/xen/common/kimage.c
@@ -0,0 +1,887 @@
+/*
+ * Kexec Image
+ *
+ * Copyright (C) 2013 Citrix Systems R&D Ltd.
+ *
+ * Derived from kernel/kexec.c from Linux:
+ *
+ *   Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#include <xen/config.h>
+#include <xen/types.h>
+#include <xen/init.h>
+#include <xen/kernel.h>
+#include <xen/errno.h>
+#include <xen/spinlock.h>
+#include <xen/guest_access.h>
+#include <xen/mm.h>
+#include <xen/kexec.h>
+#include <xen/kimage.h>
+
+#include <asm/page.h>
+
+/*
+ * When kexec transitions to the new kernel there is a one-to-one
+ * mapping between physical and virtual addresses.  On processors
+ * where you can disable the MMU this is trivial, and easy.  For
+ * others it is still a simple predictable page table to setup.
+ *
+ * In that environment kexec copies the new kernel to its final
+ * resting place.  This means I can only support memory whose
+ * physical address can fit in an unsigned long.  In particular
+ * addresses where (pfn << PAGE_SHIFT) > ULONG_MAX cannot be handled.
+ * If the assembly stub has more restrictive requirements
+ * KEXEC_SOURCE_MEMORY_LIMIT and KEXEC_DEST_MEMORY_LIMIT can be
+ * defined more restrictively in <asm/kexec.h>.
+ *
+ * The code for the transition from the current kernel to the
+ * the new kernel is placed in the control_code_buffer, whose size
+ * is given by KEXEC_CONTROL_PAGE_SIZE.  In the best case only a single
+ * page of memory is necessary, but some architectures require more.
+ * Because this memory must be identity mapped in the transition from
+ * virtual to physical addresses it must live in the range
+ * 0 - TASK_SIZE, as only the user space mappings are arbitrarily
+ * modifiable.
+ *
+ * The assembly stub in the control code buffer is passed a linked list
+ * of descriptor pages detailing the source pages of the new kernel,
+ * and the destination addresses of those source pages.  As this data
+ * structure is not used in the context of the current OS, it must
+ * be self-contained.
+ *
+ * The code has been made to work with highmem pages and will use a
+ * destination page in its final resting place (if it happens
+ * to allocate it).  The end product of this is that most of the
+ * physical address space, and most of RAM can be used.
+ *
+ * Future directions include:
+ *  - allocating a page table with the control code buffer identity
+ *    mapped, to simplify machine_kexec and make kexec_on_panic more
+ *    reliable.
+ */
+
+/*
+ * KIMAGE_NO_DEST is an impossible destination address..., for
+ * allocating pages whose destination address we do not care about.
+ */
+#define KIMAGE_NO_DEST (-1UL)
+
+static int kimage_is_destination_range(struct kexec_image *image,
+                                       unsigned long start, unsigned long end);
+static struct page_info *kimage_alloc_page(struct kexec_image *image,
+                                           unsigned long dest);
+
+static struct page_info *kimage_alloc_xen_page(void)
+{
+    void *p;
+
+    p = alloc_xenheap_page();
+    if ( p == NULL )
+        return NULL;
+    return virt_to_page(p);
+}
+
+static void kimage_free_xen_page(struct page_info *page)
+{
+    free_xenheap_page(page_to_virt(page));
+}
+
+static int do_kimage_alloc(struct kexec_image **rimage, unsigned long entry,
+                           unsigned long nr_segments,
+                           xen_kexec_segment_t *segments)
+{
+    struct kexec_image *image;
+    unsigned long i;
+    int result;
+
+    /* Allocate a controlling structure */
+    result = -ENOMEM;
+    image = xzalloc(typeof(*image));
+    if ( !image )
+        goto out;
+
+    image->head = 0;
+    image->entry = &image->head;
+    image->last_entry = &image->head;
+    image->control_page = ~0; /* By default this does not apply */
+    image->entry_maddr = entry;
+    image->type = KEXEC_TYPE_DEFAULT;
+    image->nr_segments = nr_segments;
+    image->segments = segments;
+
+    INIT_PAGE_LIST_HEAD(&image->control_pages);
+    INIT_PAGE_LIST_HEAD(&image->dest_pages);
+    INIT_PAGE_LIST_HEAD(&image->unuseable_pages);
+
+    /*
+     * Verify we have good destination addresses.  The caller is
+     * responsible for making certain we don't attempt to load
+     * the new image into invalid or reserved areas of RAM.  This
+     * just verifies it is an address we can use.
+     *
+     * Since the kernel does everything in page size chunks ensure
+     * the destination addresses are page aligned.  Too many
+     * special cases crop of when we don't do this.  The most
+     * insidious is getting overlapping destination addresses
+     * simply because addresses are changed to page size
+     * granularity.
+     */
+    result = -EADDRNOTAVAIL;
+    for ( i = 0; i < nr_segments; i++ )
+    {
+        unsigned long mstart, mend;
+
+        mstart = image->segments[i].dest_maddr;
+        mend   = mstart + image->segments[i].dest_size;
+        if ( (mstart & ~PAGE_MASK) || (mend & ~PAGE_MASK) )
+            goto out;
+        if ( mend >= KEXEC_DESTINATION_MEMORY_LIMIT )
+            goto out;
+    }
+
+    /* Verify our destination addresses do not overlap.
+     * If we alloed overlapping destination addresses
+     * through very weird things can happen with no
+     * easy explanation as one segment stops on another.
+     */
+    result = -EINVAL;
+    for ( i = 0; i < nr_segments; i++ )
+    {
+        unsigned long mstart, mend;
+        unsigned long j;
+
+        mstart = image->segments[i].dest_maddr;
+        mend   = mstart + image->segments[i].dest_size;
+        for (j = 0; j < i; j++ )
+        {
+            unsigned long pstart, pend;
+            pstart = image->segments[j].dest_maddr;
+            pend   = pstart + image->segments[j].dest_size;
+            /* Do the segments overlap ? */
+            if ( (mend > pstart) && (mstart < pend) )
+                goto out;
+        }
+    }
+
+    /* Ensure our buffer sizes are strictly less than
+     * our memory sizes.  This should always be the case,
+     * and it is easier to check up front than to be surprised
+     * later on.
+     */
+    result = -EINVAL;
+    for ( i = 0; i < nr_segments; i++ )
+    {
+        if ( image->segments[i].buf_size > image->segments[i].dest_size )
+            goto out;
+    }
+
+    result = 0;
+out:
+    if ( result == 0 )
+        *rimage = image;
+    else
+        kimage_free(image);
+
+    return result;
+
+}
+
+static int kimage_normal_alloc(struct kexec_image **rimage, unsigned long entry,
+                               unsigned long nr_segments,
+                               xen_kexec_segment_t *segments)
+{
+    int result;
+    struct kexec_image *image;
+    void *code_page;
+
+    /* Allocate and initialize a controlling structure */
+    image = NULL;
+    result = do_kimage_alloc(&image, entry, nr_segments, segments);
+    if ( result )
+        goto out;
+
+    *rimage = image;
+
+    /*
+     * The control code page must still be accessible after the
+     * processor has switched to 32-bit mode.
+     */
+    code_page = alloc_xenheap_pages(0, MEMF_bits(32));
+    if ( code_page == NULL )
+    {
+        result = -ENOMEM;
+        gdprintk(XENLOG_WARNING, "Could not allocate control_code_buffer\n");
+        goto out;
+    }
+    image->control_code_page = virt_to_page(code_page);
+
+    result = 0;
+out:
+    if ( result == 0 )
+        *rimage = image;
+    else
+        xfree(image);
+
+    return result;
+}
+
+static int kimage_crash_alloc(struct kexec_image **rimage, unsigned long entry,
+                              unsigned long nr_segments,
+                              xen_kexec_segment_t *segments)
+{
+    int result;
+    struct kexec_image *image;
+    unsigned long i;
+
+    image = NULL;
+    /* Verify we have a valid entry point */
+    if ( (entry < kexec_crash_area.start)
+         || (entry > kexec_crash_area.start + kexec_crash_area.size))
+    {
+        result = -EADDRNOTAVAIL;
+        goto out;
+    }
+
+    /* Allocate and initialize a controlling structure */
+    result = do_kimage_alloc(&image, entry, nr_segments, segments);
+    if ( result )
+        goto out;
+
+    /* Enable the special crash kernel control page
+     * allocation policy.
+     */
+    image->control_page = kexec_crash_area.start;
+    image->type = KEXEC_TYPE_CRASH;
+
+    /*
+     * Verify we have good destination addresses.  Normally
+     * the caller is responsible for making certain we don't
+     * attempt to load the new image into invalid or reserved
+     * areas of RAM.  But crash kernels are preloaded into a
+     * reserved area of ram.  We must ensure the addresses
+     * are in the reserved area otherwise preloading the
+     * kernel could corrupt things.
+     */
+    result = -EADDRNOTAVAIL;
+    for ( i = 0; i < nr_segments; i++ )
+    {
+        unsigned long mstart, mend;
+
+        mstart = image->segments[i].dest_maddr;
+        mend = mstart + image->segments[i].dest_size - 1;
+        /* Ensure we are within the crash kernel limits */
+        if ( (mstart < kexec_crash_area.start )
+             || (mend > kexec_crash_area.start + kexec_crash_area.size))
+            goto out;
+    }
+
+    /*
+     * Find a location for the control code buffer, and add
+     * the vector of segments so that it's pages will also be
+     * counted as destination pages.
+     */
+    result = -ENOMEM;
+    image->control_code_page = kimage_alloc_control_page(image);
+    if ( !image->control_code_page )
+    {
+        gdprintk(XENLOG_WARNING, "Could not allocate control_code_buffer\n");
+        goto out;
+    }
+
+    result = 0;
+out:
+    if ( result == 0 )
+        *rimage = image;
+    else
+        xfree(image);
+
+    return result;
+}
+
+static int kimage_is_destination_range(struct kexec_image *image,
+                                       unsigned long start,
+                                       unsigned long end)
+{
+    unsigned long i;
+
+    for ( i = 0; i < image->nr_segments; i++ )
+    {
+        unsigned long mstart, mend;
+
+        mstart = image->segments[i].dest_maddr;
+        mend = mstart + image->segments[i].dest_size;
+        if ( (end > mstart) && (start < mend) )
+            return 1;
+    }
+
+    return 0;
+}
+
+static void kimage_free_page_list(struct page_list_head *list)
+{
+    struct page_info *page, *next;
+
+    page_list_for_each_safe(page, next, list)
+    {
+        printk("delete page %p\n", page);
+        page_list_del(page, list);
+        kimage_free_xen_page(page);
+    }
+}
+
+static struct page_info *kimage_alloc_normal_control_page(struct kexec_image *image)
+{
+    /* Control pages are special, they are the intermediaries
+     * that are needed while we copy the rest of the pages
+     * to their final resting place.  As such they must
+     * not conflict with either the destination addresses
+     * or memory the kernel is already using.
+     *
+     * The only case where we really need more than one of
+     * these are for architectures where we cannot disable
+     * the MMU and must instead generate an identity mapped
+     * page table for all of the memory.
+     *
+     * At worst this runs in O(N) of the image size.
+     */
+    struct page_list_head extra_pages;
+    struct page_info *page = NULL;
+
+    INIT_PAGE_LIST_HEAD(&extra_pages);
+
+    /* Loop while I can allocate a page and the page allocated
+     * is a destination page.
+     */
+    do {
+        unsigned long mfn, emfn, addr, eaddr;
+
+        page = kimage_alloc_xen_page();
+        if ( !page )
+            break;
+        mfn   = page_to_mfn(page);
+        emfn  = mfn + 1;
+        addr  = mfn << PAGE_SHIFT;
+        eaddr = emfn << PAGE_SHIFT;
+        if ( (emfn >= (KEXEC_CONTROL_MEMORY_LIMIT >> PAGE_SHIFT)) ||
+             kimage_is_destination_range(image, addr, eaddr) )
+        {
+            printk("add page %p\n", page);
+            page_list_add(page, &extra_pages);
+            page = NULL;
+        }
+    } while ( !page );
+
+    if ( page )
+    {
+        /* Remember the allocated page... */
+        page_list_add(page, &image->control_pages);
+
+        /* Because the page is already in it's destination
+         * location we will never allocate another page at
+         * that address.  Therefore kimage_alloc_page
+         * will not return it (again) and we don't need
+         * to give it an entry in image->segments[].
+         */
+    }
+    /* Deal with the destination pages I have inadvertently allocated.
+     *
+     * Ideally I would convert multi-page allocations into single
+     * page allocations, and add everything to image->dest_pages.
+     *
+     * For now it is simpler to just free the pages.
+     */
+    kimage_free_page_list(&extra_pages);
+
+    return page;
+}
+
+static struct page_info *kimage_alloc_crash_control_page(struct kexec_image *image)
+{
+    /* Control pages are special, they are the intermediaries
+     * that are needed while we copy the rest of the pages
+     * to their final resting place.  As such they must
+     * not conflict with either the destination addresses
+     * or memory the kernel is already using.
+     *
+     * Control pages are also the only pags we must allocate
+     * when loading a crash kernel.  All of the other pages
+     * are specified by the segments and we just memcpy
+     * into them directly.
+     *
+     * The only case where we really need more than one of
+     * these are for architectures where we cannot disable
+     * the MMU and must instead generate an identity mapped
+     * page table for all of the memory.
+     *
+     * Given the low demand this implements a very simple
+     * allocator that finds the first hole of the appropriate
+     * size in the reserved memory region, and allocates all
+     * of the memory up to and including the hole.
+     */
+    unsigned long hole_start, hole_end, size;
+    struct page_info *page;
+
+    page = NULL;
+    size = PAGE_SIZE;
+    hole_start = (image->control_page + (size - 1)) & ~(size - 1);
+    hole_end   = hole_start + size - 1;
+    while ( hole_end <= kexec_crash_area.start + kexec_crash_area.size )
+    {
+        unsigned long i;
+
+        if ( hole_end > KEXEC_CRASH_CONTROL_MEMORY_LIMIT )
+            break;
+        if ( hole_end > kexec_crash_area.start + kexec_crash_area.size )
+            break;
+        /* See if I overlap any of the segments */
+        for ( i = 0; i < image->nr_segments; i++ )
+        {
+            unsigned long mstart, mend;
+
+            mstart = image->segments[i].dest_maddr;
+            mend   = mstart + image->segments[i].dest_size - 1;
+            if ( (hole_end >= mstart) && (hole_start <= mend) )
+            {
+                /* Advance the hole to the end of the segment */
+                hole_start = (mend + (size - 1)) & ~(size - 1);
+                hole_end   = hole_start + size - 1;
+                break;
+            }
+        }
+        /* If I don't overlap any segments I have found my hole! */
+        if ( i == image->nr_segments )
+        {
+            page = mfn_to_page(hole_start >> PAGE_SHIFT);
+            break;
+        }
+    }
+    if ( page )
+        image->control_page = hole_end;
+
+    return page;
+}
+
+
+struct page_info *kimage_alloc_control_page(struct kexec_image *image)
+{
+    struct page_info *pages = NULL;
+
+    switch ( image->type )
+    {
+    case KEXEC_TYPE_DEFAULT:
+        pages = kimage_alloc_normal_control_page(image);
+        break;
+    case KEXEC_TYPE_CRASH:
+        pages = kimage_alloc_crash_control_page(image);
+        break;
+    }
+
+    if ( pages )
+        clear_page(page_to_virt(pages));
+
+    return pages;
+}
+
+static int kimage_add_entry(struct kexec_image *image, kimage_entry_t entry)
+{
+    if ( *image->entry != 0 )
+        image->entry++;
+
+    if ( image->entry == image->last_entry )
+    {
+        kimage_entry_t *ind_page;
+        struct page_info *page;
+
+        page = kimage_alloc_page(image, KIMAGE_NO_DEST);
+        if ( !page )
+            return -ENOMEM;
+
+        ind_page = page_to_virt(page);
+        *image->entry = page_to_maddr(page) | IND_INDIRECTION;
+        image->entry = ind_page;
+        image->last_entry = ind_page +
+            ((PAGE_SIZE/sizeof(kimage_entry_t)) - 1);
+    }
+    *image->entry = entry;
+    image->entry++;
+    *image->entry = 0;
+
+    return 0;
+}
+
+static int kimage_set_destination(struct kexec_image *image,
+                                  unsigned long destination)
+{
+    int result;
+
+    destination &= PAGE_MASK;
+    result = kimage_add_entry(image, destination | IND_DESTINATION);
+    if ( result == 0 )
+        image->destination = destination;
+
+    return result;
+}
+
+
+static int kimage_add_page(struct kexec_image *image, unsigned long page)
+{
+    int result;
+
+    page &= PAGE_MASK;
+    result = kimage_add_entry(image, page | IND_SOURCE);
+    if ( result == 0 )
+        image->destination += PAGE_SIZE;
+
+    return result;
+}
+
+
+static void kimage_free_extra_pages(struct kexec_image *image)
+{
+    kimage_free_page_list(&image->dest_pages);
+    kimage_free_page_list(&image->unuseable_pages);
+
+}
+
+static void kimage_terminate(struct kexec_image *image)
+{
+    if ( *image->entry != 0 )
+        image->entry++;
+
+    *image->entry = IND_DONE;
+}
+
+#define for_each_kimage_entry(image, ptr, entry)                      \
+    for ( ptr = &image->head; (entry = *ptr) && !(entry & IND_DONE ); \
+          ptr = (entry & IND_INDIRECTION) ?                           \
+              maddr_to_virt((entry & PAGE_MASK)) : ptr + 1)
+
+static void kimage_free_entry(kimage_entry_t entry)
+{
+    struct page_info *page;
+
+    page = mfn_to_page(entry >> PAGE_SHIFT);
+    kimage_free_xen_page(page);
+}
+
+void kimage_free(struct kexec_image *image)
+{
+    kimage_entry_t *ptr, entry;
+    kimage_entry_t ind = 0;
+
+    if ( !image )
+        return;
+
+    kimage_free_extra_pages(image);
+    for_each_kimage_entry(image, ptr, entry)
+    {
+        if ( entry & IND_INDIRECTION )
+        {
+            /* Free the previous indirection page */
+            if ( ind & IND_INDIRECTION )
+                kimage_free_entry(ind);
+            /* Save this indirection page until we are
+             * done with it.
+             */
+            ind = entry;
+        }
+        else if ( entry & IND_SOURCE )
+            kimage_free_entry(entry);
+    }
+    /* Free the final indirection page */
+    if ( ind & IND_INDIRECTION )
+        kimage_free_entry(ind);
+
+    /* Free the kexec control pages... */
+    kimage_free_page_list(&image->control_pages);
+    xfree(image->segments);
+    xfree(image);
+}
+
+static kimage_entry_t *kimage_dst_used(struct kexec_image *image,
+                                       unsigned long page)
+{
+    kimage_entry_t *ptr, entry;
+    unsigned long destination = 0;
+
+    for_each_kimage_entry(image, ptr, entry)
+    {
+        if ( entry & IND_DESTINATION )
+            destination = entry & PAGE_MASK;
+        else if ( entry & IND_SOURCE )
+        {
+            if ( page == destination )
+                return ptr;
+            destination += PAGE_SIZE;
+        }
+    }
+
+    return NULL;
+}
+
+static struct page_info *kimage_alloc_page(struct kexec_image *image,
+                                      unsigned long destination)
+{
+    /*
+     * Here we implement safeguards to ensure that a source page
+     * is not copied to its destination page before the data on
+     * the destination page is no longer useful.
+     *
+     * To do this we maintain the invariant that a source page is
+     * either its own destination page, or it is not a
+     * destination page at all.
+     *
+     * That is slightly stronger than required, but the proof
+     * that no problems will not occur is trivial, and the
+     * implementation is simply to verify.
+     *
+     * When allocating all pages normally this algorithm will run
+     * in O(N) time, but in the worst case it will run in O(N^2)
+     * time.   If the runtime is a problem the data structures can
+     * be fixed.
+     */
+    struct page_info *page;
+    unsigned long addr;
+
+    /*
+     * Walk through the list of destination pages, and see if I
+     * have a match.
+     */
+    page_list_for_each(page, &image->dest_pages)
+    {
+        addr = page_to_mfn(page) << PAGE_SHIFT;
+        if ( addr == destination )
+        {
+            page_list_del(page, &image->dest_pages);
+            return page;
+        }
+    }
+    page = NULL;
+    for (;;)
+    {
+        kimage_entry_t *old;
+
+        /* Allocate a page, if we run out of memory give up */
+        page = kimage_alloc_xen_page();
+        if ( !page )
+            return NULL;
+        /* If the page cannot be used file it away */
+        if ( page_to_mfn(page) >
+             (KEXEC_SOURCE_MEMORY_LIMIT >> PAGE_SHIFT) )
+        {
+            page_list_add(page, &image->unuseable_pages);
+            continue;
+        }
+        addr = page_to_mfn(page) << PAGE_SHIFT;
+
+        /* If it is the destination page we want use it */
+        if ( addr == destination )
+            break;
+
+        /* If the page is not a destination page use it */
+        if ( !kimage_is_destination_range(image, addr,
+                                          addr + PAGE_SIZE) )
+            break;
+
+        /*
+         * I know that the page is someones destination page.
+         * See if there is already a source page for this
+         * destination page.  And if so swap the source pages.
+         */
+        old = kimage_dst_used(image, addr);
+        if ( old )
+        {
+            /* If so move it */
+            unsigned long old_addr;
+            struct page_info *old_page;
+
+            old_addr = *old & PAGE_MASK;
+            old_page = mfn_to_page(old_addr >> PAGE_SHIFT);
+            copy_page(page, old_page);
+            *old = addr | (*old & ~PAGE_MASK);
+
+            addr = old_addr;
+            page = old_page;
+            break;
+        }
+        else
+        {
+            /* Place the page on the destination list I
+             * will use it later.
+             */
+            page_list_add(page, &image->dest_pages);
+        }
+    }
+
+    return page;
+}
+
+static int kimage_load_normal_segment(struct kexec_image *image,
+                                      xen_kexec_segment_t *segment)
+{
+    unsigned long to_copy;
+    unsigned long src_offset;
+    unsigned long dest;
+    int ret;
+
+    to_copy = segment->buf_size;
+    src_offset = 0;
+    dest = segment->dest_maddr;
+
+    ret = kimage_set_destination(image, dest);
+    if ( ret < 0 )
+        return ret;
+
+    while ( to_copy )
+    {
+        unsigned long dest_mfn;
+        size_t dest_off;
+        struct page_info *page;
+        void *dest_va;
+        size_t size;
+
+        dest_mfn = dest >> PAGE_SHIFT;
+        dest_off = dest & ~PAGE_MASK;
+
+        size = min(PAGE_SIZE - dest_off, to_copy);
+
+        page = kimage_alloc_page(image, dest);
+        if ( !page )
+            return -ENOMEM;
+        ret = kimage_add_page(image, page_to_mfn(page) << PAGE_SHIFT);
+        if ( ret < 0 )
+            return ret;
+
+        dest_va = page_to_virt(page);
+        clear_page(dest_va);
+        ret = copy_from_guest_offset(dest_va + dest_off, segment->buf, src_offset, size);
+        if ( ret )
+            return -EFAULT;
+
+        to_copy -= size;
+        src_offset += size;
+        dest += size;
+    }
+
+    return 0;
+}
+
+static int kimage_load_crash_segment(struct kexec_image *image,
+                                     xen_kexec_segment_t *segment)
+{
+    /* For crash dumps kernels we simply copy the data from
+     * user space to it's destination.
+     * We do things a page at a time for the sake of kmap.
+     */
+	unsigned long dest;
+	unsigned long sbytes, dbytes;
+    int ret = 0;
+    unsigned long src_offset = 0;
+
+	sbytes = segment->buf_size;
+	dbytes = segment->dest_size;
+	dest = segment->dest_maddr;
+
+	while ( dbytes )
+    {
+        unsigned long dest_mfn;
+        size_t dest_off;
+        void *dest_va;
+		size_t schunk, dchunk;
+
+        dest_mfn = dest >> PAGE_SHIFT;
+        dest_off = dest & ~PAGE_MASK;
+
+		dchunk = min(PAGE_SIZE - dest_off, dbytes);
+        schunk = min(dchunk, sbytes);
+
+		dest_va = vmap(&dest_mfn, 1);
+        if ( dest_va == NULL )
+            return -EINVAL;
+
+        ret = copy_from_guest_offset(dest_va + dest_off, segment->buf, src_offset, schunk);
+        memset(dest_va + dest_off + schunk, 0, dchunk - schunk);
+
+		vunmap(dest_va);
+		if ( ret )
+            return -EFAULT;
+
+		dbytes -= dchunk;
+		sbytes -= schunk;
+		dest += dchunk;
+        src_offset += schunk;
+	}
+
+    return 0;
+}
+
+static int kimage_load_segment(struct kexec_image *image, xen_kexec_segment_t *segment)
+{
+    int result = -ENOMEM;
+
+    switch ( image->type )
+    {
+    case KEXEC_TYPE_DEFAULT:
+        result = kimage_load_normal_segment(image, segment);
+        break;
+    case KEXEC_TYPE_CRASH:
+        result = kimage_load_crash_segment(image, segment);
+        break;
+    }
+
+    return result;
+}
+
+int kimage_alloc(struct kexec_image **rimage, uint8_t type, uint16_t arch,
+                 uint64_t entry_maddr,
+                 uint32_t nr_segments, xen_kexec_segment_t *segment)
+{
+    int result;
+
+    switch( type )
+    {
+    case KEXEC_TYPE_DEFAULT:
+        result = kimage_normal_alloc(rimage, entry_maddr, nr_segments, segment);
+        break;
+    case KEXEC_TYPE_CRASH:
+        result = kimage_crash_alloc(rimage, entry_maddr, nr_segments, segment);
+        break;
+    default:
+        result = -EINVAL;
+        break;
+    }
+    if ( result < 0 )
+        return result;
+
+    (*rimage)->arch = arch;
+
+    return result;
+}
+
+int kimage_load_segments(struct kexec_image *image)
+{
+    int s;
+    int result;
+
+    for ( s = 0; s < image->nr_segments; s++ ) {
+        result = kimage_load_segment(image, &image->segments[s]);
+        if ( result < 0 )
+            return result;
+    }
+    kimage_terminate(image);
+    return 0;
+}
+
+/*
+ * Local variables:
+ * mode: C
+ * c-file-style: "BSD"
+ * c-basic-offset: 4
+ * tab-width: 4
+ * indent-tabs-mode: nil
+ * End:
+ */
diff --git a/xen/include/xen/kimage.h b/xen/include/xen/kimage.h
new file mode 100644
index 0000000..dc71b87
--- /dev/null
+++ b/xen/include/xen/kimage.h
@@ -0,0 +1,64 @@
+#ifndef __XEN_KIMAGE_H__
+#define __XEN_KIMAGE_H__
+
+#include <xen/list.h>
+#include <xen/mm.h>
+#include <public/kexec.h>
+
+#define KEXEC_DESTINATION_MEMORY_LIMIT (~0ul)
+#define KEXEC_CONTROL_MEMORY_LIMIT (~0ul)
+#define KEXEC_CRASH_CONTROL_MEMORY_LIMIT (~0ul)
+#define KEXEC_SOURCE_MEMORY_LIMIT (~0ul)
+
+#define KEXEC_CONTROL_PAGE_SIZE PAGE_SIZE
+
+#define KEXEC_SEGMENT_MAX 16
+
+typedef unsigned long kimage_entry_t;
+#define IND_DESTINATION  0x1
+#define IND_INDIRECTION  0x2
+#define IND_DONE         0x4
+#define IND_SOURCE       0x8
+
+struct kexec_image {
+    uint8_t type;
+    uint16_t arch;
+    uint64_t entry_maddr;
+    uint32_t nr_segments;
+    xen_kexec_segment_t *segments;
+
+    kimage_entry_t head;
+    kimage_entry_t *entry;
+    kimage_entry_t *last_entry;
+
+    unsigned long destination;
+
+    struct page_info *control_code_page;
+    struct page_info *aux_page;
+
+    struct page_list_head control_pages;
+    struct page_list_head dest_pages;
+    struct page_list_head unuseable_pages;
+
+    /* Address of next control page to allocate for crash kernels. */
+    unsigned long control_page;
+};
+
+int kimage_alloc(struct kexec_image **rimage, uint8_t type, uint16_t arch,
+                 uint64_t entry_maddr,
+                 uint32_t nr_segments, xen_kexec_segment_t *segment);
+void kimage_free(struct kexec_image *image);
+int kimage_load_segments(struct kexec_image *image);
+struct page_info *kimage_alloc_control_page(struct kexec_image *image);
+
+#endif /* __XEN_KIMAGE_H__ */
+
+/*
+ * Local variables:
+ * mode: C
+ * c-file-style: "BSD"
+ * c-basic-offset: 4
+ * tab-width: 4
+ * indent-tabs-mode: nil
+ * End:
+ */
-- 
1.7.2.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
