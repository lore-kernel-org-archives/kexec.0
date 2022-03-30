From: HAGIO KAZUHITO=?unknown-8bit?b?6JCp5bC+IOS4gOS7gQ==?= <k-hagio-ab@nec.com>
Date: Wed, 30 Mar 2022 02:04:39 +0000
Subject: crash: read error on type: "memory section root table"
In-Reply-To: <DB7PR08MB327305868D5DF87C2E31B972CA1E9@DB7PR08MB3273.eurprd08.prod.outlook.com>
References: <DB7PR08MB327305868D5DF87C2E31B972CA1E9@DB7PR08MB3273.eurprd08.prod.outlook.com>
Message-ID: <TYYPR01MB67776D129929014239C34414DD1F9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

-----Original Message-----
> Hello,
> 
> Sorry to cross post on both ML, I'm not sure which one would be the most suitable.
> 
> Issue on analysis with crash-7.3.1 on a Centos 8 machine:
> crash: read error: kernel virtual address: ffff8f4fff7fc000? type: "memory section root table"
> 
> Crash machine has a Rocky Linux 8.5 based kernel with following config options:
> - CONFIG_RANDOMIZE_BASE=y
> - CONFIG_RANDOMIZE_MEMORY=y
> - CONFIG_SPARSEMEM_MANUAL=y
> - CONFIG_SPARSEMEM=y
> - CONFIG_SPARSEMEM_EXTREME=y
> - CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> - CONFIG_KEXEC_CORE=y
> - CONFIG_KEXEC=y
> - CONFIG_KEXEC_FILE=y
> 
> Kexec-tools package is from Centos Stream repo: kexec-tools-2.0.20-68.el8.2.5ale.x86_64
> 
> /proc/vmcore is packaged with :
> /sbin/makedumpfile -D -d 0 -c --message-level 15 /proc/vmcore /tmpd/crashdump-${linux_ver}-${date_time}
> 
> At kernel panic, I get:
> Dumping memory to crash partition
> This may take a while, please wait...
> makedumpfile: version 1.7.0 (released on 8 Nov 2021)
> command line: /sbin/makedumpfile -D -d 0 -c --message-level 15 /proc/vmcore /tmpd/crashdump--20220329-1538
> 
> sadump: does not have partition header
> sadump: read dump device as unknown format
> sadump: unknown format
> ?????????????? phys_start???????? phys_end?????? virt_start???????? virt_end
> LOAD[ 0]????????? 8000000????????? 9a2c000 ffffffff8a400000 ffffffff8be2c000
> LOAD[ 1]?????????? 100000???????? 3b000000 ffff8f4fc0100000 ffff8f4ffb000000
> LOAD[ 2]???????? 3d800000???????? 3e341000 ffff8f4ffd800000 ffff8f4ffe341000
> LOAD[ 3]???????? 3ed7b000???????? 3eee2000 ffff8f4ffed7b000 ffff8f4ffeee2000
> LOAD[ 4]???????? 3f63a000???????? 3f800000 ffff8f4fff63a000 ffff8f4fff800000
> Linux kdump
> VMCOREINFO?? :
> ? OSRELEASE=4.18.0-348.12.2.el8_5-ale
> ? PAGESIZE=4096
> page_size??? : 4096
> ? SYMBOL(init_uts_ns)=ffffffff8b653600
> ? SYMBOL(node_online_map)=ffffffff8b7630a8
> ? SYMBOL(swapper_pg_dir)=ffffffff8b64c000
> ? SYMBOL(_stext)=ffffffff8a400000
> ? SYMBOL(vmap_area_list)=ffffffff8b6a47a0
> ? SYMBOL(mem_map)=ffffffff8bd25828
> ? SYMBOL(contig_page_data)=ffffffff8b726600
> ? SYMBOL(mem_section)=ffff8f4fff7fc000

hm, probably I've never seen a system that has both mem_map and mem_section, but
it looks like makedumpfile works fine.. i.e. recognizes it as SPARSEMEM_EXTREME
correctly.

