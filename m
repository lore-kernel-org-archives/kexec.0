Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYsVw-0007Rp-Cx
 for kexec@lists.infradead.org; Mon, 17 Dec 2018 13:00:56 +0000
Date: Mon, 17 Dec 2018 14:00:24 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2 v3] kdump: add the vmcoreinfo documentation
Message-ID: <20181217130024.GD12165@zn.tnic>
References: <20181216131617.2612-1-lijiang@redhat.com>
 <20181216131617.2612-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181216131617.2612-2-lijiang@redhat.com>
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: bhe@redhat.com, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On Sun, Dec 16, 2018 at 09:16:16PM +0800, Lianbo Jiang wrote:
> +clear_idx
> +=========
> +The index that the next printk record to read after the last 'clear'
> +command. It indicates the first record after the last SYSLOG_ACTION
> +_CLEAR, like issued by 'dmesg -c'.

What is that used for by the userspace tools?

> +
> +log_next_idx
> +============
> +The index of the next record to store in the buffer 'log_buf'. It helps
> +to compute the index of current strings position.
> +
> +printk_log
> +==========
> +The size of a structure 'printk_log'. It helps to compute the size of
> +messages, and extract dmesg log.

What is the difference between that and log_buf?



> +
> +(printk_log, ts_nsec|len|text_len|dict_len)
> +===========================================
> +It represents these field offsets in the structure 'printk_log'. User
> +space tools can parse it and detect any changes to structure down the
> +line.

What does that mean? "any changes down the line"?

> +
> +(free_area.free_list, MIGRATE_TYPES)
> +====================================
> +The number of migrate types for pages. The free_list is divided into
> +the array, it needs to know the number of the array.

... for?

> +
> +NR_FREE_PAGES
> +=============
> +On linux-2.6.21 or later, the number of free_pages is in
> +vm_stat[NR_FREE_PAGES]. It can get the number of free pages from the
> +array.
> +
> +PG_lru|PG_private|PG_swapcache|PG_swapbacked|PG_slab|
> +PG_hwpoision|PG_head_mask
> +=====================================================
> +It means the attribute of a page. These flags will be used to filter
> +the free pages.
> +
> +PAGE_BUDDY_MAPCOUNT_VALUE or ~PG_buddy
> +======================================
> +The 'PG_buddy' flag indicates that the page is free and in the buddy
> +system. Makedumpfile can exclude the free pages managed by a buddy.

That text belongs with the one above?

> +
> +HUGETLB_PAGE_DTOR
> +=================
> +The 'HUGETLB_PAGE_DTOR' flag indicates the hugetlbfs pages. Makedumpfile
> +will exclude these pages.
> +
> +================
> +x86_64 variables
> +================
> +
> +phys_base
> +=========
> +In x86_64, the 'phys_base' is necessary to convert virtual address of
> +exported kernel symbol to physical address.
> +
> +init_top_pgt
> +============
> +The 'init_top_pgt' used to walk through the whole page table and convert
> +virtual address to physical address.

This is the same as swapper_pg_dir?

> +
> +pgtable_l5_enabled
> +==================
> +User-space tools need to know whether the crash kernel was in 5-level
> +paging mode or not.
> +
> +node_data
> +=========
> +This is a struct 'pglist_data' array, it stores all numa nodes information.
> +In general, Makedumpfile can get the pglist_data structure from symbol
> +'node_data'.
> +
> +(node_data, MAX_NUMNODES)
> +=========================
> +The number of this 'node_data' array. It means the maximum number of the
> +nodes in system.
> +
> +KERNELOFFSET
> +============
> +Randomize the address of the kernel image. This is the offset of KASLR in
> +VMCOREINFO ELF notes. It is used to compute the page offset in x86_64. If
> +KASLE is disabled, this value is zero.
> +
> +KERNEL_IMAGE_SIZE
> +=================
> +The size of 'KERNEL_IMAGE_SIZE', currently unused.

So remove?

> +
> +The old MODULES_VADDR need be decided by KERNEL_IMAGE_SIZE when kaslr
> +enabled. Now MODULES_VADDR is not needed any more since Pratyush makes
> +all VA to PA converting done by page table lookup.

Also, I did clean this up considerably - please include in your next
version:

---
diff --git a/Documentation/kdump/vmcoreinfo.txt b/Documentation/kdump/vmcoreinfo.txt
index d71260bf383a..2ce34d952bfd 100644
--- a/Documentation/kdump/vmcoreinfo.txt
+++ b/Documentation/kdump/vmcoreinfo.txt
@@ -1,18 +1,19 @@
 ================================================================
