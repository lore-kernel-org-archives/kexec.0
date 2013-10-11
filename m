Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VUhpe-0003hk-7e
 for kexec@lists.infradead.org; Fri, 11 Oct 2013 18:53:04 +0000
Date: Fri, 11 Oct 2013 14:52:32 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1398853173.5067799.1381517552627.JavaMail.root@redhat.com>
In-Reply-To: <20131011094700.13571.24033.stgit@k.asiapacific.hpqcorp.net>
References: <20131011094700.13571.24033.stgit@k.asiapacific.hpqcorp.net>
Subject: Re: [PATCH v2] crash utility: fix max_mapnr issue on system has
 over 44-bit addressing
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Jingbai Ma <jingbai.ma@hp.com>
Cc: bhe@redhat.com, nishimura@mxp.nes.nec.co.jp, usui@mxm.nes.nec.co.jp, d hatayama <d.hatayama@jp.fujitsu.com>, lisa mitchell <lisa.mitchell@hp.com>, ruyang@redhat.com, tachibana@mxm.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, vgoyal@redhat.com, kexec@lists.infradead.org, chaowang@redhat.com, crash-utility@redhat.com


Hello Jingbai,

The old diskdump-compatibility issue has been addressed by this second 
patch, but it fails to work with "split" kdumps.

I only have two sample split compressed kdumps.  Despite the dumpfile 
names, both of them were compressed and filtered with "-c -d31".

Here is the first one:

 $ crash vmlinux-5.3.gz vmcore-kdump-d31-split-2-1 vmcore-kdump-d31-split-2-2
  
 crash 7.0.2
 Copyright (C) 2002-2013  Red Hat, Inc.
 Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
 Copyright (C) 1999-2006  Hewlett-Packard Co
 Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
 Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
 Copyright (C) 2005, 2011  NEC Corporation
 Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
 Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
 This program is free software, covered by the GNU General Public License,
 and you are welcome to change it and/or distribute copies of it under
 certain conditions.  Enter "help copying" to see the conditions.
 This program has absolutely no warranty.  Enter "help warranty" for details.
   
 GNU gdb (GDB) 7.6                             
 Copyright (C) 2013 Free Software Foundation, Inc.
 License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
 This is free software: you are free to change and redistribute it.
 There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
 and "show warranty" for details.
 This GDB was configured as "x86_64-unknown-linux-gnu"...
 
       KERNEL: vmlinux-5.3.gz                    
    DUMPFILES: vmcore-kdump-d31-split-2-1 [PARTIAL DUMP]
               vmcore-kdump-d31-split-2-2 [PARTIAL DUMP]
         CPUS: 4
         DATE: Tue Apr  7 11:08:57 2009
       UPTIME: 00:01:45
 LOAD AVERAGE: 0.65, 0.27, 0.09
        TASKS: 119
     NODENAME: legacy.usersys.redhat.com
      RELEASE: 2.6.18-128.el5
      VERSION: #1 SMP Wed Dec 17 11:41:38 EST 2008
      MACHINE: x86_64  (3000 Mhz)
       MEMORY: 5.3 GB
        PANIC: "SysRq : Trigger a crashdump"
          PID: 3676
      COMMAND: "bash"
         TASK: ffff810105791100  [THREAD_INFO: ffff81016ff68000]
          CPU: 3
        STATE: TASK_RUNNING (SYSRQ)
 
 crash> 

With your patch applied, all reads fail immediately:
 
 $ crash vmlinux-5.3.gz vmcore-kdump-d31-split-2-1 vmcore-kdump-d31-split-2-2
 
 crash 7.0.3rc8
 Copyright (C) 2002-2013  Red Hat, Inc.
 Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
 Copyright (C) 1999-2006  Hewlett-Packard Co
 Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
 Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
 Copyright (C) 2005, 2011  NEC Corporation
 Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
 Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
 This program is free software, covered by the GNU General Public License,
 and you are welcome to change it and/or distribute copies of it under
 certain conditions.  Enter "help copying" to see the conditions.
 This program has absolutely no warranty.  Enter "help warranty" for details.
  
 GNU gdb (GDB) 7.6                             
 Copyright (C) 2013 Free Software Foundation, Inc.
 License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
 This is free software: you are free to change and redistribute it.
 There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
 and "show warranty" for details.
 This GDB was configured as "x86_64-unknown-linux-gnu"...
 
 crash: seek error: kernel virtual address: ffffffff80431260  type: "possible"
 WARNING: cannot read cpu_possible_map
 crash: seek error: kernel virtual address: ffffffff803d9520  type: "present"
 WARNING: cannot read cpu_present_map
 crash: seek error: kernel virtual address: ffffffff803d4260  type: "online"
 WARNING: cannot read cpu_online_map
 crash: seek error: kernel virtual address: ffffffff803db200  type: "xtime"
 $ 
 
