Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ww0-f41.google.com ([74.125.82.41])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PTFpg-0004zY-0q
	for kexec@lists.infradead.org; Thu, 16 Dec 2010 15:33:29 +0000
Received: by wwi18 with SMTP id 18so439457wwi.0
	for <kexec@lists.infradead.org>; Thu, 16 Dec 2010 07:33:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20101216020514.GJ3558@verge.net.au>
References: <20101216020514.GJ3558@verge.net.au>
Date: Thu, 16 Dec 2010 18:33:25 +0300
Message-ID: <AANLkTikX5_JURn11n-kOt_4VOjCn6hVQiNgSS1OnqKvQ@mail.gmail.com>
Subject: Re: mips: elfinfo
From: Maxim Uvarov <muvarov@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>

2010/12/16 Simon Horman <horms@verge.net.au>:
> Hi Maxim,
>
> I noticed that your change "Patch adds kernel data section to final vmcor=
e.
> This forces gdb read kernel" causes the build to break as it was applied
> after Eric's "crashdump: Move kern_vaddr_start from kexec_info into
> crash_elf_info" patch.
>
> I have it in mind to resolve this something along the lines of
> the patch below. However, I now see the following warning:
>
> =A0 =A0 =A0 =A0kexec/arch/mips/crashdump-mips.c: In function `get_kernel_=
vaddr_and_size':
> =A0 =A0 =A0 =A0kexec/arch/mips/crashdump-mips.c:81: warning: integer cons=
tant is too large for "unsigned long" type
>
> Which corresponds to this code:
>
> =A0 =A0 =A0 =A0elf_info->kern_vaddr_start =3D elf_info->kern_paddr_start |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00xffffffff80000000UL;
>
> I am compiling for 32-bit, so at a glance that constant does
> seem to large.
>

Ah, yes this values does not fit to 32 bit UL.

> Also, if you have any tips on a cross-compiling environment for 64bit
> on a x86_32 or x86_64 host I would be most grateful.
>

I tested it with building on 32 bit host. readelf -a shows that vmcore
had memory segment according to kernel memory.
So that, gdb began to read real values instead of uninitialized.

Actually  elf_info->kern_paddr_start | 0xffffffff80000000UL; is needed
only for 64 bit mips.
Because we read kernel memory ranges from /proc/vmcore and there are
values without 0xffffffff at the beginning.
But 0xfffff... are needed in case if we need access to this address from ke=
rnel.

32 bit mips kernel does not need adding 0xfffffff.  But it think there
will be only warning and nothing wrong.

Maxim.

>
> diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump=
-mips.c
> index 5ea4f4f..b937ab5 100644
> --- a/kexec/arch/mips/crashdump-mips.c
> +++ b/kexec/arch/mips/crashdump-mips.c
> @@ -51,7 +51,7 @@ unsigned long long saved_max_mem;
>
> =A0/* Read kernel physical load addr from the file returned by proc_iomem=
()
> =A0* (Kernel Code) and store in kexec_info */
> -static int get_kernel_paddr(struct kexec_info *info)
> +static int get_kernel_paddr(struct crash_elf_info *elf_info)
> =A0{
> =A0 =A0 =A0 =A0uint64_t start;
>
> @@ -59,7 +59,7 @@ static int get_kernel_paddr(struct kexec_info *info)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> =A0 =A0 =A0 =A0if (parse_iomem_single("Kernel code\n", &start, NULL) =3D=
=3D 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->kern_paddr_start =3D start;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 elf_info->kern_paddr_start =3D start;
> =A0#ifdef DEBUG
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("kernel load physical addr start =
=3D 0x%lx\n", start);
> =A0#endif
> @@ -70,21 +70,22 @@ static int get_kernel_paddr(struct kexec_info *info)
> =A0 =A0 =A0 =A0return -1;
> =A0}
>
> -static int get_kernel_vaddr_and_size(struct kexec_info *info)
> +static int get_kernel_vaddr_and_size(struct crash_elf_info *elf_info)
> =A0{
> =A0 =A0 =A0 =A0uint64_t end;
>
> - =A0 =A0 =A0 if (!info->kern_paddr_start)
> + =A0 =A0 =A0 if (!elf_info->kern_paddr_start)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>
> - =A0 =A0 =A0 info->kern_vaddr_start =3D =A0info->kern_paddr_start | 0xff=
ffffff80000000UL;
> + =A0 =A0 =A0 elf_info->kern_vaddr_start =3D elf_info->kern_paddr_start |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0xffffffff80000000UL;
> =A0 =A0 =A0 =A0if (parse_iomem_single("Kernel data\n", NULL, &end) =3D=3D=
 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->kern_size =3D end - info->kern_paddr_=
start;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 elf_info->kern_size =3D end - elf_info->ker=
n_paddr_start;
> =A0#ifdef DEBUG
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("kernel_vaddr=3D 0x%llx paddr %llx\=
n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->kern_=
vaddr_start,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->kern_=
paddr_start);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("kernel size =3D 0x%llx\n", info->ke=
rn_size);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 elf_info->k=
ern_vaddr_start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 elf_info->k=
ern_paddr_start);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("kernel size =3D 0x%llx\n", elf_info=
->kern_size);
> =A0#endif
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -355,11 +356,20 @@ int load_crashdump_segments(struct kexec_info *info=
, char* mod_cmdline,
> =A0 =A0 =A0 =A0unsigned long sz, elfcorehdr;
> =A0 =A0 =A0 =A0int nr_ranges, align =3D 1024;
> =A0 =A0 =A0 =A0struct memory_range *mem_range;
> + =A0 =A0 =A0 crash_create_elf_headers_func crash_create =3D crash_create=
_elf32_headers;
> + =A0 =A0 =A0 struct crash_elf_info *elf_info =3D &elf_info32;
>
> - =A0 =A0 =A0 if (get_kernel_paddr(info))
> +#ifdef __mips64
> + =A0 =A0 =A0 if (arch_options.core_header_type =3D=3D CORE_TYPE_ELF64) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 elf_info =3D &elf_info64;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 crash_create =3D crash_create_elf64;
> + =A0 =A0 =A0 }
> +#endif
> +
> + =A0 =A0 =A0 if (get_kernel_paddr(elf_info))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>
> - =A0 =A0 =A0 if (get_kernel_vaddr_and_size(info))
> + =A0 =A0 =A0 if (get_kernel_vaddr_and_size(elf_info))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>
> =A0 =A0 =A0 =A0if (get_crash_memory_ranges(&mem_range, &nr_ranges) < 0)
> @@ -373,28 +383,9 @@ int load_crashdump_segments(struct kexec_info *info,=
 char* mod_cmdline,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0crash_rese=
rved_mem.start,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0crash_rese=
rved_mem.end, -1);
>
> -#ifdef __mips64
> - =A0 =A0 =A0 /* Create elf header segment and store crash image data. */
> - =A0 =A0 =A0 if (arch_options.core_header_type =3D=3D CORE_TYPE_ELF64) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (crash_create_elf64_headers(info, &elf_i=
nfo64,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 crash_memory_range, nr_rang=
es,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &tmp, &sz,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ELF_CORE_HEADER_ALIGN) < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> - =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (crash_create_elf32_headers(info, &elf_i=
nfo32,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 crash_memory_range, nr_rang=
es,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &tmp, &sz,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ELF_CORE_HEADER_ALIGN) < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> - =A0 =A0 =A0 }
> -#else
> - =A0 =A0 =A0 if (crash_create_elf32_headers(info, &elf_info32,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 crash_memory_range, nr_ranges,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 &tmp, &sz,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ELF_CORE_HEADER_ALIGN) < 0)
> + =A0 =A0 =A0 if (crash_create(info, elf_info, crash_memory_range, nr_ran=
ges,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&tmp, &sz, ELF_CORE_HEAD=
ER_ALIGN) < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> -#endif
> =A0 =A0 =A0 =A0elfcorehdr =3D add_buffer(info, tmp, sz, sz, align,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0crash_reserved_mem.start,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0crash_reserved_mem.end, -1);
> diff --git a/kexec/crashdump.h b/kexec/crashdump.h
> index eccdb9f..060bb88 100644
> --- a/kexec/crashdump.h
> +++ b/kexec/crashdump.h
> @@ -35,6 +35,13 @@ struct crash_elf_info {
> =A0 =A0 =A0 =A0int (*get_note_info)(int cpu, uint64_t *addr, uint64_t *le=
n);
> =A0};
>
> +typedef int(*crash_create_elf_headers_func)(struct kexec_info *info,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 struct crash_elf_info *elf_info,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 struct memory_range *range,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 int ranges,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 void **buf, unsigned long *size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 unsigned long align);
> +
> =A0int crash_create_elf32_headers(struct kexec_info *info,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct crash_=
elf_info *elf_info,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct memory=
_range *range, int ranges,
>



-- =

Best regards,
Maxim Uvarov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