-		Documentation for VMCOREINFO
+			VMCOREINFO
 ================================================================
 
 =======================
 What is the VMCOREINFO?
 =======================
-It is a special ELF note section. The VMCOREINFO contains the first
-kernel's various information, for example, structure size, page size,
-symbol values and field offset, etc. These data are packed into an ELF
-note section, and these data will also help user-space tools(e.g. crash
-makedumpfile) analyze the first kernel's memory usage.
-
-In general, makedumpfile can dump the VMCOREINFO contents from vmlinux
-in the first kernel. For example:
+
+VMCOREINFO is a special ELF note section. It contains various
+information from the kernel like structure size, page size, symbol
+values, field offsets, etc. These data are packed into an ELF note
+section and used by user-space tools like crash and makedumpfile to
+analyze a kernel's memory layout.
+
+To dump the VMCOREINFO contents, one can do:
+
 # makedumpfile -g VMCOREINFO -x vmlinux
 
 ================
@@ -20,123 +21,132 @@ Common variables
 ================
 
 init_uts_ns.name.release
-========================
-The number of OS release. Based on this version number, people can find
-the source code for the corresponding version. When analyzing the vmcore,
-people must read the source code to find the reason why the kernel crashed.
+------------------------
+
+The version of the Linux kernel. Used to find the corresponding source
+code from which the kernel has been built.
 
 PAGE_SIZE
-=========
-The size of a page. It is the smallest unit of data for memory management
-in kernel. It is usually 4k bytes and the page is aligned in 4k bytes,
-which is very important for computing address.
+---------
+
+The size of a page. It is the smallest unit of data for memory
+management in kernel. It is usually 4096 bytes and a page is aligned on
+4096 bytes. Used for computing page addresses.
 
 init_uts_ns
-===========
-This is the UTS namespace, which is used to isolate two specific elements
-of the system that relate to the uname system call. The UTS namespace is
-named after the data structure used to store information returned by the
-uname system call.
+-----------
+
+This is the UTS namespace, which is used to isolate two specific
+elements of the system that relate to the uname(2) system call. The UTS
+namespace is named after the data structure used to store information
+returned by the uname(2) system call.
 
-User-space tools can get the kernel name, host name, kernel release number,
-kernel version, architecture name and OS type from the 'init_uts_ns'.
+User-space tools can get the kernel name, host name, kernel release
+number, kernel version, architecture name and OS type from it.
 
 node_online_map
-===============
-It is a macro definition, actually it is an array node_states[N_ONLINE],
-and it represents the set of online node in a system, one bit position
-per node number.
+---------------
 
-This is used to keep track of which nodes are in the system and online.
+An array node_states[N_ONLINE] which represents the set of online node
+in a system, one bit position per node number. Used to keep track of
+which nodes are in the system and online.
 
 swapper_pg_dir
-=============
-It generally indicates the pgd for the kernel. When mmu is enabled in
-config file, the 'swapper_pg_dir' is valid.
+-------------
 
-The 'swapper_pg_dir' helps to translate the virtual address to a physical
-address.
+The global page directory pointer of the kernel. Used to translate
+virtual to physical addresses.
 
 _stext
-======
-It is an assemble symbol that defines the beginning of the text section.
-In general, the '_stext' indicates the kernel start address. This is used
-to convert a virtual address to a physical address when the virtual address
-does not belong to the 'vmalloc' address.
+------
+
+Defines the beginning of the text section. In general, _stext indicates
+the kernel start address. Used to convert a virtual address from the
+direct kernel map to a physical address.
 
 vmap_area_list
-==============
-It stores the virtual area list, makedumpfile can get the vmalloc start
+--------------
+
+Stores the virtual area list. makedumpfile can get the vmalloc start
 value from this variable. This value is necessary for vmalloc translation.
 
 mem_map
-=======
-Physical addresses are translated to struct pages by treating them as an
-index into the mem_map array. Shifting a physical address PAGE_SHIFT bits
-to the right will treat it as a PFN from physical address 0, which is also
-an index within the mem_map array.
+-------
+
+Physical addresses are translated to struct pages by treating them as
+an index into the mem_map array. Right-shifting a physical address
+PAGE_SHIFT bits converts it into a page frame number which is an index
+into that mem_map array.
 
-In short, it can map the address to struct page.
+Used to map an address to the corresponding struct page.
 
 contig_page_data
