Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UHljZ-0005JA-Lx
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 01:53:03 +0000
Date: Tue, 19 Mar 2013 10:41:37 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile: question about memory hole
Message-Id: <20130319104137.b8aff16a428e6393e32e9d20@mxc.nes.nec.co.jp>
In-Reply-To: <20130315.093146.401285457.d.hatayama@jp.fujitsu.com>
References: <20130315.093146.401285457.d.hatayama@jp.fujitsu.com>
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
To: d.hatayama@jp.fujitsu.com
Cc: oomichi@mxs.nes.nec.co.jp, kexec@lists.infradead.org

Hello HATAYAMA-san,

On Fri, 15 Mar 2013 09:31:46 +0900 (JST)
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> Hello Kumagai-san,
> 
> I have a question about memory hole.
> 
> For example, create_1st_bitmap() calculates memory holes in the part
> below:
> 
> int
> create_1st_bitmap(void)
> {
> ...
>         /*
>          * If page is on memory hole, set bit on the 1st-bitmap.
>          */
>         pfn_bitmap1 = 0;
>         for (i = 0; get_pt_load(i, &phys_start, &phys_end, NULL, NULL); i++) {
> 
>                 print_progress(PROGRESS_HOLES, i, num_pt_loads);
> 
>                 pfn_start = paddr_to_pfn(phys_start);
>                 pfn_end   = paddr_to_pfn(phys_end);
> 
>                 if (!is_in_segs(pfn_to_paddr(pfn_start)))
>                         pfn_start++;
>                 for (pfn = pfn_start; pfn < pfn_end; pfn++) {
>                         set_bit_on_1st_bitmap(pfn);
>                         pfn_bitmap1++;
>                 }
>         }
>         pfn_memhole = info->max_mapnr - pfn_bitmap1;
> 
> What I don't understand well is that the part here:
> 
>                 pfn_start = paddr_to_pfn(phys_start);
>                 pfn_end   = paddr_to_pfn(phys_end);
> 
>                 if (!is_in_segs(pfn_to_paddr(pfn_start)))
>                         pfn_start++;
> 
> phys_start and pfn_to_paddr(pfn_start) should belong to the same page
> frame, so I suspect the pfn_start should be included in vmcore.
> 
> Looking into kexec-tool side, I don't see additional modification made
> to phys_start after it's parsed from /proc/iomem or counterpart on EFI
> interface. Is there any assumption about memory holes behind kernel?

Here is a PT_LOAD segment of ia64 machine which I actually use:

  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
[...]
  LOAD           0x000000015fd0b490 0xe0000040ffda5000 0x00000040ffda5000
                 0x000000000005a000 0x000000000005a000  RWE    0

In this case, pfn_to_paddr(pfn_start) is aligned to 0x40ffda4000 
because the page size is 16KiB, and this address is out of PT_LOAD
segment.

         phys_start
         = 0x40ffda5000                        
            |------------- PT_LOAD ----------------
     ----+----------+----------+----------+--------
         |   pfn:N  |  pfn:N+1 | pfn:N+2  |  ...
     ----+----------+----------+----------+--------
         |
   pfn_to_paddr(pfn:N)
   = 0x40ffda4000

The statement you said is for care the case that phys_start isn't aligned
with the page size.

BTW, I'll add a comment to explain this intention into here.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
