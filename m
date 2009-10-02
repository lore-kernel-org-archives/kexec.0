Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MtZeR-0007YG-67
	for kexec@lists.infradead.org; Fri, 02 Oct 2009 04:21:56 +0000
Date: Fri, 02 Oct 2009 12:21:42 +0800 (CST)
Message-Id: <20091002.122142.187435277.caiqian@redhat.com>
Subject: Re: Can't exclude unnecessary pages for 2.6.31 Kernel
From: CAI Qian <caiqian@redhat.com>
In-Reply-To: <4AC54672.7080201@mxs.nes.nec.co.jp>
References: <20091002.012816.266343564.caiqian@redhat.com>
	<4AC54672.7080201@mxs.nes.nec.co.jp>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
	boundary="--Next_Part(Fri_Oct__2_12_21_42_2009_290)--"
Content-Transfer-Encoding: 7bit
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
To: oomichi@mxs.nes.nec.co.jp
Cc: nhorman@redhat.com, kexec@lists.infradead.org, tachibana@mxm.nes.nec.co.jp, caiqian@redhat.com

----Next_Part(Fri_Oct__2_12_21_42_2009_290)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hallo Ken'ichi!

From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: Can't exclude unnecessary pages for 2.6.31 Kernel
Date: Fri, 02 Oct 2009 09:16:50 +0900

> 
> The next makedumpfile will support 2.6.31 kernel, and the above will be fixed.
> 

Great.

> 
> I created the patch for catching this change.
> Could you try the attached patch ?
> 

It does make -d 16 works without errors. However, the crash utility
failed to read it (the log attached), but the full VMCore is working
fine there.

crash: page excluded: kernel virtual address: ffffffff819f1764 type:
       "tss_struct ist array"

Thanks!
CAI Qian

----Next_Part(Fri_Oct__2_12_21_42_2009_290)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="crash.log"

[root@nec-em18 analyse-crash]# crash -d 3 /usr/lib/debug/lib/modules/2.6.31-23.el6.x86_64/vmlinux /var/crash/16/vmcore.fail 

crash 4.0.9
Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009  Red Hat, Inc.
Copyright (C) 2004, 2005, 2006  IBM Corporation
Copyright (C) 1999-2006  Hewlett-Packard Co
Copyright (C) 2005, 2006  Fujitsu Limited
Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
Copyright (C) 2005  NEC Corporation
Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
This program is free software, covered by the GNU General Public License,
and you are welcome to change it and/or distribute copies of it under
certain conditions.  Enter "help copying" to see the conditions.
This program has absolutely no warranty.  Enter "help warranty" for details.
 
compressed kdump: header->utsname.machine: 
diskdump_data: 
          filename: (null)
             flags: 6 (KDUMP_CMPRS_LOCAL|ERROR_EXCLUDED)
               dfd: 3
               ofp: 0
      machine_type: 62 (EM_X86_64)

            header: bb4c70
           signature: "KDUMP   "
      header_version: 2
             utsname:
               sysname: 
              nodename: 
               release: 
               version: 
               machine: 
            domainname: 
           timestamp:
                tv_sec: 4ac44a6f
               tv_usec: 0
              status: 0 ()
          block_size: 4096
        sub_hdr_size: 1
       bitmap_blocks: 16
           max_mapnr: 262000
    total_ram_blocks: 0
       device_blocks: 0
      written_blocks: 0
         current_cpu: 0
             nr_cpus: 1
      tasks[nr_cpus]: 0

        sub_header: 0 (n/a)

  sub_header_kdump: bb5c80 
           phys_base: 0
          dump_level: 16 (0x10) (DUMP_EXCLUDE_FREE)

       data_offset: 12000
        block_size: 4096
       block_shift: 12
            bitmap: bb6c90
        bitmap_len: 65536
   dumpable_bitmap: bc6ca0
              byte: 0
               bit: 0
   compressed_page: be6ed0
         curbufptr: 0

 page_cache_hdr[0]:
            pg_flags: 0 ()
             pg_addr: 0
           pg_bufptr: bd6ec0
        pg_hit_count: 0
 page_cache_hdr[1]:
            pg_flags: 0 ()
             pg_addr: 0
           pg_bufptr: bd7ec0
        pg_hit_count: 0
 page_cache_hdr[2]:
            pg_flags: 0 ()
             pg_addr: 0
           pg_bufptr: bd8ec0
        pg_hit_count: 0
 page_cache_hdr[3]:
            pg_flags: 0 ()
             pg_addr: 0
           pg_bufptr: bd9ec0
        pg_hit_count: 0
 page_cache_hdr[4]:
            pg_flags: 0 ()
             pg_addr: 0
           pg_bufptr: bdaec0
        pg_hit_count: 0
 page_cache_hdr[5]:
            pg_flags: 0 ()
             pg_addr: 0
           pg_bufptr: bdbec0
        pg_hit_count: 0
 page_cache_hdr[6]:
            pg_flags: 0 ()
             pg_addr: 0
           pg_bufptr: bdcec0
        pg_hit_count: 0
 page_cache_hdr[7]:
            pg_flags: 0 ()
             pg_addr: 0
           pg_bufptr: bddec0
        pg_hit_count: 0
 page_cache_hdr[8]:
            pg_flags: 0 ()
             pg_addr: 0
           pg_bufptr: bdeec0
        pg_hit_count: 0
 page_cache_hdr[9]:
            pg_flags: 0 ()
             pg_addr: 0
           pg_bufptr: bdfec0
        pg_hit_count: 0
