Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-f196.google.com ([209.85.223.196])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1edVbS-00030M-Df
 for kexec@lists.infradead.org; Mon, 22 Jan 2018 06:29:12 +0000
Received: by mail-io0-f196.google.com with SMTP id t22so8299746ioa.7
 for <kexec@lists.infradead.org>; Sun, 21 Jan 2018 22:28:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cover.1516354241.git.ptesarik@suse.com>
References: <cover.1516354241.git.ptesarik@suse.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Mon, 22 Jan 2018 11:58:58 +0530
Message-ID: <CACi5LpN7XL-uNzNBF9HLT7+-x5D_C909TEqHF=7HKDRg7C_mpQ@mail.gmail.com>
Subject: Re: [makedumpfile PATCH 0/2] Fix calculations in exclude_segment()
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
To: Petr Tesarik <ptesarik@suse.com>
Cc: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>

Hi Petr,

On Fri, Jan 19, 2018 at 5:15 PM, Petr Tesarik <ptesarik@suse.com> wrote:
> I have observed that makedumpfile --mem-usage shows bogus numbers
> on a kaslr-enabled kernel. This boils down to incorrect calculations
> in exclude_segment(). Consequently, data beyond a split LOAD segment
> are read from the wrong file offset.
>
> Petr Tesarik (2):
>   Fix off-by-one errors in exclude_segment()
>   Fix physical-to-virtual conversion in exclude_segment()
>
>  elf_info.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> --
> 2.13.6
>

Tested this patchset on a x86_64 RHEL machine (please find my test
summary below), so:

Tested-by: Bhupesh Sharma <bhsharma@redhat.com>

Test Summary
-------------------

1. I was running into the following issue while trying to run
'--mem-usage' option with makedumpfile on a RHEL machine with KASLR
enabled kernel:

# makedumpfile --mem-usage /proc/kcore -f

__vtop4_x86_64: vaddr:ffff90d3bffd63e0, page_dir:244ae0e908,
pml4:244b425067, pgd_paddr:244b425a70, pgd_pte:347ffd5067,
pmd_paddr:347ffd5ff8, pmd_pte:0
__vtop4_x86_64: Can't get a valid pmd_pte.
readmem: Can't convert a virtual address(ffff90d3bffd63e0) to physical address.
readmem: type_addr: 0, addr:ffff90d3bffd63e0, size:32
section_mem_map_addr: Can't get

which indicates that the pmd_pte is 0 for the virtual addr ffff90d3bffd63e0.

1a). On the other hand, if we use the crash utility (and gdb inside
it), we can see that it can convert this virtual addr ffff90d3bffd63e0
properly and find all the page levels properly:

# crash

crash> vtop ffff90d3bffd63e0
VIRTUAL           PHYSICAL
ffff90d3bffd63e0  87ffd63e0

PML4 DIRECTORY: ffffffff9280e000
PAGE DIRECTORY: 244b425067
   PUD: 244b425a70 => 347ffd5067
   PMD: 347ffd5ff8 => 87fedf063
   PTE: 87fedfeb0 => 800000087ffd6163
  PAGE: 87ffd6000

      PTE         PHYSICAL   FLAGS
800000087ffd6163  87ffd6000  (PRESENT|RW|ACCESSED|DIRTY|GLOBAL|NX)

      PAGE         PHYSICAL      MAPPING       INDEX CNT FLAGS
ffffce9821fff580  87ffd6000                0        0  1 2fffff00000400 reserved

2). As is seen from the crash and makedumpfile logs, both calculate
the following values correctly for the virtual addr ffff90d3bffd63e0:

pml4(244b425067), pgd_pte(347ffd5067), pmd_paddr(347ffd5ff8).

3). But while the crash util can correctly decode the
pmd_pte(87fedf063) from pmd_addr(347ffd5ff8), makedumpfile fails to do
the same.

4). The reason is that for the KASLR enabled kernels the following
computation is no longer _valid_:

kvstart = (ulong)start | PAGE_OFFSET;
kvend = (ulong)end | PAGE_OFFSET;

leading to erroneous computation of 'pmd_pte'

changing this to the following fixes the issue for me:

kvstart = (ulong)start  + PAGE_OFFSET;
kvend = (ulong)end   PAGE_OFFSET;

In addition to the above, this patchset also fixes the off-by-one
errors, so its looks good to me.

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
