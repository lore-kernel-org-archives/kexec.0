Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KeFTa-0002DV-3x
	for kexec@lists.infradead.org; Fri, 12 Sep 2008 20:42:46 +0000
Message-ID: <48CAD340.7000701@redhat.com>
Date: Fri, 12 Sep 2008 16:38:24 -0400
From: Dave Anderson <anderson@redhat.com>
MIME-Version: 1.0
Subject: Re: the exiting makedumpfile is almost there... :)
References: <48C85836.8080606@sgi.com> <20080911143226.GT29908@sgi.com>
	<48C9D22A.5010404@mxs.nes.nec.co.jp> <48CA70CD.2090500@sgi.com>
	<48CAC7DB.4090904@sgi.com>
In-Reply-To: <48CAC7DB.4090904@sgi.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0889205766=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jay Lan <jlan@sgi.com>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, kexec@lists.infradead.org, Hedi Berriche <hedi@sgi.com>

--===============0889205766==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Jay Lan wrote:
> Jay Lan wrote:
> 
>>Ken'ichi Ohmichi wrote:
>>
>>>Hi Hedi, Jay,
>>>
>>>Hedi Berriche wrote:
>>>
>>>>In addition to what other folks have mentioned about giving the latest crash
>>>>version a try, I'd like to point out that makedumpfile did spit a couple of
>>>>warnings while creating the vmcore
>>>>
>>>>
>>>>| Can't distinguish the pgtable.
>>>>| The kernel version is not supported.
>>>>| The created dumpfile may be incomplete.
>>>>
>>>>these warnings added to the fact that later on crash choked with
>>>>
>>>>| NOTE: page_hash_table does not exist in this kernel
>>>>| crash: page excluded: kernel virtual address: e000006003108e00  type:
>>>>
>>>>seem to suggest that the makedumpfile warnings could be relevant to the
>>>>end result.
>>>
>>>Oh, good point.
>>>If makedumpfile cannot distinguish the pgtable, it guesses PGTABLE_3 and
>>>creates a dumpfile. If Jay's kernel .config file has CONFIG_PGTABLE_4=y,
>>>makedumpfile misunderstands the pgtable. If it has CONFIG_PGTABLE_4=y,
>>>could you please try the attached patch ? This patch is only for debugging,
>>>and I'll investigate the cause.
>>
>>My .config uses CONFIG_PGTABLE_3=y.
>>I will try to build makedumpfile-1.2.9 and report back.
> 
> 
> I rebuilt the kernel with Ken'ichi's kernel patch he posted on 8/31 on
> "Fix the difference between node_mem_map and node_start_pfn". I also
> used makedumpfile-1.2.9 & crash-4.0-7.1. I did not see the complaint
> "Can't distinguish the pgtable" from makedumpfile this time.
> 
> Crash failed to come up again, on error:
>   page excluded: kernel virtual address: e0000060031417a8  type:
>   "zone spanned_pages"
> 
> Still, crash was able to come up with vmcore by 'cp'. How do i verify
> the "zone spanned_pages" from crash analyzing the vmcore from 'cp',
> Dave?

See below...

