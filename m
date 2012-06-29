Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SkUeH-0002bz-MK
 for kexec@lists.infradead.org; Fri, 29 Jun 2012 06:25:49 +0000
Date: Fri, 29 Jun 2012 15:23:37 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [RFC PATCH 00/10] Support free page filtering looking up
 mem_map array
Message-Id: <20120629152337.4c281342.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120628173757.19702.75678.stgit@fedora-machine>
References: <20120628173757.19702.75678.stgit@fedora-machine>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org

Hello HATAYAMA-san,

On Fri, 29 Jun 2012 02:37:57 +0900
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> Sorry for late posting. I made RFC patch set for free page filtering
> looking up mem_map array. Unlike exiting method looking up free page
> list, this is done in constant space.
> 
> I intend this patch set to be merged with Kumagai-san's cyclic patch
> set, so I mark these with RFC. See TODO below. Also, I have yet to
> test the logic for old kernels from v2.6.15 to v2.6.17.
> 
> This new free page filtering needs the following values.
> 
>   - OFFSET(page._mapcount)
>   - OFFSET(page.private)
>   - SIZE(pageflags)
>   - NUMBER(PG_buddy)
>   - NUMBER(PG_slab)
>   - NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)
> 
> Unfortunately, OFFSET(_mapcount) and OFFSET(private) fields of page
> structure cannot be obtained from VMLINUX using the exiting library in
> makedumpfile since two members are anonymous components of union
> types. We need a new interface for them.
> 
> To try to use this patch set, it's handy to pass manually editted
> VMCOREINFO file via -i option.
> 
> TODO
> 
>   1. Add new values in VMCOREINFO on the upstream kernel.
> 
>   2. Decide when to use this logic instead of the existing free list
>   logic. Option is 1) introduce new dump level or 2) use it
>   automatically if --cyclic is specified. This patch chooses 1) only
>   for RFC use.
> 
>   3. Consider how to deal with old kernels on which we cannot add the
>   values in VMCOREINFO. Options is 1) to force users to use VMLINUX,
>   2) to cover them full hard coding or 3) to give up support on full
>   range of kernel versions ever.

Thank you always for your work.

I will review your patches and measure executing time with v2 patch
of cyclic processing. If your patches are effective, then I will 
consider TODO above.
Please wait for a while.


Thanks
Atsushi Kumagai

> ---
> 
> HATAYAMA Daisuke (10):
>       Add page_is_buddy for old kernels
>       Add page_is_buddy for PG_buddy
>       Add page_is_buddy for recent kernels
>       Add excldue free pages by looking up mem_map array
>       Add command-line processing for free page filtering looking up mem_map array
>       Add page flag values as hardcoded values
>       Add debuginfo-related processing for VMCOREINFO/VMLINUX
>       Add new parameters for various tables
>       Add debuginfo interface for enum type size
>       Move page flags setup for old kernels after debuginfo initialization
> 
> 
>  dwarf_info.c   |   29 +++++++++++----
>  dwarf_info.h   |    1 +
>  makedumpfile.c |  111 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  makedumpfile.h |   34 ++++++++++++++++-
>  4 files changed, 158 insertions(+), 17 deletions(-)
> 
> -- 
> 
> Thanks.
> HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
