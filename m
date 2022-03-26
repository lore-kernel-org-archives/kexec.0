From: RuiRui Yang <ruyang@redhat.com>
Date: Sat, 26 Mar 2022 14:55:43 +0800
Subject: [ANNOUNCE] kexec-tools v2.0.24 preparation
In-Reply-To: <Yjs2V0Ck/kvcJAKy@vergenet.net>
References: <Yjs2V0Ck/kvcJAKy@vergenet.net>
Message-ID: <CALu+AoT+YxFyn27yhPKL5=90_=G-gm8OVA-bqhtpPEWMb-OCgQ@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Simon,

Recently RH CKI detected a kexec/kdump failure with kexec_load being
used,  the 2nd kernel can not boot, just reset to bios/firmware
instead.

This only happens with gcc 12.x compiled kexec-tools,  add
"-fno-tree-vectorize" to purgatory/Makefile CFLAGS make the bug
dissappear, but I hope people can help to verify and confirm it does
fix the problem.   It would be better to wait a few days so that we
can fix it in the coming release, what do you think?

Cced Baoquan who is handling the issue..

Thanks!

On Wed, 23 Mar 2022 at 23:02, Simon Horman <horms@verge.net.au> wrote:
>
> Hi all,
>
> I am planning to release kexec-tools v2.0.24 in the next two weeks
> to roughly coincide with the release of the v5.17 kernel.
>
> I would like to ask interested parties to send any patches they would like
> included in v2.0.24 within one week so they can be considered for inclusion
> in an rc release.
>
> For reference the patches queued up since v2.0.23 are as follows.
>
> Thanks to everyone who has contributed to kexec-tools!
>
> 501646beec2b kexec-xen: Allow xen_kexec_exec() to return in case of Live Update
> 1d7a308bf734 kexec-tools: print error if kexec_file_load fails
> 6effda061f75 kexec-tools: mips: Concatenate --reuse-cmdline and --append
> 8dda434a05ff kexec-tools: mips: Add some debug info
> 95de9eccf413 arm64: fix PAGE_OFFSET calc for flipped mm
> 454395e18ff1 arm64: read VA_BITS from kcore for 52-bits VA kernel
> bde864387a10 arm64/crashdump: unify routine to get page_offset
> 67ea2d99e135 arm64: make phys_offset signed
> 2e1ec106dc5a s390: add support for --reuse-cmdline
> d6516ba4c88f use slurp_proc_file() in get_command_line()
> 193e51deccc6 add slurp_proc_file()
> 91a3d0e00a5c s390: use KEXEC_ALL_OPTIONS
> defb80a20bf1 s390: add variable command line size
> b5a34a20984c arm64: support more than one crash kernel regions
> 186e7b0752d8 s390: handle R_390_PLT32DBL reloc entries in machine_apply_elf_rel()
> 1614959f2f0d arm64/crashdump: deduce paddr of _text based on kernel code size
> 10b7e1fb5d0c kexec-tools 2.0.23.git
>
> _______________________________________________
> kexec mailing list
> kexec at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>
>


