Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ia49l-0007Tm-PM
 for kexec@lists.infradead.org; Wed, 27 Nov 2019 20:43:27 +0000
Received: by mail-lj1-f197.google.com with SMTP id d16so4367244ljo.11
 for <kexec@lists.infradead.org>; Wed, 27 Nov 2019 12:43:18 -0800 (PST)
MIME-Version: 1.0
References: <CAJ2QiJLBcmdVrmJmfKehadUzzUkmMsn8b2BxmGh7LHXzo7PtJw@mail.gmail.com>
 <CACi5LpPosB9TbVBoG8CVdax0e7pJjpZQUQF2ZB3LciNohXRraQ@mail.gmail.com>
 <CAJ2QiJKK1Q9_g68OpHNdErRSU4hwOx4VtkPkBsvyfG_RJjgpQg@mail.gmail.com>
In-Reply-To: <CAJ2QiJKK1Q9_g68OpHNdErRSU4hwOx4VtkPkBsvyfG_RJjgpQg@mail.gmail.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Thu, 28 Nov 2019 02:13:00 +0530
Message-ID: <CACi5LpPP3kNrokpbN6fjkVjyuGCwVh61SCpoDL3WczMz7x6hbg@mail.gmail.com>
Subject: Re: kexec-tools/vmcore-demsg: No program header covering vaddr
 0xffff000be7a00000found kexec bug?
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
To: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Cc: Prabhakar Kushwaha <pkushwaha@marvell.com>, kexec mailing list <kexec@lists.infradead.org>, Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>

 Hi Prabhakar,

On Wed, Nov 27, 2019 at 10:20 AM Prabhakar Kushwaha
<prabhakar.pkin@gmail.com> wrote:
>
> Thanks Bhupesh for replying
>
> On Wed, Nov 27, 2019 at 2:42 AM Bhupesh Sharma <bhsharma@redhat.com> wrote:
> >
> > Hi Prabhakar,
> >
> > On Tue, Nov 26, 2019 at 1:04 PM Prabhakar Kushwaha
> > <prabhakar.pkin@gmail.com> wrote:
> > >
> > > Hi All,
> > >
> > > I am facing issue below error with latest kexec-tools/vmcore-demsg tools.
> > >
> > > $ ./build/sbin/vmcore-dmesg /proc/vmcore
> > > No program header covering vaddr 0xffff000be7a00000found kexec bug?
> > >
> > > I am testing on AARM64 platform with following git repos.
> > > A) kexec tools:
> > > https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> > > top commit: bd077966e2b9041c (kexec-tools: Fix conversion overflow
> > > when compiling on 32-bit platforms)
> > >
> > > B) Linux:git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > top commit: af42d3466bdc8f3980 (Linux 5.4-rc8)
> > >
> > > I am seeing similar issue in past also in couple of discussions. has
> > > it not fixed earlier or it keep arises with time to time
> > >
> > > Please suggest.
> >
> > Thanks for reporting the issue.
> > I think the issue with the latest ARM64 kernel and kexec-tools is the
> > same as the makedumpfile, i.e. the PAGE_OFFSET calculation needs to be
> > dynamically done for 52-bit VA_BITS correctly as well.
> >
>
> Yes we need dynamic approach of calculating VA_BITS.
>
> Please note, the AARM64 platform used by us is 48Bit.
> CONFIG_ARM64_VA_BITS_48=y
> CONFIG_ARM64_VA_BITS=48
> CONFIG_ARM64_PA_BITS_48=y
> CONFIG_ARM64_PA_BITS=48
>
> As per my understanding, this issue is not because of 52 bit. It is
> due to patch 14c127c957c1 ("arm64: mm: Flip kernel VA space") in
> Linux.
> i.e. PAGE_OFFSET address has been moved to bottom instead of middle in
> kernel virtual address space.

Well the changes for flipping the kernel VA space on arm64 was need
for introducing the 52-bit VA address space.
You can look at Steve Capper's 53-bit patchset for details which was
finally merged in the mainline [of which 14c127c957c1 ("arm64: mm:
Flip kernel VA space") is a part]:


> As below changes solves mentioned kexec-tools/vmcore-demsg problem.
>
> diff --git a/kexec/arch/arm64/crashdump-arm64.c
> b/kexec/arch/arm64/crashdump-arm64.c
> index 4fd7aa8..1c28b06 100644
> --- a/kexec/arch/arm64/crashdump-arm64.c
> +++ b/kexec/arch/arm64/crashdump-arm64.c
> @@ -58,6 +58,8 @@ static uint64_t get_kernel_page_offset(void)
>  {
>         int i;
>
> +       return 0xffff000000000000;  --> PAGE_OFFSET

Yes, you are hardcoding the PAGE_OFFSET as 0xffff000000000000 for a
vabits_actual value of 48-bits and it will work fine on platforms
which don't support ARMv8.2 LVA extensions (i.e. ARM v8.2), however on
real ARMv8.2 hardware the PAGE_OFFSET value should be
0xfff0000000000000 (for vabits_actual value of 52 bits). See '52-bit
VA support in the kernel' section in
<https://www.kernel.org/doc/Documentation/arm64/memory.rst> for
details.

I think I have found a more generic solution to the issue, but I still
need to verify on the ARMv8 simulator model (as I need to test othe
same on 52-bit platforms as well).

Regards,
Bhupesh

>         if (elf_info.kern_vaddr_start == UINT64_MAX)
>                 return UINT64_MAX;
>
> Also, I verified by moving one patch below 14c127c957c1 in Linux, no
> changes required in kexect-tools. Everything works fine.
>
> The calculation used in makedumpfile (your patches), indirectly takes
> care of this.  So we need similar calculation here in kexec also.
>
>
>
> --pk
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