-================
-Makedumpfile can get the pglist_data structure from this symbol
-'contig_page_data'. The pglist_data structure is used to describe the
-memory layout.
+----------------
 
-User-space tools can use this symbols for excluding free pages.
+Makedumpfile can get the pglist_data structure from this symbol, which
+is used to describe the memory layout.
+
+User-space tools use this to exclude free pages when dumping memory.
 
 mem_section|(mem_section, NR_SECTION_ROOTS)|(mem_section, section_mem_map)
-==========================================================================
-Export the address of 'mem_section' array, and it's length, structure size,
-and the 'section_mem_map' offset.
+--------------------------------------------------------------------------
+
+The address of the mem_section array, its length, structure size, and
+the section_mem_map offset.
 
 It exists in the sparse memory mapping model, and it is also somewhat
-similar to the mem_map variable, both of them will help to translate
-the address.
+similar to the mem_map variable, both of them are used to translate an
+address.
 
 page
-====
-The size of a 'page' structure. In kernel, the page is an important data
-structure, it is widely used to compute the continuous memory.
+----
+
+The size of a page structure. struct page is an important data structure
+and it is widely used to compute the contiguous memory.
 
 pglist_data
-===========
-The size of a 'pglist_data' structure. This value will be used to check if
-the 'pglist_data' structure is valid. It is also one of the conditions for
-checking the memory type.
+-----------
+
+The size of a pglist_data structure. This value will be used to check
+if the pglist_data structure is valid. It is also used for checking the
+memory type.
 
 zone
-====
-The size of a 'zone' structure. This value is often used to check if the
-'zone' structure is found. It is necessary structures for excluding free
-pages.
+----
+
+The size of a zone structure. This value is often used to check if the
+zone structure has been found. It is also used for excluding free pages.
 
 free_area
-=========
-The size of a 'free_area' structure. It indicates whether the 'free_area'
-structure is valid or not. This is useful for excluding free pages.
+---------
+
+The size of a free_area structure. It indicates whether the free_area
+structure is valid or not. Useful for excluding free pages.
 
 list_head
-=========
-The size of a 'list_head' structure. It depends on this value when
-iterating the free list.
+---------
+
+The size of a list_head structure. Used when iterating lists in a
+post-mortem analysis session.
 
 nodemask_t
-==========
-The size of a 'nodemask_t' type. This value is used to compute the number
+----------
+
+The size of a nodemask_t type. This value is used to compute the number
 of online nodes.
 
 (page, flags|_refcount|mapping|lru|_mapcount|private|compound_dtor|
        compound_order|compound_head)
-===================================================================
+-------------------------------------------------------------------
+
 User-space tools can compute their values based on the offset of these
 variables. The variables are helpful to exclude unnecessary pages.
 
 (pglist_data, node_zones|nr_zones|node_mem_map|node_start_pfn|node_
               spanned_pages|node_id)
-===================================================================
-On NUMA machines, each NUMA node has a pg_data_t to describe it's memory
+-------------------------------------------------------------------
+
+On NUMA machines, each NUMA node has a pg_data_t to describe its memory
 layout. On UMA machines there is a single pglist_data which describes the
 whole memory.
 
@@ -144,16 +154,18 @@ These values are used to check the memory type, and they are also helpful
 to compute the virtual address for memory map.
 
 (zone, free_area|vm_stat|spanned_pages)
-=======================================
-Each node is divided up into a number of blocks called zones which
+---------------------------------------
+
+Each node is divided into a number of blocks called zones which
 represent ranges within memory. A zone is described by a structure zone.
 Each zone type is suitable for a different type of usage.
 
-User-space tools can compute their values based on the offset of these
+User-space tools can compute required values based on the offset of these
 variables.
 
 (free_area, free_list)
-======================
+----------------------
+
 Offset of the free_list's member. This value is used to compute the number
 of free pages.
 
@@ -162,295 +174,325 @@ The fields in this structure are simple, the free_list represents a linked
 list of free page blocks.
 
 (list_head, next|prev)
-======================
-Offsets of the list_head's members. In general, the list_head is used to
-define a circular linked list. User-space tools often need to traverse
-the lists to get specific pages.
+----------------------
+
+Offsets of the list_head's members. list_head is used to define a
+circular linked list. User-space tools need these in order to traverse
+lists.
 
 (vmap_area, va_start|list)
-==========================
+--------------------------
+
 Offsets of the vmap_area's members. They indicate the vmalloc layer
-information. Makedumpfile can get the start address of vmalloc region.
+information. Makedumpfile gets the start address of the vmalloc region.
 
 (zone.free_area, MAX_ORDER)
