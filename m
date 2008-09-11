Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kdn03-00076n-I9
	for kexec@lists.infradead.org; Thu, 11 Sep 2008 14:18:24 +0000
Message-ID: <48C927A3.2000302@redhat.com>
Date: Thu, 11 Sep 2008 10:13:55 -0400
From: Dave Anderson <anderson@redhat.com>
MIME-Version: 1.0
Subject: Re: the exiting makedumpfile is almost there... :)
References: <48C85836.8080606@sgi.com>
In-Reply-To: <48C85836.8080606@sgi.com>
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
To: Jay Lan <jlan@sgi.com>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org

Jay Lan wrote:
> After getting around a few kdump kernel panic/hang, i finally was
> able to complete a kdump vmcore with 2.6.27-rc5. The system under
> testing was an IA64 with 128 cpu and 256G memory A4700 system.
> 
> The /proc/vmcore is:
> a4700rac:/boot # ll /proc/vmcore
> -r-------- 1 root root 263006257684 2008-09-10 14:45 /proc/vmcore
> a4700rac:/boot # ls -lh /proc/vmcore
> -r-------- 1 root root 245G 2008-09-10 14:44 /proc/vmcore
> 
> Time spent in saving the vmcore using cp was 7 min 17 sec:
> 
> a4700rac:/boot # date; cp /proc/vmcore /mnt/sda9/diskdump/vmcore-cp; date
> Wed Sep 10 14:34:18 PDT 2008
> Wed Sep 10 14:41:35 PDT 2008
> 
> Time spent with 'makedumpfile -c -d31' was 1 min 40 sec:
> 
> a4700rac:/boot # date; makedumpfile -c -d31 -x
> /boot/vmlinux-2.6.27-rc5-default /proc/vmcore
> /mnt/sda9/diskdump/vmcore-2.6.27-rc5-default; date
> Wed Sep 10 14:31:56 PDT 2008
> Can't distinguish the pgtable.
> The kernel version is not supported.
> The created dumpfile may be incomplete.
> Copying data                       : [100 %]
> 
> The dumpfile is saved to /mnt/sda9/diskdump/vmcore-2.6.27-rc5-default.
> 
> makedumpfile Completed.
> Wed Sep 10 14:33:36 PDT 2008
> 
> 
> The fact that it took only 1 min 40 sec in running makedumpfile was
> EXCELLENT and EXCITING!!! Remember last time i tested on a 256 cpu
> 1TB A4700? It took 18 hours to complete the makedumpfile. What an
> improvement!
> 
> Hmmm, the reason it is only "almost there" was that crash failed
> to analyze the output of makedumpfile. :(  Crash was happy with
> the vmcore saved with 'cp' command.
> 
> a4700rac:/var/tmp/jlan # crash -d 1 /boot/vmlinux-2.6.27-rc5-default
> /mnt/sda9/diskdump/vmcore-2.6.27-rc5-default
> 
> crash 4.0-4.10
> Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007  Red Hat, Inc.
> Copyright (C) 2004, 2005, 2006  IBM Corporation
> Copyright (C) 1999-2006  Hewlett-Packard Co
> Copyright (C) 2005, 2006  Fujitsu Limited
> Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
> Copyright (C) 2005  NEC Corporation
> Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
> Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
> This program is free software, covered by the GNU General Public License,
> and you are welcome to change it and/or distribute copies of it under
> certain conditions.  Enter "help copying" to see the conditions.
> This program has absolutely no warranty.  Enter "help warranty" for details.
> 
> crash: xc_core_elf_verify: not a xen ELF core file
> diskdump_data:
>              flags: 6 (KDUMP_CMPRS_LOCAL|ERROR_EXCLUDED)
>                dfd: 3
>                ofp: 0
>       machine_type: 50 (EM_IA_64)
> 
>             header: 6000000001142c70
>            signature: "KDUMP   "
>       header_version: 1
>              utsname:
>                sysname:
>               nodename:
>                release:
>                version:
>                machine:
>             domainname:
>            timestamp:
>                 tv_sec: 0
>                tv_usec: 0
>               status: 0 ()
>           block_size: 65536
>         sub_hdr_size: 1
>        bitmap_blocks: 2076
>            max_mapnr: 543813611
>     total_ram_blocks: 0
>        device_blocks: 0
>       written_blocks: 0
>          current_cpu: 0
>              nr_cpus: 1
>       tasks[nr_cpus]: 0
> 
>         sub_header: 0 (n/a)
> 
>   sub_header_kdump: 6000000001152c80
>            phys_base: 6044000000
>           dump_level: 31 (0x1f)
> (DUMP_EXCLUDE_ZERO|DUMP_EXCLUDE_CACHE|DUMP_EXCLUDE_CACHE_PRI|DUMP_EXCLUDE_USER_DATA|DUMP_EXCLUDE_FREE)
> 
>        data_offset: 81e0000
>         block_size: 65536
>        block_shift: 16
>             bitmap: 2000000000530010
>         bitmap_len: 136052736
>    dumpable_bitmap: 2000000008700010
>               byte: 0
>                bit: 0
>    compressed_page: 6000000001162c90
>          curbufptr: 0
> 
>  page_cache_hdr[0]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 20000000109e0010
>         pg_hit_count: 0
>  page_cache_hdr[1]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 20000000109f0010
>         pg_hit_count: 0
>  page_cache_hdr[2]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010a00010
>         pg_hit_count: 0
>  page_cache_hdr[3]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010a10010
>         pg_hit_count: 0
>  page_cache_hdr[4]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010a20010
>         pg_hit_count: 0
>  page_cache_hdr[5]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010a30010
>         pg_hit_count: 0
>  page_cache_hdr[6]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010a40010
>         pg_hit_count: 0
>  page_cache_hdr[7]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010a50010
>         pg_hit_count: 0
>  page_cache_hdr[8]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010a60010
>         pg_hit_count: 0
>  page_cache_hdr[9]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010a70010
>         pg_hit_count: 0
> page_cache_hdr[10]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010a80010
>         pg_hit_count: 0
> page_cache_hdr[11]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010a90010
>         pg_hit_count: 0
> page_cache_hdr[12]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010aa0010
>         pg_hit_count: 0
> page_cache_hdr[13]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010ab0010
>         pg_hit_count: 0
> page_cache_hdr[14]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010ac0010
>         pg_hit_count: 0
> page_cache_hdr[15]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010ad0010
>         pg_hit_count: 0
> 
>     page_cache_buf: 20000000109e0010
>        evict_index: 0
>          evictions: 0
>           accesses: 0
>       cached_reads: 0
>        valid_pages: 20000000108d0010
> compressed kdump: phys_start: 6044000000
> gdb /boot/vmlinux-2.6.27-rc5-default
> GNU gdb 6.1
> Copyright 2004 Free Software Foundation, Inc.
> GDB is free software, covered by the GNU General Public License, and you are
> welcome to change it and/or distribute copies of it under certain
> conditions.
> Type "show copying" to see the conditions.
> There is absolutely no warranty for GDB.  Type "show warranty" for details.
> This GDB was configured as "ia64-unknown-linux-gnu"...
> 
> crash: CONFIG_HZ: 250
> crash: CONFIG_NR_CPUS: 512
> verify_namelist:
> /proc/version:
> Linux version 2.6.27-rc5-default (jlan@jackhammer) (gcc version 4.1.2
> 20070115 (SUSE Linux)) #61 SMP Wed Sep 10 14:21:26 PDT 2008
> utsname version: #61 SMP Wed Sep 10 14:21:26 PDT 2008
> /boot/vmlinux-2.6.27-rc5-default:
> Linux version 2.6.27-rc5-default (jlan@jackhammer) (gcc version 4.1.2
> 20070115 (SUSE Linux)) #61 SMP Wed Sep 10 14:21:26 PDT 2008
> 
> WARNING: Because this kernel was compiled with gcc version 4.1.2, certain
>          commands or command options may fail unless crash is invoked with
>          the  "--readnow" command line option.
> 
> crash: get_cpus_online: online: 128
> node_table[0]:
>              id: 0
>           pgdat: 0
>            size: 543813632
>         present: 73014444033
>         mem_map: 0
>     start_paddr: 0
>     start_mapnr: 0
> NOTE: page_hash_table does not exist in this kernel
> crash: page excluded: kernel virtual address: e000006003108e00  type:
> "runqueues entry (per_cpu)"
> a4700rac:/var/tmp/jlan #
> 

Jay,

Ken'ichi's suggestion to update your crash version is a good one,
although it's noteworthy that "Crash was happy with the vmcore saved
with 'cp' command".

At first I thought that the "phys_start" value of 6044000000 was
bizarre, but then again, this is an SGI machine, and it must
be correct since it was able to read the "linux_banner" string
from the mapped kernel region (as evidenced by the output above
showing "/proc/version: ...").  You can always verify that value
by running on the live system or against the "cp" generated dump:

   crash> help -m | grep phys_start

In any case, the node_table data looks bogus, and there was a
change in 4.0-4.12 that comes to mind:

4.0-4.12 - Fix for the "kmem -n" command to handle the 2.6.24 kernel replacement
            of the "node_online_map" nodemask with its appropriate entry in the
            new "node_states[]" nodemask array.  Without the patch, the per-node
            zone data would not be displayed, and any commands depending upon
            the node table data would be affected.  (anderson@redhat.com)

But the crash session would at least initialize properly, as yours did when
running with the "cp" dumpfile.  Anyway, please update your crash version.

Then, when it tried to read a per-cpu runqueue structure it ran into
the "page excluded" error.  One thing to verify is that the per-cpu
address is being correctly generated.  Using the "cp" generated dumpfile
enter "per_cpu__runqueues" on the command line, as in this RHEL5/ia64
example:

   crash> per_cpu__runqueues
   PER-CPU DATA TYPE:
     struct rq per_cpu__runqueues;
   PER-CPU ADDRESSES:
     [0]: e000000004e04be0
     [1]: e000000004e14be0
   crash>

My guess is that the runqueue address you see for cpu 0 will be the excluded
e000006003108e00.  If that's true, then makedumpfile does appear to be
excluding the page, and that page -- where the runqueue data structure(s)
exist -- is absolutely essential to initializing the crash session.

Dave








_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
