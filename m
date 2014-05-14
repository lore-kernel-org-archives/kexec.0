Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WkWZr-0000U4-NR
 for kexec@lists.infradead.org; Wed, 14 May 2014 10:38:24 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 276013EE0AE
 for <kexec@lists.infradead.org>; Wed, 14 May 2014 19:37:58 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 1608045DE93
 for <kexec@lists.infradead.org>; Wed, 14 May 2014 19:37:58 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.nic.fujitsu.com [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 0189045DE90
 for <kexec@lists.infradead.org>; Wed, 14 May 2014 19:37:58 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id E9CD61DB8037
 for <kexec@lists.infradead.org>; Wed, 14 May 2014 19:37:57 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 963421DB8032
 for <kexec@lists.infradead.org>; Wed, 14 May 2014 19:37:57 +0900 (JST)
Date: Wed, 14 May 2014 19:37:23 +0900 (JST)
Message-Id: <20140514.193723.161348018.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v3 1/2] Generic handling of multi-page exclusions
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9721099E@BPXM01GP.gisp.nec.co.jp>
References: <1399482403-3656-1-git-send-email-ptesarik@suse.cz>
 <1399482403-3656-2-git-send-email-ptesarik@suse.cz>
 <0910DD04CBD6DE4193FCF86B9C00BE9721099E@BPXM01GP.gisp.nec.co.jp>
Mime-Version: 1.0
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org, ptesarik@suse.cz

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v3 1/2] Generic handling of multi-page exclusions
Date: Wed, 14 May 2014 07:54:17 +0000

> Hello Petr,
> 
>>When multiple pages are excluded from the dump, store the extents in
>>struct cycle and check if anything is still pending on the next invocation
>>of __exclude_unnecessary_pages. This assumes that:
>>
>>  1. after __exclude_unnecessary_pages is called for a struct mem_map_data
>>     that extends beyond the current cycle, it is not called again during
>>     that cycle,
>>  2. in the next cycle, __exclude_unnecessary_pages is not called before
>>     this final struct mem_map_data.
>>
>>Both assumptions are met if struct mem_map_data segments:
>>
>>  1. do not overlap,
>>  2. are sorted by physical address in ascending order.
> 
> In ELF case, write_elf_pages_cyclic() processes PT_LOAD entries from
> PT_LOAD(0), this can break both assumptions unluckily.
> Actually this patch doesn't work on my machine:
> 
> LOAD (0)
>   phys_start : 1000000
>   phys_end   : 182f000
>   virt_start : ffffffff81000000
>   virt_end   : ffffffff8182f000
> LOAD (1)
>   phys_start : 1000
>   phys_end   : 9b400
>   virt_start : ffff810000001000
>   virt_end   : ffff81000009b400
> LOAD (2)
>   phys_start : 100000
>   phys_end   : 27000000
>   virt_start : ffff810000100000
>   virt_end   : ffff810027000000
> LOAD (3)
>   phys_start : 37000000
>   phys_end   : cff70000
>   virt_start : ffff810037000000
>   virt_end   : ffff8100cff70000
> LOAD (4)
>   phys_start : 100000000
>   phys_end   : 170000000
>   virt_start : ffff810100000000
>   virt_end   : ffff810170000000
> 
> 
> PT_LOAD(2) includes PT_LOAD(0) and there physical addresses aren't sorted.
> 
> If there is the only "sort issue", it may easy to fix it with a new iterator
> like "for_each_pt_load()", it iterates PT_LOAD entries in ascending order
> by physical address.
> However, I don't have a good idea to solve the overlap issue now...
> 

Is it enough to merge them? Prepare a modified version of PTLOAD list
and refer to it in actual processing. I think this also leads to
cleaning up readpage_elf() that addresses some overapping memory map
issue on ia64.

--
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
