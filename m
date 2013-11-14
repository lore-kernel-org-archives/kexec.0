Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VguET-000413-VZ
 for kexec@lists.infradead.org; Thu, 14 Nov 2013 10:33:08 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id EE0AD3EE0BD
 for <kexec@lists.infradead.org>; Thu, 14 Nov 2013 19:32:35 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id DEC2F45DE55
 for <kexec@lists.infradead.org>; Thu, 14 Nov 2013 19:32:35 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.nic.fujitsu.com [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id C79A545DE54
 for <kexec@lists.infradead.org>; Thu, 14 Nov 2013 19:32:35 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id BB28F1DB8044
 for <kexec@lists.infradead.org>; Thu, 14 Nov 2013 19:32:35 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 6CAA41DB803F
 for <kexec@lists.infradead.org>; Thu, 14 Nov 2013 19:32:35 +0900 (JST)
Message-ID: <5284A689.70903@jp.fujitsu.com>
Date: Thu, 14 Nov 2013 19:31:37 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: /proc/vmcore mmap() failure issue
References: <20131113204130.GD7613@redhat.com>
In-Reply-To: <20131113204130.GD7613@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux kernel mailing list <linux-kernel@vger.kernel.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "Eric W. Biederman" <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, WANG Chao <chaowang@redhat.com>

(2013/11/14 5:41), Vivek Goyal wrote:
> Hi Hatayama,
>
> We are facing some /proc/vmcore mmap() failure issues and then makdumpfile
> exits without saving dump and system reboots.
>
> I tried latest makedumpfile (devel branch) with 3.12 kernel.
>
> I think this issue happens only on some machines. And it looks like it
> happens when end of system RAM chunk in first kernel is not page aligned. For
> example, I have one machine where I noticed it and this is how system
> RAM looks like.
>
> 00100000-dafa57ff : System RAM
>    01000000-015892fa : Kernel code
>    015892fb-0195c9ff : Kernel data
>    01ae6000-01d31fff : Kernel bss
>    24000000-33ffffff : Crash kernel
> dafa5800-dbffffff : reserved
>
> Notice that dafa57ff does not end at page boundary and next reserved
> range does not start at page boundary. I think that next reserved
> range is referenced through some ACPI data. More on this later.
>
> So we put some printk() messages to get more info. In a nut shell,
> remap_pfn_range() fails when we try to map the last section of system
> RAM not ending on page boundary.
>
> remap_pfn_range()
>     track_pfn_remap() {
>          /*
>           * For anything smaller than the vma size we set prot based on the
>           * lookup.
>           */
>          flags = lookup_memtype(paddr);
>
>          /* Check memtype for the remaining pages */
>          while (size > PAGE_SIZE) {
>                  size -= PAGE_SIZE;
>                  paddr += PAGE_SIZE;
>                  if (flags != lookup_memtype(paddr))
>                          return -EINVAL; <---------------- Failure.
>          }
> 	
>     }
>
>
> So we pass in a range to track_pfn_remap. Say pfn=0xdad62 size=0x244000.
> Now we call lookup_memtype() on every page in the range and make sure
> they all are same, otherwise we fail. Guess what, all all same except
> last page (which does not end at page boundary).
>
> I dived deeper in to lookup_memtype() and noticed that all regular
> ranges are not registered anywhere and their flags are _PAGE_CACHE_UC_MINUS.
> But last unaligned page/range, is registered in memtype rb tree and
> has attribute, _PAGE_CACHE_WB.
>
> Then I hooked into reserve_memtype() to figure out who is registering
> page 0xdafa5000 and it is acpi_init() which does it.
>
> [    0.721655] Hardware name: <edited>
> [    0.730590]  ffff8800340f3830 ffff8800340f37c0 ffffffff81575509
> 00000000dafa5000
> [    0.738010]  ffff8800340f3800 ffffffff810566cc 00000000000dafa5
> 00000000dafa5000
> [    0.745428]  00000000dafa6000 00000000dafa5000 0000000000000000
> 0000000000001000
> [    0.752845] Call Trace:
> [    0.755288]  [<ffffffff81575509>] dump_stack+0x45/0x56
> [    0.760414]  [<ffffffff810566cc>] reserve_memtype+0x31c/0x3f0
> [    0.766144]  [<ffffffff810537ef>] __ioremap_caller+0x12f/0x360
> [    0.771963]  [<ffffffff8130ad56>] ? acpi_os_release_object+0xe/0x12
> [    0.778217]  [<ffffffff815686ba>] ? acpi_os_map_memory+0xf6/0x14e
> [    0.784295]  [<ffffffff81053a54>] ioremap_cache+0x14/0x20
> [    0.789679]  [<ffffffff815686ba>] acpi_os_map_memory+0xf6/0x14e
> [    0.795582]  [<ffffffff81322ac9>]
> acpi_ex_system_memory_space_handler+0xdd/0x1ca
> [    0.802961]  [<ffffffff8131ca48>]
> acpi_ev_address_space_dispatch+0x1b0/0x208
> [    0.809993]  [<ffffffff8131fd49>] acpi_ex_access_region+0x20e/0x2a2
> [    0.816244]  [<ffffffff81149464>] ? __alloc_pages_nodemask+0x134/0x300
> [    0.822754]  [<ffffffff813200e4>] acpi_ex_field_datum_io+0xf6/0x171
> [    0.829004]  [<ffffffff81320301>] acpi_ex_extract_from_field+0xd7/0x20a
> [    0.835602]  [<ffffffff81331d80>] ?
> acpi_ut_create_internal_object_dbg+0x23/0x8a
> [    0.842981]  [<ffffffff8131f8e7>]
> acpi_ex_read_data_from_field+0x10f/0x14b
> [    0.849838]  [<ffffffff81322e16>]
> acpi_ex_resolve_node_to_value+0x18e/0x21c
> [    0.856780]  [<ffffffff813230a6>] acpi_ex_resolve_to_value+0x202/0x209
> [    0.863291]  [<ffffffff81319486>] acpi_ds_evaluate_name_path+0x7b/0xf5
> [    0.869803]  [<ffffffff81319834>] acpi_ds_exec_end_op+0x98/0x3e8
> [    0.875793]  [<ffffffff8132aca4>] acpi_ps_parse_loop+0x514/0x560
> [    0.881784]  [<ffffffff8132b738>] acpi_ps_parse_aml+0x98/0x28c
> [    0.887601]  [<ffffffff8132bf8d>] acpi_ps_execute_method+0x1c1/0x26c
> [    0.893939]  [<ffffffff813269c5>] acpi_ns_evaluate+0x1c1/0x258
> [    0.899755]  [<ffffffff8131cb98>] acpi_ev_execute_reg_method+0xca/0x112
> [    0.906353]  [<ffffffff8131cd6e>] acpi_ev_reg_run+0x48/0x52
> [    0.911910]  [<ffffffff81328fad>] acpi_ns_walk_namespace+0xc8/0x17f
> [    0.918160]  [<ffffffff8131cd26>] ? acpi_ev_detach_region+0x146/0x146
> [    0.924585]  [<ffffffff8131cdbc>] acpi_ev_execute_reg_methods+0x44/0xf7
> [    0.931184]  [<ffffffff819b2324>] ? acpi_sleep_proc_init+0x2a/0x2a
> [    0.937349]  [<ffffffff8130ac66>] ? acpi_os_wait_semaphore+0x43/0x57
> [    0.943686]  [<ffffffff81331a3f>] ? acpi_ut_acquire_mutex+0x48/0x88
> [    0.949938]  [<ffffffff8131ceb8>]
> acpi_ev_initialize_op_regions+0x49/0x71
> [    0.956709]  [<ffffffff819b2324>] ? acpi_sleep_proc_init+0x2a/0x2a
> [    0.962873]  [<ffffffff81333310>] acpi_initialize_objects+0x23/0x4f
> [    0.969125]  [<ffffffff819b23b4>] acpi_init+0x90/0x268
>
> So basically, this split page seems to be a problem. Some other code
> thinks that it has access to full page and goes ahead and registers
> that with PAT rb tree and this causes problems in mmap() code.
>
> I suspect we might have to go back to idea of copying first and last
> non page aligned ranges in new kernel's memory and read it from there
> to solve this issue. Do you have other ideas?
>

Sorry for delayed response, although it looks like you have already found
a way to fix this issue.

BTW, I previously found a part of makedumpfile that truncates the first and
last pages if they are not aligned in page size. Discussing with Kumagai-san,
the truncation is performed on some ia64 system and he found a valid data in
the truncated area, and the latest makedumpfile no longer does such
truncation.

The commit is:

commit f854b37adba223d5b4801accbedd17b447266d51
Author: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date:   Fri Jun 21 15:25:31 2013 +0900

     [PATCH 2/2] Fix the handling of the pages correspond to border of PT_LOAD.

     The pages correspond to border of PT_LOAD were removed as holes.
     For example, pfn:N showed below was removed but we know even
     odd region like [0x40ffda7000 - 0x40ffda8000] can include valid
     dates, so we shouldn't remove it as holes.

                                phys_start
                                = 0x40ffda7000
              |<-- frac_head -->|------------- PT_LOAD -------------
          ----+-----------------------+---------------------+----
              |         pfn:N         |       pfn:N+1       | ...
          ----+-----------------------+---------------------+----
              |
          pfn_to_paddr(pfn:N)               # page size = 16k
          = 0x40ffda4000

     This patch handles such odd regions correctly. Then read pfn:N
     and write it to disk, the ranges not covered by any PT_LOAD
     entries will be filled with 0.

     Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

The log on the web is:

http://lists.infradead.org/pipermail/kexec/2013-May/008875.html

So, without this change, you would not have seen this issue. The original
reason why the code was implemented so might be the issues similar to here.

Next, I think it necessary to consider whether or not to revert the above
commit or not since makedumpfile fails on some kind of system as you reported.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
