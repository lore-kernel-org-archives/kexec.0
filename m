Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TYBNp-0000uu-TF
 for kexec@lists.infradead.org; Tue, 13 Nov 2012 07:58:12 +0000
Date: Tue, 13 Nov 2012 16:56:08 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 00/10] Support free page filtering looking up mem_map array
Message-Id: <20121113165608.b561e597fefb6bc3f2bbd5de@mxc.nes.nec.co.jp>
In-Reply-To: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
References: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
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

On Thu, 08 Nov 2012 18:48:07 +0900
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> This patch set implements filtering free pages looking up mem_map
> array instead of free lists. This is compatible for cyclic mode
> because looking up mem_map can be divided into cycles. On the other
> hand, dividing free pages contaiend in free lists is difficult since
> they are not sorted in physical-address order.
> 
> Unlike RFC version, the logic used is automatically selected at
> runtime according to the current mode. On cyclic mode, mem_map array
> logic is used. On non-cyclic mode, free list logic is used.
> 
> The RFC version is:
> http://lists.infradead.org/pipermail/kexec/2012-June/006441.html

Thanks for re-sending the mem_map array patch set.

This function will work fine when VMCOREINFO is specified manually,
so I think the basic logic is good.

> * TODO
> 
> Add the following values in VMCOREINFO on the upstream kernel. These
> are used in the mem_map logic.
> 
>   - OFFSET(page._mapcount)
>   - OFFSET(page.private)
>   - SIZE(pageflags)
>   - NUMBER(PG_buddy)
>   - NUMBER(PG_slab)
>   - NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)

And I will post the patch to add the values above to the upstream kernel,
so there is no problem on the future kernel.

However, according to my tests, current makedumpfile can't get some of the
values above from VMLINUX and can't exclude free pages with the mem_map
array logic.
For example, page_is_buddy_v1() will be selected for kernel-3.4 with 
setup_page_is_buddy() due to not founding NUMBER(PG_buddy) and SIZE(pageflags), 
it's miss selection.

Therefore, I propose to change the policy for excluding free page as below
in order to take care of current kernels:

  1. If VMCORE (or specified VMCOREINFO) includes the values above,
     using the mem_map array logic.

  2. In other cases, using the current logic which uses free_list even if
     running on cyclic mode.

Of course, page_is_buddy_v1() and page_is_buddy_v2() should be retain
because there is valuable for the user who can prepare VMCOREINFO.


Thanks
Atsushi Kumagai

> * Test
> 
> I tested this patch set on the following kernel versions.
> 
> - 3.4
> - 3.1
> - 2.6.38
> - 2.6.32
> - 2.6.18
> 
> On the test, I manually specified VMCOREINFO while extending it with
> the following values according to the kernel versions.
> 
> - 3.1, 3.4
> NUMBER(PG_slab)=7
> SIZE(pageflags)=4
> OFFSET(page._mapcount)=24
> OFFSET(page.private)=48
> NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)=-128
> 
> - 2.6.38
> SIZE(pageflags)=4
> OFFSET(page._mapcount)=12
> OFFSET(page.private)=16
> NUMBER(PG_slab)=7
> NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)=-2
> 
> - 2.6.32
> NUMBER(PG_slab)=7
> NUMBER(PG_buddy)=19
> OFFSET(page._mapcount)=12
> OFFSET(page.private)=16
> SIZE(pageflags)=4
> 
> - 2.6.18
> NUMBER(PG_slab)=7
> NUMBER(PG_buddy)=19
> OFFSET(page._mapcount)=12
> OFFSET(page.private)=16
> 
> ---
> 
> HATAYAMA Daisuke (10):
>       Print warning about cyclic buffer overrun if it can happen
>       Add page_is_buddy for old kernels
>       Add page_is_buddy for PG_buddy
>       Add page_is_buddy for recent kernels
>       Exclude free pages by looking up mem_map array
>       Add hardcoded page flag values
>       Add debuginfo-related processing for VMCOREINFO/VMLINUX
>       Add new parameters to various tables
>       Add debuginfo interface for enum type size
>       Move page flags setup for old kernels after debuginfo initialization
> 
> 
>  dwarf_info.c   |   18 ++++++
>  dwarf_info.h   |    1 
>  makedumpfile.c |  170 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  makedumpfile.h |   29 +++++++++-
>  4 files changed, 204 insertions(+), 14 deletions(-)
> 
> -- 
> 
> Thanks.
> HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