> 
> Best
> jay
> 
> 
> (Running crash against vmcore saved by makedumpfile:)
> a4700rac:/mnt/sda9/diskdump # /var/tmp/jlan/crash -d 1
> /boot/vmlinux-2.6.27-rc5-default vmcore-2.6.27-rc5-default.1
> 
> crash 4.0-7.1
> Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007, 2008  Red Hat, Inc.
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
> compressed kdump: header->utsname.machine:
> diskdump_data:
>              flags: 6 (KDUMP_CMPRS_LOCAL|ERROR_EXCLUDED)
>                dfd: 3
>                ofp: 0
>       machine_type: 50 (EM_IA_64)
> 
>             header: 60000000004e2c70
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
>   sub_header_kdump: 60000000004f2c80
>            phys_base: 6044000000
>           dump_level: 31 (0x1f)
> (DUMP_EXCLUDE_ZERO|DUMP_EXCLUDE_CACHE|DUMP_EXCLUDE_CACHE_PRI|DUMP_EXCLUDE_USER_DATA|DUMP_EXCLUDE_FREE)
> 
>        data_offset: 81e0000
>         block_size: 65536
>        block_shift: 16
>             bitmap: 2000000000590010
>         bitmap_len: 136052736
>    dumpable_bitmap: 2000000008760010
>               byte: 0
>                bit: 0
>    compressed_page: 6000000000502c90
>          curbufptr: 0
> 
>  page_cache_hdr[0]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010a40010
>         pg_hit_count: 0
>  page_cache_hdr[1]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010a50010
>         pg_hit_count: 0
>  page_cache_hdr[2]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010a60010
>         pg_hit_count: 0
>  page_cache_hdr[3]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010a70010
>         pg_hit_count: 0
>  page_cache_hdr[4]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010a80010
>         pg_hit_count: 0
>  page_cache_hdr[5]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010a90010
>         pg_hit_count: 0
>  page_cache_hdr[6]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010aa0010
>         pg_hit_count: 0
>  page_cache_hdr[7]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010ab0010
>         pg_hit_count: 0
>  page_cache_hdr[8]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010ac0010
>         pg_hit_count: 0
>  page_cache_hdr[9]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010ad0010
>         pg_hit_count: 0
> page_cache_hdr[10]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010ae0010
>         pg_hit_count: 0
> page_cache_hdr[11]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010af0010
>         pg_hit_count: 0
> page_cache_hdr[12]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010b00010
>         pg_hit_count: 0
> page_cache_hdr[13]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010b10010
>         pg_hit_count: 0
> page_cache_hdr[14]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010b20010
>         pg_hit_count: 0
> page_cache_hdr[15]:
>             pg_flags: 0 ()
>              pg_addr: 0
>            pg_bufptr: 2000000010b30010
>         pg_hit_count: 0
> 
>     page_cache_buf: 2000000010a40010
>        evict_index: 0
>          evictions: 0
>           accesses: 0
>       cached_reads: 0
>        valid_pages: 2000000010930010
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
> cpu_possible_map: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
> 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44
> 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68
> 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92
> 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112
> 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127
> cpu_present_map: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21
> 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45
> 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69
> 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93
> 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112
> 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127
> cpu_online_map: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21
> 22 23 24
> 
> 1 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74
> 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98
> 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116
> 117 118 119 120 121 122 123 124 125 126 127
> verify_namelist:
> /proc/version:
> Linux version 2.6.27-rc5-default (jlan@jackhammer) (gcc version 4.1.2
> 20070115 (SUSE Linux)) #64 SMP Fri Sep 12 11:39:17 PDT 2008
> utsname version: #64 SMP Fri Sep 12 11:39:17 PDT 2008
> /boot/vmlinux-2.6.27-rc5-default:
> Linux version 2.6.27-rc5-default (jlan@jackhammer) (gcc version 4.1.2
> 20070115 (SUSE Linux)) #64 SMP Fri Sep 12 11:39:17 PDT 2008
> 
> WARNING: Because this kernel was compiled with gcc version 4.1.2, certain
>          commands or command options may fail unless crash is invoked with
>          the  "--readnow" command line option.
> 
> crash: get_cpus_online: online: 128
> node_online_map: [1ffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> 0] -> nodes online: 33
> No symbol "node_data" in current context.
> node_table[0]:
>              id: 0
>           pgdat: e000006003140000
>            size: 62720
>         present: 62720
>         mem_map: a07ffff8fdd0a800
>     start_paddr: 6003000000
>     start_mapnr: 6292224
> crash: page excluded: kernel virtual address: e0000060031417a8  type:
> "zone spanned_pages"

Try using at least -d4 and redirect the output to a file.  It's much
more verbose than the above, but it shows every readmem() made from
the dumpfile:

 # crash -d4 vmlinux vmcore.cp > /tmp/debug.cp
 q
 # crash -d4 vmlinux vmcore.makedumpfile > /tmp/debug.makedumpfile
 q
 #

Then compare the two outputs -- they should be pretty much identical
(except for any crash utility user addresses) until the vmcore.makedumpfile
fails.  So you should see a successful readmem() of e0000060031417a8 in
the "vmcore.cp" debug output at the point where it fails doing the
read in "vmcore.makedumpfile" above.

What's kind of strange is that pglist_data.node_zones structure that
it's reading from is in the same page as the base pglist_data
at e000006003140000, i.e., at page offset 17a8 (6056).  And the code
looks like it has already read data from that same page prior to
reading the "zone spanned pages".  (I'm presuming that the ia64 page
size you're using is greater than 4k).  But the -d4 output will
confirm that.

Dave




--===============0889205766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0889205766==--
