Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.eu.citrix.com ([62.200.22.115])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JoEQD-0006CB-Pe
	for kexec@lists.infradead.org; Tue, 22 Apr 2008 09:04:18 +0000
Date: Tue, 22 Apr 2008 09:53:46 +0100
Subject: Re: [Xen-devel] handle x86_64 xen code/data relocation 
From: Keir Fraser <keir.fraser@eu.citrix.com>
Message-ID: <C433662A.1FDAC%keir.fraser@eu.citrix.com>
In-Reply-To: <20080422154506.BDB1.ODA@valinux.co.jp>
Mime-version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Itsuro ODA <oda@valinux.co.jp>, kexec@lists.infradead.org
Cc: xen-devel@lists.xensource.com, crash-utility@redhat.com

While you're thinking about this, I'll also point out that the 'xen heap'
will be going away quite soon. That's an inconvenience for kdump since
currently Xen's own allocations are conveniently squashed up in a small
range of a few megabytes of memory. I'm not sure what the right fix is for
kdump -- either you don't get Xen's dynamically-allocated state, or you'll
have to gather it up at kdump time somehow.

 -- Keir

On 22/4/08 09:32, "Itsuro ODA" <oda@valinux.co.jp> wrote:

> Hi all,
> 
> Recent version of xen (ex. RHEL5.2, 3.2.0) on the x86_64
> moves the physical(machine) address of xen code/data area after
> the system started up. The start address of this is stored in
> 'xen_phys_start'. Thus to get a machine address of a xen text symbol
> from its virtual address, calculate
> "va - __XEN_VIRT_START +  xen_phys_start".
> 
> crash and makedumpfile command need the value of xen_phys_start.
> They know the virtual address of 'xen_phys_start' symbol but
> no way to extract the value of xen_phys_start.
> 
> I think adding the xen_phys_start value to the CRASHINFO ElfNote
> section at first. (Plan A: patch for xen hypervisor code attaced)
> It is smallest modification necessary over all.
> 
> On the other hand there is a opinion that it is better to upgrade
> a user-package than a hypervisor or kernel package.
> The xen_phys_start value can be got from /proc/iomem.
>     -------------------------------------------------------
>     # cat /proc/iomem
>     ...
>       7e600000-7f5fffff : Hypervisor code and data  *** this line
>     ...
>     -------------------------------------------------------
> So the kexec-tools can handle it theoretically.
> 
> The Plan B is that kexec-tools adds another ElfNote section which
> holds the xen_phys_start value. The attached patch works well
> though I am concern about it is a bit tricky.
> 
> Which plan is better ?  Or more good implementation ?
> Please comment.
> 
> (note that crash and makedumpfile modification is same degree
> for both plan.)
> 
> Thanks.
> Itsuro Oda
> 
> === Plan A (modify the xen hypervisor. It is for RHEL5.2 but almost same for
> other version) ===
> --- include/xen/elfcore.h.org 2008-04-17 14:11:41.000000000 +0900
> +++ include/xen/elfcore.h 2008-04-17 14:11:57.000000000 +0900
> @@ -66,6 +66,7 @@
>      unsigned long xen_compile_time;
>      unsigned long tainted;
>  #ifdef CONFIG_X86
> +    unsigned long xen_phys_start;
>      unsigned long dom0_pfn_to_mfn_frame_list_list;
>  #endif
>  } crash_xen_info_t;
> --- arch/x86/crash.c.org 2008-04-17 14:12:51.000000000 +0900
> +++ arch/x86/crash.c 2008-04-17 14:13:13.000000000 +0900
> @@ -102,6 +102,7 @@
>      hvm_disable();
>  
>      info = kexec_crash_save_info();
> +    info->xen_phys_start = xen_phys_start;
>      info->dom0_pfn_to_mfn_frame_list_list =
>          arch_get_pfn_to_mfn_frame_list_list(dom0);
>  }
> ================================================================
> 
> === Plan B (modify the kexec-tools. proof of concept version) ===
> diff -ru kexec-tools-testing-20080324.org/kexec/arch/x86_64/crashdump-x86_64.c
> kexec-tools-testing-20080324/kexec/arch/x86_64/crashdump-x86_64.c
> --- 
> kexec-tools-testing-20080324.org/kexec/arch/x86_64/crashdump-x86_64.c 2008-03-
> 21 13:16:28.000000000 +0900
> +++ 
> kexec-tools-testing-20080324/kexec/arch/x86_64/crashdump-x86_64.c 2008-04-22
> 15:15:08.000000000 +0900
> @@ -73,6 +73,25 @@
> return -1;
>  }
>  
> +static int get_hypervisor_paddr(struct kexec_info *info)
> +{
> + uint64_t start;
> +
> + if (!xen_present())
> +  return 0;
> +
> + if (parse_iomem_single("Hypervisor code and data\n", &start, NULL) == 0) {
> +  info->hypervisor_paddr_start = start;
> +#ifdef DEBUG
> +  printf("kernel load physical addr start = 0x%016Lx\n", start);
> +#endif
> +  return 0;
> + }
> +
> + fprintf(stderr, "Cannot determine hypervisor physical load addr\n");
> + return -1;
> +}
> +
>  /* Retrieve info regarding virtual address kernel has been compiled for and
>   * size of the kernel from /proc/kcore. Current /proc/kcore parsing from
>   * from kexec-tools fails because of malformed elf notes. A kernel patch has
> @@ -581,6 +600,9 @@
> if (get_kernel_paddr(info))
> return -1;
>  
> + if (get_hypervisor_paddr(info))
> +  return -1;
> +
> if (get_kernel_vaddr_and_size(info))
> return -1;
>  
> @@ -620,6 +642,9 @@
> */
> elfcorehdr = add_buffer(info, tmp, sz, 16*1024, align, min_base,
> max_addr, -1);
> + if (info->hypervisor_paddr_start && xen_present()) {
> +  *(info->hypervisor_paddr_loc) += elfcorehdr;
> + }
> if (delete_memmap(memmap_p, elfcorehdr, sz) < 0)
> return -1;
> cmdline_add_memmap(mod_cmdline, memmap_p);
> diff -ru kexec-tools-testing-20080324.org/kexec/crashdump.c
> kexec-tools-testing-20080324/kexec/crashdump.c
> --- kexec-tools-testing-20080324.org/kexec/crashdump.c 2008-03-21
> 13:16:28.000000000 +0900
> +++ kexec-tools-testing-20080324/kexec/crashdump.c 2008-04-22
> 15:33:47.000000000 +0900
> @@ -36,8 +36,10 @@
>  #define FUNC crash_create_elf64_headers
>  #define EHDR Elf64_Ehdr
>  #define PHDR Elf64_Phdr
> +#define NHDR Elf64_Nhdr
>  #include "crashdump-elf.c"
>  #undef ELF_WIDTH
> +#undef NHDR
>  #undef PHDR
>  #undef EHDR
>  #undef FUNC
> @@ -46,8 +48,10 @@
>  #define FUNC crash_create_elf32_headers
>  #define EHDR Elf32_Ehdr
>  #define PHDR Elf32_Phdr
> +#define NHDR Elf32_Nhdr
>  #include "crashdump-elf.c"
>  #undef ELF_WIDTH
> +#undef NHDR
>  #undef PHDR
>  #undef EHDR
>  #undef FUNC
> diff -ru kexec-tools-testing-20080324.org/kexec/crashdump-elf.c
> kexec-tools-testing-20080324/kexec/crashdump-elf.c
> --- kexec-tools-testing-20080324.org/kexec/crashdump-elf.c 2008-01-11
> 12:13:48.000000000 +0900
> +++ kexec-tools-testing-20080324/kexec/crashdump-elf.c 2008-04-22
> 15:35:16.000000000 +0900
> @@ -1,6 +1,6 @@
>  
> -#if !defined(FUNC) || !defined(EHDR) || !defined(PHDR)
> -#error FUNC, EHDR and PHDR must be defined
> +#if !defined(FUNC) || !defined(EHDR) || !defined(PHDR) || !defined(NHDR)
> +#error FUNC, EHDR, PHDR and NHDR must be defined
>  #endif
>  
>  #if (ELF_WIDTH == 64)
> @@ -37,6 +37,7 @@
> uint64_t vmcoreinfo_addr, vmcoreinfo_len;
> int has_vmcoreinfo = 0;
> int (*get_note_info)(int cpu, uint64_t *addr, uint64_t *len);
> + int has_hypervisor_paddr_start = 0;
>  
> if (xen_present())
> nr_cpus = xen_get_nr_phys_cpus();
> @@ -78,6 +79,11 @@
> sz += sizeof(PHDR);
> }
>  
> + if (info->hypervisor_paddr_start && xen_present()) {
> +  sz += sizeof(PHDR) + sizeof(NHDR) + 4 + sizeof(unsigned long);
> +  has_hypervisor_paddr_start = 1;
> + }
> +
> /*
> * Make sure the ELF core header is aligned to at least 1024.
> * We do this because the secondary kernel gets the ELF core
> @@ -168,6 +174,22 @@
> dbgprintf_phdr("vmcoreinfo header", phdr);
> }
>  
> + if (has_hypervisor_paddr_start) {
> +  phdr = (PHDR *) bufp;
> +  bufp += sizeof(PHDR);
> +  phdr->p_type = PT_NOTE;
> +  phdr->p_flags = 0;
> +  phdr->p_offset  = phdr->p_paddr = 0;
> +  phdr->p_vaddr   = 0;
> +  phdr->p_filesz = phdr->p_memsz = sizeof(NHDR) + 4 + sizeof(unsigned long);
> +  phdr->p_align = 0;
> +
> +  (elf->e_phnum)++;
> +  dbgprintf_phdr("hypervisor phys addr header", phdr);
> +
> +  info->hypervisor_paddr_loc = (unsigned long *)&phdr->p_offset;
> + }
> +
> /* Setup an PT_LOAD type program header for the region where
> * Kernel is mapped if info->kern_size is non-zero.
> */
> @@ -225,6 +247,24 @@
> (elf->e_phnum)++;
> dbgprintf_phdr("Elf header", phdr);
> }
> +
> + if (has_hypervisor_paddr_start) {
> +  NHDR *nhdr;
> +  unsigned int offset = (void *)bufp - *buf;
> +
> +  nhdr = (NHDR *) bufp;
> +  bufp += sizeof(NHDR);
> +  nhdr->n_namesz = 4;
> +  nhdr->n_descsz = sizeof(unsigned long);
> +  nhdr->n_type = 0x1000003;
> +  memcpy(bufp, "Xen", 4);
> +  bufp += 4;
> +  *((unsigned long *)bufp) = info->hypervisor_paddr_start;
> +  bufp += sizeof(unsigned long);
> +
> +  *(info->hypervisor_paddr_loc) = offset;
> + }
> +
> return 0;
>  }
>  
> diff -ru kexec-tools-testing-20080324.org/kexec/kexec.h
> kexec-tools-testing-20080324/kexec/kexec.h
> --- kexec-tools-testing-20080324.org/kexec/kexec.h 2008-03-21
> 13:16:28.000000000 +0900
> +++ kexec-tools-testing-20080324/kexec/kexec.h 2008-04-22 15:08:57.000000000
> +0900
> @@ -123,6 +123,8 @@
> unsigned long kern_vaddr_start;
> unsigned long kern_paddr_start;
> unsigned long kern_size;
> + unsigned long hypervisor_paddr_start;
> + unsigned long *hypervisor_paddr_loc;
>  };
>  
>  void usage(void);
> ==============================================================================
> ========



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
