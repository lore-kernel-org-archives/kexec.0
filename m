Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KC2Lf-0003o9-5R
	for kexec@lists.infradead.org; Fri, 27 Jun 2008 01:01:59 +0000
Message-Id: <48643C01.6000108@mxs.nes.nec.co.jp>
Date: Fri, 27 Jun 2008 10:01:53 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: Remove trailing whitespace
References: <20080626130408.GA28200@suse.de>
In-Reply-To: <20080626130408.GA28200@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0847607440=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org

--===============0847607440==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Thank you for the patch.
I will apply the patch to the next release.


Thanks
Ken'ichi Ohmichi

Bernhard Walle wrote:
> This is just a cleanup patch that removes trailing whitespace from
> implementation files.
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> 
> ---
>  diskdump_mod.h |    2 +-
>  ia64.c         |    4 ++--
>  makedumpfile.c |   52 ++++++++++++++++++++++++++--------------------------
>  makedumpfile.h |    2 +-
>  ppc64.c        |    2 +-
>  x86.c          |    4 ++--
>  x86_64.c       |    4 ++--
>  7 files changed, 35 insertions(+), 35 deletions(-)
> 
> --- a/diskdump_mod.h
> +++ b/diskdump_mod.h
> @@ -1,4 +1,4 @@
> -/* 
> +/*
>   * diskdump.h
>   *
>   * Copyright (C) 2004, 2005 David Anderson
> --- a/ia64.c
> +++ b/ia64.c
> @@ -1,4 +1,4 @@
> -/* 
> +/*
>   * ia64.c
>   *
>   * Copyright (C) 2006, 2007  NEC Corporation
> @@ -293,7 +293,7 @@ kvtop_xen_ia64(unsigned long kvaddr)
>  	dirp += ((addr >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1)) * sizeof(unsigned long long);
>  	if (!readmem(PADDR, dirp, &entry, sizeof(entry)))
>  		return NOT_PADDR;
> - 
> +
>  	dirp = entry & _PFN_MASK;
>  	if (!dirp)
>  		return NOT_PADDR;
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -1,4 +1,4 @@
> -/* 
> +/*
>   * makedumpfile.c
>   *
>   * Copyright (C) 2006, 2007  NEC Corporation
> @@ -270,7 +270,7 @@ get_kernel_version(char *release)
>  	if (min == LONG_MAX)
>  		return FALSE;
>  
> -	start = end + 1;	
> +	start = end + 1;
>  	rel = strtol(start, &end, 10);
>  	if (rel == LONG_MAX)
>    		return FALSE;
> @@ -1265,7 +1265,7 @@ __search_mapping(Dwarf *dwarfd, Dwarf_Di
>  			continue;
>  		return TRUE;
>  
> -	} while (!dwarf_siblingof(walker, walker)); 
> +	} while (!dwarf_siblingof(walker, walker));
>  
>  	return FALSE;
>  }
> @@ -1293,7 +1293,7 @@ search_mapping(Dwarf *dwarfd, Dwarf_Die
>  			continue;
>  		if (__search_mapping(dwarfd, &die_struct, offset))
>  			return TRUE;
> -	} while (!dwarf_siblingof(walker, walker)); 
> +	} while (!dwarf_siblingof(walker, walker));
>  
>  	return FALSE;
>  }
> @@ -1310,7 +1310,7 @@ search_member(Dwarf *dwarfd, Dwarf_Die *
>  		return;
>  
>  	walker = &child;
> -	
> +
>  	do {
>  		tag  = dwarf_tag(walker);
>  		name = dwarf_diename(walker);
> @@ -1368,7 +1368,7 @@ search_member(Dwarf *dwarfd, Dwarf_Die *
>  				continue;
>  			return;
>  		}
> -	} while (!dwarf_siblingof(walker, walker)); 
> +	} while (!dwarf_siblingof(walker, walker));
>  
>  	/*
>  	 * Return even if not found.
> @@ -1503,7 +1503,7 @@ search_number(Dwarf *dwarfd, Dwarf_Die *
>  			*found = TRUE;
>  			dwarf_info.enum_number = (long)const_value;
>  
> -		} while (!dwarf_siblingof(walker, walker)); 
> +		} while (!dwarf_siblingof(walker, walker));
>  
>  	} while (!dwarf_siblingof(die, die));
>  }
> @@ -1596,9 +1596,9 @@ search_symbol(Dwarf *dwarfd, Dwarf_Die *
>  static void
>  search_die_tree(Dwarf *dwarfd, Dwarf_Die *die, int *found)
>  {
> -	Dwarf_Die child; 
> +	Dwarf_Die child;
>  
> -	/* 
> +	/*
>  	 * start by looking at the children
>  	 */
>  	if (dwarf_child(die, &child) == 0)
> @@ -3223,13 +3223,13 @@ initial()
>  		return FALSE;
>  
>  	/*
> -	 * Get the debug information for analysis from the vmcoreinfo file 
> +	 * Get the debug information for analysis from the vmcoreinfo file
>  	 */
>  	if (info->flag_read_vmcoreinfo) {
>  		if (!read_vmcoreinfo())
>  			return FALSE;
>  	/*
> -	 * Get the debug information for analysis from the kernel file 
> +	 * Get the debug information for analysis from the kernel file
>  	 */
>  	} else if (info->name_vmlinux) {
>  		dwarf_info.fd_debuginfo   = info->fd_vmlinux;
> @@ -3583,7 +3583,7 @@ read_buf_from_stdin(void *buf, int buf_s
>  	while (read_size != buf_size) {
>  
>  		tmp_read_size = read(STDIN_FILENO, buf + read_size,
> -		    buf_size - read_size); 
> +		    buf_size - read_size);
>  
>  		if (tmp_read_size < 0) {
>  			ERRMSG("Can't read STDIN. %s\n", strerror(errno));
> @@ -3721,7 +3721,7 @@ rearrange_dumpdata()
>  				goto out;
>  
>  			read_size += tmp_read_size;
> -		} 
> +		}
>  		/*
>  		 * Read the next header.
>  		 */
> @@ -3730,7 +3730,7 @@ rearrange_dumpdata()
>  			goto out;
>  		}
>  
> -	} while ((0 <= fdh.offset) && (0 < fdh.buf_size)); 
> +	} while ((0 <= fdh.offset) && (0 < fdh.buf_size));
>  
>  	if ((fdh.offset != END_FLAG_FLAT_HEADER)
>  	    || (fdh.buf_size != END_FLAG_FLAT_HEADER)) {
> @@ -4396,7 +4396,7 @@ get_loads_dumpfile()
>  			/*
>  			 * If the number of the contiguous pages to be excluded
>  			 * is 256 or more, those pages are excluded really.
> -			 * And a new PT_LOAD segment is created. 
> +			 * And a new PT_LOAD segment is created.
>  			 */
>  			if (num_excluded >= PFN_EXCLUDED) {
>  				num_new_load++;
> @@ -4507,7 +4507,7 @@ write_elf_header()
>  		/*
>  		 * PT_NOTE(1) + PT_LOAD(1+)
>  		 */
> -		ehdr64.e_phnum = 1 + num_loads_dumpfile; 
> +		ehdr64.e_phnum = 1 + num_loads_dumpfile;
>  	} else {                /* ELF32 */
>  		if (!get_elf32_ehdr(&ehdr32)) {
>  			ERRMSG("Can't get ehdr32.\n");
> @@ -4516,7 +4516,7 @@ write_elf_header()
>  		/*
>  		 * PT_NOTE(1) + PT_LOAD(1+)
>  		 */
> -		ehdr32.e_phnum = 1 + num_loads_dumpfile; 
> +		ehdr32.e_phnum = 1 + num_loads_dumpfile;
>  	}
>  
>  	/*
> @@ -4554,7 +4554,7 @@ write_elf_header()
>  		offset_note_memory   = note64.p_offset;
>  		offset_note_dumpfile = sizeof(ehdr64)
>  		    + sizeof(Elf64_Phdr) * ehdr64.e_phnum;
> -		note64.p_offset      = offset_note_dumpfile; 
> +		note64.p_offset      = offset_note_dumpfile;
>  		size_note            = note64.p_filesz;
>  
>  		if (!write_buffer(info->fd_dumpfile, sizeof(ehdr64), &note64,
> @@ -4579,7 +4579,7 @@ write_elf_header()
>  		offset_note_memory   = note32.p_offset;
>  		offset_note_dumpfile = sizeof(ehdr32)
>  		    + sizeof(Elf32_Phdr) * ehdr32.e_phnum;
> -		note32.p_offset      = offset_note_dumpfile; 
> +		note32.p_offset      = offset_note_dumpfile;
>  		size_note            = note32.p_filesz;
>  
>  		if (!write_buffer(info->fd_dumpfile, sizeof(ehdr32), &note32,
> @@ -4863,7 +4863,7 @@ write_elf_pages()
>  			/*
>  			 * If the number of the contiguous pages to be excluded
>  			 * is 256 or more, those pages are excluded really.
> -			 * And a new PT_LOAD segment is created. 
> +			 * And a new PT_LOAD segment is created.
>  			 */
>  			if (info->flag_elf64) { /* ELF64 */
>  				load64.p_memsz  = memsz;
> @@ -5053,7 +5053,7 @@ out:
>  
>  /*
>   * This function is specific for reading page.
> - * 
> + *
>   * If reading the separated page on different PT_LOAD segments,
>   * this function gets the page data from both segments. This is
>   * worthy of ia64 /proc/vmcore. In ia64 /proc/vmcore, region 5
> @@ -5666,7 +5666,7 @@ get_xen_info()
>  	}
>  	info->domain_list[num_domain].domain_addr = domain;
>  	info->domain_list[num_domain].domain_id = domain_id;
> -	
> +
>  	/*
>  	 * Get architecture specific data
>  	 */
> @@ -5876,7 +5876,7 @@ is_select_domain(unsigned int id)
>  	int i;
>  
>  	/* selected domain is fix to dom0 only now !!
> -	   (yes... domain_list is not necessary right now, 
> +	   (yes... domain_list is not necessary right now,
>  		   it can get from "dom0" directly) */
>  
>  	for (i = 0; i < info->num_domain; i++) {
> @@ -5966,7 +5966,7 @@ initial_xen()
>  	}
>  
>  	/*
> -	 * Get the debug information for analysis from the vmcoreinfo file 
> +	 * Get the debug information for analysis from the vmcoreinfo file
>  	 */
>  	if (info->flag_read_vmcoreinfo) {
>  		if (!read_vmcoreinfo_xen())
> @@ -6050,7 +6050,7 @@ print_report()
>  	shrinking = shrinking / pfn_original;
>  
>  	REPORT_MSG("Original pages  : 0x%016llx\n", pfn_original);
> -	REPORT_MSG("  Excluded pages   : 0x%016llx\n", pfn_excluded); 
> +	REPORT_MSG("  Excluded pages   : 0x%016llx\n", pfn_excluded);
>  	REPORT_MSG("    Pages filled with zero  : 0x%016llx\n", pfn_zero);
>  	REPORT_MSG("    Cache pages             : 0x%016llx\n", pfn_cache);
>  	REPORT_MSG("    Cache pages + private   : 0x%016llx\n",
> @@ -6127,7 +6127,7 @@ check_param_for_generating_vmcoreinfo(in
>  	    || info->flag_flatten      || info->flag_rearrange
>  	    || info->flag_exclude_xen_dom
>  	    || (!info->name_vmlinux && !info->name_xen_syms))
> -	
> +
>  		return FALSE;
>  
>  	return TRUE;
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -718,7 +718,7 @@ struct DumpInfo {
>  	unsigned long	len_bitmap;          /* size of bitmap(1st and 2nd) */
>  	struct dump_bitmap 		*bitmap1;
>  	struct dump_bitmap 		*bitmap2;
> -	struct disk_dump_header		*dump_header; 
> +	struct disk_dump_header		*dump_header;
>  
>  	/*
>  	 * ELF header info:
> --- a/ppc64.c
> +++ b/ppc64.c
> @@ -1,4 +1,4 @@
> -/* 
> +/*
>   * ppc64.c
>   *
>   * Created by: Sachin Sant (sachinp@in.ibm.com)
> --- a/x86.c
> +++ b/x86.c
> @@ -1,4 +1,4 @@
> -/* 
> +/*
>   * x86.c
>   *
>   * Copyright (C) 2006, 2007  NEC Corporation
> @@ -59,7 +59,7 @@ kvtop_xen_x86(unsigned long kvaddr)
>  	dirp += ((kvaddr >> PGDIR_SHIFT_3LEVEL) & (PTRS_PER_PGD_3LEVEL - 1)) * sizeof(unsigned long long);
>  	if (!readmem(PADDR, dirp, &entry, sizeof(entry)))
>  		return NOT_PADDR;
> - 
> +
>  	if (!(entry & _PAGE_PRESENT))
>  		return NOT_PADDR;
>  
> --- a/x86_64.c
> +++ b/x86_64.c
> @@ -1,4 +1,4 @@
> -/* 
> +/*
>   * x86_64.c
>   *
>   * Copyright (C) 2006, 2007  NEC Corporation
> @@ -206,7 +206,7 @@ kvtop_xen_x86_64(unsigned long kvaddr)
>  	dirp += pgd_index(kvaddr) * sizeof(unsigned long long);
>  	if (!readmem(PADDR, dirp, &entry, sizeof(entry)))
>  		return NOT_PADDR;
> - 
> +
>  	if (!(entry & _PAGE_PRESENT))
>  		return NOT_PADDR;
>  
> 



--===============0847607440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0847607440==--
