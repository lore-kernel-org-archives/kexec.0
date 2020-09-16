Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIdud-00039J-Ja
 for kexec@lists.infradead.org; Wed, 16 Sep 2020 20:20:20 +0000
Received: by mail-ej1-x643.google.com with SMTP id p9so12764450ejf.6
 for <kexec@lists.infradead.org>; Wed, 16 Sep 2020 13:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <1599874789-7042-1-git-send-email-tangyouling@loongson.cn>
In-Reply-To: <1599874789-7042-1-git-send-email-tangyouling@loongson.cn>
From: Bhupesh SHARMA <bhupesh.linux@gmail.com>
Date: Thu, 17 Sep 2020 01:50:05 +0530
Message-ID: <CAFTCetQRyzv6qx2dSsR59qUoL7keiwawjxN_f_f1DrD75PGB7A@mail.gmail.com>
Subject: Re: [PATCH] kexec-tools: Add some missing free() calls
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
To: Youling Tang <tangyouling@loongson.cn>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid@gonehiking.org>

Hi Youling,

See some comments inline:

On Sat, Sep 12, 2020 at 7:11 AM Youling Tang <tangyouling@loongson.cn> wrote:
>
> Add some missing free() calls.
>
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>  kexec/arch/i386/crashdump-x86.c    | 22 +++++++++++++++++-----
>  kexec/arch/mips/crashdump-mips.c   |  5 ++++-
>  kexec/arch/ppc64/crashdump-ppc64.c |  8 ++++++--
>  3 files changed, 27 insertions(+), 8 deletions(-)

First, I think this is a step in the right direction, however, earlier
also while running 'valgrind' on an x86_64 kexec elf I saw the
following memory leaks reported:

==596886== 15,604 bytes in 1 blocks are indirectly lost in loss record 4 of 12
==596886==    at 0x483A809: malloc (vg_replace_malloc.c:307)
==596886==    by 0x40396D: xmalloc (kexec.c:101)
==596886==    by 0x410D35: do_bzImage64_load (kexec-bzImage64.c:182)
==596886==    by 0x410D35: bzImage64_load (kexec-bzImage64.c:391)
==596886==    by 0x404410: my_load (kexec.c:774)
==596886==    by 0x402D2D: main (kexec.c:1605)

==596886== 15,732 (128 direct, 15,604 indirect) bytes in 1 blocks are
definitely lost in loss record 5 of 12
==596886==    at 0x483CCE8: realloc (vg_replace_malloc.c:834)
==596886==    by 0x403FB9: xrealloc (kexec.c:112)
==596886==    by 0x403FB9: add_segment_phys_virt (kexec.c:357)
==596886==    by 0x40410F: add_buffer_phys_virt (kexec.c:392)
==596886==    by 0x404153: add_buffer_virt (kexec.c:401)
==596886==    by 0x40CD11: setup_linux_bootloader_parameters_high
(x86-linux-setup.c:80)
==596886==    by 0x410E6A: do_bzImage64_load (kexec-bzImage64.c:214)
==596886==    by 0x410E6A: bzImage64_load (kexec-bzImage64.c:391)
==596886==    by 0x404410: my_load (kexec.c:774)
==596886==    by 0x402D2D: main (kexec.c:1605)

==596886== 28,896 bytes in 1 blocks are indirectly lost in loss record 7 of 12
==596886==    at 0x483A809: malloc (vg_replace_malloc.c:307)
==596886==    by 0x40396D: xmalloc (kexec.c:101)
==596886==    by 0x406781: elf_rel_load (kexec-elf-rel.c:254)
==596886==    by 0x406EEA: elf_rel_build_load (kexec-elf-rel.c:432)
==596886==    by 0x410CFE: do_bzImage64_load (kexec-bzImage64.c:173)
==596886==    by 0x410CFE: bzImage64_load (kexec-bzImage64.c:391)
==596886==    by 0x404410: my_load (kexec.c:774)
==596886==    by 0x402D2D: main (kexec.c:1605)

==596886== 30,048 (1,152 direct, 28,896 indirect) bytes in 1 blocks
are definitely lost in loss record 8 of 12
==596886==    at 0x483A809: malloc (vg_replace_malloc.c:307)
==596886==    by 0x40396D: xmalloc (kexec.c:101)
==596886==    by 0x405735: build_mem_shdrs (kexec-elf.c:618)
==596886==    by 0x405735: build_elf_info (kexec-elf.c:774)
==596886==    by 0x406EB9: build_elf_rel_info (kexec-elf-rel.c:142)
==596886==    by 0x406EB9: elf_rel_build_load (kexec-elf-rel.c:427)
==596886==    by 0x410CFE: do_bzImage64_load (kexec-bzImage64.c:173)
==596886==    by 0x410CFE: bzImage64_load (kexec-bzImage64.c:391)
==596886==    by 0x404410: my_load (kexec.c:774)
==596886==    by 0x402D2D: main (kexec.c:1605)
==596886==

Note that there were 12 issues highlighted via valgrind out of which I
have removed the zlib related issue reports.