-===========================
+---------------------------
+
 It indicates the maximum number of the array free_area. This macro is
-used to the zone buddy allocator. User-space tools use this value to
+used by the zone buddy allocator. User-space tools use this value to
 iterate the free_area.
 
 log_buf
-=======
-In general, console output is written to the ring buffer 'log_buf' at
-index 'log_first_idx'. It can get kernel log from the log_buf.
+-------
+
+Console output is written to the ring buffer log_buf at index
+log_first_idx. Used to get the kernel log.
 
 log_buf_len
-===========
-Length of a 'log_buf'. Makedumpfile can read the number of strings
-from the log_buf.
+-----------
 
-log_first_idx
-=============
-Index of the first record stored in the buffer 'log_buf'. This value
-tells the user-space tools the place where to read the strings in the
+Length of a log_buf. Used to read the number of strings from the
 log_buf.
 
+log_first_idx
+-------------
+
+Index of the first record stored in the buffer log_buf. Used by
+user-space tools to read the strings in the log_buf.
+
 clear_idx
-=========
-The index that the next printk record to read after the last 'clear'
+---------
+
+The index that the next printk() record to read after the last clear
 command. It indicates the first record after the last SYSLOG_ACTION
 _CLEAR, like issued by 'dmesg -c'.
 
 log_next_idx
-============
-The index of the next record to store in the buffer 'log_buf'. It helps
-to compute the index of current strings position.
+------------
+
+The index of the next record to store in the buffer log_buf. Used to
+compute the index of the current string position.
 
 printk_log
-==========
-The size of a structure 'printk_log'. It helps to compute the size of
+----------
+
+The size of a structure printk_log. Used to compute the size of
 messages, and extract dmesg log.
 
 (printk_log, ts_nsec|len|text_len|dict_len)
-===========================================
-It represents these field offsets in the structure 'printk_log'. User
-space tools can parse it and detect any changes to structure down the
-line.
+-------------------------------------------
+
+It represents field offsets in struct printk_log. User space tools can
+parse it and detect any changes to structure down the line.
 
 (free_area.free_list, MIGRATE_TYPES)
-====================================
+------------------------------------
+
 The number of migrate types for pages. The free_list is divided into
 the array, it needs to know the number of the array.
 
 NR_FREE_PAGES
-=============
+-------------
+
 On linux-2.6.21 or later, the number of free_pages is in
-vm_stat[NR_FREE_PAGES]. It can get the number of free pages from the
-array.
+vm_stat[NR_FREE_PAGES]. Used to get the number of free pages.
 
 PG_lru|PG_private|PG_swapcache|PG_swapbacked|PG_slab|
 PG_hwpoision|PG_head_mask
-=====================================================
-It means the attribute of a page. These flags will be used to filter
-the free pages.
+-----------------------------------------------------a
+
+Page attributes. These flags are used to filter free pages.
 
 PAGE_BUDDY_MAPCOUNT_VALUE or ~PG_buddy
-======================================
-The 'PG_buddy' flag indicates that the page is free and in the buddy
+--------------------------------------
+
+The PG_buddy flag indicates that the page is free and in the buddy
 system. Makedumpfile can exclude the free pages managed by a buddy.
 
 HUGETLB_PAGE_DTOR
-=================
-The 'HUGETLB_PAGE_DTOR' flag indicates the hugetlbfs pages. Makedumpfile
-will exclude these pages.
+-----------------
 
-================
-x86_64 variables
-================
+The HUGETLB_PAGE_DTOR flag denotes hugetlbfs pages. Makedumpfile
+excludes these pages.
+
+======
+x86_64
+======
 
 phys_base
-=========
-In x86_64, the 'phys_base' is necessary to convert virtual address of
-exported kernel symbol to physical address.
+---------
+
+Used to convert the virtual address of an exported kernel symbol to its
+physical address.
 
 init_top_pgt
-============
-The 'init_top_pgt' used to walk through the whole page table and convert
-virtual address to physical address.
+------------
+
+Used to walk through the whole page table and convert virtual addresses
+to physical addresses.
 
 pgtable_l5_enabled
-==================
+------------------
+
 User-space tools need to know whether the crash kernel was in 5-level
-paging mode or not.
+paging mode.
 
 node_data
-=========
-This is a struct 'pglist_data' array, it stores all numa nodes information.
-In general, Makedumpfile can get the pglist_data structure from symbol
-'node_data'.
+---------
+
+This is a struct pglist_data array and stores all numa nodes
+information. Makedumpfile gets the pglist_data structure from it.
 
 (node_data, MAX_NUMNODES)