page_cache_hdr[10]:
            pg_flags: 0 ()
             pg_addr: 0
           pg_bufptr: be0ec0
        pg_hit_count: 0
page_cache_hdr[11]:
            pg_flags: 0 ()
             pg_addr: 0
           pg_bufptr: be1ec0
        pg_hit_count: 0
page_cache_hdr[12]:
            pg_flags: 0 ()
             pg_addr: 0
           pg_bufptr: be2ec0
        pg_hit_count: 0
page_cache_hdr[13]:
            pg_flags: 0 ()
             pg_addr: 0
           pg_bufptr: be3ec0
        pg_hit_count: 0
page_cache_hdr[14]:
            pg_flags: 0 ()
             pg_addr: 0
           pg_bufptr: be4ec0
        pg_hit_count: 0
page_cache_hdr[15]:
            pg_flags: 0 ()
             pg_addr: 0
           pg_bufptr: be5ec0
        pg_hit_count: 0

    page_cache_buf: bd6ec0
       evict_index: 0
         evictions: 0
          accesses: 0
      cached_reads: 0 
       valid_pages: bd6cb0
crash: pv_init_ops exists: ARCH_PVOPS
compressed kdump: phys_base: 0
gdb /usr/lib/debug/lib/modules/2.6.31-23.el6.x86_64/vmlinux 
GNU gdb 6.1
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "x86_64-unknown-linux-gnu"...

cpu_possible_map: 0 1 
cpu_present_map: 0 1 
cpu_online_map: 0 1 
base kernel version: 2.6.31
verify_namelist:
/proc/version:
Linux version 2.6.31-23.el6.x86_64 (mockbuild@x86-004.build.bos.redhat.com) (gcc version 4.4.1 20090916 (Red Hat 4.4.1-14) (GCC) ) #1 SMP Fri Sep 18 16:04:38 EDT 2009
utsname version: #1 SMP Fri Sep 18 16:04:38 EDT 2009
/usr/lib/debug/lib/modules/2.6.31-23.el6.x86_64/vmlinux:
Linux version 2.6.31-23.el6.x86_64 (mockbuild@x86-004.build.bos.redhat.com) (gcc version 4.4.1 20090916 (Red Hat 4.4.1-14) (GCC) ) #1 SMP Fri Sep 18 16:04:38 EDT 2009

WARNING: Because this kernel was compiled with gcc version 4.4.1, certain
         commands or command options may fail unless crash is invoked with
         the  "--readnow" command line option.

