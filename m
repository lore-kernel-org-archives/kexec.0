Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UHmWl-0006Mk-1P
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 02:43:52 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id EB0713EE0B6
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:43:48 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id D0AC245DE55
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:43:48 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id BB93C45DE54
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:43:48 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id ADC17E08003
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:43:48 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 675E1E08002
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:43:48 +0900 (JST)
Date: Tue, 19 Mar 2013 11:42:20 +0900 (JST)
Message-Id: <20130319.114220.118274790.d.hatayama@jp.fujitsu.com>
Subject: Re: makedumpfile: question about memory hole
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20130319104137.b8aff16a428e6393e32e9d20@mxc.nes.nec.co.jp>
References: <20130315.093146.401285457.d.hatayama@jp.fujitsu.com>
 <20130319104137.b8aff16a428e6393e32e9d20@mxc.nes.nec.co.jp>
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
Cc: oomichi@mxs.nes.nec.co.jp, kexec@lists.infradead.org

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile: question about memory hole
Date: Tue, 19 Mar 2013 10:41:37 +0900

> On Fri, 15 Mar 2013 09:31:46 +0900 (JST)
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

>> What I don't understand well is that the part here:
>> 
>>                 pfn_start = paddr_to_pfn(phys_start);
>>                 pfn_end   = paddr_to_pfn(phys_end);
>> 
>>                 if (!is_in_segs(pfn_to_paddr(pfn_start)))
>>                         pfn_start++;
>> 
>> phys_start and pfn_to_paddr(pfn_start) should belong to the same page
>> frame, so I suspect the pfn_start should be included in vmcore.
>> 
>> Looking into kexec-tool side, I don't see additional modification made
>> to phys_start after it's parsed from /proc/iomem or counterpart on EFI
>> interface. Is there any assumption about memory holes behind kernel?
> 
> Here is a PT_LOAD segment of ia64 machine which I actually use:
> 
>   Type           Offset             VirtAddr           PhysAddr
>                  FileSiz            MemSiz              Flags  Align
> [...]
>   LOAD           0x000000015fd0b490 0xe0000040ffda5000 0x00000040ffda5000
>                  0x000000000005a000 0x000000000005a000  RWE    0
> 
> In this case, pfn_to_paddr(pfn_start) is aligned to 0x40ffda4000 
> because the page size is 16KiB, and this address is out of PT_LOAD
> segment.
> 
>          phys_start
>          = 0x40ffda5000                        
>             |------------- PT_LOAD ----------------
>      ----+----------+----------+----------+--------
>          |   pfn:N  |  pfn:N+1 | pfn:N+2  |  ...
>      ----+----------+----------+----------+--------
>          |
>    pfn_to_paddr(pfn:N)
>    = 0x40ffda4000
> 
> The statement you said is for care the case that phys_start isn't aligned
> with the page size.
> 
> BTW, I'll add a comment to explain this intention into here.

Thanks for the pictorial explanation. It's easy to understand.

Still I think pfn:N should be included in vmcore. The current
implementation drops [0x40ffda5000, 0x40ffda8000] that is contained in
the PT_LOAD. Or, the range must be hole or other kinds of unnecessary
memory from some kernel-side assumption?

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