-=========================
-The number of this 'node_data' array. It means the maximum number of the
-nodes in system.
+-------------------------
+
+The maximum number of the nodes in system.
 
 KERNELOFFSET
-============
-Randomize the address of the kernel image. This is the offset of KASLR in
-VMCOREINFO ELF notes. It is used to compute the page offset in x86_64. If
-KASLE is disabled, this value is zero.
+------------
+
+The kernel randomization offset. Used to compute the page offset. If
+KASLR is disabled, this value is zero.
 
 KERNEL_IMAGE_SIZE
-=================
-The size of 'KERNEL_IMAGE_SIZE', currently unused.
+-----------------
 
-The old MODULES_VADDR need be decided by KERNEL_IMAGE_SIZE when kaslr
-enabled. Now MODULES_VADDR is not needed any more since Pratyush makes
-all VA to PA converting done by page table lookup.
+Currently unused.
 
 PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_offline)
-========================================
-The value of 'PG_offline' flag can be used for marking pages as logically
-offline. Makedumpfile can directly skip pages that are logically offline.
+----------------------------------------
+
+The value of PG_offline flag can be used for marking pages as logically
+offline. Makedumpfile skips pages that are logically offline.
 
 sme_mask
-========
-For AMD machine with SME feature, it indicates the secure memory encryption
-mask. Makedumpfile tools need to know whether the crash kernel was encrypted
-or not. If SME is enabled in the first kernel, the crash kernel's page
-table(pgd/pud/pmd/pte) contains the memory encryption mask, so need to
-remove the sme mask to obtain the true physical address.
+--------
 
-=============
-x86 variables
-=============
+For AMD machine with SME feature, it indicates the secure memory
+encryption mask. Makedumpfile tools need to know whether the crash
+kernel was encrypted. If SME is enabled in the first kernel, the crash
+kernel's page table (pgd/pud/pmd/pte) contains the memory encryption
+mask and this is used to remove the SME mask to obtain the true physical
+address.
+
+======
+x86_32
+======
 
 X86_PAE
-=======
-It means the physical address extension. It has the cost of more
-page table lookup overhead, and also consumes more page table space
-per process. This flag will be used to check whether the PAE was
-enabled in crash kernel or not when converting virtual address to
-physical address.
+-------
 
-==============
-ia64 variables
-==============
+Denotes whether physical address extensions are enabled. It has the cost
+of more page table lookup overhead, and also consumes more page table
+space per process. Used to check whether PAE was enabled in the crash
+kernel when converting virtual addresses to physical addresses.
+
+====
+ia64
+====
 
 pgdat_list|(pgdat_list, MAX_NUMNODES)
-=====================================
-This is a struct 'pg_data_t' array, it stores all numa nodes information.
-And the 'MAX_NUMNODES' indicates the number of the nodes.
+-------------------------------------
+
+pg_data_t array storing all numa nodes information. MAX_NUMNODES
+indicates the number of the nodes.
 
 node_memblk|(node_memblk, NR_NODE_MEMBLKS)
-==========================================
+------------------------------------------
+
 List of node memory chunks. Filled when parsing SRAT table to obtain
-information about memory nodes. The 'NR_NODE_MEMBLKS' indicates the number
+information about memory nodes. NR_NODE_MEMBLKS indicates the number
 of node memory chunks.
 
-These values are used to compute the number of nodes in crash kernel.
+These values are used to compute the number of nodes in the crash kernel.
 
 node_memblk_s|(node_memblk_s, start_paddr)|(node_memblk_s, size)
-================================================================
-The size of a struct 'node_memblk_s', and the offsets of the
-node_memblk_s's members. It helps to compute the number of nodes.
+----------------------------------------------------------------
+
+The size of a struct node_memblk_s and the offsets of the
+node_memblk_s's members. Used to compute the number of nodes.
 
 PGTABLE_3|PGTABLE_4
-===================
+-------------------
+
 User-space tools need to know whether the crash kernel was in 3-level or
-4-level paging mode. This flag can help to distinguish the page table.
+4-level paging mode. Used to distinguish the page table.
 
-===============
-arm64 variables
-===============
+=====
+ARM64
+=====
 
 VA_BITS
-=======
-The maximum number of bits for virtual addresses. This value helps to
-compute the virtual memory ranges.
+-------
+
+The maximum number of bits for virtual addresses. Used to compute the
+virtual memory ranges.
 
 kimage_voffset