If invoked with "-d8", here are the readmem errors, where eacho of the
requested pfns indicate that they are "beyond last dumpfile".  This
is a RHEL5 kernel with a phys_base of 0x200000, so the paddr/pfn
values are correct:
 
 ...
 <readmem: ffffffff80431260, KVADDR, "possible", 32, (ROE), e5b4e0>
 <read_diskdump: addr: ffffffff80431260 paddr: 631260 cnt: 32>
 read_diskdump: SEEK_ERROR: paddr/pfn 631260/631 beyond last dumpfile
 crash: seek error: kernel virtual address: ffffffff80431260  type: "possible"
 WARNING: cannot read cpu_possible_map
 <readmem: ffffffff803d9520, KVADDR, "present", 32, (ROE), e5b4e0>
 <read_diskdump: addr: ffffffff803d9520 paddr: 5d9520 cnt: 32>
 read_diskdump: SEEK_ERROR: paddr/pfn 5d9520/5d9 beyond last dumpfile
 crash: seek error: kernel virtual address: ffffffff803d9520  type: "present"
 WARNING: cannot read cpu_present_map
 <readmem: ffffffff803d4260, KVADDR, "online", 32, (ROE), e5b4e0>
 <read_diskdump: addr: ffffffff803d4260 paddr: 5d4260 cnt: 32>
 read_diskdump: SEEK_ERROR: paddr/pfn 5d4260/5d4 beyond last dumpfile
 crash: seek error: kernel virtual address: ffffffff803d4260  type: "online"
 WARNING: cannot read cpu_online_map
 FREEBUF(0)
 GETBUF(248 -> 0)
 GNU_GET_DATATYPE[timekeeper]: returned via gdb_error_hook (1 buffer in use)
 FREEBUF(0)
 GETBUF(248 -> 0)
 GNU_GET_DATATYPE[timekeeper]: returned via gdb_error_hook (1 buffer in use)
 FREEBUF(0)
 <readmem: ffffffff803db200, KVADDR, "xtime", 16, (FOE), cd1e10>
 <read_diskdump: addr: ffffffff803db200 paddr: 5db200 cnt: 16>
 read_diskdump: SEEK_ERROR: paddr/pfn 5db200/5db beyond last dumpfile
 crash: seek error: kernel virtual address: ffffffff803db200  type: "xtime"
 $

And here's the second sample:

 $ crash vmlinux-5.3.gz vmcore-kdump-compressed-d31-split-2-1 vmcore-kdump-compressed-d31-split-2-2
 
 crash 7.0.2
 Copyright (C) 2002-2013  Red Hat, Inc.
 Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
 Copyright (C) 1999-2006  Hewlett-Packard Co
 Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
 Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
 Copyright (C) 2005, 2011  NEC Corporation
 Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
 Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
 This program is free software, covered by the GNU General Public License,
 and you are welcome to change it and/or distribute copies of it under
 certain conditions.  Enter "help copying" to see the conditions.
 This program has absolutely no warranty.  Enter "help warranty" for details.
  
 GNU gdb (GDB) 7.6                             
 Copyright (C) 2013 Free Software Foundation, Inc.
 License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
 This is free software: you are free to change and redistribute it.
 There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
 and "show warranty" for details.
 This GDB was configured as "x86_64-unknown-linux-gnu"...
 
       KERNEL: vmlinux-5.3.gz                    
    DUMPFILES: vmcore-kdump-compressed-d31-split-2-1 [PARTIAL DUMP]
               vmcore-kdump-compressed-d31-split-2-2 [PARTIAL DUMP]
         CPUS: 4
         DATE: Tue Apr  7 11:25:36 2009
       UPTIME: 00:09:46
 LOAD AVERAGE: 0.08, 0.11, 0.08
        TASKS: 118
     NODENAME: legacy.usersys.redhat.com
      RELEASE: 2.6.18-128.el5
      VERSION: #1 SMP Wed Dec 17 11:41:38 EST 2008
      MACHINE: x86_64  (3000 Mhz)
       MEMORY: 5.3 GB
        PANIC: "SysRq : Trigger a crashdump"
          PID: 3781
      COMMAND: "bash"
         TASK: ffff81017220b080  [THREAD_INFO: ffff81016fe2a000]
          CPU: 3
        STATE: TASK_RUNNING (SYSRQ)
 
 crash> 

