Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay3.sgi.com ([192.48.152.1] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TvX81-00029m-22
 for kexec@lists.infradead.org; Wed, 16 Jan 2013 17:50:28 +0000
Date: Wed, 16 Jan 2013 11:50:17 -0600
From: Cliff Wickman <cpw@sgi.com>
Subject: Re: [PATCH v2] makedumpfile: request the kernel do page scans
Message-ID: <20130116175017.GA4867@sgi.com>
References: <E1TrA0E-0001Ov-Pe@eag09.americas.sgi.com>
 <1358338529.13097.987.camel@lisamlinux.fc.hp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <1358338529.13097.987.camel@lisamlinux.fc.hp.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Lisa Mitchell <lisa.mitchell@hp.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kumagai-atsushi@mxc.nes.nec.co.jp" <kumagai-atsushi@mxc.nes.nec.co.jp>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> 
> Cliff I tried your patch above on makedumpfile v1.5.1 (built dynamically
> on the same DL980 I was running the test on), with all the RHEL 6
> versions of kernel patches you gave me from 1207 plus the kernel patch
> to kexec recommended for makedumpfile v1.5.1 built on top of a
> preliminary RHEL 6.4 kernel source (higher patch level of 2.6.32
> kernel), this time on a 1 TB Memory system (We have lost access to a 4
> TB Memory system for some time, now). On this same system, regular
> Makedumpfile v1.5.1 worked fine to produce a dump. But the Makedumpfile
> with the patches above could not even start the dump, and printed:
> 
> Saving vmcore-dmesg.txt
> Saved vmcore-dmesg.txt
> PL_REQUEST_MEMMAP returned -1
> Restarting system.
> 
> This happened with both a crashkernel size=200M that would have invoked
> cyclic buffer mode, and also with a larger one, 384M that should not
> have needed cyclic mode.  I had no cyclic buffer mode set or turned off
> in the makedumpfile command line, just recording memory usage with:
> 
> core_collector makedumpfile -c --message-level 31 -d 31
> debug_mem_level 2
> 
> 
>  ret = write(pfn_list_fd, &request, sizeof(request));
>         if (ret < 0) {
>                 fprintf(stderr, "PL_REQUEST_MEMMAP returned %d\n", ret);
>                 return FALSE;
> 
> Any ideas what probably caused this? Am I missing a patch?  Do I have
> the wrong kernel patches? Tips to debug?

Hi Lisa,

  It looks like you are using the right patches.
  I have a couple for a rhel 2.6.32 kernel that are a bit newer, but the
  differences look trivial.  I'll attach them.

  If the PL_REQUEST_MEMMAP call fails there should be a message in the
  log.

  The helpful thing is to bring the crash kernel up to multiuser mode
  so that you can run makedumpfile several ways if necessary and see the
  log with dmesg.
  (on a 3.0.13 sles kernel I can even network from the crash kernel and
   so fetch test versions of makedumpfile.  but on a 2.6.32 rhel kernel
   I can't network)

  In /etc/init.d/kdump
    might have to do this if your kernel does not have a proper 'minor number:
    min=279
    stick that after the last min=

  In /sbin/mkdumprd
      if [ -z "$DEFAULT_ACTION" ];then
              DEFAULT_ACTION="reboot"
              #FINAL_ACTION="reboot -f"
              FINAL_ACTION="echo 'do not exit this shell!!'; /bin/sh"
      fi

  and

       emit "  load_selinux_policy /mnt"
       make_trace_mem "  Before dumping vmcore" 1:shortmem 2+:mem 3+:slab
       # Save vmcore-dmesg
       emit "  DMESG_PATH=/mnt/$SAVE_PATH/127.0.0.1-\$DATE/"
       emit "  save_vmcore_dmesg_fs ${DMESG_COLLECTOR} \${DMESG_PATH}"
       # Save vmcore
    replace these two:
       # emit "  $CORE_COLLECTOR /proc/vmcore \$VMCORE-incomplete >/dev/null"
       # emit "  exitcode=\$?"
       emit "  exitcode=1"

   and when the crash kernel comes up to the shell prompt I am in the
   wrong root, so I have to, for example, mount /dev/sda6 /mnt
   Then my test scripts are under /mnt.

  If anyone knows how to bring up a 2.6.32 crash kernel to full multiuser
  mode I would like to know how you did it.  It's a pain to have to reboot
  to try a new makedumpfile command.

  On a 3.0.13 sles kernel I do this:
   In /etc/sysconfig/kdump
           KDUMP_SAVEDIR="file:///fubar"
           KDUMP_IMMEDIATE_REBOOT="no"
   In /lib/mkinitrd/boot/91-kdump.sh
     near save_dump
     comment out the kdumptool
     do   ls /root/xxxxy  to generate an error

   When the crash kernel gets to the shell prompt:
   exit
   and it boots to multi-user mode 

   I'll attach both the 2.6.32 patches (rhel) and 3.0.13 ones (sles).
  
-Cliff
 
> I am attaching the Kernel patches you sent me earlier that I used, on
> top of:
> 
> https://lkml.org/lkml/2012/11/21/90  with the tweak for RHEL 2.6.32
> kernels below applied on top of it:
> 
> NOTE: The patch above is for latest kernel. So you need to fix it as
>       below if your kernel version is between v2.6.18 and v2.6.37:
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 511151b..56583a4 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1490,7 +1490,6 @@ static int __init crash_save_vmcoreinfo_init(void)
> 	VMCOREINFO_OFFSET(page, flags);
> 	VMCOREINFO_OFFSET(page, _count);
> 	VMCOREINFO_OFFSET(page, mapping);
> -	VMCOREINFO_OFFSET(page, _mapcount);
> 	VMCOREINFO_OFFSET(page, private);
> 	VMCOREINFO_OFFSET(page, lru);
> 	VMCOREINFO_OFFSET(pglist_data, node_zones);
> @@ -1515,8 +1514,7 @@ static int __init crash_save_vmcoreinfo_init(void)
> 	VMCOREINFO_NUMBER(PG_lru);
> 	VMCOREINFO_NUMBER(PG_private);
> 	VMCOREINFO_NUMBER(PG_swapcache);
> -	VMCOREINFO_NUMBER(PG_slab);
> -	VMCOREINFO_NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE);
> +	VMCOREINFO_NUMBER(PG_buddy);
> 
> 	arch_crash_save_vmcoreinfo();
> 	update_vmcoreinfo_note();
> 
> 

-- 
Cliff Wickman
SGI
cpw@sgi.com
(651) 683-3824

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="130102.vmcore_pagescans.rhel"

Subject: [PATCH] scan page tables for makedumpfile

This is for a 2.6.32-based kernel (rhel6.4)
Note the use of PG_buddy.

Signed-off-by: Cliff Wickman <cpw@sgi.com>

---
 fs/proc/vmcore.c             |  687 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/makedumpfile.h |  117 +++++++
 2 files changed, 802 insertions(+), 2 deletions(-)

Index: linux/fs/proc/vmcore.c
===================================================================
--- linux.orig/fs/proc/vmcore.c
+++ linux/fs/proc/vmcore.c
@@ -17,8 +17,21 @@
 #include <linux/init.h>
 #include <linux/crash_dump.h>
 #include <linux/list.h>
+#include <linux/makedumpfile.h>
+#include <linux/mmzone.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
+#include <asm/page.h>
+#include <asm/pgtable_types.h>
+#include <asm/tlbflush.h>
+static int num_mem_map_data;
+static struct mem_map_data *mem_map_data;
+static struct pfn_element *pfn_list;
+static long in_pfn_list;
+static int last_found_vaddr;
+static int last_found_paddr;
+static int max_pfn_list;
+static void *vm_vaddr;
 
 /* List representing chunks of contiguous memory areas and their offsets in
  * vmcore file.
@@ -32,7 +45,8 @@ static size_t elfcorebuf_sz;
 /* Total size of vmcore file. */
 static u64 vmcore_size;
 
-static struct proc_dir_entry *proc_vmcore = NULL;
+static struct proc_dir_entry *proc_vmcore;
+static struct proc_dir_entry *proc_vmcore_pfn_lists;
 
 /* Reads a page from the oldmem device from given offset. */
 static ssize_t read_from_oldmem(char *buf, size_t count,
@@ -126,7 +140,7 @@ static ssize_t read_vmcore(struct file *
 
 	start = map_offset_to_paddr(*fpos, &vmcore_list, &curr_m);
 	if (!curr_m)
-        	return -EINVAL;
+		return -EINVAL;
 	if ((tsz = (PAGE_SIZE - (start & ~PAGE_MASK))) > buflen)
 		tsz = buflen;
 
@@ -160,8 +174,673 @@ static ssize_t read_vmcore(struct file *
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
+	unsigned long local_vaddr;
+	unsigned long offset;
+
+	if (!num_mem_map_data) {
+		printk(KERN_ERR "find_page_vaddr !! num_mem_map_data is %d\n",
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
+				fnd++;
+				/* caching gives about 99% hit on first pass */
+				last_found_vaddr = i;
+				break;
+			}
+		}
+	}
+
+	if (!fnd) {
+		if (last_found_vaddr > 0) {
+			last_found_vaddr = 0;
+			goto fullsearch;
+		}
+		return 0;
+	}
+
+	/* and offset is the offset into the found section */
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
+		printk(KERN_ERR "find_page_paddr !! num_mem_map_data is %d\n",
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
+		printk(KERN_ERR "root is null!!, node %d order %d\n",
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
+	if (!local_lhp)
+		return 0;
+
+	while (local_lhp != boot_root) {
+		list_ct++;
+		if (lhp == NULL) {
+			printk(KERN_ERR
+			 "The free list has a null!!, node %d order %d\n",
+				node, order);
+			break;
+		}
+		if (list_ct > 1 && local_lhp->prev != prev) {
+			/* can't be compared to root, as that is local */
+			printk(KERN_ERR "The free list is broken!!\n");
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
+				/* if array would overflow, come back to
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
+		printk(KERN_ERR "ioremap_cache of pgdat %#lx failed\n",
+				page_aligned_pgdat);
+		return -EINVAL;
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
+						((unsigned long)flp -
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
+ * map a range of page structures into the kernel page table using huge pages.
+ * return the virtual address to which they were mapped
+ * local virtual is the base of the single global region this is to be mapped to
+ */
+void *
+direct_map(int index, unsigned long local_virtual, struct mem_map_data *mmd)
+{
+	unsigned long paddr = mmd->paddr;
+	unsigned long ret_vaddr;
+	unsigned long size;
+	unsigned long va;
+	unsigned long hpagesize = 0x200000UL;
+	int i;
+	pgd_t *pgd, *base = swapper_pg_dir;
+	pud_t *pud;
+	pmd_t *pmd;
+	/* cached is a GREAT deal faster than uncached */
+	pgprot_t prot = PAGE_KERNEL_LARGE;
+
+	paddr = mmd->paddr;
+
+	va = local_virtual + mmd->virtual_offset;
+	size = mmd->mapped_size;
+	mmd->section_vaddr = (void *)va; /* for the unmap */
+	/* return the virtual address that the paddr corresponds to */
+	ret_vaddr = va;
+
+	for (i = 0; size;
+		i++, paddr += hpagesize, size -= hpagesize, va += hpagesize) {
+		pgd = base + pgd_index(va);
+		if (!pgd_present(*pgd)) {
+			pud = (pud_t *)get_zeroed_page(GFP_ATOMIC);
+			set_pgd(pgd, __pgd(__pa(pud) | _KERNPG_TABLE));
+		}
+		pud = pud_offset(pgd, va);
+		if (!pud_present(*pud)) {
+			pmd = (pmd_t *)get_zeroed_page(GFP_ATOMIC);
+			set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
+		}
+		pmd = pmd_offset(pud, va);
+		set_pmd(pmd, __pmd(paddr | pgprot_val(prot)));
+		if (size < hpagesize)
+			break;
+	}
+	__flush_tlb_all();
+
+	return (void *)ret_vaddr;
+}
+
+/*
+ * remove mappings of a range of page structures from the kernel page table
+ */
+void
+direct_unmap(struct mem_map_data *mmd)
+{
+	unsigned long va = (unsigned long)mmd->section_vaddr;
+	unsigned long size = mmd->mapped_size;
+	unsigned long hpagesize = 0x200000UL;
+	pgd_t *pgd, *base = swapper_pg_dir;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	for (; size; size -= hpagesize, va += hpagesize) {
+		pgd = base + pgd_index(va);
+		pud = pud_offset(pgd, va);
+		pmd = pmd_offset(pud, va);
+		pmd_clear(pmd);
+		if (size < hpagesize)
+			break;
+	}
+
+	return;
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
+	int ret = 0;
+	int node;
+	unsigned long hpagesize = 0x200000UL;
+	unsigned long hpagemask = 0xffffffffffe00000UL;
+	unsigned long size;
+	unsigned long local_virtual;
+	long pfn_list_elements;
+	long malloc_size;
+	unsigned long page_section_size;
+	unsigned long low_virtual;
+	unsigned long high_virtual;
+	struct mem_map_data *mmd, *dum_mmd;
+	struct pfn_reply rep;
+	void *bufptr;
+	struct vm_struct *vm;
+
+	rep.pfn_list_elements = 0;
+	if (num_mem_map_data) {
+		/* shouldn't have been done before, but if it was.. */
+		printk(KERN_INFO "warning: PL_REQUEST_MEMMAP is repeated\n");
+		for (i = 0, mmd = mem_map_data; i < num_mem_map_data;
+								i++, mmd++) {
+			direct_unmap(mmd);
+		}
+		vunmap(vm_vaddr);
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
+		printk(KERN_ERR "Error in mem_map_data, %d * %ld != %ld\n",
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
+		printk(KERN_ERR "kmalloc of mem_map_data for %ld failed\n",
+			size);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (copy_from_user(mem_map_data, bufptr, size)) {
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
+	/* Fill in the size and ending address of array of page struct */
+	for (i = 0, mmd = mem_map_data; i < num_mem_map_data; i++, mmd++) {
+		mmd->mapped_size =
+			((mmd->pfn_end - mmd->pfn_start) * sizeof(struct page));
+		mmd->ending_paddr = mmd->paddr + mmd->mapped_size;
+		if (mmd->pfn_end < mmd->pfn_start) {
+			printk(KERN_ERR "reversed start/end %#llx %#llx\n",
+				mmd->pfn_start, mmd->pfn_end);
+			ret = -EINVAL;
+		}
+	}
+
+	/*
+	 * Map each section of page structures to the single local virtual
+	 * address range.
+	 */
+	mmd = mem_map_data;
+	low_virtual = mmd->mem_map;
+	high_virtual = 0;
+	for (i = 0, mmd = mem_map_data; i < num_mem_map_data; i++, mmd++) {
+		if (mmd->mem_map + mmd->mapped_size > high_virtual)
+			high_virtual = mmd->mem_map + mmd->mapped_size;
+		mmd->virtual_offset = mmd->mem_map - low_virtual;
+	}
+
+	node = numa_node_id();
+
+	size = high_virtual - low_virtual;
+	/* add an extra virtual space for huge page alignment */
+	size += hpagesize;
+	/* round to full huge pages */
+	size = (size + hpagesize - 1) & hpagemask;
+
+	vm = __get_vm_area(size + hpagesize, VM_IOREMAP, VMALLOC_START,
+								VMALLOC_END);
+	if (!vm)
+		ret = -EINVAL;
+	vm_vaddr = vm->addr; /* for the vunmap */
+
+	/* map starting at a huge page boundary */
+	local_virtual = ((unsigned long)vm->addr + hpagesize - 1) & hpagemask;
+
+	if (low_virtual < (unsigned long)vm->addr)
+		ret = -EINVAL;
+
+	for (i = 0, mmd = mem_map_data; i < num_mem_map_data; i++, mmd++) {
+		mmd->section_vaddr = direct_map(i, local_virtual, mmd);
+		if (!mmd->section_vaddr) {
+			printk(KERN_ERR
+				"direct_map of [%d] %#lx for %#lx failed\n",
+				i, mmd->mem_map, mmd->mapped_size);
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
+		pfn_list = kmalloc(malloc_size, GFP_KERNEL);
+		if (pfn_list != NULL) {
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
+		printk(KERN_ERR
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
+		printk(KERN_ERR
+			"ERROR: PL_REQUEST_EXCLUDE cannot find paddr %#lx\n",
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
+			rep.in_pfn_list = in_pfn_list;
+			rep.more = 1;
+			rep.map_index = i;
+			break;
+		}
+		/*
+		 * Exclude the free page managed by a buddy
+		 */
+		if ((reqp->exclude_bits & DL_EXCLUDE_FREE)
+		    && (pagep->flags & (1UL << PG_buddy))) {
+			pe = &pfn_list[in_pfn_list++];
+			pe->pfn = pfn;
+			pe->order = pagep->private;
+			rep.pfn_free += (1 << pe->order);
+		}
+		/*
+		 * Exclude the cache page without the private page.
+		 */
+		else if ((reqp->exclude_bits & DL_EXCLUDE_CACHE)
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
+	return 0;
+}
+
+static ssize_t write_vmcore_pfn_lists(struct file *file,
+	const char __user *user_buf, size_t count, loff_t *ppos)
+{
+	int ret;
+	struct pfn_list_request pfn_list_request;
+
+	if (count != sizeof(struct pfn_list_request))
+		return -EINVAL;
+
+	if (copy_from_user(&pfn_list_request, user_buf, count))
+		return -EFAULT;
+
+	if (pfn_list_request.request == PL_REQUEST_FREE)
+		ret = write_vmcore_get_free(&pfn_list_request);
+	else if (pfn_list_request.request == PL_REQUEST_EXCLUDE)
+		ret = write_vmcore_get_excludes(&pfn_list_request);
+	else if (pfn_list_request.request == PL_REQUEST_MEMMAP)
+		ret = write_vmcore_get_memmap(&pfn_list_request);
+	else
+		return -EINVAL;
+
+	if (ret)
+		return ret;
+	return count;
+}
+
+static const struct file_operations proc_vmcore_pfn_lists_operations = {
+	.write		= write_vmcore_pfn_lists,
+};
+
 static const struct file_operations proc_vmcore_operations = {
 	.read		= read_vmcore,
+	.llseek		= default_llseek,
 };
 
 static struct vmcore* __init get_new_element(void)
@@ -648,6 +1327,10 @@ static int __init vmcore_init(void)
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
@@ -0,0 +1,117 @@
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
+					   without Private Pages */
+#define DL_EXCLUDE_CACHE_PRI	(0x004) /* Exclude Cache Pages
+					   with Private Pages */
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
+	unsigned long pfn;
+	unsigned long order;
+};
+
+struct mem_map_data {
+	/*
+	 * pfn_start/pfn_end are the pfn's represented by this mem_map entry.
+	 * mem_map is the virtual address of the array of page structures
+	 * that represent these pages.
+	 * paddr is the physical address of that array of structures.
+	 * ending_paddr would be (pfn_end - pfn_start) * sizeof(struct page).
+	 * section_vaddr is the address we get from ioremap_cache().
+	 */
+	unsigned long long	pfn_start;
+	unsigned long long	pfn_end;
+	unsigned long		mem_map;
+	unsigned long long	paddr;		/* filled in by makedumpfile */
+	long			virtual_offset; /* filled in by kernel */
+	unsigned long long	ending_paddr;	/* filled in by kernel */
+	unsigned long		mapped_size;	/* filled in by kernel */
+	void			*section_vaddr;	/* filled in by kernel */
+};

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="130111.read_pages_kernel.rhel"

---
 fs/proc/vmcore.c             |  101 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/makedumpfile.h |    4 +
 2 files changed, 98 insertions(+), 7 deletions(-)

Index: linux/fs/proc/vmcore.c
===================================================================
--- linux.orig/fs/proc/vmcore.c
+++ linux/fs/proc/vmcore.c
@@ -32,6 +32,10 @@ static int last_found_vaddr;
 static int last_found_paddr;
 static int max_pfn_list;
 static void *vm_vaddr;
+static void *page_vm_vaddr;
+static unsigned long current_pfn_start;
+static unsigned long current_pfn_end;
+static void *current_hpage_vaddr;
 
 /* List representing chunks of contiguous memory areas and their offsets in
  * vmcore file.
@@ -469,7 +473,7 @@ list_full:
  * local virtual is the base of the single global region this is to be mapped to
  */
 void *
-direct_map(int index, unsigned long local_virtual, struct mem_map_data *mmd)
+direct_map(unsigned long local_virtual, struct mem_map_data *mmd)
 {
 	unsigned long paddr = mmd->paddr;
 	unsigned long ret_vaddr;
@@ -483,8 +487,6 @@ direct_map(int index, unsigned long loca
 	/* cached is a GREAT deal faster than uncached */
 	pgprot_t prot = PAGE_KERNEL_LARGE;
 
-	paddr = mmd->paddr;
-
 	va = local_virtual + mmd->virtual_offset;
 	size = mmd->mapped_size;
 	mmd->section_vaddr = (void *)va; /* for the unmap */
@@ -539,6 +541,88 @@ direct_unmap(struct mem_map_data *mmd)
 }
 
 /*
+ * Read a page of boot kernel memory.
+ */
+int
+write_vmcore_read_page(struct pfn_list_request *reqp)
+{
+	int ret = 0;
+	unsigned long hpagesize = 0x200000UL;
+	unsigned long hpagemask = 0xffffffffffe00000UL;
+	unsigned long pfn;
+	unsigned long paddr;
+	unsigned long hpage_paddr;
+	struct pfn_reply rep;
+	struct vm_struct *vm;
+	struct mem_map_data memmap_local;
+	void *bufptr;
+	void *vaddr;
+	void *page_vaddr;
+
+	rep.status = 0;
+	pfn = reqp->req_pfn;
+	bufptr = reqp->buf_ptr;
+
+	if (current_hpage_vaddr == 0) { /* only once */
+		vm = __get_vm_area(2 * hpagesize, VM_IOREMAP, VMALLOC_START,
+								VMALLOC_END);
+		if (!vm) {
+			ret = -EINVAL;
+			rep.status = 1;
+			goto out;
+		}
+		page_vm_vaddr = vm->addr; /* for the vunmap */
+		/* use the huge page area of the virtual space */
+		current_hpage_vaddr = (void *)
+			(((unsigned long)vm->addr + hpagesize - 1) & hpagemask);
+	}
+
+	/*
+	 * If the requested pfn is not mapped to the current huge page,
+	 * remove the old mapping and map it in.
+	 * current_pfn_start/current_pfn_end are mapped in the current
+	 * huge page.
+	 */
+	if (pfn < current_pfn_start || pfn >= current_pfn_end) {
+		memmap_local.section_vaddr = current_hpage_vaddr;
+		memmap_local.mapped_size = hpagesize;
+		direct_unmap(&memmap_local);
+
+		paddr = pfn << PAGE_SHIFT;
+		hpage_paddr = paddr & hpagemask;
+		current_pfn_start = hpage_paddr >> PAGE_SHIFT;
+		current_pfn_end = current_pfn_start + (hpagesize / PAGE_SIZE);
+
+		memmap_local.paddr = hpage_paddr;
+		memmap_local.virtual_offset = 0;
+		vaddr = direct_map((unsigned long)current_hpage_vaddr,
+								&memmap_local);
+		if (!vaddr || vaddr != current_hpage_vaddr) {
+			printk(KERN_ERR
+			     "direct_map of paddr %#llx to vaddr %p failed\n",
+				memmap_local.paddr, current_hpage_vaddr);
+			ret = -EINVAL;
+			rep.status = 1;
+			goto out;
+		}
+	}
+	/* calculate the virtual address of the requested pfn */
+	page_vaddr = (void *)(((pfn - current_pfn_start) * PAGE_SIZE) +
+					(unsigned long)current_hpage_vaddr);
+
+	/* copy the page itself */
+	if (copy_to_user(bufptr, page_vaddr, PAGE_SIZE)) {
+		ret = -EFAULT;
+		rep.status = 1;
+	}
+
+out:
+	if (copy_to_user(reqp->reply_ptr, &rep, sizeof(struct pfn_reply)))
+		return -EFAULT;
+	return ret;
+}
+
+/*
  * Get the memap_data table from makedumpfile
  * and do the single allocate of the pfn_list.
  */
@@ -548,7 +632,6 @@ write_vmcore_get_memmap(struct pfn_list_
 	int i;
 	int count;
 	int ret = 0;
-	int node;
 	unsigned long hpagesize = 0x200000UL;
 	unsigned long hpagemask = 0xffffffffffe00000UL;
 	unsigned long size;
@@ -572,11 +655,15 @@ write_vmcore_get_memmap(struct pfn_list_
 			direct_unmap(mmd);
 		}
 		vunmap(vm_vaddr);
+		current_hpage_vaddr = 0;
 		kfree(mem_map_data);
 		mem_map_data = NULL;
 		num_mem_map_data = 0;
 		kfree(pfn_list);
 		pfn_list = NULL;
+		vunmap(page_vm_vaddr);
+		current_pfn_start = 0;
+		current_pfn_end = 0;
 	}
 
 	count = reqp->map_count;
@@ -641,8 +728,6 @@ write_vmcore_get_memmap(struct pfn_list_
 		mmd->virtual_offset = mmd->mem_map - low_virtual;
 	}
 
-	node = numa_node_id();
-
 	size = high_virtual - low_virtual;
 	/* add an extra virtual space for huge page alignment */
 	size += hpagesize;
@@ -662,7 +747,7 @@ write_vmcore_get_memmap(struct pfn_list_
 		ret = -EINVAL;
 
 	for (i = 0, mmd = mem_map_data; i < num_mem_map_data; i++, mmd++) {
-		mmd->section_vaddr = direct_map(i, local_virtual, mmd);
+		mmd->section_vaddr = direct_map(local_virtual, mmd);
 		if (!mmd->section_vaddr) {
 			printk(KERN_ERR
 				"direct_map of [%d] %#lx for %#lx failed\n",
@@ -826,6 +911,8 @@ static ssize_t write_vmcore_pfn_lists(st
 		ret = write_vmcore_get_excludes(&pfn_list_request);
 	else if (pfn_list_request.request == PL_REQUEST_MEMMAP)
 		ret = write_vmcore_get_memmap(&pfn_list_request);
+	else if (pfn_list_request.request == PL_REQUEST_PAGE)
+		ret = write_vmcore_read_page(&pfn_list_request);
 	else
 		return -EINVAL;
 
Index: linux/include/linux/makedumpfile.h
===================================================================
--- linux.orig/include/linux/makedumpfile.h
+++ linux/include/linux/makedumpfile.h
@@ -36,6 +36,7 @@ isAnon(struct address_space *mapping)
 					   pages */
 #define PL_REQUEST_MEMMAP	3	/* request to pass in the makedumpfile
 					   mem_map_data table */
+#define PL_REQUEST_PAGE		4	/* request a page of data */
 /*
  * a request for finding pfn's that can be excluded from the dump
  * they may be pages of particular types or free pages
@@ -57,6 +58,8 @@ struct pfn_list_request {
 	int map_size;		/* for PL_REQUEST_MEMMAP; bytes in table */
 	void *map_ptr;		/* for PL_REQUEST_MEMMAP; address of table */
 	long list_size;		/* for PL_REQUEST_MEMMAP negotiation */
+	unsigned long req_pfn;	/* PL_REQUEST_PAGE; requested pfn */
+        void *buf_ptr;          /* PL_REQUEST_PAGE; page buffer */
 	/* resume info: */
 	int more;		/* 0 for done, 1 for "there's more" */
 				/* PL_REQUEST_EXCLUDE: */
@@ -73,6 +76,7 @@ struct pfn_list_request {
  * the list of pfn's itself is pointed to by pfn_list
  */
 struct pfn_reply {
+	int status;		/* PL_REQUEST_PAGE returned status  0 is ok */
 	long pfn_list_elements;	/* negotiated on PL_REQUEST_MEMMAP */
 	long in_pfn_list;	/* returned by PL_REQUEST_EXCLUDE and
 				   PL_REQUEST_FREE */

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="130102.vmcore_pagescans.sles"

Subject: [PATCH] scan page tables for makedumpfile

This is for a 3.0.13 kernel (sles11sp2)
Note the use of PAGE_BUDDY_MAPCOUNT_VALUE.

Signed-off-by: Cliff Wickman <cpw@sgi.com>

---
 fs/proc/vmcore.c             |  688 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/makedumpfile.h |  117 +++++++
 2 files changed, 803 insertions(+), 2 deletions(-)

Index: linux/fs/proc/vmcore.c
===================================================================
--- linux.orig/fs/proc/vmcore.c
+++ linux/fs/proc/vmcore.c
@@ -18,8 +18,21 @@
 #include <linux/init.h>
 #include <linux/crash_dump.h>
 #include <linux/list.h>
+#include <linux/makedumpfile.h>
+#include <linux/mmzone.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
+#include <asm/page.h>
+#include <asm/pgtable_types.h>
+#include <asm/tlbflush.h>
+static int num_mem_map_data;
+static struct mem_map_data *mem_map_data;
+static struct pfn_element *pfn_list;
+static long in_pfn_list;
+static int last_found_vaddr;
+static int last_found_paddr;
+static int max_pfn_list;
+static void *vm_vaddr;
 
 /* List representing chunks of contiguous memory areas and their offsets in
  * vmcore file.
@@ -33,7 +46,8 @@ static size_t elfcorebuf_sz;
 /* Total size of vmcore file. */
 static u64 vmcore_size;
 
-static struct proc_dir_entry *proc_vmcore = NULL;
+static struct proc_dir_entry *proc_vmcore;
+static struct proc_dir_entry *proc_vmcore_pfn_lists;
 
 /*
  * Returns > 0 for RAM pages, 0 for non-RAM pages, < 0 on error
@@ -173,7 +187,7 @@ static ssize_t read_vmcore(struct file *
 
 	start = map_offset_to_paddr(*fpos, &vmcore_list, &curr_m);
 	if (!curr_m)
-        	return -EINVAL;
+		return -EINVAL;
 	if ((tsz = (PAGE_SIZE - (start & ~PAGE_MASK))) > buflen)
 		tsz = buflen;
 
@@ -207,6 +221,672 @@ static ssize_t read_vmcore(struct file *
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
+	unsigned long local_vaddr;
+	unsigned long offset;
+
+	if (!num_mem_map_data) {
+		printk(KERN_ERR "find_page_vaddr !! num_mem_map_data is %d\n",
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
+				fnd++;
+				/* caching gives about 99% hit on first pass */
+				last_found_vaddr = i;
+				break;
+			}
+		}
+	}
+
+	if (!fnd) {
+		if (last_found_vaddr > 0) {
+			last_found_vaddr = 0;
+			goto fullsearch;
+		}
+		return 0;
+	}
+
+	/* and offset is the offset into the found section */
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
+		printk(KERN_ERR "find_page_paddr !! num_mem_map_data is %d\n",
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
+		printk(KERN_ERR "root is null!!, node %d order %d\n",
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
+	if (!local_lhp)
+		return 0;
+
+	while (local_lhp != boot_root) {
+		list_ct++;
+		if (lhp == NULL) {
+			printk(KERN_ERR
+			 "The free list has a null!!, node %d order %d\n",
+				node, order);
+			break;
+		}
+		if (list_ct > 1 && local_lhp->prev != prev) {
+			/* can't be compared to root, as that is local */
+			printk(KERN_ERR "The free list is broken!!\n");
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
+				/* if array would overflow, come back to
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
+		printk(KERN_ERR "ioremap_cache of pgdat %#lx failed\n",
+				page_aligned_pgdat);
+		return -EINVAL;
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
+						((unsigned long)flp -
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
+ * map a range of page structures into the kernel page table using huge pages.
+ * return the virtual address to which they were mapped
+ * local virtual is the base of the single global region this is to be mapped to
+ */
+void *
+direct_map(int index, unsigned long local_virtual, struct mem_map_data *mmd)
+{
+	unsigned long paddr = mmd->paddr;
+	unsigned long ret_vaddr;
+	unsigned long size;
+	unsigned long va;
+	unsigned long hpagesize = 0x200000UL;
+	int i;
+	pgd_t *pgd, *base = swapper_pg_dir;
+	pud_t *pud;
+	pmd_t *pmd;
+	/* cached is a GREAT deal faster than uncached */
+	pgprot_t prot = PAGE_KERNEL_LARGE;
+
+	paddr = mmd->paddr;
+
+	va = local_virtual + mmd->virtual_offset;
+	size = mmd->mapped_size;
+	mmd->section_vaddr = (void *)va; /* for the unmap */
+	/* return the virtual address that the paddr corresponds to */
+	ret_vaddr = va;
+
+	for (i = 0; size;
+		i++, paddr += hpagesize, size -= hpagesize, va += hpagesize) {
+		pgd = base + pgd_index(va);
+		if (!pgd_present(*pgd)) {
+			pud = (pud_t *)get_zeroed_page(GFP_ATOMIC);
+			set_pgd(pgd, __pgd(__pa(pud) | _KERNPG_TABLE));
+		}
+		pud = pud_offset(pgd, va);
+		if (!pud_present(*pud)) {
+			pmd = (pmd_t *)get_zeroed_page(GFP_ATOMIC);
+			set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
+		}
+		pmd = pmd_offset(pud, va);
+		set_pmd(pmd, __pmd(paddr | pgprot_val(prot)));
+		if (size < hpagesize)
+			break;
+	}
+	__flush_tlb_all();
+
+	return (void *)ret_vaddr;
+}
+
+/*
+ * remove mappings of a range of page structures from the kernel page table
+ */
+void
+direct_unmap(struct mem_map_data *mmd)
+{
+	unsigned long va = (unsigned long)mmd->section_vaddr;
+	unsigned long size = mmd->mapped_size;
+	unsigned long hpagesize = 0x200000UL;
+	pgd_t *pgd, *base = swapper_pg_dir;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	for (; size; size -= hpagesize, va += hpagesize) {
+		pgd = base + pgd_index(va);
+		pud = pud_offset(pgd, va);
+		pmd = pmd_offset(pud, va);
+		pmd_clear(pmd);
+		if (size < hpagesize)
+			break;
+	}
+
+	return;
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
+	int ret = 0;
+	int node;
+	unsigned long hpagesize = 0x200000UL;
+	unsigned long hpagemask = 0xffffffffffe00000UL;
+	unsigned long size;
+	unsigned long local_virtual;
+	long pfn_list_elements;
+	long malloc_size;
+	unsigned long page_section_size;
+	unsigned long low_virtual;
+	unsigned long high_virtual;
+	struct mem_map_data *mmd, *dum_mmd;
+	struct pfn_reply rep;
+	void *bufptr;
+	struct vm_struct *vm;
+
+	rep.pfn_list_elements = 0;
+	if (num_mem_map_data) {
+		/* shouldn't have been done before, but if it was.. */
+		printk(KERN_INFO "warning: PL_REQUEST_MEMMAP is repeated\n");
+		for (i = 0, mmd = mem_map_data; i < num_mem_map_data;
+								i++, mmd++) {
+			direct_unmap(mmd);
+		}
+		vunmap(vm_vaddr);
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
+		printk(KERN_ERR "Error in mem_map_data, %d * %ld != %ld\n",
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
+		printk(KERN_ERR "kmalloc of mem_map_data for %ld failed\n",
+			size);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (copy_from_user(mem_map_data, bufptr, size)) {
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
+	/* Fill in the size and ending address of array of page struct */
+	for (i = 0, mmd = mem_map_data; i < num_mem_map_data; i++, mmd++) {
+		mmd->mapped_size =
+			((mmd->pfn_end - mmd->pfn_start) * sizeof(struct page));
+		mmd->ending_paddr = mmd->paddr + mmd->mapped_size;
+		if (mmd->pfn_end < mmd->pfn_start) {
+			printk(KERN_ERR "reversed start/end %#llx %#llx\n",
+				mmd->pfn_start, mmd->pfn_end);
+			ret = -EINVAL;
+		}
+	}
+
+	/*
+	 * Map each section of page structures to the single local virtual
+	 * address range.
+	 */
+	mmd = mem_map_data;
+	low_virtual = mmd->mem_map;
+	high_virtual = 0;
+	for (i = 0, mmd = mem_map_data; i < num_mem_map_data; i++, mmd++) {
+		if (mmd->mem_map + mmd->mapped_size > high_virtual)
+			high_virtual = mmd->mem_map + mmd->mapped_size;
+		mmd->virtual_offset = mmd->mem_map - low_virtual;
+	}
+
+	node = numa_node_id();
+
+	size = high_virtual - low_virtual;
+	/* add an extra virtual space for huge page alignment */
+	size += hpagesize;
+	/* round to full huge pages */
+	size = (size + hpagesize - 1) & hpagemask;
+
+	vm = __get_vm_area(size + hpagesize, VM_IOREMAP, VMALLOC_START,
+								VMALLOC_END);
+	if (!vm)
+		ret = -EINVAL;
+	vm_vaddr = vm->addr; /* for the vunmap */
+
+	/* map starting at a huge page boundary */
+	local_virtual = ((unsigned long)vm->addr + hpagesize - 1) & hpagemask;
+
+	if (low_virtual < (unsigned long)vm->addr)
+		ret = -EINVAL;
+
+	for (i = 0, mmd = mem_map_data; i < num_mem_map_data; i++, mmd++) {
+		mmd->section_vaddr = direct_map(i, local_virtual, mmd);
+		if (!mmd->section_vaddr) {
+			printk(KERN_ERR
+				"direct_map of [%d] %#lx for %#lx failed\n",
+				i, mmd->mem_map, mmd->mapped_size);
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
+		pfn_list = kmalloc(malloc_size, GFP_KERNEL);
+		if (pfn_list != NULL) {
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
+		printk(KERN_ERR
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
+		printk(KERN_ERR
+			"ERROR: PL_REQUEST_EXCLUDE cannot find paddr %#lx\n",
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
+			rep.in_pfn_list = in_pfn_list;
+			rep.more = 1;
+			rep.map_index = i;
+			break;
+		}
+		/*
+		 * Exclude the free page managed by a buddy
+		 */
+		if ((reqp->exclude_bits & DL_EXCLUDE_FREE)
+		    && ((pagep->flags & (1UL << PG_slab)) == 0)
+		    && (atomic_read(&pagep->_mapcount) ==
+					PAGE_BUDDY_MAPCOUNT_VALUE)) {
+			pe = &pfn_list[in_pfn_list++];
+			pe->pfn = pfn;
+			pe->order = pagep->private;
+			rep.pfn_free += (1 << pe->order);
+		}
+		/*
+		 * Exclude the cache page without the private page.
+		 */
+		else if ((reqp->exclude_bits & DL_EXCLUDE_CACHE)
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
+	return 0;
+}
+
+static ssize_t write_vmcore_pfn_lists(struct file *file,
+	const char __user *user_buf, size_t count, loff_t *ppos)
+{
+	int ret;
+	struct pfn_list_request pfn_list_request;
+
+	if (count != sizeof(struct pfn_list_request))
+		return -EINVAL;
+
+	if (copy_from_user(&pfn_list_request, user_buf, count))
+		return -EFAULT;
+
+	if (pfn_list_request.request == PL_REQUEST_FREE)
+		ret = write_vmcore_get_free(&pfn_list_request);
+	else if (pfn_list_request.request == PL_REQUEST_EXCLUDE)
+		ret = write_vmcore_get_excludes(&pfn_list_request);
+	else if (pfn_list_request.request == PL_REQUEST_MEMMAP)
+		ret = write_vmcore_get_memmap(&pfn_list_request);
+	else
+		return -EINVAL;
+
+	if (ret)
+		return ret;
+	return count;
+}
+
+static const struct file_operations proc_vmcore_pfn_lists_operations = {
+	.write		= write_vmcore_pfn_lists,
+};
+
 static const struct file_operations proc_vmcore_operations = {
 	.read		= read_vmcore,
 	.llseek		= default_llseek,
@@ -696,6 +1376,10 @@ static int __init vmcore_init(void)
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
@@ -0,0 +1,117 @@
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
+					   without Private Pages */
+#define DL_EXCLUDE_CACHE_PRI	(0x004) /* Exclude Cache Pages
+					   with Private Pages */
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
+	unsigned long pfn;
+	unsigned long order;
+};
+
+struct mem_map_data {
+	/*
+	 * pfn_start/pfn_end are the pfn's represented by this mem_map entry.
+	 * mem_map is the virtual address of the array of page structures
+	 * that represent these pages.
+	 * paddr is the physical address of that array of structures.
+	 * ending_paddr would be (pfn_end - pfn_start) * sizeof(struct page).
+	 * section_vaddr is the address we get from ioremap_cache().
+	 */
+	unsigned long long	pfn_start;
+	unsigned long long	pfn_end;
+	unsigned long		mem_map;
+	unsigned long long	paddr;		/* filled in by makedumpfile */
+	long			virtual_offset; /* filled in by kernel */
+	unsigned long long	ending_paddr;	/* filled in by kernel */
+	unsigned long		mapped_size;	/* filled in by kernel */
+	void			*section_vaddr;	/* filled in by kernel */
+};

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="130111.read_pages_kernel.sles"

---
 fs/proc/vmcore.c             |  101 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/makedumpfile.h |    4 +
 2 files changed, 98 insertions(+), 7 deletions(-)

Index: linux/fs/proc/vmcore.c
===================================================================
--- linux.orig/fs/proc/vmcore.c
+++ linux/fs/proc/vmcore.c
@@ -33,6 +33,10 @@ static int last_found_vaddr;
 static int last_found_paddr;
 static int max_pfn_list;
 static void *vm_vaddr;
+static void *page_vm_vaddr;
+static unsigned long current_pfn_start;
+static unsigned long current_pfn_end;
+static void *current_hpage_vaddr;
 
 /* List representing chunks of contiguous memory areas and their offsets in
  * vmcore file.
@@ -516,7 +520,7 @@ list_full:
  * local virtual is the base of the single global region this is to be mapped to
  */
 void *
-direct_map(int index, unsigned long local_virtual, struct mem_map_data *mmd)
+direct_map(unsigned long local_virtual, struct mem_map_data *mmd)
 {
 	unsigned long paddr = mmd->paddr;
 	unsigned long ret_vaddr;
@@ -530,8 +534,6 @@ direct_map(int index, unsigned long loca
 	/* cached is a GREAT deal faster than uncached */
 	pgprot_t prot = PAGE_KERNEL_LARGE;
 
-	paddr = mmd->paddr;
-
 	va = local_virtual + mmd->virtual_offset;
 	size = mmd->mapped_size;
 	mmd->section_vaddr = (void *)va; /* for the unmap */
@@ -586,6 +588,88 @@ direct_unmap(struct mem_map_data *mmd)
 }
 
 /*
+ * Read a page of boot kernel memory.
+ */
+int
+write_vmcore_read_page(struct pfn_list_request *reqp)
+{
+	int ret = 0;
+	unsigned long hpagesize = 0x200000UL;
+	unsigned long hpagemask = 0xffffffffffe00000UL;
+	unsigned long pfn;
+	unsigned long paddr;
+	unsigned long hpage_paddr;
+	struct pfn_reply rep;
+	struct vm_struct *vm;
+	struct mem_map_data memmap_local;
+	void *bufptr;
+	void *vaddr;
+	void *page_vaddr;
+
+	rep.status = 0;
+	pfn = reqp->req_pfn;
+	bufptr = reqp->buf_ptr;
+
+	if (current_hpage_vaddr == 0) { /* only once */
+		vm = __get_vm_area(2 * hpagesize, VM_IOREMAP, VMALLOC_START,
+								VMALLOC_END);
+		if (!vm) {
+			ret = -EINVAL;
+			rep.status = 1;
+			goto out;
+		}
+		page_vm_vaddr = vm->addr; /* for the vunmap */
+		/* use the huge page area of the virtual space */
+		current_hpage_vaddr = (void *)
+			(((unsigned long)vm->addr + hpagesize - 1) & hpagemask);
+	}
+
+	/*
+	 * If the requested pfn is not mapped to the current huge page,
+	 * remove the old mapping and map it in.
+	 * current_pfn_start/current_pfn_end are mapped in the current
+	 * huge page.
+	 */
+	if (pfn < current_pfn_start || pfn >= current_pfn_end) {
+		memmap_local.section_vaddr = current_hpage_vaddr;
+		memmap_local.mapped_size = hpagesize;
+		direct_unmap(&memmap_local);
+
+		paddr = pfn << PAGE_SHIFT;
+		hpage_paddr = paddr & hpagemask;
+		current_pfn_start = hpage_paddr >> PAGE_SHIFT;
+		current_pfn_end = current_pfn_start + (hpagesize / PAGE_SIZE);
+
+		memmap_local.paddr = hpage_paddr;
+		memmap_local.virtual_offset = 0;
+		vaddr = direct_map((unsigned long)current_hpage_vaddr,
+								&memmap_local);
+		if (!vaddr || vaddr != current_hpage_vaddr) {
+			printk(KERN_ERR
+			     "direct_map of paddr %#llx to vaddr %p failed\n",
+				memmap_local.paddr, current_hpage_vaddr);
+			ret = -EINVAL;
+			rep.status = 1;
+			goto out;
+		}
+	}
+	/* calculate the virtual address of the requested pfn */
+	page_vaddr = (void *)(((pfn - current_pfn_start) * PAGE_SIZE) +
+					(unsigned long)current_hpage_vaddr);
+
+	/* copy the page itself */
+	if (copy_to_user(bufptr, page_vaddr, PAGE_SIZE)) {
+		ret = -EFAULT;
+		rep.status = 1;
+	}
+
+out:
+	if (copy_to_user(reqp->reply_ptr, &rep, sizeof(struct pfn_reply)))
+		return -EFAULT;
+	return ret;
+}
+
+/*
  * Get the memap_data table from makedumpfile
  * and do the single allocate of the pfn_list.
  */
@@ -595,7 +679,6 @@ write_vmcore_get_memmap(struct pfn_list_
 	int i;
 	int count;
 	int ret = 0;
-	int node;
 	unsigned long hpagesize = 0x200000UL;
 	unsigned long hpagemask = 0xffffffffffe00000UL;
 	unsigned long size;
@@ -619,11 +702,15 @@ write_vmcore_get_memmap(struct pfn_list_
 			direct_unmap(mmd);
 		}
 		vunmap(vm_vaddr);
+		current_hpage_vaddr = 0;
 		kfree(mem_map_data);
 		mem_map_data = NULL;
 		num_mem_map_data = 0;
 		kfree(pfn_list);
 		pfn_list = NULL;
+		vunmap(page_vm_vaddr);
+		current_pfn_start = 0;
+		current_pfn_end = 0;
 	}
 
 	count = reqp->map_count;
@@ -688,8 +775,6 @@ write_vmcore_get_memmap(struct pfn_list_
 		mmd->virtual_offset = mmd->mem_map - low_virtual;
 	}
 
-	node = numa_node_id();
-
 	size = high_virtual - low_virtual;
 	/* add an extra virtual space for huge page alignment */
 	size += hpagesize;
@@ -709,7 +794,7 @@ write_vmcore_get_memmap(struct pfn_list_
 		ret = -EINVAL;
 
 	for (i = 0, mmd = mem_map_data; i < num_mem_map_data; i++, mmd++) {
-		mmd->section_vaddr = direct_map(i, local_virtual, mmd);
+		mmd->section_vaddr = direct_map(local_virtual, mmd);
 		if (!mmd->section_vaddr) {
 			printk(KERN_ERR
 				"direct_map of [%d] %#lx for %#lx failed\n",
@@ -875,6 +960,8 @@ static ssize_t write_vmcore_pfn_lists(st
 		ret = write_vmcore_get_excludes(&pfn_list_request);
 	else if (pfn_list_request.request == PL_REQUEST_MEMMAP)
 		ret = write_vmcore_get_memmap(&pfn_list_request);
+	else if (pfn_list_request.request == PL_REQUEST_PAGE)
+		ret = write_vmcore_read_page(&pfn_list_request);
 	else
 		return -EINVAL;
 
Index: linux/include/linux/makedumpfile.h
===================================================================
--- linux.orig/include/linux/makedumpfile.h
+++ linux/include/linux/makedumpfile.h
@@ -36,6 +36,7 @@ isAnon(struct address_space *mapping)
 					   pages */
 #define PL_REQUEST_MEMMAP	3	/* request to pass in the makedumpfile
 					   mem_map_data table */
+#define PL_REQUEST_PAGE		4	/* request a page of data */
 /*
  * a request for finding pfn's that can be excluded from the dump
  * they may be pages of particular types or free pages
@@ -57,6 +58,8 @@ struct pfn_list_request {
 	int map_size;		/* for PL_REQUEST_MEMMAP; bytes in table */
 	void *map_ptr;		/* for PL_REQUEST_MEMMAP; address of table */
 	long list_size;		/* for PL_REQUEST_MEMMAP negotiation */
+	unsigned long req_pfn;	/* PL_REQUEST_PAGE; requested pfn */
+        void *buf_ptr;          /* PL_REQUEST_PAGE; page buffer */
 	/* resume info: */
 	int more;		/* 0 for done, 1 for "there's more" */
 				/* PL_REQUEST_EXCLUDE: */
@@ -73,6 +76,7 @@ struct pfn_list_request {
  * the list of pfn's itself is pointed to by pfn_list
  */
 struct pfn_reply {
+	int status;		/* PL_REQUEST_PAGE returned status  0 is ok */
 	long pfn_list_elements;	/* negotiated on PL_REQUEST_MEMMAP */
 	long in_pfn_list;	/* returned by PL_REQUEST_EXCLUDE and
 				   PL_REQUEST_FREE */

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="130111.makedumpfile_kernel_lists"

To: kumagai-atsushi@mxc.nes.nec.co.jp d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org
Subject: [PATCH] makedumpfile: request the kernel do page scans
From: Cliff Wickman <cpw@sgi.com>

I've been experimenting with asking the kernel to scan the page tables
instead of reading all those page structures through /proc/vmcore.
The results are rather dramatic.
On a small, idle UV: about 4 sec. versus about 40 sec.
On a 8TB UV the unnecessary page scan takes 4 minutes, vs. about 200 min
through /proc/vmcore.

This patch incorporates this scheme into version 1.5.1, so that the cyclic
processing can use the kernel scans.
It also uses the page_is_buddy logic to speed the finding of free pages.
And also allows makedumpfile to work as before with a kernel that does
not provide /proc/vmcore_pfn_lists.

This patch:
  - writes requests to new kernel file /proc/vmcore_pfn_lists
  - makes request PL_REQUEST_MEMMAP to pass the crash kernel information about
    the boot kernel
  - makes requests PL_REQUEST_FREE and PL_REQUEST_EXCLUDE, asking the kernel
    to return lists of PFNs
  - adds page scan timing options -n -o and -t
  - still has a debugging option  -a

This patch depends on a kernel patch.

Diffed against the released makedumpfile-1.5.1

Signed-off-by: Cliff Wickman <cpw@sgi.com>
---
 dwarf_info.c   |    2 
 makedumpfile.c |  587 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 makedumpfile.h |   95 +++++++++
 print_info.c   |    5 
 4 files changed, 665 insertions(+), 24 deletions(-)


Index: makedumpfile-1.5.1.released/makedumpfile.h
===================================================================
--- makedumpfile-1.5.1.released.orig/makedumpfile.h
+++ makedumpfile-1.5.1.released/makedumpfile.h
@@ -86,6 +86,8 @@ int get_mem_type(void);
 #define LSEEKED_PDESC	(2)
 #define LSEEKED_PDATA	(3)
 
+#define EXTRA_MEMMAPS	100
+
 /*
  * Xen page flags
  */
@@ -418,7 +420,7 @@ do { \
 #define KVER_MIN_SHIFT 16
 #define KERNEL_VERSION(x,y,z) (((x) << KVER_MAJ_SHIFT) | ((y) << KVER_MIN_SHIFT) | (z))
 #define OLDEST_VERSION		KERNEL_VERSION(2, 6, 15)/* linux-2.6.15 */
-#define LATEST_VERSION		KERNEL_VERSION(3, 6, 7)/* linux-3.6.7 */
+#define LATEST_VERSION		KERNEL_VERSION(3, 7, 8)/* linux-3.7.8 */
 
 /*
  * vmcoreinfo in /proc/vmcore
@@ -794,11 +796,25 @@ typedef struct {
 } xen_crash_info_v2_t;
 
 struct mem_map_data {
+	/*
+	 * pfn_start/pfn_end are the pfn's represented by this mem_map entry.
+	 * mem_map is the virtual address of the array of page structures
+	 * that represent these pages.
+	 * paddr is the physical address of that array of structures.
+	 * ending_paddr would be (pfn_end - pfn_start) * sizeof(struct page).
+	 * section_vaddr is the address we get from ioremap_cache().
+	 */
 	unsigned long long	pfn_start;
 	unsigned long long	pfn_end;
-	unsigned long	mem_map;
+	unsigned long		mem_map;
+	unsigned long long	paddr;		/* filled in by makedumpfile */
+	long			virtual_offset;	/* filled in by kernel */
+	unsigned long long	ending_paddr;	/* filled in by kernel */
+	unsigned long		mapped_size;	/* filled in by kernel */
+	void 			*section_vaddr;	/* filled in by kernel */
 };
 
+
 struct dump_bitmap {
 	int		fd;
 	int		no_block;
@@ -875,6 +891,7 @@ struct DumpInfo {
 	int		flag_rearrange;      /* flag of creating dumpfile from
 						flattened format */
 	int		flag_split;	     /* splitting vmcore */
+	int		flag_use_kernel_lists;
   	int		flag_cyclic;	     /* cyclic processing to keep memory consumption */
 	int		flag_reassemble;     /* reassemble multiple dumpfiles into one */
 	int		flag_refiltering;    /* refilter from kdump-compressed file */
@@ -1384,6 +1401,80 @@ struct domain_list {
 	unsigned int  pickled_id;
 };
 
+#define PL_REQUEST_FREE		1	/* request for a list of free pages */
+#define PL_REQUEST_EXCLUDE	2	/* request for a list of excludable
+					   pages */
+#define PL_REQUEST_MEMMAP	3	/* request to pass in the makedumpfile
+					   mem_map_data table */
+/*
+ * limit the size of the pfn list to this many pfn_element structures
+ */
+#define MAX_PFN_LIST 10000
+
+/*
+ * one element in the pfn_list
+ */
+struct pfn_element {
+	unsigned long pfn;
+	unsigned long order;
+};
+
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
+	long pfn_list_elements;	/* negoiated on PL_REQUEST_MEMMAP */
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
 #define PAGES_PER_MAPWORD 	(sizeof(unsigned long) * 8)
 #define MFNS_PER_FRAME		(info->page_size / sizeof(unsigned long))
 
Index: makedumpfile-1.5.1.released/dwarf_info.c
===================================================================
--- makedumpfile-1.5.1.released.orig/dwarf_info.c
+++ makedumpfile-1.5.1.released/dwarf_info.c
@@ -324,6 +324,8 @@ get_data_member_location(Dwarf_Die *die,
 	return TRUE;
 }
 
+int dwarf_formref(Dwarf_Attribute *, Dwarf_Off *);
+
 static int
 get_die_type(Dwarf_Die *die, Dwarf_Die *die_type)
 {
Index: makedumpfile-1.5.1.released/print_info.c
===================================================================
--- makedumpfile-1.5.1.released.orig/print_info.c
+++ makedumpfile-1.5.1.released/print_info.c
@@ -244,6 +244,11 @@ print_usage(void)
 	MSG("  [-f]:\n");
 	MSG("      Overwrite DUMPFILE even if it already exists.\n");
 	MSG("\n");
+	MSG("  [-o]:\n");
+	MSG("      Read page structures from /proc/vmcore in the scan for\n");
+	MSG("      free and excluded pages regardless of whether\n");
+	MSG("      /proc/vmcore_pfn_lists is present.\n");
+	MSG("\n");
 	MSG("  [-h]:\n");
 	MSG("      Show help message and LZO/snappy support status (enabled/disabled).\n");
 	MSG("\n");
Index: makedumpfile-1.5.1.released/makedumpfile.c
===================================================================
--- makedumpfile-1.5.1.released.orig/makedumpfile.c
+++ makedumpfile-1.5.1.released/makedumpfile.c
@@ -13,6 +13,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
+#define _GNU_SOURCE
+#include <stdio.h>
 #include "makedumpfile.h"
 #include "print_info.h"
 #include "dwarf_info.h"
@@ -31,6 +33,14 @@ struct srcfile_table	srcfile_table;
 
 struct vm_table		vt = { 0 };
 struct DumpInfo		*info = NULL;
+int pfn_list_fd;
+struct pfn_element *pfn_list;
+int nflag = 0;
+int oflag = 0;
+int tflag = 0;
+int aflag = 0;
+struct timeval scan_start;
+int max_pfn_list;
 
 char filename_stdout[] = FILENAME_STDOUT;
 
@@ -2415,6 +2425,22 @@ get_mm_sparsemem(void)
 	unsigned long long pfn_start, pfn_end;
 	unsigned long section, mem_map;
 	unsigned long *mem_sec = NULL;
+	unsigned long vaddr;
+	unsigned long paddr;
+	unsigned long lastvaddr;
+	unsigned long lastpaddr;
+	unsigned long diff;
+	long j;
+	int i;
+	int npfns;
+	int pagesize;
+	int num_mem_map;
+	int num_added = 0;
+	struct mem_map_data *mmd;
+	struct mem_map_data *curmmd;
+	struct mem_map_data *work1mmd;
+	struct mem_map_data *work2mmd;
+	struct mem_map_data *lastmmd;
 
 	int ret = FALSE;
 
@@ -2441,7 +2467,8 @@ get_mm_sparsemem(void)
 	}
 	info->num_mem_map = num_section;
 	if ((info->mem_map_data = (struct mem_map_data *)
-	    malloc(sizeof(struct mem_map_data)*info->num_mem_map)) == NULL) {
+	    malloc(sizeof(struct mem_map_data) *
+		   		(EXTRA_MEMMAPS + info->num_mem_map))) == NULL) {
 		ERRMSG("Can't allocate memory for the mem_map_data. %s\n",
 		    strerror(errno));
 		goto out;
@@ -2459,6 +2486,71 @@ get_mm_sparsemem(void)
 		dump_mem_map(pfn_start, pfn_end, mem_map, section_nr);
 	}
 	ret = TRUE;
+
+	/* add paddr to the table */
+	mmd = &info->mem_map_data[0];
+	num_mem_map = info->num_mem_map;
+	lastmmd = mmd + num_mem_map;
+	for (i = 0; i < num_mem_map; i++) {
+		if (mmd[i].mem_map == 0) {
+			mmd[i].paddr = 0;
+		} else {
+			mmd[i].paddr = vaddr_to_paddr(mmd[i].mem_map);
+			if (mmd[i].paddr == 0) {
+				printf("! can't translate %#lx to paddr\n",
+					mmd[i].mem_map);
+				exit(1);
+			}
+			/*
+			 * When we pass a mem_map and its paddr to the kernel
+			 * it will be remapped assuming the entire range
+			 * of pfn's are consecutive. If they are not then
+			 * we need to split the range into two.
+			 */
+			pagesize = SIZE(page);
+			npfns = mmd[i].pfn_end - mmd[i].pfn_start;
+			vaddr = (unsigned long)mmd[i].mem_map;
+			paddr = vaddr_to_paddr(vaddr);
+			diff = vaddr - paddr;
+			lastvaddr = vaddr + (pagesize * (npfns-1));
+			lastpaddr = vaddr_to_paddr(lastvaddr);
+			if (lastvaddr - lastpaddr != diff) {
+			/* there is a break in vtop somewhere in this range */
+			/* we need to split it */
+			  for (j = 0; j < npfns; j++) {
+			    paddr = vaddr_to_paddr(vaddr);
+			    if (vaddr - paddr != diff) {
+				diff = vaddr - paddr;
+				/* insert a new entry if we have room */
+				if (num_added < EXTRA_MEMMAPS) {
+					curmmd = &info->mem_map_data[i];
+					num_added++;
+					work1mmd = lastmmd - 1;
+					for (work2mmd = lastmmd;
+						work2mmd > curmmd; work2mmd--) {
+						work1mmd = work2mmd - 1;
+						*work2mmd = *work1mmd;
+					}
+					work2mmd = work1mmd + 1;
+					work2mmd->mem_map =
+					  work1mmd->mem_map + (pagesize * j);
+					lastmmd++;
+					num_mem_map++;
+					info->num_mem_map++;
+					/*
+					 * need only 1 split, the new
+					 * one will be checked also.
+					 */
+					break;
+				} else
+					printf("warn: out of EXTRA_MEMMAPS\n");
+			    }
+				vaddr += pagesize;
+			  }
+			}
+		}
+	}
+
 out:
 	if (mem_sec != NULL)
 		free(mem_sec);
@@ -2571,6 +2663,172 @@ initialize_bitmap_memory(void)
 	return TRUE;
 }
 
+/*
+ * construct a version of the mem_map_data table to pass to the kernel
+ */
+void *
+make_kernel_mmap(int *kmap_elements, int *kmap_size)
+{
+	int i, j;
+	int elements = 0;
+	int page_structs;
+	int elem;
+	long l;
+	unsigned long base_end_pfn;
+	unsigned long end_paddr;
+	unsigned long v1;
+	unsigned long v2;
+	unsigned long end_page_pfns;
+	unsigned long hpagesize = 0x200000UL;
+	unsigned long hpageoffset = hpagesize - 1;
+	struct mem_map_data *mmdo, *mmdn;
+	struct mem_map_data *mmdbase, *mmdnext, *mmdend, *mmdwork;
+	struct mem_map_data temp_mmd;
+	struct mem_map_data *mmap;
+
+	mmap = malloc(info->num_mem_map * sizeof(struct mem_map_data));
+	if (mmap == NULL) {
+		ERRMSG("Can't allocate memory kernel map\n");
+		return NULL;
+	}
+
+	/* condense them down to the valid ones */
+	for (i = 0, mmdn = mmap, mmdo = &info->mem_map_data[0];
+				i < info->num_mem_map; i++, mmdo++) {
+		if (mmdo->mem_map && mmdo->paddr) {
+			*mmdn = *mmdo;
+			mmdn++;
+			elements++;
+		}
+	}
+
+	/* make sure it is sorted by mem_map (it should be already) */
+	mmdn = mmap;
+	for (i = 0; i < elements - 1; i++) {
+		for (j = i + 1; j < elements; j++) {
+			if (mmdn[j].mem_map < mmdn[i].mem_map) {
+				temp_mmd = mmdn[j];
+				mmdn[j] = mmdn[i];
+				mmdn[i] = temp_mmd;
+			}
+		}
+	}
+
+	if (aflag) {
+		mmdn = mmap;
+		printf("entire mem_map:\n");
+		for (i = 0; i < elements - 1; i++) {
+			l = (mmdn[i].pfn_end - mmdn[i].pfn_start) * SIZE(page);
+			printf(
+			 "[%d] pfn %#llx-%llx mem_map %#lx paddr %#llx-%llx\n",
+				i, mmdn[i].pfn_start, mmdn[i].pfn_end,
+				mmdn[i].mem_map, mmdn[i].paddr,
+				mmdn[i].paddr + l);
+		}
+	}
+
+	/*
+	 * a first pass to split overlapping pfn entries like this:
+	 * pfn 0x1248000-1250000 mem_map 0xffffea003ffc0000 paddr 0x10081c0000
+	 * pfn 0x1248000-1250000 mem_map 0xffffea0040000030 paddr 0x1008400030
+	 */
+	mmdbase = mmap;
+	mmdnext = mmap + 1;
+	mmdend = mmap + elements;
+	/* test each mmdbase/mmdnext pair */
+	while (mmdnext < mmdend) {  /* mmdnext is the one after mmdbase */
+		page_structs = (mmdbase->pfn_end - mmdbase->pfn_start);
+		/* mmdwork scans from mmdnext to the end */
+		if ((mmdbase->pfn_start == mmdnext->pfn_start) &&
+		    (mmdbase->pfn_end == mmdnext->pfn_end)) {
+			/* overlapping pfns, we need a fix */
+			v1 = mmdnext->mem_map - mmdbase->mem_map;
+			v2 = mmdnext->paddr - mmdbase->paddr;
+			if (v1 != (v2 & hpageoffset))
+				printf("virt to phys is wrong %#lx %#lx\n",
+					v1, v2);
+			l = mmdbase->pfn_end - mmdbase->pfn_start;
+			end_page_pfns = l - (((hpagesize -
+				(hpageoffset & mmdbase->paddr)) +
+				  SIZE(page) - 1) / SIZE(page));
+			mmdbase->pfn_end -= end_page_pfns;
+			mmdnext->pfn_start = mmdbase->pfn_end;
+		} else if ((mmdbase->pfn_start == mmdnext->pfn_start) ||
+		    (mmdbase->pfn_end == mmdnext->pfn_end)) {
+			printf("warning: unfixed overlap\n");
+		}
+		mmdbase++;
+		mmdnext++;
+	}
+
+	/*
+	 * consolidate those mem_map's with occupying consecutive physical
+	 * addresses
+	 *  pages represented by these pages structs:       addr of page struct
+	 * pfns 0x1000000-1008000 mem_map 0xffffea0038000000 paddr 0x11f7e00000
+	 * pfns 0x1008000-1010000 mem_map 0xffffea00381c0000 paddr 0x11f7fc0000
+	 * pfns 0x1010000-1018000 mem_map 0xffffea0038380000 paddr 0x11f8180000
+	 *           8000 increments                             inc's:  1c0000
+	 *        8000000 of memory (128M)                    8000 page structs
+	 */
+	mmdbase = mmap;
+	mmdnext = mmap + 1;
+	mmdend = mmap + elements;
+	while (mmdnext < mmdend) {
+		elem = mmdend - mmdnext;
+		/*  test mmdbase vs. mmdwork and onward: */
+		for (i = 0, mmdwork = mmdnext; i < elem; i++, mmdwork++) {
+			base_end_pfn = mmdbase->pfn_end;
+			if (base_end_pfn == mmdwork->pfn_start) {
+				page_structs = (mmdbase->pfn_end -
+							mmdbase->pfn_start);
+				end_paddr = (page_structs * SIZE(page)) +
+							mmdbase->paddr;
+				if (mmdwork->paddr == end_paddr) {
+					/* extend base by the work one */
+					mmdbase->pfn_end = mmdwork->pfn_end;
+					/* next is where to begin next time */
+					mmdnext = mmdwork + 1;
+				} else {
+					/* gap in address of page
+					   structs; end of section */
+					mmdbase++;
+					if (mmdwork - mmdbase > 0)
+						*mmdbase = *mmdwork;
+					mmdnext = mmdwork + 1;
+					break;
+				}
+			} else {
+				/* gap in pfns; end of section */
+				mmdbase++;
+				if (mmdwork - mmdbase > 0)
+					*mmdbase = *mmdwork;
+				mmdnext = mmdwork + 1;
+				break;
+			}
+		}
+	}
+	elements = (mmdbase - mmap) + 1;
+
+	if (aflag) {
+		printf("user mmap for kernel:\n");
+		for (i = 0, mmdwork = mmap; i < elements; i++, mmdwork++) {
+			l = mmdwork->pfn_end - mmdwork->pfn_start;
+			printf(
+		      "[%d] user pfn %#llx-%llx paddr %#llx-%llx vaddr %#lx\n",
+				i, mmdwork->pfn_start, mmdwork->pfn_end,
+				mmdwork->paddr,
+				mmdwork->paddr + (l * SIZE(page)),
+				mmdwork->mem_map);
+		}
+	}
+
+	*kmap_elements = elements;
+	*kmap_size = elements * sizeof(struct mem_map_data);
+
+	return mmap;
+}
+
 int
 initial(void)
 {
@@ -2833,7 +3091,14 @@ out:
 	if (!get_value_for_old_linux())
 		return FALSE;
 
-	if (info->flag_cyclic && (info->dump_level & DL_EXCLUDE_FREE))
+	/*
+	 * page_is_buddy will tell us whether free pages can be identified
+	 * by flags and counts in the page structure without making an extra
+	 * pass through the free lists.
+	 * This is applicable to using /proc/vmcore or using the kernel.
+	 *   force all old (-o) forms to search free lists
+	 */
+	if (info->dump_level & DL_EXCLUDE_FREE)
 		setup_page_is_buddy();
 
 	return TRUE;
@@ -3549,6 +3814,65 @@ out:
 	return ret;
 }
 
+/*
+ * let the kernel find excludable pages from one node
+ */
+void
+__exclude_free_pages_kernel(unsigned long pgdat, int node)
+{
+	int i, j, ret, pages;
+	unsigned long pgdat_paddr;
+	struct pfn_list_request request;
+	struct pfn_reply reply;
+	struct pfn_element *pe;
+
+	if ((pgdat_paddr = vaddr_to_paddr(pgdat)) == NOT_PADDR) {
+		ERRMSG("Can't convert virtual address(%#lx) to physical.\n",
+			pgdat);
+		return;
+	}
+
+	/*
+	 * Get the list of free pages.
+	 * This may be broken up into MAX_PFN_list arrays of PFNs.
+	 */
+	memset(&request, 0, sizeof(request));
+	request.request = PL_REQUEST_FREE;
+	request.node = node;
+	request.pgdat_paddr = pgdat_paddr;
+	request.pgdat_vaddr = pgdat;
+	request.reply_ptr = (void *)&reply;
+	request.pfn_list_ptr = (void *)pfn_list;
+	memset(&reply, 0, sizeof(reply));
+
+	do {
+		request.more = 0;
+		if (reply.more) {
+			/* this is to be a continuation of the last request */
+			request.more = 1;
+			request.zone_index = reply.zone_index;
+			request.freearea_index = reply.freearea_index;
+			request.type_index = reply.type_index;
+			request.list_ct = reply.list_ct;
+		}
+		ret = write(pfn_list_fd, &request, sizeof(request));
+		if (ret != sizeof(request)) {
+			printf("PL_REQUEST_FREE failed\n");
+			return;
+		}
+		pfn_free += reply.pfn_free;
+
+		for (i = 0; i < reply.in_pfn_list; i++) {
+			pe = &pfn_list[i];
+			pages = (1 << pe->order);
+                        for (j = 0; j < pages; j++) {
+				clear_bit_on_2nd_bitmap_for_kernel(pe->pfn + j);
+			}
+		}
+	} while (reply.more);
+
+	return;
+}
 
 int
 _exclude_free_page(void)
@@ -3568,7 +3892,24 @@ _exclude_free_page(void)
 	gettimeofday(&tv_start, NULL);
 
 	for (num_nodes = 1; num_nodes <= vt.numnodes; num_nodes++) {
-
+		if (!info->flag_cyclic && info->flag_use_kernel_lists) {
+			node_zones = pgdat + OFFSET(pglist_data.node_zones);
+			if (!readmem(VADDR,
+				pgdat + OFFSET(pglist_data.nr_zones),
+				&nr_zones, sizeof(nr_zones))) {
+					ERRMSG("Can't get nr_zones.\n");
+				return FALSE;
+			}
+			print_progress(PROGRESS_FREE_PAGES, num_nodes - 1,
+								vt.numnodes);
+			/* ask the kernel to do one node */
+			__exclude_free_pages_kernel(pgdat, node);
+			goto next_pgdat;
+		}
+		/*
+		 * kernel does not have the pfn_list capability
+		 * use the old way
+		 */
 		print_progress(PROGRESS_FREE_PAGES, num_nodes - 1, vt.numnodes);
 
 		node_zones = pgdat + OFFSET(pglist_data.node_zones);
@@ -3595,6 +3936,7 @@ _exclude_free_page(void)
 			if (!reset_bitmap_of_free_pages(zone))
 				return FALSE;
 		}
+	next_pgdat:
 		if (num_nodes < vt.numnodes) {
 			if ((node = next_online_node(node + 1)) < 0) {
 				ERRMSG("Can't get next online node.\n");
@@ -3612,6 +3954,8 @@ _exclude_free_page(void)
 	 */
 	print_progress(PROGRESS_FREE_PAGES, vt.numnodes, vt.numnodes);
 	print_execution_time(PROGRESS_FREE_PAGES, &tv_start);
+	if (tflag)
+		print_execution_time("Total time", &scan_start);
 
 	return TRUE;
 }
@@ -3755,7 +4099,6 @@ setup_page_is_buddy(void)
 		}
 	} else
 		info->page_is_buddy = page_is_buddy_v2;
-
 out:
 	if (!info->page_is_buddy)
 		DEBUG_MSG("Can't select page_is_buddy handler; "
@@ -3964,10 +4307,89 @@ exclude_zero_pages(void)
 	return TRUE;
 }
 
+/*
+ * let the kernel find excludable pages from one mem_section
+ */
+int
+__exclude_unnecessary_pages_kernel(int mm, struct mem_map_data *mmd)
+{
+	unsigned long long pfn_start = mmd->pfn_start;
+	unsigned long long pfn_end = mmd->pfn_end;
+	int i, j, ret, pages, flag;
+	struct pfn_list_request request;
+	struct pfn_reply reply;
+	struct pfn_element *pe;
+
+	/*
+	 * Get the list of to-be-excluded pages in this section.
+	 * It may be broken up by groups of max_pfn_list size.
+	 */
+	memset(&request, 0, sizeof(request));
+	request.request = PL_REQUEST_EXCLUDE;
+	request.paddr = mmd->paddr; /* phys addr of mem_map */
+	request.reply_ptr = (void *)&reply;
+	request.pfn_list_ptr = (void *)pfn_list;
+	request.exclude_bits = 0;
+	request.pfn_start = pfn_start;
+	request.count = pfn_end - pfn_start;
+	if (info->dump_level & DL_EXCLUDE_CACHE)
+	 	request.exclude_bits |= DL_EXCLUDE_CACHE;
+	if (info->dump_level & DL_EXCLUDE_CACHE_PRI)
+	 	request.exclude_bits |= DL_EXCLUDE_CACHE_PRI;
+	if (info->dump_level & DL_EXCLUDE_USER_DATA)
+	 	request.exclude_bits |= DL_EXCLUDE_USER_DATA;
+	/* if we try for free pages from the freelists then we don't need
+           to ask here for 'buddy' pages */
+	if (info->dump_level & DL_EXCLUDE_FREE)
+	 	request.exclude_bits |= DL_EXCLUDE_FREE;
+	memset(&reply, 0, sizeof(reply));
+
+	do {
+		/* pfn represented by paddr */
+		request.more = 0;
+		if (reply.more) {
+			/* this is to be a continuation of the last request */
+			request.more = 1;
+			request.map_index = reply.map_index;
+		}
+
+		ret = write(pfn_list_fd, &request, sizeof(request));
+		if (ret != sizeof(request))
+			return FALSE;
+
+		pfn_cache += reply.pfn_cache;
+		pfn_cache_private += reply.pfn_cache_private;
+		pfn_user += reply.pfn_user;
+		pfn_free += reply.pfn_free;
+
+		flag = 0;
+		for (i = 0; i < reply.in_pfn_list; i++) {
+			pe = &pfn_list[i];
+			pages = (1 << pe->order);
+                        for (j = 0; j < pages; j++) {
+				if (clear_bit_on_2nd_bitmap_for_kernel(
+							pe->pfn + j) == FALSE) {
+					// printf("fail: mm %d slot %d pfn %#lx\n",
+						// mm, i, pe->pfn + j);
+					// printf("paddr %#llx pfn %#llx-%#llx mem_map %#lx\n",
+					// mmd->paddr, mmd->pfn_start, mmd->pfn_end, mmd->mem_map);
+					flag = 1;
+					break;
+				}
+				if (flag) break;
+			}
+		}
+	} while (reply.more);
+
+	return TRUE;
+}
+
 int
-__exclude_unnecessary_pages(unsigned long mem_map,
-    unsigned long long pfn_start, unsigned long long pfn_end)
+__exclude_unnecessary_pages(int mm, struct mem_map_data *mmd)
 {
+	unsigned long long pfn_start = mmd->pfn_start;
+	unsigned long long pfn_end = mmd->pfn_end;
+	unsigned long mem_map = mmd->mem_map;
 	unsigned long long pfn, pfn_mm, maddr;
 	unsigned long long pfn_read_start, pfn_read_end, index_pg;
 	unsigned char page_cache[SIZE(page) * PGMM_CACHED];
@@ -3975,6 +4397,12 @@ __exclude_unnecessary_pages(unsigned lon
 	unsigned int _count, _mapcount = 0;
 	unsigned long flags, mapping, private = 0;
 
+	if (info->flag_use_kernel_lists) {
+		if (__exclude_unnecessary_pages_kernel(mm, mmd) == FALSE)
+			return FALSE;
+		return TRUE;
+	}
+
 	/*
 	 * Refresh the buffer of struct page, when changing mem_map.
 	 */
@@ -4012,7 +4440,6 @@ __exclude_unnecessary_pages(unsigned lon
 				pfn_mm = PGMM_CACHED - index_pg;
 			else
 				pfn_mm = pfn_end - pfn;
-
 			if (!readmem(VADDR, mem_map,
 			    page_cache + (index_pg * SIZE(page)),
 			    SIZE(page) * pfn_mm)) {
@@ -4036,7 +4463,6 @@ __exclude_unnecessary_pages(unsigned lon
 		 * Exclude the free page managed by a buddy
 		 */
 		if ((info->dump_level & DL_EXCLUDE_FREE)
-		    && info->flag_cyclic
 		    && info->page_is_buddy
 		    && info->page_is_buddy(flags, _mapcount, private, _count)) {
 			int i;
@@ -4085,19 +4511,78 @@ __exclude_unnecessary_pages(unsigned lon
 	return TRUE;
 }
 
+/*
+ * Pass in the mem_map_data table.
+ * Must do this once, and before doing PL_REQUEST_FREE or PL_REQUEST_EXCLUDE.
+ */
+int
+setup_kernel_mmap()
+{
+	int ret;
+	int kmap_elements, kmap_size;
+	long malloc_size;
+	void *kmap_addr;
+	struct pfn_list_request request;
+	struct pfn_reply reply;
+
+	kmap_addr = make_kernel_mmap(&kmap_elements, &kmap_size);
+	if (kmap_addr == NULL)
+		return FALSE;
+	memset(&request, 0, sizeof(request));
+	request.request = PL_REQUEST_MEMMAP;
+	request.map_ptr = kmap_addr;
+	request.reply_ptr = (void *)&reply;
+	request.map_count = kmap_elements;
+	request.map_size = kmap_size;
+	request.list_size = MAX_PFN_LIST;
+
+	ret = write(pfn_list_fd, &request, sizeof(request));
+	if (ret < 0) {
+		fprintf(stderr, "PL_REQUEST_MEMMAP returned %d\n", ret);
+		return FALSE;
+	}
+	/* the reply tells us how long the kernel's list actually is */
+	max_pfn_list = reply.pfn_list_elements;
+	if (max_pfn_list <= 0) {
+		fprintf(stderr,
+			"PL_REQUEST_MEMMAP returned max_pfn_list %d\n",
+			max_pfn_list);
+		return FALSE;
+	}
+	if (max_pfn_list < MAX_PFN_LIST) {
+		printf("length of pfn list dropped from %d to %d\n",
+			MAX_PFN_LIST, max_pfn_list);
+	}
+	free(kmap_addr);
+	/*
+	 * Allocate the buffer for the PFN list (just once).
+	 */
+	malloc_size = max_pfn_list * sizeof(struct pfn_element);
+	if ((pfn_list = (struct pfn_element *)malloc(malloc_size)) == NULL) {
+		ERRMSG("Can't allocate pfn_list of %ld\n", malloc_size);
+		return FALSE;
+	}
+	return TRUE;
+}
+
 int
 exclude_unnecessary_pages(void)
 {
-	unsigned int mm;
-	struct mem_map_data *mmd;
-	struct timeval tv_start;
+ 	unsigned int mm;
+ 	struct mem_map_data *mmd;
+ 	struct timeval tv_start;
 
 	if (is_xen_memory() && !info->dom0_mapnr) {
 		ERRMSG("Can't get max domain-0 PFN for excluding pages.\n");
 		return FALSE;
 	}
 
+	if (!info->flag_cyclic && info->flag_use_kernel_lists) {
+		if (setup_kernel_mmap() == FALSE)
+			return FALSE;
+	}
 	gettimeofday(&tv_start, NULL);
+	gettimeofday(&scan_start, NULL);
 
 	for (mm = 0; mm < info->num_mem_map; mm++) {
 		print_progress(PROGRESS_UNN_PAGES, mm, info->num_mem_map);
@@ -4106,9 +4591,9 @@ exclude_unnecessary_pages(void)
 
 		if (mmd->mem_map == NOT_MEMMAP_ADDR)
 			continue;
-
-		if (!__exclude_unnecessary_pages(mmd->mem_map,
-						 mmd->pfn_start, mmd->pfn_end))
+		if (mmd->paddr == 0)
+			continue;
+		if (!__exclude_unnecessary_pages(mm, mmd))
 			return FALSE;
 	}
 
@@ -4139,7 +4624,11 @@ exclude_unnecessary_pages_cyclic(void)
 	 */
 	copy_bitmap_cyclic();
 
-	if ((info->dump_level & DL_EXCLUDE_FREE) && !info->page_is_buddy)
+	/*
+	 * If free pages cannot be identified with the buddy flag and/or
+	 * count then we have to search free lists.
+	 */
+	if ((info->dump_level & DL_EXCLUDE_FREE) && (!info->page_is_buddy))
 		if (!exclude_free_page())
 			return FALSE;
 
@@ -4164,8 +4653,7 @@ exclude_unnecessary_pages_cyclic(void)
 
 			if (mmd->pfn_end >= info->cyclic_start_pfn &&
 			    mmd->pfn_start <= info->cyclic_end_pfn) {
-				if (!__exclude_unnecessary_pages(mmd->mem_map,
-								 mmd->pfn_start, mmd->pfn_end))
+				if (!__exclude_unnecessary_pages(mm, mmd))
 					return FALSE;
 			}
 		}
@@ -4195,7 +4683,7 @@ update_cyclic_region(unsigned long long 
 	if (!create_1st_bitmap_cyclic())
 		return FALSE;
 
-	if (!exclude_unnecessary_pages_cyclic())
+	if (exclude_unnecessary_pages_cyclic() == FALSE)
 		return FALSE;
 
 	return TRUE;
@@ -4255,7 +4743,7 @@ create_2nd_bitmap(void)
 	if (info->dump_level & DL_EXCLUDE_CACHE ||
 	    info->dump_level & DL_EXCLUDE_CACHE_PRI ||
 	    info->dump_level & DL_EXCLUDE_USER_DATA) {
-		if (!exclude_unnecessary_pages()) {
+		if (exclude_unnecessary_pages() == FALSE) {
 			ERRMSG("Can't exclude unnecessary pages.\n");
 			return FALSE;
 		}
@@ -4263,8 +4751,10 @@ create_2nd_bitmap(void)
 
 	/*
 	 * Exclude free pages.
+	 * If free pages cannot be identified with the buddy flag and/or
+	 * count then we have to search free lists.
 	 */
-	if (info->dump_level & DL_EXCLUDE_FREE)
+	if ((info->dump_level & DL_EXCLUDE_FREE) && (!info->page_is_buddy))
 		if (!exclude_free_page())
 			return FALSE;
 
@@ -4395,6 +4885,10 @@ create_dump_bitmap(void)
 	int ret = FALSE;
 
 	if (info->flag_cyclic) {
+		if (info->flag_use_kernel_lists) {
+			if (setup_kernel_mmap() == FALSE)
+				goto out;
+		}
 		if (!prepare_bitmap_buffer_cyclic())
 			goto out;
 
@@ -4872,6 +5366,7 @@ get_num_dumpable_cyclic(void)
 {
 	unsigned long long pfn, num_dumpable=0;
 
+	gettimeofday(&scan_start, NULL);
 	for (pfn = 0; pfn < info->max_mapnr; pfn++) {
 		if (!update_cyclic_region(pfn))
 			return FALSE;
@@ -5201,7 +5696,7 @@ get_loads_dumpfile_cyclic(void)
 	info->cyclic_end_pfn = info->pfn_cyclic;
 	if (!create_1st_bitmap_cyclic())
 		return FALSE;
-	if (!exclude_unnecessary_pages_cyclic())
+	if (exclude_unnecessary_pages_cyclic() == FALSE)
 		return FALSE;
 
 	if (!(phnum = get_phnum_memory()))
@@ -5613,6 +6108,10 @@ write_kdump_pages(struct cache_data *cd_
 			pfn_zero++;
 			continue;
 		}
+
+		if (nflag)
+			continue;
+
 		/*
 		 * Compress the page data.
 		 */
@@ -5768,6 +6267,7 @@ write_kdump_pages_cyclic(struct cache_da
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 
 		if ((num_dumped % per) == 0)
+
 			print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable);
 
 		/*
@@ -5786,11 +6286,17 @@ write_kdump_pages_cyclic(struct cache_da
 		 */
 		if ((info->dump_level & DL_EXCLUDE_ZERO)
 		    && is_zero_page(buf, info->page_size)) {
+		    if (!nflag) {
 			if (!write_cache(cd_header, pd_zero, sizeof(page_desc_t)))
 				goto out;
+		    }
 			pfn_zero++;
 			continue;
 		}
+
+		if (nflag)
+			continue;
+
 		/*
 		 * Compress the page data.
 		 */
@@ -6208,6 +6714,8 @@ write_kdump_pages_and_bitmap_cyclic(stru
 		if (!update_cyclic_region(pfn))
                         return FALSE;
 
+		if (tflag)
+			print_execution_time("Total time", &scan_start);
 		if (!write_kdump_pages_cyclic(cd_header, cd_page, &pd_zero, &offset_data))
 			return FALSE;
 
@@ -8231,6 +8739,22 @@ static struct option longopts[] = {
 	{0, 0, 0, 0}
 };
 
+/*
+ * test for the presence of capability in the kernel to provide lists
+ * of pfn's:
+ *   /proc/vmcore_pfn_lists
+ * return 1 for present
+ * return 0 for not present
+ */
+int
+test_kernel_pfn_lists(void)
+{
+	if ((pfn_list_fd = open("/proc/vmcore_pfn_lists", O_WRONLY)) < 0) {
+		return 0;
+	}
+	return 1;
+}
+
 int
 main(int argc, char *argv[])
 {
@@ -8256,9 +8780,12 @@ main(int argc, char *argv[])
 	
 	info->block_order = DEFAULT_ORDER;
 	message_level = DEFAULT_MSG_LEVEL;
-	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:lMpRrsvXx:", longopts,
+	while ((opt = getopt_long(argc, argv, "ab:cDd:EFfg:hi:MnoRrstVvXx:Y", longopts,
 	    NULL)) != -1) {
 		switch (opt) {
+		case 'a':
+			aflag = 1;
+			break;
 		case 'b':
 			info->block_order = atoi(optarg);
 			break;
@@ -8314,6 +8841,13 @@ main(int argc, char *argv[])
 		case 'M':
 			info->flag_dmesg = 1;
 			break;
+		case 'n':
+			/* -n undocumented, for testing page scanning time */
+			nflag = 1;
+			break;
+		case 'o':
+			oflag = 1;
+			break;
 		case 'p':
 			info->flag_compress = DUMP_DH_COMPRESSED_SNAPPY;
 			break;
@@ -8329,6 +8863,9 @@ main(int argc, char *argv[])
 		case 'r':
 			info->flag_reassemble = 1;
 			break;
+		case 't':
+			tflag = 1;
+			break;
 		case 'V':
 			info->vaddr_for_vtop = strtoul(optarg, NULL, 0);
 			break;
@@ -8360,6 +8897,12 @@ main(int argc, char *argv[])
 			goto out;
 		}
 	}
+
+	if (oflag)
+		info->flag_use_kernel_lists = 0;
+	else
+		info->flag_use_kernel_lists = test_kernel_pfn_lists();
+
 	if (flag_debug)
 		message_level |= ML_PRINT_DEBUG_MSG;
 

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="130111.makedumpfile_read_pages"

---
 makedumpfile.c |   29 ++++++++++++++++++++++++++++-
 makedumpfile.h |    4 ++++
 2 files changed, 32 insertions(+), 1 deletion(-)

Index: makedumpfile-1.5.1.released/makedumpfile.c
===================================================================
--- makedumpfile-1.5.1.released.orig/makedumpfile.c
+++ makedumpfile-1.5.1.released/makedumpfile.c
@@ -39,6 +39,7 @@ int nflag = 0;
 int oflag = 0;
 int tflag = 0;
 int aflag = 0;
+int jflag = 0;
 struct timeval scan_start;
 int max_pfn_list;
 
@@ -5630,9 +5631,32 @@ write_elf_pages(struct cache_data *cd_he
 int
 read_pfn(unsigned long long pfn, unsigned char *buf)
 {
+	int ret;
 	unsigned long long paddr;
 	off_t offset1, offset2;
 	size_t size1, size2;
+	struct pfn_list_request request;
+	struct pfn_reply reply;
+
+	/* can get a page directly, without using /proc/vmcore */
+	/* -j means use /proc/vmcore */
+	if (!jflag && info->flag_use_kernel_lists) {
+		memset(&request, 0, sizeof(request));
+		request.request = PL_REQUEST_PAGE;
+		request.req_pfn = pfn;
+		request.buf_ptr = buf;
+		request.reply_ptr = &reply;
+		ret = write(pfn_list_fd, &request, sizeof(request));
+		if (ret != sizeof(request)) {
+			printf("PL_REQUEST_PAGE failed\n");
+			return FALSE;
+		}
+		if (reply.status) {
+			ERRMSG("Can't get the page data.\n");
+			return FALSE;
+		}
+		return TRUE;
+	}
 
 	paddr = pfn_to_paddr(pfn);
 	if (info->flag_refiltering || info->flag_sadump) {
@@ -8780,12 +8804,15 @@ main(int argc, char *argv[])
 	
 	info->block_order = DEFAULT_ORDER;
 	message_level = DEFAULT_MSG_LEVEL;
-	while ((opt = getopt_long(argc, argv, "ab:cDd:EFfg:hi:MnoRrstVvXx:Y", longopts,
+	while ((opt = getopt_long(argc, argv, "ab:cDd:EFfg:hi:jMnoRrstVvXx:Y", longopts,
 	    NULL)) != -1) {
 		switch (opt) {
 		case 'a':
 			aflag = 1;
 			break;
+		case 'j':
+			jflag = 1; // use /proc/vmcore, not kernel call
+			break;
 		case 'b':
 			info->block_order = atoi(optarg);
 			break;
Index: makedumpfile-1.5.1.released/makedumpfile.h
===================================================================
--- makedumpfile-1.5.1.released.orig/makedumpfile.h
+++ makedumpfile-1.5.1.released/makedumpfile.h
@@ -1406,6 +1406,7 @@ struct domain_list {
 					   pages */
 #define PL_REQUEST_MEMMAP	3	/* request to pass in the makedumpfile
 					   mem_map_data table */
+#define PL_REQUEST_PAGE		4	/* request a page of data */
 /*
  * limit the size of the pfn list to this many pfn_element structures
  */
@@ -1440,6 +1441,8 @@ struct pfn_list_request {
 	int map_size;		/* for PL_REQUEST_MEMMAP; bytes in table */
 	void *map_ptr;		/* for PL_REQUEST_MEMMAP; address of table */
 	long list_size;		/* for PL_REQUEST_MEMMAP negotiation */
+	unsigned long req_pfn;	/* PL_REQUEST_PAGE; requested pfn */
+	void *buf_ptr;		/* PL_REQUEST_PAGE; page buffer */
 	/* resume info: */
 	int more;		/* 0 for done, 1 for "there's more" */
 				/* PL_REQUEST_EXCLUDE: */
@@ -1456,6 +1459,7 @@ struct pfn_list_request {
  * the list of pfn's itself is pointed to by pfn_list
  */
 struct pfn_reply {
+	int status;		/* PL_REQUEST_PAGE returned status  0 is ok */
 	long pfn_list_elements;	/* negoiated on PL_REQUEST_MEMMAP */
 	long in_pfn_list;	/* returned by PL_REQUEST_EXCLUDE and
 				   PL_REQUEST_FREE */

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--+QahgC5+KEYLbs62--

