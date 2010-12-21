Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wy0-f177.google.com ([74.125.82.177])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PUwGz-0007X5-DM
	for kexec@lists.infradead.org; Tue, 21 Dec 2010 07:04:38 +0000
Received: by wyf22 with SMTP id 22so3599631wyf.36
	for <kexec@lists.infradead.org>; Mon, 20 Dec 2010 23:04:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20101219234450.GA13595@verge.net.au>
References: <20101216020514.GJ3558@verge.net.au>
	<AANLkTikX5_JURn11n-kOt_4VOjCn6hVQiNgSS1OnqKvQ@mail.gmail.com>
	<20101219234450.GA13595@verge.net.au>
Date: Tue, 21 Dec 2010 10:04:34 +0300
Message-ID: <AANLkTi=OXyJJ_i4q7w+g81NFA=d-+ZmFyDWJ-ZwiXkhs@mail.gmail.com>
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

2010/12/20 Simon Horman <horms@verge.net.au>:
> On Thu, Dec 16, 2010 at 06:33:25PM +0300, Maxim Uvarov wrote:
>> 2010/12/16 Simon Horman <horms@verge.net.au>:
>> > Hi Maxim,
>> >
>> > I noticed that your change "Patch adds kernel data section to final vm=
core.
>> > This forces gdb read kernel" causes the build to break as it was appli=
ed
>> > after Eric's "crashdump: Move kern_vaddr_start from kexec_info into
>> > crash_elf_info" patch.
>> >
>> > I have it in mind to resolve this something along the lines of
>> > the patch below. However, I now see the following warning:
>> >
>> > =A0 =A0 =A0 =A0kexec/arch/mips/crashdump-mips.c: In function `get_kern=
el_vaddr_and_size':
>> > =A0 =A0 =A0 =A0kexec/arch/mips/crashdump-mips.c:81: warning: integer c=
onstant is too large for "unsigned long" type
>> >
>> > Which corresponds to this code:
>> >
>> > =A0 =A0 =A0 =A0elf_info->kern_vaddr_start =3D elf_info->kern_paddr_sta=
rt |
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A00xffffffff80000000UL;
>> >
>> > I am compiling for 32-bit, so at a glance that constant does
>> > seem to large.
>> >
>>
>> Ah, yes this values does not fit to 32 bit UL.
>>
>> > Also, if you have any tips on a cross-compiling environment for 64bit
>> > on a x86_32 or x86_64 host I would be most grateful.
>> >
>>
>> I tested it with building on 32 bit host. readelf -a shows that vmcore
>> had memory segment according to kernel memory.
>> So that, gdb began to read real values instead of uninitialized.
>>
>> Actually =A0elf_info->kern_paddr_start | 0xffffffff80000000UL; is needed
>> only for 64 bit mips.
>> Because we read kernel memory ranges from /proc/vmcore and there are
>> values without 0xffffffff at the beginning.
>> But 0xfffff... are needed in case if we need access to this address from=
 kernel.
>>
>> 32 bit mips kernel does not need adding 0xfffffff. =A0But it think there
>> will be only warning and nothing wrong.
>
> Understood, but it would be nice to eliminate the warning.
> As load_crashdump_segments() is already 32/64 bit aware I wonder
> if we could just pass appropriate constant from there as
> a parameter of get_kernel_vaddr_and_size().
>
> Perhaps something like the following which
> applies on top of my previous patch.
>
Yes, that has to work. Thanks.

> diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump=
-mips.c
> index b937ab5..aa50109 100644
> --- a/kexec/arch/mips/crashdump-mips.c
> +++ b/kexec/arch/mips/crashdump-mips.c
> @@ -70,7 +70,8 @@ static int get_kernel_paddr(struct crash_elf_info *elf_=
info)
> =A0 =A0 =A0 =A0return -1;
> =A0}
>
> -static int get_kernel_vaddr_and_size(struct crash_elf_info *elf_info)
> +static int get_kernel_vaddr_and_size(struct crash_elf_info *elf_info,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
unsigned long start_offset)
> =A0{
> =A0 =A0 =A0 =A0uint64_t end;
>
> @@ -78,7 +79,7 @@ static int get_kernel_vaddr_and_size(struct crash_elf_i=
nfo *elf_info)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>
> =A0 =A0 =A0 =A0elf_info->kern_vaddr_start =3D elf_info->kern_paddr_start |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0xffffffff80000000UL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 start_offset;
> =A0 =A0 =A0 =A0if (parse_iomem_single("Kernel data\n", NULL, &end) =3D=3D=
 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0elf_info->kern_size =3D end - elf_info->ke=
rn_paddr_start;
> =A0#ifdef DEBUG
> @@ -358,18 +359,20 @@ int load_crashdump_segments(struct kexec_info *info=
, char* mod_cmdline,
> =A0 =A0 =A0 =A0struct memory_range *mem_range;
> =A0 =A0 =A0 =A0crash_create_elf_headers_func crash_create =3D crash_creat=
e_elf32_headers;
> =A0 =A0 =A0 =A0struct crash_elf_info *elf_info =3D &elf_info32;
> + =A0 =A0 =A0 unsigned long start_offset =3D 0x80000000UL;
>
> =A0#ifdef __mips64
> =A0 =A0 =A0 =A0if (arch_options.core_header_type =3D=3D CORE_TYPE_ELF64) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0elf_info =3D &elf_info64;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0crash_create =3D crash_create_elf64;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 start_offset =3D 0xffffffff80000000UL;
> =A0 =A0 =A0 =A0}
> =A0#endif
>
> =A0 =A0 =A0 =A0if (get_kernel_paddr(elf_info))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>
> - =A0 =A0 =A0 if (get_kernel_vaddr_and_size(elf_info))
> + =A0 =A0 =A0 if (get_kernel_vaddr_and_size(elf_info, start_offset))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>
> =A0 =A0 =A0 =A0if (get_crash_memory_ranges(&mem_range, &nr_ranges) < 0)
>



-- =

Best regards,
Maxim Uvarov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