-==============
-The offset between the kernel virtual and physical mappings. This value
-helps to translate virtual address to physical address.
+--------------
+
+The offset between the kernel virtual and physical mappings. Used to
+translate virtual to physical addresses.
 
 PHYS_OFFSET
-===========
-It indicates the physical address of the start of memory. It is similar
-with the kimage_voffset, which is used to translate virtual address to
-physical address.
+-----------
+
+Indicates the physical address of the start of memory. Similar to
+kimage_voffset, which is used to translate virtual address to physical
+address.
 
 KERNELOFFSET
-============
-It is similar to x86_64.
+------------
+
+The kernel randomization offset. Used to compute the page offset. If
+KASLR is disabled, this value is zero.
 
 =============
 arm variables
 =============
 
 ARM_LPAE
-========
-It indicates whether the crash kernel support the large physical address
-extension. This value will tell you how to translate virtual address to
-physical address.
+--------
 
-==============
-s390 variables
-==============
+It indicates whether the crash kernel supports large physical address
+extensions. Used to translate virtual address to physical address.
+
+====
+s390
+====
 
 lowcore_ptr
-==========
-An array with a pointer to the lowcore of every CPU. This value
-helps to print the psw and all registers information.
+----------
+
+An array with a pointer to the lowcore of every CPU. Used to print the
+psw and all registers information.
 
 high_memory
-===========
-It can get the vmalloc_start address from the high_memory symbol.
+-----------
+
+Used to get the vmalloc_start address from the high_memory symbol.
 
 (lowcore_ptr, NR_CPUS)
-======================
-The maximum number of cpus.
+----------------------
 
-TODO.
+The maximum number of CPUs.
+
+=======
+powerpc
+=======
 
-powerpc variables
-=================
 
 node_data|(node_data, MAX_NUMNODES)
-===================================
-Please refer to common variables.
+-----------------------------------
+
+See above.
 
 contig_page_data
-================
-Please refer to common variables.
+----------------
+
+See above.
 
 vmemmap_list
-============
-The 'vmemmap_list' maintains the entire vmemmap physical mapping. It
-can get vmemmap list count and populate vmemmap regions info. If the
-vmemmap address translation information is stored in crash kernel,
-which helps to translate vmemmap kernel virtual addresses.
+------------
+
+The vmemmap_list maintains the entire vmemmap physical mapping. It can
+get vmemmap list count and populate vmemmap regions info. If the vmemmap
+address translation information is stored in the crash kernel, it helps
+to translate vmemmap kernel virtual addresses.
 
 mmu_vmemmap_psize
-=================
-The size of a page. It will try to use this page sizes for vmemmap if
-support. This value helps to translate virtual address to physical
-address.
+-----------------
+
+The size of a page. Used to translate address to physical addresses.
 
 mmu_psize_defs
-==============
-It stores a variety of pages, such as the page size is 4k, 64k, or 16M.
+--------------
 
-It depends on this value when making vtop translations.
+Page size definitions, i.e. 4k, 64k, or 16M.
+
+Used to make vtop translations.
 
 vmemmap_backing|(vmemmap_backing, list)|(vmemmap_backing, phys)|
 (vmemmap_backing, virt_addr)
-================================================================
+----------------------------------------------------------------
+
 The vmemmap virtual address space management does not have a traditional
 page table to track which virtual struct pages are backed by physical
 mapping. The virtual to physical mappings are tracked in a simple linked
 list format.
 
-And user-space tools need to know the offset of 'list', 'phys' and
-'virt_addr'. It depends on these values when computing the count of
-vmemmap regions.
+User-space tools need to know the offset of list, phys and virt_addr
+when computing the count of vmemmap regions.
 
 mmu_psize_def|(mmu_psize_def, shift)
-====================================
-The size of a struct 'mmu_psize_def', and the offset of mmu_psize_def's
+------------------------------------
+
+The size of a struct mmu_psize_def and the offset of mmu_psize_def's
 member.
 
-These values help to make the vtop translations.
+Used in vtop translations.
 
-============
-sh variables
-============
+==
+sh
+==
 
 node_data|(node_data, MAX_NUMNODES)
-===================================
-It is similar to X86_64, please refer to above description.
+-----------------------------------
+
+See above.
 
 X2TLB
-=====
-It indicates whether the crash kernel enables the extended mode of the SH.
+-----
 
-TODO.
+Indicates whether the crash kernel enables SH extended mode.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