> ? LENGTH(mem_section)=2048
> ? SIZE(mem_section)=16
> ? OFFSET(mem_section.section_mem_map)=0
> ? SIZE(page)=64
> ? SIZE(pglist_data)=5696
> ? SIZE(zone)=1216
> ? SIZE(free_area)=72
> ? SIZE(list_head)=16
> ? SIZE(nodemask_t)=8
> ? OFFSET(page.flags)=0
> ? OFFSET(page._refcount)=52
> ? OFFSET(page.mapping)=24
> ? OFFSET(page.lru)=8
> ? OFFSET(page._mapcount)=48
> ? OFFSET(page.private)=40
> ? OFFSET(page.compound_dtor)=16
> ? OFFSET(page.compound_order)=17
> ? OFFSET(page.compound_head)=8
> ? OFFSET(pglist_data.node_zones)=0
> ? OFFSET(pglist_data.nr_zones)=4944
> ? OFFSET(pglist_data.node_start_pfn)=4952
> ? OFFSET(pglist_data.node_spanned_pages)=4968
> ? OFFSET(pglist_data.node_id)=4976
> ? OFFSET(zone.free_area)=192
> ? OFFSET(zone.vm_stat)=1104
> ? OFFSET(zone.spanned_pages)=96
> ? OFFSET(free_area.free_list)=0
> ? OFFSET(list_head.next)=0
> ? OFFSET(list_head.prev)=8
> ? OFFSET(vmap_area.va_start)=0
> ? OFFSET(vmap_area.list)=40
> ? LENGTH(zone.free_area)=11
> ? SYMBOL(log_buf)=ffffffff8b67d3c0
> ? SYMBOL(log_buf_len)=ffffffff8b67d3bc
> ? SYMBOL(log_first_idx)=ffffffff8bd1a3d8
> ? SYMBOL(clear_idx)=ffffffff8bd1a3a4
> ? SYMBOL(log_next_idx)=ffffffff8bd1a3c8
> ? SIZE(printk_log)=16
> ? OFFSET(printk_log.ts_nsec)=0
> ? OFFSET(printk_log.len)=8
> ? OFFSET(printk_log.text_len)=10
> ? OFFSET(printk_log.dict_len)=12
> ? LENGTH(free_area.free_list)=4
> ?NUMBER(NR_FREE_PAGES)=0
> ? NUMBER(PG_lru)=5
> ? NUMBER(PG_private)=12
> ? NUMBER(PG_swapcache)=9
> ? NUMBER(PG_swapbacked)=18
> ? NUMBER(PG_slab)=8
> ? NUMBER(PG_head_mask)=32768
> ? NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)=-129
> ? NUMBER(HUGETLB_PAGE_DTOR)=2
> ? NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE)=-257
> ? SYMBOL(alcatel_dump_info)=ffffffff8b647000
> ? NUMBER(phys_base)=-37748736
> ? SYMBOL(init_top_pgt)=ffffffff8b64c000
> ? NUMBER(pgtable_l5_enabled)=0
> ? KERNELOFFSET=9400000
> ? NUMBER(KERNEL_IMAGE_SIZE)=1073741824
> ? NUMBER(sme_mask)=0
> ? CRASHTIME=1648561077
> 
> phys_base??? : fffffffffdc00000 (vmcoreinfo)
> 
> max_mapnr??? : 3f800
> There is enough free memory to be done in one cycle.
> 
> Buffer size for the cyclic mode: 65024
> page_offset ?: ffff8f4fc0000000 (pt_load)
> num of NODEs : 1
> Memory type? : SPARSEMEM_EX
> 
> ?????????????????????? mem_map??????? pfn_start????????? pfn_end
> mem_map[?? 0] ffff8f4ffa000000??????????????? 0???????????? 8000
> mem_map[?? 1] ffff8f4ffa200000???????????? 8000?? ?????????10000
> mem_map[?? 2] ffff8f4ffa400000??????????? 10000??????????? 18000
> mem_map[?? 3] ffff8f4ffa600000??????????? 18000??????????? 20000
> mem_map[?? 4] ffff8f4ffa800000??????????? 20000??????????? 28000
> mem_map[?? 5] ffff8f4ffaa00000??????????? 28000??????????? 30000
> mem_map[?? 6] ffff8f4ffac00000??????????? 30000??????????? 38000
> mem_map[?? 7] ffff8f4ffae00000??????????? 38000??????????? 3f800
> mmap() is available on the kernel.
> Copying data????????????????????????????????????? : [100.0 %] |?????????? eta: 0s
> Writing erase info...
> offset_eraseinfo: ca157f3, size_eraseinfo: 0
> 
> The dumpfile is saved to /tmpd/crashdump--20220329-1538.
> 
> makedumpfile Completed.
> Rebooting the system...
> 
> And latest logs from a 'crash -d 7' command are:
> <.>
> kernel NR_CPUS: 2
> <readmem: ffffffff8bd25820, KVADDR, "high_memory", 8, (FOE), 55e05ecb3608>
> <read_diskdump: addr: ffffffff8bd25820 paddr: 9925820 cnt: 8>
> PAGESIZE=4096
> mem_section_size = 16384
> NR_SECTION_ROOTS = 2048
> NR_MEM_SECTIONS = 524288
> SECTIONS_PER_ROOT = 256
> SECTION_ROOT_MASK = 0xff
> PAGES_PER_SECTION = 32768
> <readmem: ffffffff8bd26db0, KVADDR, "mem_section", 8, (FOE), 7ffdbf96a440>
> <read_diskdump: addr: ffffffff8bd26db0 paddr: 9926db0 cnt: 8>
> <readmem: ffff8f4fff7fc000, KVADDR, "memory section root table", 16384, (FOE), 55e06391b840>
> <read_diskdump: addr: ffff8f4fff7fc000 paddr: 3f7fc000 cnt: 4096>
> crash: read error: kernel virtual address: ffff8f4fff7fc000? type: "memory section root table"
> 
> The address (ffff8f4fff7fc000) seems to be inside the LOAD[4] range and is recorded as 'mem_section' with
> VMCOREINFO.

Yes, this says it's sane, and its paddr also looks sane..

So I'm not sure why read_diskdump() returns READ_ERROR, could you debug it?
I'm suspecting the read() below in cache_page() returns something, e.g.

--- a/diskdump.c
+++ b/diskdump.c
@@ -1189,10 +1189,13 @@ cache_page(physaddr_t paddr)
                        return PAGE_INCOMPLETE;
                }
        } else {
+               ssize_t r;
                if (lseek(dd->dfd, pd.offset, SEEK_SET) == failed)
                        return SEEK_ERROR;
-               if (read(dd->dfd, dd->compressed_page, pd.size) != pd.size)
+               if ((r = read(dd->dfd, dd->compressed_page, pd.size)) != pd.size) {
+                       error(INFO, "errno=%d r=%ld pd.size=%u\n", errno, r, pd.size);
                        return READ_ERROR;
+               }
        }
 
        if (pd.flags & DUMP_DH_COMPRESSED_ZLIB) {

although another path may be returning it.

Thanks,
Kazu