You can run 'valgrind' on mips, i386 and ppc64 executables (as shown
below) to see if all such issues are fixed by your patch:
$ sudo valgrind --leak-check=full --show-leak-kinds=all
--track-origins=yes --verbose --log-file=valgrind-out.txt ./kexec -l
/boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname -r`.img
--reuse-cmdline -d

> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index c79791f..d5b5b68 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -913,8 +913,11 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>         add_memmap(memmap_p, &nr_memmap, info->backup_src_start, info->backup_src_size, RANGE_RAM);
>         for (i = 0; i < crash_reserved_mem_nr; i++) {
>                 sz = crash_reserved_mem[i].end - crash_reserved_mem[i].start +1;
> -               if (add_memmap(memmap_p, &nr_memmap, crash_reserved_mem[i].start, sz, RANGE_RAM) < 0)
> +               if (add_memmap(memmap_p, &nr_memmap, crash_reserved_mem[i].start,
> +                               sz, RANGE_RAM) < 0) {
> +                       free(memmap_p);
>                         return ENOCRASHKERNEL;
> +               }
>         }
>
>         /* Create a backup region segment to store backup data*/
> @@ -926,22 +929,29 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>                                                 0, max_addr, -1);
>                 dbgprintf("Created backup segment at 0x%lx\n",
>                           info->backup_start);
> -               if (delete_memmap(memmap_p, &nr_memmap, info->backup_start, sz) < 0)
> +               if (delete_memmap(memmap_p, &nr_memmap, info->backup_start, sz) < 0) {
> +                       free(tmp);
> +                       free(memmap_p);
>                         return EFAILED;
> +               }
>         }

Can we use the error handler path we use in other kexec source files
(see 'kexec/arch/arm64/kexec-arm64.c') for freeing up the resources,
something like:

on_error_tmp:
    if (tmp)
        free(tmp);
on_error_memmap_p:
    if (memmap_p)
        free(memmap_p);

as same for the changes done below in this patch ...

>         /* Create elf header segment and store crash image data. */
>         if (arch_options.core_header_type == CORE_TYPE_ELF64) {
>                 if (crash_create_elf64_headers(info, &elf_info, mem_range,
>                                                 nr_ranges, &tmp, &bufsz,
> -                                               ELF_CORE_HEADER_ALIGN) < 0)
> +                                               ELF_CORE_HEADER_ALIGN) < 0) {
> +                       free(memmap_p);
>                         return EFAILED;
> +               }
>         }
>         else {
>                 if (crash_create_elf32_headers(info, &elf_info, mem_range,
>                                                 nr_ranges, &tmp, &bufsz,
> -                                               ELF_CORE_HEADER_ALIGN) < 0)
> +                                               ELF_CORE_HEADER_ALIGN) < 0) {
> +                       free(memmap_p);
>                         return EFAILED;
> +               }

.. see above ..

>         }
>         /* the size of the elf headers allocated is returned in 'bufsz' */
>
> @@ -962,8 +972,10 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>         elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
>                                                         max_addr, -1);
>         dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
> -       if (delete_memmap(memmap_p, &nr_memmap, elfcorehdr, memsz) < 0)
> +       if (delete_memmap(memmap_p, &nr_memmap, elfcorehdr, memsz) < 0) {
> +               free(memmap_p);
>                 return -1;
> +               }
>         if (!bzImage_support_efi_boot || arch_options.noefi ||
>             !sysfs_efi_runtime_map_exist())
>                 cmdline_add_efi(mod_cmdline);
> diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
> index fc92e64..c1603d9 100644
> --- a/kexec/arch/mips/crashdump-mips.c
> +++ b/kexec/arch/mips/crashdump-mips.c
> @@ -387,8 +387,11 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>                                 crash_reserved_mem.end, -1);
>
>         if (crash_create(info, elf_info, crash_memory_range, nr_ranges,
> -                        &tmp, &sz, ELF_CORE_HEADER_ALIGN) < 0)
> +                        &tmp, &sz, ELF_CORE_HEADER_ALIGN) < 0) {
> +               free(tmp);
>                 return -1;
> +       }
> +
>         elfcorehdr = add_buffer(info, tmp, sz, sz, align,
>                 crash_reserved_mem.start,
>                 crash_reserved_mem.end, -1);
> diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
> index b2787d5..26f9a01 100644
> --- a/kexec/arch/ppc64/crashdump-ppc64.c
> +++ b/kexec/arch/ppc64/crashdump-ppc64.c
> @@ -535,15 +535,19 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>                 if (crash_create_elf64_headers(info, &elf_info64,
>                                                crash_memory_range, nr_ranges,
>                                                &tmp, &sz,
> -                                              ELF_CORE_HEADER_ALIGN) < 0)
> +                                              ELF_CORE_HEADER_ALIGN) < 0) {
> +                       free (tmp);
>                         return -1;
> +               }
>         }
>         else {
>                 if (crash_create_elf32_headers(info, &elf_info32,
>                                                crash_memory_range, nr_ranges,
>                                                &tmp, &sz,
> -                                              ELF_CORE_HEADER_ALIGN) < 0)
> +                                              ELF_CORE_HEADER_ALIGN) < 0) {
> +                       free(tmp);
>                         return -1;
> +               }
>         }

... see above ...

>
>         elfcorehdr = add_buffer(info, tmp, sz, sz, align, min_base,
> --
> 2.1.0

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
