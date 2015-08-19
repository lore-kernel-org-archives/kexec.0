Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZSA8S-0002Xp-1I
 for kexec@lists.infradead.org; Wed, 19 Aug 2015 20:39:00 +0000
Date: Wed, 19 Aug 2015 16:38:33 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <2097586247.19732970.1440016713516.JavaMail.zimbra@redhat.com>
In-Reply-To: <mailman.5.1440010802.20553.kexec@lists.infradead.org>
References: <mailman.5.1440010802.20553.kexec@lists.infradead.org>
Subject: Dmesg not being dumped
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kernel@kyup.com
Cc: kexec@lists.infradead.org



----- Original Message -----
> 
> Hi,
> 
> On 08/19/2015 12:02 PM, Baoquan He wrote:
> > On 08/19/15 at 09:21am, Nikolay Borisov wrote:
> >> Hello,
> >>
> >> I've recently noticed that when creating crashdumps the dmesg is not
> >> being saved. The error reported is this: "Missing the struct log size
> >> export". I've tested with both kernel 4.1.1 and 3.12.28. My version of
> >> kexec tools is : kexec-tools 2.0.9 released 04 June 2015. The kernel has
> >> been compiled with debugging info so the respective symbol should be
> >> exported but apparently it is not. Any ideas how to debug that?
> > 
> > That would be more helpful if you can attach the 1st kernel and kdump
> > kernel console log.
> 
> I just tested with 4.1.6 with the same result. I'm sending you a link to
> the bzImage in question
> http://georgi.unixsol.org/cruft/tmp/bzImage-4.1.6-clouder1 ( I assume
> you meant the bzImage, if you need I can provide the vmlinux as well).
> Unfortunately, I couldn't figure how to obtain the log of kdump in
> textual format (and didn't want to send pictures). Here are the 3
> relevant lines (from memory):
> 
> Saving vmcore-dmesg.txt
> Missing the struct log size export   
> Error saving vmcore-dmesg.txt.
> 
> Yet, when I load the crashdump inside the 'crash' utility and invoke the
> 'log' command the dmesg log is there. Whereas the vmcore-dmesg-incomplete.txt is empty.

FYI -- the crash utility doesn't use the vmcoreinfo data for its "log" command, 
but you can dump the vmcore's header contents, including the vmcoreinfo strings,
with the "help -n" command.  For example:

crash> help -n
... [ cut ] ...
                      OSRELEASE=3.18.0-0.rc2.git2.1.slub1.fc21.x86_64
                      PAGESIZE=4096
                      SYMBOL(init_uts_ns)=ffffffff81e1b300
                      SYMBOL(node_online_map)=ffffffff81fe8980
                      SYMBOL(swapper_pg_dir)=ffffffff81e14000
                      SYMBOL(_stext)=ffffffff810001c8
                      SYMBOL(vmap_area_list)=ffffffff81efce50
                      SYMBOL(mem_section)=ffffffff832eb180
                      LENGTH(mem_section)=4096
                      SIZE(mem_section)=32
                      OFFSET(mem_section.section_mem_map)=0
                      SIZE(page)=64
                      SIZE(pglist_data)=156928
                      SIZE(zone)=1984
                      SIZE(free_area)=88
                      SIZE(list_head)=16
                      SIZE(nodemask_t)=128
                      OFFSET(page.flags)=0
                      OFFSET(page._count)=28
                      OFFSET(page.mapping)=8
                      OFFSET(page.lru)=32
                      OFFSET(page._mapcount)=24
                      OFFSET(page.private)=48
                      OFFSET(pglist_data.node_zones)=0
                      OFFSET(pglist_data.nr_zones)=156480
                      OFFSET(pglist_data.node_start_pfn)=156560
                      OFFSET(pglist_data.node_spanned_pages)=156576
                      OFFSET(pglist_data.node_id)=156584
                      OFFSET(zone.free_area)=392
                      OFFSET(zone.vm_stat)=1664
                      OFFSET(zone.spanned_pages)=120
                      OFFSET(free_area.free_list)=0
                      OFFSET(list_head.next)=0
                      OFFSET(list_head.prev)=8
                      OFFSET(vmap_area.va_start)=0
                      OFFSET(vmap_area.list)=48
                      LENGTH(zone.free_area)=11
                      SYMBOL(log_buf)=ffffffff81e5f0c0
                      SYMBOL(log_buf_len)=ffffffff81e5f0bc
                      SYMBOL(log_first_idx)=ffffffff831bee88
                      SYMBOL(log_next_idx)=ffffffff831bee78
                      SIZE(printk_log)=16
                      OFFSET(printk_log.ts_nsec)=0
                      OFFSET(printk_log.len)=8
                      OFFSET(printk_log.text_len)=10
                      OFFSET(printk_log.dict_len)=12
                      LENGTH(free_area.free_list)=5
                      NUMBER(NR_FREE_PAGES)=0
                      NUMBER(PG_lru)=5
                      NUMBER(PG_private)=11
                      NUMBER(PG_swapcache)=16
                      NUMBER(PG_slab)=7
                      NUMBER(PG_hwpoison)=23
                      NUMBER(PG_head_mask)=16384
                      NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)=-128
                      SYMBOL(free_huge_page)=ffffffff81239430
                      SYMBOL(phys_base)=ffffffff81e1b010
                      SYMBOL(init_level4_pgt)=ffffffff81e14000
                      SYMBOL(node_data)=ffffffff81fe2d40
                      LENGTH(node_data)=1024
                      KERNELOFFSET=0
                      CRASHTIME=141512763
...

Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
