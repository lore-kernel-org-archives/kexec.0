Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gKsKN-00068H-6E
 for kexec@lists.infradead.org; Thu, 08 Nov 2018 21:59:04 +0000
Received: by mail-lf1-f66.google.com with SMTP id c16so15345041lfj.8
 for <kexec@lists.infradead.org>; Thu, 08 Nov 2018 13:58:52 -0800 (PST)
MIME-Version: 1.0
References: <1540799431-11064-1-git-send-email-bhsharma@redhat.com>
 <1540799431-11064-2-git-send-email-bhsharma@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC0355EF59@BPXM09GP.gisp.nec.co.jp>
 <4AE2DC15AC0B8543882A74EA0D43DBEC0355F237@BPXM09GP.gisp.nec.co.jp>
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC0355F237@BPXM09GP.gisp.nec.co.jp>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Fri, 9 Nov 2018 03:28:38 +0530
Message-ID: <CACi5LpNB9HZFfqgRC=sZCoKJ6YMvZkaPwBM=AAT_o3_t-+e5eQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] makedumpfile/arm64: Use VMCOREINFO inside
 '/proc/kcore' (if available)
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
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: kexec mailing list <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>

Hi Kazu,

On Wed, Nov 7, 2018 at 1:53 AM Kazuhito Hagio <k-hagio@ab.jp.nec.com> wrote:
>
> On 11/2/2018 5:00 PM, Kazuhito Hagio wrote:
> > Originally, info->page_offset (PAGE_OFFSET) is used in the following
> > parts on arm64.
> >
> > arch/arm64.c:
> > __pa(unsigned long vaddr)
> > {
> >         if (kimage_voffset == NOT_FOUND_NUMBER ||
> >                         (vaddr >= PAGE_OFFSET))
> >                 return (vaddr - PAGE_OFFSET + info->phys_base);
> >         else
> >                 return (vaddr - kimage_voffset);
> > }
> >
> > elf_info.c:
> >         kvstart = (ulong)start + PAGE_OFFSET;
> >         kvend = (ulong)end + PAGE_OFFSET;
> > --
> >         kvaddr = (ulong)vmcoreinfo_addr + PAGE_OFFSET;
> >
> > I'm wondering about its consistency.  Is it OK to set
> > (virt_start - phys_start) to info->page_offset on arm64?
> > In other words, on arm64 system with info->phys_base != 0, does it
> > work correctly for both /proc/vmcore and --mem-usage /proc/kcore?
>
> I found an arm64 system available and (virt_start - phys_start)
> tested OK for both /proc/vmcore and --mem-usage /proc/kcore,
> because the __pa() function is used just only for swapper_pg_dir
> and the "(vaddr - PAGE_OFFSET + info->phys_base)" line is not used.
>
> The definition of PAGE_OFFSET in kernel is:
>
>   #define PAGE_OFFSET             (UL(0xffffffffffffffff) - \
>           (UL(1) << (VA_BITS - 1)) + 1)
>
> The one in crash is:
>
>   #define ARM64_PAGE_OFFSET    ((0xffffffffffffffffUL) \
>                                         << (machdep->machspec->VA_BITS - 1))
>
> So I think it would be better to use the same definition also in
> makedumpfile to avoid confusion. In other words, I think the following
> does not support arm64 now, and ideally should be fixed by introducing
> something like phys_to_virt()..
>
> elf_info.c:
>         kvstart = (ulong)start + PAGE_OFFSET;
>         kvend = (ulong)end + PAGE_OFFSET;
>         --
>         kvaddr = (ulong)vmcoreinfo_addr + PAGE_OFFSET;
>
> and then,
>
>   if (NUMBER(VA_BITS) != NOT_FOUND_NUMBER)
>       va_bits = NUMBER(VA_BITS);
>   else
>       ... va_vits calculation ...
>
>   info->page_offset = 0xffffffffffffffffUL << (va_bits - 1);
>
> And also we will need to add get_phys_base() to show_mem_usage()
> with some additional code for arm64 with old kernels.
> I'm considering this approach.

Note that PAGE_OFFSET is not constant on KASLR enabled arm64 kernels
as the start of the linear range gets randomized as well (as per the
KASLR seed) which means that PAGE_OFFSET is no longer equal to the
macro:
#define PAGE_OFFSET             (UL(0xffffffffffffffff) - \
           (UL(1) << (VA_BITS - 1)) + 1)

Please have a look at my discussion with the arm64 maintainers which
started the whole vmcoreinfo in kcore stuff rolling: ).
It talks about PAGE_OFFSET and how it cannot be a constant macro for
KASLR boot cases:
[1]. https://www.spinics.net/lists/arm-kernel/msg655933.html
[2]. https://www.spinics.net/lists/kexec/msg20842.html

Also implementing __pa() or __phys_to_virt(x) in user-space is not
easy as reported earlier for kexec-tools as well. A typical arm64
__phys_to_virt(x) looks like this (simplified):

| #define __phys_to_virt(x) \
| ((unsigned long)((x) - memstart_addr) | PAGE_OFFSET)

Please have a look at the discussion with the arm64 maintainers
regarding their views on the same here:
[3]. https://www.spinics.net/lists/kexec/msg20867.html

As James, suggested in this thread, " If user-space needs this value
to work with
/proc/{kcore,vmcore} we should expose something like 'p2v_offset' as an elf-note
on those files. (looks like they both have elf-headers).", something
which I am working on already and plan to send upstream next week.

My only concern is regarding whether we are heading in a direction in
user-land, which has been NAK'ed by arm64 kernel maintainers, which
means that if we need to avoid the nasty rewrite of a 'p2v'
implementation in the user-space we should probably stick to using the
standard interfaces exposed by kernel space and add the missing ones
in kernel and push the kernel community to consider accepting the same
as a standard ABI between kernel and user space.

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
