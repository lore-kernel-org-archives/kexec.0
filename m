Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlHJ4-0001M0-BA
 for kexec@lists.infradead.org; Tue, 26 Nov 2013 11:59:55 +0000
Date: Tue, 26 Nov 2013 19:59:03 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] makedumpfile: add parameters to update_cyclic_region
Message-ID: <20131126115903.GD22934@dhcp-16-252.nay.redhat.com>
References: <20131125023150.GB13197@dhcp-16-252.nay.redhat.com>
 <5292D30E.5070003@jp.fujitsu.com>
 <20131126025221.GA22934@dhcp-16-252.nay.redhat.com>
 <5294368A.8030804@jp.fujitsu.com>
 <20131126075742.GB22934@dhcp-16-252.nay.redhat.com>
 <529460EA.2080006@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <529460EA.2080006@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, chaowang@redhat.com

On 11/26/13 at 05:50pm, HATAYAMA Daisuke wrote:
> (2013/11/26 16:57), Baoquan He wrote:
> >On 11/26/13 at 02:50pm, HATAYAMA Daisuke wrote:
> >>(2013/11/26 11:52), Baoquan He wrote:
> >>>On 11/25/13 at 01:33pm, HATAYAMA Daisuke wrote:
> >>>>(2013/11/25 11:31), Baoquan He wrote:
> >
> >>

> 
> For that, you need to pass a part with the currnet cycle to __exclude_unnecessary_pages(),
> not a whole (mmd->pfn_start, mmd->pfn_end). There might be similar part that needs fix,
> but sorry I don't have good memory...
> 
> int
> exclude_unnecessary_pages_cyclic(void)
> {
> <cut>
>                         if (mmd->pfn_end >= info->cyclic_start_pfn &&
>                             mmd->pfn_start <= info->cyclic_end_pfn) {
>                                 if (!__exclude_unnecessary_pages(mmd->mem_map,
>                                                                  mmd->pfn_start, mmd->pfn_end))
>                                         return FALSE;
>                         }
> 
> For ELF-to-ELF code, unfortunately, I gave up in the middle of source code reading.
> At lesst, if I remember correctly, I think the code relied on the current
> update_mmap_range() implementation. It might be hard to clean up there in a natural way.

Hi,

I reviewed code again, and understand what kind of pain you meant. I
think the hard part is write_elf_pages_cyclic(), because it is not kind
of like kdump format which loops from 0 to info->max_mapnr, then you can
use the loop MACRO.

struct cycle {
  uint64_t start_pfn;
  uint64_t end_pfn;
};

#define for_each_cycle(C, MAX_MAPNR) \
  for (first_cycle((C), (MAX_MAPNR)); !end_cycle(C); \
       update_cycle(C))

for_each_cycle(&cycle, info->max_mapnr) {
  if (!create_1st_bitmap_cyclic(&cycle))
    return FALSE;
  if (!exclude_unnecessary_pages_cyclic(&cycle))
    return FALSE;
  if (!write_kdump_bitmap1_cyclic(&cycle))
    return FALSE;
}


In fact, don't worry. Please check create_1st_bitmap_cyclic() again, its
handling is very similar to write_elf_pages_cyclic(), because both of
them traverse each PT_LOAD segment, and then do some handling. So you
can call create_1st_bitmap_cyclic() in the big loop which is from 0 to
info->max_mapnr, if rethink about write_elf_pages_cyclic(), you will
find it can also be called like this. Then the cycle loop MACRO can be
used either for elf format handling.

for_each_cycle(&cycle, info->max_mapnr) {
  if (!create_1st_bitmap_cyclic(&cycle))
    return FALSE;
  if (!exclude_unnecessary_pages_cyclic(&cycle))
    return FALSE;
  if (!write_elf_pages_cyclic(&cycle))
    return FALSE;
}

As for mmap, I don't think it will be affected by this change, anyway,
cycle has been passed in, not as a function parameter, but a global
variable (it's stored in global varible info, should be the same).

Baoquan
Thanks

> 
> -- 
> Thanks.
> HATAYAMA, Daisuke
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
