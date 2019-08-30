Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3dmv-0006Ny-2g
 for kexec@lists.infradead.org; Fri, 30 Aug 2019 10:05:50 +0000
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 13F19641C7
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2019 10:05:48 +0000 (UTC)
Received: by mail-lj1-f197.google.com with SMTP id c2so756826ljf.11
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2019 03:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190830091258.51133-1-buczek@molgen.mpg.de>
 <20190830092351.GE12242@MiWiFi-R3L-srv>
 <99faeaab-a4ea-e204-f4e8-9b74f86e5e43@molgen.mpg.de>
In-Reply-To: <99faeaab-a4ea-e204-f4e8-9b74f86e5e43@molgen.mpg.de>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Fri, 30 Aug 2019 15:35:33 +0530
Message-ID: <CACi5LpOBQCXv1v=aGjLZ0tE_qUDgcR8DtcC_uA5nC-tmm4UnZw@mail.gmail.com>
Subject: Re: [PATCH] x86: Fix PAGE_OFFSET for kernels since 4.20
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
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: Simon Horman <horms@verge.net.au>, kexec mailing list <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>

On Fri, Aug 30, 2019 at 3:04 PM Donald Buczek <buczek@molgen.mpg.de> wrote:
>
> Dear Baoquan,
>
> On 8/30/19 11:23 AM, Baoquan He wrote:
> > On 08/30/19 at 11:12am, Donald Buczek wrote:
> >> Linux kernel commit d52888aa2753 ("x86/mm: Move LDT remap out of KASLR
> >> region on 5-level paging") changed the base of the direct mapping
> >> from 0xffff880000000000 to 0xffff888000000000. This was merged
> >> into v4.20-rc2.
> >
> > A good catch and necessary fix, thanks.
> >
> > Does it have issue in makedumpfile?
>
> We don't use makedumpfile. We use `cp /proc/vmcore /mnt/crash.vmcore` in the panic kernel.

That shouldn't be a problem in makedumpfile as we have a generic way
to calculate the PAGE_OFFSET value there from the PT_LOADs in the
'/proc/kcore' file (which I mentioned in the other email conversation,
see [0]):

static int
get_page_offset_x86_64(void)
{
<..snip..>
    if (get_num_pt_loads()) {
        /*
         * Linux 4.19 (only) adds KCORE_REMAP PT_LOADs, which have
         * virt_start < __START_KERNEL_map, to /proc/kcore. In order
         * not to select them, we select the last valid PT_LOAD.
         */
        for (i = 0;
            get_pt_load(i, &phys_start, NULL, &virt_start, NULL);
            i++) {
            if (virt_start != NOT_KV_ADDR
                    && virt_start < __START_KERNEL_map
                    && phys_start != NOT_PADDR) {
                page_offset = virt_start - phys_start;
            }
        }
        if (page_offset) {
            info->page_offset = page_offset;
            DEBUG_MSG("page_offset  : %lx (pt_load)\n",
                info->page_offset);
            return TRUE;
        }
    }
<..snip..>

Also as I mentioned in the other thread, I don't think adding
different MACRO value for a kernel version is a long-term maintainable
approach. Instead I am working on adding a similar functionality as
present in makedumpfile to make the PAGE_OFFSET calculation generic.
Only if we fail to calculate PAGE_OFFSET through a generic method
should we fall back on MACRO values for backward compatibility.

I will try to post the patch for reviews by tomorrow.

[0]. https://lkml.org/lkml/2019/8/28/1060

Thanks,
Bhupesh

> Without this patch, the file /mnt/crash.vmcore has the wrong vaddr in the elf headers and can't be processed by gdb or crash.
>
> With this patch, the file has the correct vaddr an can be processed by gdb and crash.
>
> Btw:  I've got four strange error replies for my mail.
>
>      Date: 30 Aug 2019 05:13:31 EDT
>      From: MAILER_DAEMON@email.uscc.net
>      To: buczek@molgen.mpg.de
>          Message to 7867650283@email.uscc.net failed.
>
> I hope, my patch reaches the right people anyway.
>
> Best
>    Donald
>
>
> >
> > #ifdef __x86_64__
> > #define __PAGE_OFFSET_ORIG      (0xffff810000000000) /* 2.6.26, or former */
> > #define __PAGE_OFFSET_2_6_27    (0xffff880000000000) /* 2.6.27, or later  */
> > #define __PAGE_OFFSET_5LEVEL    (0xff10000000000000) /* 5-level page table */
> > ...
> > #endif
> >
> > Thanks
> > Baoquan
> >
> >>
> >> Update to new address accordingly.
> >> ---
> >>   kexec/arch/i386/crashdump-x86.c | 2 ++
> >>   kexec/arch/i386/crashdump-x86.h | 3 ++-
> >>   2 files changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> >> index a2aea31..c79791f 100644
> >> --- a/kexec/arch/i386/crashdump-x86.c
> >> +++ b/kexec/arch/i386/crashdump-x86.c
> >> @@ -61,6 +61,8 @@ static int get_kernel_page_offset(struct kexec_info *UNUSED(info),
> >>
> >>              if (kv < KERNEL_VERSION(2, 6, 27))
> >>                      elf_info->page_offset = X86_64_PAGE_OFFSET_PRE_2_6_27;
> >> +            else if (kv < KERNEL_VERSION(4, 20, 0))
> >> +                    elf_info->page_offset = X86_64_PAGE_OFFSET_PRE_4_20_0;
> >>              else
> >>                      elf_info->page_offset = X86_64_PAGE_OFFSET;
> >>      }
> >> diff --git a/kexec/arch/i386/crashdump-x86.h b/kexec/arch/i386/crashdump-x86.h
> >> index ddee19f..e4fdc82 100644
> >> --- a/kexec/arch/i386/crashdump-x86.h
> >> +++ b/kexec/arch/i386/crashdump-x86.h
> >> @@ -13,7 +13,8 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
> >>
> >>   #define X86_64__START_KERNEL_map   0xffffffff80000000ULL
> >>   #define X86_64_PAGE_OFFSET_PRE_2_6_27      0xffff810000000000ULL
> >> -#define X86_64_PAGE_OFFSET          0xffff880000000000ULL
> >> +#define X86_64_PAGE_OFFSET_PRE_4_20_0       0xffff880000000000ULL
> >> +#define X86_64_PAGE_OFFSET  0xffff888000000000ULL
> >>
> >>   #define X86_64_MAXMEM                      0x3fffffffffffUL
> >>
> >> --
> >> 2.22.0
> >>
> >>
> >> _______________________________________________
> >> kexec mailing list
> >> kexec@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/kexec
>
>
> --
> Donald Buczek
> buczek@molgen.mpg.de
> Tel: +49 30 8413 1433

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