GNU_GET_DATATYPE[runqueue]: returned via gdb_error_hook 
GNU_GET_DATATYPE[runqueue]: returned via gdb_error_hook 
GNU_GET_DATATYPE[prio_array]: returned via gdb_error_hook 
GNU_GET_DATATYPE[prio_array]: returned via gdb_error_hook 
GNU_GET_DATATYPE[prio_array]: returned via gdb_error_hook 
crash: get_cpus_online: online: 2
GNU_GET_DATATYPE[irq_desc_t]: returned via gdb_error_hook 
GNU_GET_DATATYPE[hw_interrupt_type]: returned via gdb_error_hook 
GNU_GET_DATATYPE[timer_vec_root]: returned via gdb_error_hook 
GNU_GET_DATATYPE[timer_vec]: returned via gdb_error_hook 
GNU_GET_DATATYPE[tvec_root_s]: returned via gdb_error_hook 
GNU_GET_DATATYPE[softirq_state]: returned via gdb_error_hook 
GNU_GET_DATATYPE[kallsyms_header]: returned via gdb_error_hook 
GNU_GET_DATATYPE[gate_struct]: returned via gdb_error_hook 
GNU_GET_DATATYPE[user_regs_struct]: returned via gdb_error_hook 
GNU_GET_DATATYPE[user_regs_struct]: returned via gdb_error_hook 
GNU_GET_DATATYPE[user_regs_struct]: returned via gdb_error_hook 
GNU_GET_DATATYPE[user_regs_struct]: returned via gdb_error_hook 
GNU_GET_DATATYPE[user_regs_struct]: returned via gdb_error_hook 
GNU_GET_DATATYPE[user_regs_struct]: returned via gdb_error_hook 
GNU_GET_DATATYPE[x8664_pda]: returned via gdb_error_hook 
x86_64_per_cpu_init: setup_percpu areas: 2
crash: get_cpus_online: online: 2
crash: page excluded: kernel virtual address: ffffffff819f1764  type: "tss_struct ist array"


# ./makedumpfile -D -d 16 /var/crash/127.0.0.1-2009-10-01-06\:22\:33/vmcore vmcore.16
LOAD (0)
  phys_start : 1000000
  phys_end   : 2683000
  virt_start : ffffffff81000000
  virt_end   : ffffffff82683000
LOAD (1)
  phys_start : 0
  phys_end   : a0000
  virt_start : ffff810000000000
  virt_end   : ffff8100000a0000
LOAD (2)
  phys_start : 100000
  phys_end   : 3000000
  virt_start : ffff810000100000
  virt_end   : ffff810003000000
LOAD (3)
  phys_start : b000000
  phys_end   : 3ff70000
  virt_start : ffff81000b000000
  virt_end   : ffff81003ff70000
Linux kdump
page_size    : 4096

max_mapnr    : 3ff70
The kernel version is not supported.
The created dumpfile may be incomplete.

num of NODEs : 1


Memory type  : SPARSEMEM_EX

mem_map (0)
  mem_map    : ffffea0000000000
  pfn_start  : 0
  pfn_end    : 8000
mem_map (1)
  mem_map    : ffffea0000340000
  pfn_start  : 8000
  pfn_end    : 10000
mem_map (2)
  mem_map    : ffffea0000680000
  pfn_start  : 10000
  pfn_end    : 18000
mem_map (3)
  mem_map    : ffffea00009c0000
  pfn_start  : 18000
  pfn_end    : 20000
mem_map (4)
  mem_map    : ffffea0000d00000
  pfn_start  : 20000
  pfn_end    : 28000
mem_map (5)
  mem_map    : ffffea0001040000
  pfn_start  : 28000
  pfn_end    : 30000
mem_map (6)
  mem_map    : ffffea0001380000
  pfn_start  : 30000
  pfn_end    : 38000
mem_map (7)
  mem_map    : ffffea00016c0000
  pfn_start  : 38000
  pfn_end    : 3ff70
Copying data                       : [100 %] 

The dumpfile is saved to vmcore.16.

makedumpfile Completed.


----Next_Part(Fri_Oct__2_12_21_42_2009_290)--
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

----Next_Part(Fri_Oct__2_12_21_42_2009_290)----