And with your patch applied:
 
 $ crash vmlinux-5.3.gz vmcore-kdump-compressed-d31-split-2-1 vmcore-kdump-compressed-d31-split-2-2 
 
 crash 7.0.3rc8
 Copyright (C) 2002-2013  Red Hat, Inc.
 Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
 Copyright (C) 1999-2006  Hewlett-Packard Co
 Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
 Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
 Copyright (C) 2005, 2011  NEC Corporation
 Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
 Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
 This program is free software, covered by the GNU General Public License,
 and you are welcome to change it and/or distribute copies of it under
 certain conditions.  Enter "help copying" to see the conditions.
 This program has absolutely no warranty.  Enter "help warranty" for details.
 
 GNU gdb (GDB) 7.6                             
 Copyright (C) 2013 Free Software Foundation, Inc.
 License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
 This is free software: you are free to change and redistribute it.
 There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
 and "show warranty" for details.
 This GDB was configured as "x86_64-unknown-linux-gnu"...
 
 crash: seek error: kernel virtual address: ffffffff80431260  type: "possible"
 WARNING: cannot read cpu_possible_map
 crash: seek error: kernel virtual address: ffffffff803d9520  type: "present"
 WARNING: cannot read cpu_present_map
 crash: seek error: kernel virtual address: ffffffff803d4260  type: "online"
 WARNING: cannot read cpu_online_map
 crash: seek error: kernel virtual address: ffffffff803db200  type: "xtime"
 $ 

I have temporarily placed the sample split dumpfiles above here for you 
to download and test with:

  http://people.redhat.com/anderson/kdump_split

Let me know when you have copied them so I can clear up the disk space.

Thanks,
  Dave

 
 

