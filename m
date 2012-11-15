Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay3.sgi.com ([192.48.152.1] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TZ8JC-0000SO-96
 for kexec@lists.infradead.org; Thu, 15 Nov 2012 22:53:21 +0000
Received: from estes.americas.sgi.com (estes.americas.sgi.com [128.162.236.10])
 by relay3.corp.sgi.com (Postfix) with ESMTP id DF944AC004
 for <kexec@lists.infradead.org>; Thu, 15 Nov 2012 14:53:16 -0800 (PST)
Received: from eag09.americas.sgi.com (eag09.americas.sgi.com [128.162.232.15])
 by estes.americas.sgi.com (Postfix) with ESMTP id 99CB470030E7
 for <kexec@lists.infradead.org>; Thu, 15 Nov 2012 16:53:16 -0600 (CST)
Received: from cpw by eag09.americas.sgi.com with local (Exim 4.69)
 (envelope-from <cpw@sgi.com>) id 1TZ8Ih-0000Gw-QE
 for kexec@lists.infradead.org; Thu, 15 Nov 2012 16:52:47 -0600
Subject: [PATCH] scan page tables for makedumpfile
Message-Id: <E1TZ8Ih-0000Gw-QE@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Thu, 15 Nov 2012 16:52:47 -0600
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


Accompanies [PATCH] makedumpfile: request the kernel do page scans

This patch moves the scanning of page tables into the kernel.

The makedumpfile command makes requests by writes to /proc/vmcore_pfn_lists
and this code writes a list of PFN's back to it.

This is experimental code.  It is tested on SGI UV machines, but not yet
proposed to the linux kernel community.

Diffed against linux-next (3.7.0-rc5-next-20121115-uv+)

Signed-off-by: Cliff Wickman <cpw@sgi.com>
---
 fs/proc/vmcore.c             |  558 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/makedumpfile.h |  115 ++++++++
 2 files changed, 673 insertions(+)

Index: linux/fs/proc/vmcore.c
===================================================================
--- linux.orig/fs/proc/vmcore.c
+++ linux/fs/proc/vmcore.c
@@ -19,8 +19,18 @@
 #include <linux/init.h>
 #include <linux/crash_dump.h>
 #include <linux/list.h>
+#include <linux/makedumpfile.h>
+#include <linux/mmzone.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
+#include <asm/page.h>
+static int num_mem_map_data = 0;
+static struct mem_map_data *mem_map_data;
+static struct pfn_element *pfn_list;
+static long in_pfn_list;
+static int last_found_vaddr = 0;
+static int last_found_paddr = 0;
+static int max_pfn_list;
 
 /* List representing chunks of contiguous memory areas and their offsets in
  * vmcore file.
@@ -35,6 +45,7 @@ static size_t elfcorebuf_sz;
 static u64 vmcore_size;
 
 static struct proc_dir_entry *proc_vmcore = NULL;
+static struct proc_dir_entry *proc_vmcore_pfn_lists = NULL;
 
 /*
  * Returns > 0 for RAM pages, 0 for non-RAM pages, < 0 on error
@@ -208,11 +219,554 @@ static ssize_t read_vmcore(struct file *
 	return acc;
 }
 
+/*
+ * Given the boot-kernel-relative virtual address of a page
+ * return its crashkernel-relative virtual address.
+ *
+ * We have a memory map named mem_map_data
+ *
+ * return 0 if it cannot be found
+ */
+unsigned long
+find_local_vaddr(unsigned long orig_vaddr)
+{
+	int i;
+	int fnd = 0;
+	struct mem_map_data *mmd, *next_mmd;
+	unsigned long paddr;
+	unsigned long local_vaddr;
+	unsigned long offset;
+
+	if (!num_mem_map_data) {
+		printk("find_page_paddr !! num_mem_map_data is %d\n",
+			num_mem_map_data);
+		return 0;
+	}
+
+fullsearch:
+	for (i = last_found_vaddr, mmd = mem_map_data + last_found_vaddr,
+		next_mmd = mem_map_data + last_found_vaddr + 1;
+		i < num_mem_map_data; i++, mmd++, next_mmd++) {
+		if (mmd->mem_map && mmd->paddr) {
+			if (orig_vaddr >= mmd->mem_map &&
+			    orig_vaddr < next_mmd->mem_map) {
+				offset = orig_vaddr - mmd->mem_map;
+				paddr = mmd->paddr + offset;
+				fnd++;
+				/* caching gives about 99% hit on first pass */
+				last_found_vaddr = i;
+				break;
+			}
+		}
+	}
+
+	if (! fnd) {
+		if (last_found_vaddr > 0) {
+			last_found_vaddr = 0;
+			goto fullsearch;
+		}
+		return 0;
+	}
+
+	/* paddr is now the physical address of the page structure */
+	/* and offset is the offset into the found section, and we have
+	   a table of how those sections are ioremap_cache'd */
+	local_vaddr = (unsigned long)mmd->section_vaddr + offset;
+	return local_vaddr;
+}
+
+/*
+ * Given a paddr, return its crashkernel-relative virtual address.
+ *
+ * We have a memory map named mem_map_data
+ *
+ * return 0 if it cannot be found
+ */
+void *
+find_local_from_paddr(unsigned long paddr)
+{
+	int i;
+	struct mem_map_data *mmd;
+	unsigned long offset;
+
+	if (!num_mem_map_data) {
+		printk("find_page_paddr !! num_mem_map_data is %d\n",
+			num_mem_map_data);
+		return 0;
+	}
+
+fullsearch:
+	for (i = last_found_paddr, mmd = mem_map_data + last_found_paddr;
+		i < num_mem_map_data; i++, mmd++) {
+		if ((paddr >= mmd->paddr) && (paddr < mmd->ending_paddr)) {
+			offset = paddr - mmd->paddr;
+			last_found_paddr = i;
+			/* caching gives about 98% hit on first pass */
+			return (void *)(mmd->section_vaddr + offset);
+		}
+	}
+
+	if (last_found_paddr > 0) {
+		last_found_paddr = 0;
+		goto fullsearch;
+	}
+	return 0;
+}
+
+/*
+ * given an anchoring list_head, walk the list of free pages
+ * 'root' is a virtual address based on the ioremap_cache'd pointer pgp
+ * 'boot_root' is the virtual address of the list root, boot kernel relative
+ *
+ * return the number of pages found on the list
+ */
+int
+walk_freelist(struct list_head *root, int node, int zone, int order, int list,
+		int restart_list, int start_page, struct pfn_list_request *reqp,
+		struct pfn_reply *replyp, struct list_head *boot_root)
+{
+	int list_ct = 0;
+	int list_free_pages = 0;
+	int doit;
+	unsigned long start_pfn;
+	struct page *pagep;
+	struct page *local_pagep;
+	struct list_head *lhp;
+	struct list_head *local_lhp; /* crashkernel-relative */
+	struct list_head *prev;
+	struct pfn_element *pe;
+
+	/*
+	 * root is the crashkernel-relative address of the anchor of the
+	 * free_list.
+	 */
+	prev = root;
+	if (root == NULL) {
+		printk(KERN_EMERG "root is null!!, node %d order %d\n",
+			node, order);
+			return 0;
+	}
+
+	if (root->next == boot_root)
+		/* list is empty */
+		return 0;
+
+	lhp = root->next;
+	local_lhp = (struct list_head *)find_local_vaddr((unsigned long)lhp);
+	if (!local_lhp) {
+		return 0;
+	}
+
+	while (local_lhp != boot_root) {
+		list_ct++;
+		if (lhp == NULL) {
+			printk(KERN_EMERG
+			 "The free list has a null!!, node %d order %d\n",
+				node, order);
+			break;
+		}
+		if (list_ct > 1 && local_lhp->prev != prev) {
+			/* can't be compared to root, as that is local */
+			printk(KERN_EMERG "The free list is broken!!\n");
+			break;
+		}
+
+		/* we want the boot kernel's pfn that this page represents */
+		pagep = container_of((struct list_head *)lhp,
+							struct page, lru);
+		start_pfn = pagep - vmemmap;
+		local_pagep = container_of((struct list_head *)local_lhp,
+							struct page, lru);
+		doit = 1;
+		if (restart_list && list_ct < start_page)
+			doit = 0;
+		if (doit) {
+			if (in_pfn_list == max_pfn_list) {
+			 	/* if array would overflow, come back to
+				   this page with a continuation */
+				replyp->more = 1;
+				replyp->zone_index = zone;
+				replyp->freearea_index = order;
+				replyp->type_index = list;
+				replyp->list_ct = list_ct;
+				goto list_is_full;
+			}
+			pe = &pfn_list[in_pfn_list++];
+			pe->pfn = start_pfn;
+			pe->order = order;
+			list_free_pages += (1 << order);
+		}
+		prev = lhp;
+		lhp = local_pagep->lru.next;
+		/* the local node-relative vaddr: */
+		local_lhp = (struct list_head *)
+					find_local_vaddr((unsigned long)lhp);
+		if (!local_lhp)
+			break;
+	}
+
+list_is_full:
+	return list_free_pages;
+}
+
+/*
+ * Return the pfns of free pages on this node
+ */
+int
+write_vmcore_get_free(struct pfn_list_request *reqp)
+{
+	int node;
+	int nr_zones;
+	int nr_orders = MAX_ORDER;
+	int nr_freelist = MIGRATE_TYPES;
+	int zone;
+	int order;
+	int list;
+	int start_zone = 0;
+	int start_order = 0;
+	int start_list = 0;
+	int ret;
+	int restart = 0;
+	int start_page = 0;
+	int node_free_pages = 0;
+	struct pfn_reply rep;
+	struct pglist_data *pgp;
+	struct zone *zonep;
+	struct free_area *fap;
+	struct list_head *flp;
+	struct list_head *boot_root;
+	unsigned long pgdat_paddr;
+	unsigned long pgdat_vaddr;
+	unsigned long page_aligned_pgdat;
+	unsigned long page_aligned_size;
+	void *mapped_vaddr;
+
+	node = reqp->node;
+	pgdat_paddr = reqp->pgdat_paddr;
+	pgdat_vaddr = reqp->pgdat_vaddr;
+
+	/* map this pglist_data structure within a page-aligned area */
+	page_aligned_pgdat = pgdat_paddr & ~(PAGE_SIZE - 1);
+	page_aligned_size = sizeof(struct pglist_data) +
+					(pgdat_paddr - page_aligned_pgdat);
+	page_aligned_size = ((page_aligned_size + (PAGE_SIZE - 1))
+				>> PAGE_SHIFT) << PAGE_SHIFT;
+	mapped_vaddr = ioremap_cache(page_aligned_pgdat, page_aligned_size);
+	if (!mapped_vaddr) {
+		printk("ioremap_cache of pgdat %#lx failed\n",
+				page_aligned_pgdat);
+        	return -EINVAL;
+	}
+	pgp = (struct pglist_data *)(mapped_vaddr +
+				(pgdat_paddr - page_aligned_pgdat));
+	nr_zones = pgp->nr_zones;
+	memset(&rep, 0, sizeof(rep));
+
+	if (reqp->more) {
+		restart = 1;
+		start_zone = reqp->zone_index;
+		start_order = reqp->freearea_index;
+		start_list = reqp->type_index;
+		start_page = reqp->list_ct;
+	}
+
+	in_pfn_list = 0;
+	for (zone = start_zone; zone < nr_zones; zone++) {
+		zonep = &pgp->node_zones[zone];
+		for (order = start_order; order < nr_orders; order++) {
+			fap = &zonep->free_area[order];
+			/* some free_area's are all zero */
+			if (fap->nr_free) {
+				for (list = start_list; list < nr_freelist;
+								list++) {
+					flp = &fap->free_list[list];
+					boot_root = (struct list_head *)
+						(pgdat_vaddr +
+				    		 ((unsigned long)flp -
+						 (unsigned long)pgp));
+					ret = walk_freelist(flp, node, zone,
+						order, list, restart,
+						start_page, reqp, &rep,
+						boot_root);
+					node_free_pages += ret;
+					restart = 0;
+					if (rep.more)
+						goto list_full;
+				}
+			}
+		}
+	}
+list_full:
+
+	iounmap(mapped_vaddr);
+
+	/* copy the reply and the valid part of our pfn list to the user */
+	rep.pfn_free = node_free_pages; /* the total, for statistics */
+	rep.in_pfn_list = in_pfn_list;
+	if (copy_to_user(reqp->reply_ptr, &rep, sizeof(struct pfn_reply)))
+		return -EFAULT;
+	if (in_pfn_list) {
+		if (copy_to_user(reqp->pfn_list_ptr, pfn_list,
+				(in_pfn_list * sizeof(struct pfn_element))))
+			return -EFAULT;
+	}
+	return 0;
+}
+
+/*
+ * Get the memap_data table from makedumpfile
+ * and do the single allocate of the pfn_list.
+ */
+int
+write_vmcore_get_memmap(struct pfn_list_request *reqp)
+{
+	int i;
+	int count;
+	int size;
+	int ret = 0;
+	long pfn_list_elements;
+	long malloc_size;
+	unsigned long page_section_start;
+	unsigned long page_section_size;
+	struct mem_map_data *mmd, *dum_mmd;
+	struct pfn_reply rep;
+	void *bufptr;
+
+	rep.pfn_list_elements = 0;
+	if (num_mem_map_data) {
+		/* shouldn't have been done before, but if it was.. */
+		printk(KERN_INFO "warning: PL_REQUEST_MEMMAP is repeated\n");
+		for (i = 0, mmd = mem_map_data; i < num_mem_map_data;
+								i++, mmd++) {
+			iounmap(mmd->section_vaddr);
+		}
+		kfree(mem_map_data);
+		mem_map_data = NULL;
+		num_mem_map_data = 0;
+		kfree(pfn_list);
+		pfn_list = NULL;
+	}
+
+	count = reqp->map_count;
+	size = reqp->map_size;
+	bufptr = reqp->map_ptr;
+	if (size != (count * sizeof(struct mem_map_data))) {
+		printk("Error in mem_map_data, %d * %ld != %d\n",
+			count, sizeof(struct mem_map_data), size);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* add a dummy at the end to limit the size of the last entry */
+	size += sizeof(struct mem_map_data);
+
+	mem_map_data = kzalloc(size, GFP_KERNEL);
+	if (!mem_map_data) {
+		printk("kmalloc of mem_map_data for %d failed\n", size);
+		ret = -EINVAL;
+		goto out;
+	}
+
+        if (copy_from_user(mem_map_data, bufptr, size)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	num_mem_map_data = count;
+
+	/* construct the dummy entry to limit the size of 'next_mmd->mem_map' */
+	/* (see find_local_vaddr() ) */
+	mmd = mem_map_data + (num_mem_map_data - 1);
+	page_section_size = (mmd->pfn_end - mmd->pfn_start) *
+							sizeof(struct page);
+	dum_mmd = mmd + 1;
+	*dum_mmd = *mmd;
+	dum_mmd->mem_map += page_section_size;
+
+	/* Fill in the ending address of array of page struct */
+	for (i = 0, mmd = mem_map_data; i < num_mem_map_data; i++, mmd++) {
+		mmd->ending_paddr = mmd->paddr +
+			((mmd->pfn_end - mmd->pfn_start) * sizeof(struct page));
+	}
+
+	/* Map each section of page structures to local virtual addresses */
+	/* (these are never iounmap'd, as this is the crash kernel) */
+	for (i = 0, mmd = mem_map_data; i < num_mem_map_data; i++, mmd++) {
+		page_section_start = mmd->paddr;
+		page_section_size = (mmd->pfn_end - mmd->pfn_start) *
+							sizeof(struct page);
+		mmd->section_vaddr = ioremap_cache(page_section_start,
+							page_section_size);
+		if (!mmd->section_vaddr) {
+			printk(
+			  "ioremap_cache of [%d] node %#lx for %#lx failed\n",
+				i, page_section_start, page_section_size);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	/*
+	 * allocate the array for PFN's (just once)
+	 * get as much as we can, up to what the user specified, and return
+	 * that count to the user
+	 */
+	pfn_list_elements = reqp->list_size;
+	do {
+		malloc_size = pfn_list_elements * sizeof(struct pfn_element);
+		if ((pfn_list = kmalloc(malloc_size, GFP_KERNEL)) != NULL) {
+			rep.pfn_list_elements = pfn_list_elements;
+			max_pfn_list = pfn_list_elements;
+			goto out;
+		}
+		pfn_list_elements -= 1000;
+	} while (pfn_list == NULL && pfn_list_elements > 0);
+
+	ret = -EINVAL;
+out:
+	if (copy_to_user(reqp->reply_ptr, &rep, sizeof(struct pfn_reply)))
+		return -EFAULT;
+	return ret;
+}
+
+/*
+ * Return the pfns of to-be-excluded pages fulfilling this request.
+ * This is called for each mem_map in makedumpfile's list.
+ */
+int
+write_vmcore_get_excludes(struct pfn_list_request *reqp)
+{
+	int i;
+	int start = 0;
+	int end;
+	unsigned long paddr;
+	unsigned long pfn;
+	void *vaddr;
+	struct page *pagep;
+	struct pfn_reply rep;
+	struct pfn_element *pe;
+
+	if (!num_mem_map_data) {
+		/* sanity check */
+		printk(
+		"ERROR:PL_REQUEST_MEMMAP not done before PL_REQUEST_EXCLUDE\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * the request contains (besides request type and bufptr):
+	 *  paddr (physical address of the page[0]
+	 *  count of pages in the block
+	 *  exclude bits (DL_EXCLUDE_...)
+	 */
+	paddr = reqp->paddr;
+	end = reqp->count;
+	pfn = reqp->pfn_start;
+	/* find the already-mapped vaddr of this paddr */
+	vaddr = find_local_from_paddr(paddr);
+	if (!vaddr) {
+		printk("ERROR: PL_REQUEST_EXCLUDE cannot find paddr %#lx\n",
+			paddr);
+		return -EINVAL;
+	}
+	if (reqp->more) {
+		start = reqp->map_index;
+		vaddr += (reqp->map_index * sizeof(struct page));
+		pfn += reqp->map_index;
+	}
+	memset(&rep, 0, sizeof(rep));
+	in_pfn_list = 0;
+
+	for (i = start, pagep = (struct page *)vaddr; i < end;
+							i++, pagep++, pfn++) {
+		if (in_pfn_list == max_pfn_list) {
+			rep.more = 1;
+			rep.map_index = i;
+			break;
+		}
+		/*
+		 * Exclude the cache page without the private page.
+		 */
+		if ((reqp->exclude_bits & DL_EXCLUDE_CACHE)
+		    && (isLRU(pagep->flags) || isSwapCache(pagep->flags))
+		    && !isPrivate(pagep->flags) && !isAnon(pagep->mapping)) {
+			pe = &pfn_list[in_pfn_list++];
+			pe->pfn = pfn;
+			pe->order = 0; /* assume 4k */
+			rep.pfn_cache++;
+		}
+		/*
+		 * Exclude the cache page with the private page.
+		 */
+		else if ((reqp->exclude_bits & DL_EXCLUDE_CACHE_PRI)
+		    && (isLRU(pagep->flags) || isSwapCache(pagep->flags))
+		    && !isAnon(pagep->mapping)) {
+			pe = &pfn_list[in_pfn_list++];
+			pe->pfn = pfn;
+			pe->order = 0; /* assume 4k */
+			rep.pfn_cache_private++;
+		}
+		/*
+		 * Exclude the data page of the user process.
+		 */
+		else if ((reqp->exclude_bits & DL_EXCLUDE_USER_DATA)
+		    && isAnon(pagep->mapping)) {
+			pe = &pfn_list[in_pfn_list++];
+			pe->pfn = pfn;
+			pe->order = 0; /* assume 4k */
+			rep.pfn_user++;
+		}
+
+	}
+	rep.in_pfn_list = in_pfn_list;
+	if (copy_to_user(reqp->reply_ptr, &rep, sizeof(struct pfn_reply)))
+		return -EFAULT;
+	if (in_pfn_list) {
+		if (copy_to_user(reqp->pfn_list_ptr, pfn_list,
+				(in_pfn_list * sizeof(struct pfn_element))))
+			return -EFAULT;
+	}
+        return 0;
+}
+
+static ssize_t write_vmcore_pfn_lists(struct file *file,
+	const char __user *user_buf, size_t count, loff_t *ppos)
+{
+	int ret;
+	struct pfn_list_request pfn_list_request;
+
+	if (count != sizeof(struct pfn_list_request)) {
+                return -EINVAL;
+	}
+
+        if (copy_from_user(&pfn_list_request, user_buf, count))
+                return -EFAULT;
+
+	if (pfn_list_request.request == PL_REQUEST_FREE) {
+		ret = write_vmcore_get_free(&pfn_list_request);
+	} else if (pfn_list_request.request == PL_REQUEST_EXCLUDE) {
+		ret = write_vmcore_get_excludes(&pfn_list_request);
+	} else if (pfn_list_request.request == PL_REQUEST_MEMMAP) {
+		ret = write_vmcore_get_memmap(&pfn_list_request);
+	} else {
+                return -EINVAL;
+	}
+
+	if (ret)
+		return ret;
+        return count;
+}
+
+
 static const struct file_operations proc_vmcore_operations = {
 	.read		= read_vmcore,
 	.llseek		= default_llseek,
 };
 
+static const struct file_operations proc_vmcore_pfn_lists_operations = {
+	.write		= write_vmcore_pfn_lists,
+};
+
 static struct vmcore* __init get_new_element(void)
 {
 	return kzalloc(sizeof(struct vmcore), GFP_KERNEL);
@@ -697,6 +1251,10 @@ static int __init vmcore_init(void)
 	proc_vmcore = proc_create("vmcore", S_IRUSR, NULL, &proc_vmcore_operations);
 	if (proc_vmcore)
 		proc_vmcore->size = vmcore_size;
+
+	proc_vmcore_pfn_lists = proc_create("vmcore_pfn_lists", S_IWUSR, NULL,
+					&proc_vmcore_pfn_lists_operations);
+
 	return 0;
 }
 module_init(vmcore_init)
Index: linux/include/linux/makedumpfile.h
===================================================================
--- /dev/null
+++ linux/include/linux/makedumpfile.h
@@ -0,0 +1,115 @@
+/*
+ * makedumpfile.h
+ * portions Copyright (C) 2006, 2007, 2008, 2009  NEC Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#define isLRU(flags)		(flags & (1UL << PG_lru))
+#define isPrivate(flags)	(flags & (1UL << PG_private))
+#define isSwapCache(flags)	(flags & (1UL << PG_swapcache))
+
+static inline int
+isAnon(struct address_space *mapping)
+{
+	return ((unsigned long)mapping & PAGE_MAPPING_ANON) != 0;
+}
+
+#define DL_EXCLUDE_ZERO		(0x001) /* Exclude Pages filled with Zeros */
+#define DL_EXCLUDE_CACHE	(0x002) /* Exclude Cache Pages
+				           without Private Pages */
+#define DL_EXCLUDE_CACHE_PRI	(0x004) /* Exclude Cache Pages
+				           with Private Pages */
+#define DL_EXCLUDE_USER_DATA	(0x008) /* Exclude UserProcessData Pages */
+#define DL_EXCLUDE_FREE		(0x010)	/* Exclude Free Pages */
+
+#define PL_REQUEST_FREE		1	/* request for a list of free pages */
+#define PL_REQUEST_EXCLUDE	2	/* request for a list of excludable
+					   pages */
+#define PL_REQUEST_MEMMAP	3	/* request to pass in the makedumpfile
+					   mem_map_data table */
+/*
+ * a request for finding pfn's that can be excluded from the dump
+ * they may be pages of particular types or free pages
+ */
+struct pfn_list_request {
+	int request;		/* PL_REQUEST_FREE PL_REQUEST_EXCLUDE or */
+				/* PL_REQUEST_MEMMAP */
+	int debug;
+	unsigned long paddr;	/* mem_map address for PL_REQUEST_EXCLUDE */
+	unsigned long pfn_start;/* pfn represented by paddr */
+	unsigned long pgdat_paddr; /* for PL_REQUEST_FREE */
+	unsigned long pgdat_vaddr; /* for PL_REQUEST_FREE */
+	int node;		/* for PL_REQUEST_FREE */
+	int exclude_bits;	/* for PL_REQUEST_EXCLUDE */
+	int count;		/* for PL_REQUEST_EXCLUDE */
+	void *reply_ptr;	/* address of user's pfn_reply, for reply */
+	void *pfn_list_ptr;	/* address of user's pfn array (*pfn_list) */
+	int map_count;		/* for PL_REQUEST_MEMMAP; elements */
+	int map_size;		/* for PL_REQUEST_MEMMAP; bytes in table */
+	void *map_ptr;		/* for PL_REQUEST_MEMMAP; address of table */
+	long list_size;		/* for PL_REQUEST_MEMMAP negotiation */
+	/* resume info: */
+	int more;		/* 0 for done, 1 for "there's more" */
+				/* PL_REQUEST_EXCLUDE: */
+	int map_index;		/* slot in the mem_map array of page structs */
+				/* PL_REQUEST_FREE: */
+	int zone_index;		/* zone within the node's pgdat_list */
+	int freearea_index;	/* free_area within the zone */
+	int type_index;		/* free_list within the free_area */
+	int list_ct;		/* page within the list */
+};
+
+/*
+ * the reply from a pfn_list_request
+ * the list of pfn's itself is pointed to by pfn_list
+ */
+struct pfn_reply {
+	long pfn_list_elements;	/* negotiated on PL_REQUEST_MEMMAP */
+	long in_pfn_list;	/* returned by PL_REQUEST_EXCLUDE and
+				   PL_REQUEST_FREE */
+	/* resume info */
+	int more;		/* 0 == done, 1 == there is more */
+				/* PL_REQUEST_MEMMAP: */
+	int map_index;		/* slot in the mem_map array of page structs */
+				/* PL_REQUEST_FREE: */
+	int zone_index;		/* zone within the node's pgdat_list */
+	int freearea_index;	/* free_area within the zone */
+	int type_index;		/* free_list within the free_area */
+	int list_ct;		/* page within the list */
+	/* statistic counters: */
+	unsigned long long pfn_cache;		/* PL_REQUEST_EXCLUDE */
+	unsigned long long pfn_cache_private;	/* PL_REQUEST_EXCLUDE */
+	unsigned long long pfn_user;		/* PL_REQUEST_EXCLUDE */
+	unsigned long long pfn_free;		/* PL_REQUEST_FREE */
+};
+
+struct pfn_element {
+        unsigned long pfn;
+        unsigned long order;
+};
+
+struct mem_map_data {
+	/*
+	 * pfn_start/pfn_end are the pfn's represented by this mem_map entry.
+	 * mem_map is the virtual address of the array of page structures
+	 * that represent this pages.
+	 * paddr is the physical address of that array of structures.
+	 * ending_paddr would be (pfn_end - pfn_start) * sizeof(struct page).
+	 * section_vaddr is the address we get from ioremap_cache().
+	 */
+	unsigned long long	pfn_start;
+	unsigned long long	pfn_end;
+	unsigned long		mem_map;
+	unsigned long long	paddr;		/* filled in by makedumpfile */
+	unsigned long long	ending_paddr;	/* filled in by kernel */
+	void 			*section_vaddr;	/* filled in by kernel */
+};

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
