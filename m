Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo185.gate.nec.co.jp ([114.179.232.185])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gK7u5-0003jF-JP
 for kexec@lists.infradead.org; Tue, 06 Nov 2018 20:24:52 +0000
Received: from tyo162.gate.nec.co.jp (tyo162.gate.nec.co.jp [114.179.232.162])
 by tyo185.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id
 wA6KNSEe025966
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <kexec@lists.infradead.org>; Wed, 7 Nov 2018 05:23:28 +0900
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH v2 1/2] makedumpfile/arm64: Use VMCOREINFO inside
 '/proc/kcore' (if available)
Date: Tue, 6 Nov 2018 20:17:03 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC0355F237@BPXM09GP.gisp.nec.co.jp>
References: <1540799431-11064-1-git-send-email-bhsharma@redhat.com>
 <1540799431-11064-2-git-send-email-bhsharma@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC0355EF59@BPXM09GP.gisp.nec.co.jp>
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC0355EF59@BPXM09GP.gisp.nec.co.jp>
Content-Language: en-US
MIME-Version: 1.0
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>

On 11/2/2018 5:00 PM, Kazuhito Hagio wrote:
> Originally, info->page_offset (PAGE_OFFSET) is used in the following
> parts on arm64.
> 
> arch/arm64.c:
> __pa(unsigned long vaddr)
> {
>         if (kimage_voffset == NOT_FOUND_NUMBER ||
>                         (vaddr >= PAGE_OFFSET))
>                 return (vaddr - PAGE_OFFSET + info->phys_base);
>         else
>                 return (vaddr - kimage_voffset);
> }
> 
> elf_info.c:
>         kvstart = (ulong)start + PAGE_OFFSET;
>         kvend = (ulong)end + PAGE_OFFSET;
> --
>         kvaddr = (ulong)vmcoreinfo_addr + PAGE_OFFSET;
> 
> I'm wondering about its consistency.  Is it OK to set
> (virt_start - phys_start) to info->page_offset on arm64?
> In other words, on arm64 system with info->phys_base != 0, does it
> work correctly for both /proc/vmcore and --mem-usage /proc/kcore?

I found an arm64 system available and (virt_start - phys_start)
tested OK for both /proc/vmcore and --mem-usage /proc/kcore,
because the __pa() function is used just only for swapper_pg_dir
and the "(vaddr - PAGE_OFFSET + info->phys_base)" line is not used.

The definition of PAGE_OFFSET in kernel is:

  #define PAGE_OFFSET             (UL(0xffffffffffffffff) - \
          (UL(1) << (VA_BITS - 1)) + 1)

The one in crash is:

  #define ARM64_PAGE_OFFSET    ((0xffffffffffffffffUL) \
                                        << (machdep->machspec->VA_BITS - 1))

So I think it would be better to use the same definition also in
makedumpfile to avoid confusion. In other words, I think the following
does not support arm64 now, and ideally should be fixed by introducing
something like phys_to_virt()..

elf_info.c:
        kvstart = (ulong)start + PAGE_OFFSET;
        kvend = (ulong)end + PAGE_OFFSET;
        --
        kvaddr = (ulong)vmcoreinfo_addr + PAGE_OFFSET;

and then,

  if (NUMBER(VA_BITS) != NOT_FOUND_NUMBER)
      va_bits = NUMBER(VA_BITS);
  else
      ... va_vits calculation ...

  info->page_offset = 0xffffffffffffffffUL << (va_bits - 1);

And also we will need to add get_phys_base() to show_mem_usage()
with some additional code for arm64 with old kernels.
I'm considering this approach.

Thanks,
Kazu



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