----- Original Message -----
> The patch will add support for new compressed dumpfile header_version 6.
> 
> This bug was posted here:
> http://lists.infradead.org/pipermail/kexec/2013-September/009587.html
> 
> This patch will add a new field in struct kdump_sub_header.
> unsigned long   max_mapnr;
> 
> And the old "unsigned int max_mapnr" in struct disk_dump_header will
> not be used anymore. But still be there for compatibility purpose.
> 
> Changelog:
> v2:
> - Rename max_mapnr in struct kdump_sub_header to max_mapnr_64.
> - Change type of max_mapnr_64 from unsigned long to unsigned long long.
>   In x86 PAE mode on x86_32 kernel, the address may exceeds 44bit limit.
> - Add start_pfn_64, end_pfn_64 for struct kdump_sub_header.
> - Add a 64bit max_mapnr in struct diskdump_data. The max_mapnr_64 in
>   the sub-header only exists in compressed kdump file format, so can't
>   be used in diskdump file format.
> - Merge a patch from Dave Anderson that fixed bitmap_len issue.
> 
> v1:
> - http://lists.infradead.org/pipermail/kexec/2013-September/009663.html
> 
> Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
> Tested-by: Lisa Mitchell <lisa.mitchell@hp.com>
> ---
>  diskdump.c |  116
>  ++++++++++++++++++++++++++++++++++++++++++++++++------------
>  diskdump.h |   17 +++++++--
>  2 files changed, 106 insertions(+), 27 deletions(-)
> 
> diff --git a/diskdump.c b/diskdump.c
> index 0819a3f..cc01d5d 100644
> --- a/diskdump.c
> +++ b/diskdump.c
> @@ -40,11 +40,13 @@ struct diskdump_data {
>  	struct disk_dump_sub_header	*sub_header;
>  	struct kdump_sub_header		*sub_header_kdump;
>  
> +	unsigned long long	max_mapnr;	/* 64bit max_mapnr */
> +
>  	size_t	data_offset;
>  	int	block_size;
>  	int	block_shift;
>  	char	*bitmap;
> -	int	bitmap_len;
> +	off_t	bitmap_len;
>  	char	*dumpable_bitmap;
>  	int	byte, bit;
>  	char	*compressed_page;	/* copy of compressed page data */
> @@ -170,9 +172,9 @@ add_diskdump_data(char* name)
>  	dd->filename = name;
>  
>  	if (CRASHDEBUG(1))
> -		fprintf(fp, "%s: start_pfn=%lu, end_pfn=%lu\n", name,
> -			dd->sub_header_kdump->start_pfn,
> -			dd->sub_header_kdump->end_pfn);
> +		fprintf(fp, "%s: start_pfn=%llu, end_pfn=%llu\n", name,
> +			dd->sub_header_kdump->start_pfn_64,
> +			dd->sub_header_kdump->end_pfn_64);
>  }
>  
>  static void
> @@ -199,13 +201,13 @@ get_bit(char *map, int byte, int bit)
>  }
>  
>  static inline int
> -page_is_ram(unsigned int nr)
> +page_is_ram(unsigned long nr)
>  {
>  	return get_bit(dd->bitmap, nr >> 3, nr & 7);
>  }
>  
>  static inline int
> -page_is_dumpable(unsigned int nr)
> +page_is_dumpable(unsigned long nr)
>  {
>  	return dd->dumpable_bitmap[nr>>3] & (1 << (nr & 7));
>  }
> @@ -214,7 +216,7 @@ static inline int
>  dump_is_partial(const struct disk_dump_header *header)
>  {
>  	return header->bitmap_blocks >=
> -	    divideup(divideup(header->max_mapnr, 8), dd->block_size) * 2;
> +	    divideup(divideup(dd->max_mapnr, 8), dd->block_size) * 2;
>  }
>  
>  static int
> @@ -321,6 +323,9 @@ x86_process_elf_notes(void *note_ptr, unsigned long
> size_note)
>   * [40]    unsigned long   size_note;          /  header_version 4 and later
>   /
>   * [44]    off_t           offset_eraseinfo;   /  header_version 5 and later
>   /
>   * [52]    unsigned long   size_eraseinfo;     /  header_version 5 and later
>   /
> + * [56]    unsigned long long   start_pfn_64;  /  header_version 6 and later
> /
> + * [64]    unsigned long long   end_pfn_64;    /  header_version 6 and later
> /
> + * [72]    unsigned long long   max_mapnr_64;  /  header_version 6 and later
> /
>   * };
>   *
>   * But when compiled on an ARM processor, each 64-bit "off_t" would be
>   pushed
> @@ -337,7 +342,10 @@ x86_process_elf_notes(void *note_ptr, unsigned long
> size_note)
>   * [40]    off_t           offset_note;        /  header_version 4 and later
>   /
>   * [48]    unsigned long   size_note;          /  header_version 4 and later
>   /
>   * [56]    off_t           offset_eraseinfo;   /  header_version 5 and later
>   /
> - * [62]    unsigned long   size_eraseinfo;     /  header_version 5 and later
> /
> + * [64]    unsigned long   size_eraseinfo;     /  header_version 5 and later
> /
> + * [72]    unsigned long long   start_pfn_64;  /  header_version 6 and later
> /
> + * [80]    unsigned long long   end_pfn_64;    /  header_version 6 and later
> /
> + * [88]    unsigned long long   max_mapnr_64;  /  header_version 6 and later
> /
>   * };
>   *
>   */
> @@ -357,6 +365,10 @@ struct kdump_sub_header_ARM_target {
>  	int 		pad3;
>          off_t           offset_eraseinfo;   /* header_version 5 and later */
>          unsigned long   size_eraseinfo;     /* header_version 5 and later */
> +	int		pad4;
> +	unsigned long long start_pfn_64;    /* header_version 6 and later */
> +	unsigned long long end_pfn_64;      /* header_version 6 and later */
> +	unsigned long long max_mapnr_64;    /* header_version 6 and later */
>  };
>  
>  static void
> @@ -380,6 +392,15 @@ arm_kdump_header_adjust(int header_version)
>  		kdsh->offset_eraseinfo = kdsh_ARM_target->offset_eraseinfo;
>  		kdsh->size_eraseinfo = kdsh_ARM_target->size_eraseinfo;
>  	}
> +	if (header_version >= 6) {
> +		kdsh->start_pfn_64 = kdsh_ARM_target->start_pfn_64;
> +		kdsh->end_pfn_64 = kdsh_ARM_target->end_pfn_64;
> +		kdsh->max_mapnr_64 = kdsh_ARM_target->map_mapnr_64;
> +	} else {
> +		kdsh->start_pfn_64 = kdsh_ARM_target->start_pfn;
> +		kdsh->end_pfn_64 = kdsh_ARM_target->end_pfn;
> +		kdsh->max_mapnr_64 = dd->map_mapnr;
> +	}
>  }
>  #endif  /* __i386__ && ARM */
>  
> @@ -390,7 +411,10 @@ read_dump_header(char *file)
>  	struct disk_dump_sub_header *sub_header = NULL;
>  	struct kdump_sub_header *sub_header_kdump = NULL;
>  	size_t size;
> -	int bitmap_len;
> +	off_t bitmap_len;
> +	char *bufptr;
> +	size_t len;
> +	size_t bytes_read;
>  	int block_size = (int)sysconf(_SC_PAGESIZE);
>  	off_t offset;
>  	const off_t failed = (off_t)-1;
> @@ -540,8 +564,21 @@ restart:
>  #if defined(__i386__) && defined(ARM)
>  		arm_kdump_header_adjust(header->header_version);
>  #endif
> +		/* use 64bit max_mapnr in compressed kdump file sub-header */
> +		if (header->header_version >= 6)
> +			dd->max_mapnr = dd->sub_header_kdump->max_mapnr_64;
> +	} else {
> +		/* the 64bit max_mapnr only exists in sub-header of compressed
> +		 * kdump file, if it's not a compressed kdump file, we have to
> +		 * use the old 32bit max_mapnr in dumpfile header.
> +		 * max_mapnr may be truncated here.
> +		 */
> +		dd->max_mapnr = header->max_mapnr;
>  	}
>  
> +	if (header->header_version < 6)
> +		dd->max_mapnr = header->max_mapnr;
> +
>  	/* read memory bitmap */
>  	bitmap_len = block_size * header->bitmap_blocks;
>  	dd->bitmap_len = bitmap_len;
> @@ -571,11 +608,27 @@ restart:
>  				DISKDUMP_VALID() ? "diskdump" : "compressed kdump");
>  			goto err;
>  		}
> +#ifdef OLDWAY
>  		if (read(dd->dfd, dd->bitmap, bitmap_len) < bitmap_len) {
>  			error(INFO, "%s: cannot read memory bitmap\n",
>  				DISKDUMP_VALID() ? "diskdump" : "compressed kdump");
>  			goto err;
>  		}
> +#else
> +		bufptr = dd->bitmap;
> +		len = bitmap_len;
> +		while (len) {
> +			bytes_read = read(dd->dfd, bufptr, len);
> +			if (bytes_read  < 0) {
> +				error(INFO, "%s: cannot read memory bitmap\n",
> +					DISKDUMP_VALID() ? "diskdump"
> +					: "compressed kdump");
> +				goto err;
> +			}
> +			len -= bytes_read;
> +			bufptr += bytes_read;
> +		}
> +#endif
>  	}
>  
>  	if (dump_is_partial(header))
> @@ -679,13 +732,13 @@ restart:
>  	}
>  
>  	if (!is_split) {
> -		max_sect_len = divideup(header->max_mapnr, BITMAP_SECT_LEN);
> +		max_sect_len = divideup(dd->max_mapnr, BITMAP_SECT_LEN);
>  		pfn = 0;
>  		dd->filename = file;
>  	}
>  	else {
> -		ulong start = sub_header_kdump->start_pfn;
> -		ulong end = sub_header_kdump->end_pfn;
> +		unsigned long long start = sub_header_kdump->start_pfn_64;
> +		unsigned long long end = sub_header_kdump->end_pfn_64;
>  		max_sect_len = divideup(end - start + 1, BITMAP_SECT_LEN);
>  		pfn = start;
>  	}
> @@ -727,8 +780,9 @@ pfn_to_pos(ulong pfn)
>  	ulong p1, p2;
>  
>  	if (KDUMP_SPLIT()) {
> -		p1 = pfn - dd->sub_header_kdump->start_pfn;
> -		p2 = round(p1, BITMAP_SECT_LEN) + dd->sub_header_kdump->start_pfn;
> +		p1 = pfn - dd->sub_header_kdump->start_pfn_64;
> +		p2 = round(p1, BITMAP_SECT_LEN)
> +			+ dd->sub_header_kdump->start_pfn_64;
>  	}
>  	else {
>  		p1 = pfn;
> @@ -1034,12 +1088,12 @@ read_diskdump(int fd, void *bufptr, int cnt, ulong
> addr, physaddr_t paddr)
>  	if (KDUMP_SPLIT()) {
>  		/* Find proper dd */
>  		int i;
> -		unsigned long start_pfn;
> -		unsigned long end_pfn;
> +		unsigned long long start_pfn;
> +		unsigned long long end_pfn;
>  
>  		for (i=0; i<num_dumpfiles; i++) {
> -			start_pfn = dd_list[i]->sub_header_kdump->start_pfn;
> -			end_pfn = dd_list[i]->sub_header_kdump->end_pfn;
> +			start_pfn = dd_list[i]->sub_header_kdump->start_pfn_64;
> +			end_pfn = dd_list[i]->sub_header_kdump->end_pfn_64;
>  			if ((pfn >= start_pfn) && (pfn <= end_pfn))	{
>  				dd = dd_list[i];
>  				break;
> @@ -1058,14 +1112,14 @@ read_diskdump(int fd, void *bufptr, int cnt, ulong
> addr, physaddr_t paddr)
>  	curpaddr = paddr & ~((physaddr_t)(dd->block_size-1));
>  	page_offset = paddr & ((physaddr_t)(dd->block_size-1));
>  
> -	if ((pfn >= dd->header->max_mapnr) || !page_is_ram(pfn)) {
> +	if ((pfn >= dd->max_mapnr) || !page_is_ram(pfn)) {
>  		if (CRASHDEBUG(8)) {
>  			fprintf(fp, "read_diskdump: SEEK_ERROR: "
>  			    "paddr/pfn: %llx/%lx ",
>  				(ulonglong)paddr, pfn);
> -			if (pfn >= dd->header->max_mapnr)
> -				fprintf(fp, "max_mapnr: %x\n",
> -					dd->header->max_mapnr);
> +			if (pfn >= dd->max_mapnr)
> +				fprintf(fp, "max_mapnr: %llx\n",
> +					dd->max_mapnr);
>  			else
>  				fprintf(fp, "!page_is_ram\n");
>  		}
> @@ -1517,7 +1571,7 @@ __diskdump_memory_dump(FILE *fp)
>  	fprintf(fp, "          block_size: %d\n", dh->block_size);
>  	fprintf(fp, "        sub_hdr_size: %d\n", dh->sub_hdr_size);
>  	fprintf(fp, "       bitmap_blocks: %u\n", dh->bitmap_blocks);
> -	fprintf(fp, "           max_mapnr: %u\n", dh->max_mapnr);
> +	fprintf(fp, "           max_mapnr: %llu\n", dd->max_mapnr);
>  	fprintf(fp, "    total_ram_blocks: %u\n", dh->total_ram_blocks);
>  	fprintf(fp, "       device_blocks: %u\n", dh->device_blocks);
>  	fprintf(fp, "      written_blocks: %u\n", dh->written_blocks);
> @@ -1662,6 +1716,20 @@ __diskdump_memory_dump(FILE *fp)
>  				dump_eraseinfo(fp);
>  			}
>  		}
> +		if (dh->header_version >= 6) {
> +			fprintf(fp, "           start_pfn_64: ");
> +			if (KDUMP_SPLIT())
> +				fprintf(fp, "%lld (0x%llx)\n",
> +					kdsh->start_pfn_64, kdsh->start_pfn_64);
> +			else
> +				fprintf(fp, "(unused)\n");
> +			fprintf(fp, "             end_pfn_64: ");
> +			if (KDUMP_SPLIT())
> +				fprintf(fp, "%lld (0x%llx)\n",
> +					kdsh->end_pfn_64, kdsh->end_pfn_64);
> +			else
> +				fprintf(fp, "(unused)\n");
> +		}
>  		fprintf(fp, "\n");
>  	} else
>          	fprintf(fp, "(n/a)\n\n");
> @@ -1670,7 +1738,7 @@ __diskdump_memory_dump(FILE *fp)
>  	fprintf(fp, "        block_size: %d\n", dd->block_size);
>  	fprintf(fp, "       block_shift: %d\n", dd->block_shift);
>  	fprintf(fp, "            bitmap: %lx\n", (ulong)dd->bitmap);
> -	fprintf(fp, "        bitmap_len: %d\n", dd->bitmap_len);
> +	fprintf(fp, "        bitmap_len: %ld\n", dd->bitmap_len);
>  	fprintf(fp, "   dumpable_bitmap: %lx\n", (ulong)dd->dumpable_bitmap);
>  	fprintf(fp, "              byte: %d\n", dd->byte);
>  	fprintf(fp, "               bit: %d\n", dd->bit);
> diff --git a/diskdump.h b/diskdump.h
> index 9ab10b6..0492351 100644
> --- a/diskdump.h
> +++ b/diskdump.h
> @@ -42,7 +42,9 @@ struct disk_dump_header {
>  						   header in blocks */
>  	unsigned int		bitmap_blocks;	/* Size of Memory bitmap in
>  						   block */
> -	unsigned int		max_mapnr;	/* = max_mapnr */
> +	unsigned int		max_mapnr;	/* = max_mapnr, 32bit only,
> +						   full 64bit in sub header.
> +						   Do NOT use this anymore! */
>  	unsigned int		total_ram_blocks;/* Number of blocks should be
>  						   written */
>  	unsigned int		device_blocks;	/* Number of total blocks in
> @@ -61,14 +63,23 @@ struct kdump_sub_header {
>  	unsigned long	phys_base;
>  	int		dump_level;         /* header_version 1 and later */
>  	int		split;              /* header_version 2 and later */
> -	unsigned long	start_pfn;          /* header_version 2 and later */
> -	unsigned long	end_pfn;            /* header_version 2 and later */
> +	unsigned long	start_pfn;          /* header_version 2 and later,
> +					       32bit only, full 64bit in
> +					       start_pfn_64.
> +					       Do not use this anymore! */
> +	unsigned long	end_pfn;            /* header_version 2 and later,
> +					       32bit only, full 64bit in
> +					       end_pfn_64.
> +					       Do not use this anymore! */
>  	off_t		offset_vmcoreinfo;  /* header_version 3 and later */
>  	unsigned long	size_vmcoreinfo;    /* header_version 3 and later */
>  	off_t		offset_note;        /* header_version 4 and later */
>  	unsigned long	size_note;          /* header_version 4 and later */
>  	off_t		offset_eraseinfo;   /* header_version 5 and later */
>  	unsigned long	size_eraseinfo;     /* header_version 5 and later */
> +	unsigned long long start_pfn_64;    /* header_version 6 and later */
> +	unsigned long long end_pfn_64;      /* header_version 6 and later */
> +	unsigned long long max_mapnr_64;    /* header_version 6 and later */
>  };
>  
>  /* page flags */
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
