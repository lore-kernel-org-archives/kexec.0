Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZpHz-0005dR-Gt
 for kexec@lists.infradead.org; Wed, 27 Nov 2019 04:50:57 +0000
Received: by mail-il1-x142.google.com with SMTP id t9so193123iln.4
 for <kexec@lists.infradead.org>; Tue, 26 Nov 2019 20:50:52 -0800 (PST)
MIME-Version: 1.0
References: <CAJ2QiJLBcmdVrmJmfKehadUzzUkmMsn8b2BxmGh7LHXzo7PtJw@mail.gmail.com>
 <CACi5LpPosB9TbVBoG8CVdax0e7pJjpZQUQF2ZB3LciNohXRraQ@mail.gmail.com>
In-Reply-To: <CACi5LpPosB9TbVBoG8CVdax0e7pJjpZQUQF2ZB3LciNohXRraQ@mail.gmail.com>
From: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date: Wed, 27 Nov 2019 10:20:41 +0530
Message-ID: <CAJ2QiJKK1Q9_g68OpHNdErRSU4hwOx4VtkPkBsvyfG_RJjgpQg@mail.gmail.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Prabhakar Kushwaha <pkushwaha@marvell.com>, kexec mailing list <kexec@lists.infradead.org>, Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>

Thanks Bhupesh for replying

On Wed, Nov 27, 2019 at 2:42 AM Bhupesh Sharma <bhsharma@redhat.com> wrote:
>
> Hi Prabhakar,
>
> On Tue, Nov 26, 2019 at 1:04 PM Prabhakar Kushwaha
> <prabhakar.pkin@gmail.com> wrote:
> >
> > Hi All,
> >
> > I am facing issue below error with latest kexec-tools/vmcore-demsg tools.
> >
> > $ ./build/sbin/vmcore-dmesg /proc/vmcore
> > No program header covering vaddr 0xffff000be7a00000found kexec bug?
> >
> > I am testing on AARM64 platform with following git repos.
> > A) kexec tools:
> > https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> > top commit: bd077966e2b9041c (kexec-tools: Fix conversion overflow
> > when compiling on 32-bit platforms)
> >
> > B) Linux:git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > top commit: af42d3466bdc8f3980 (Linux 5.4-rc8)
> >
> > I am seeing similar issue in past also in couple of discussions. has
> > it not fixed earlier or it keep arises with time to time
> >
> > Please suggest.
>
> Thanks for reporting the issue.
> I think the issue with the latest ARM64 kernel and kexec-tools is the
> same as the makedumpfile, i.e. the PAGE_OFFSET calculation needs to be
> dynamically done for 52-bit VA_BITS correctly as well.
>

Yes we need dynamic approach of calculating VA_BITS.

Please note, the AARM64 platform used by us is 48Bit.
CONFIG_ARM64_VA_BITS_48=y
CONFIG_ARM64_VA_BITS=48
CONFIG_ARM64_PA_BITS_48=y
CONFIG_ARM64_PA_BITS=48

As per my understanding, this issue is not because of 52 bit. It is
due to patch 14c127c957c1 ("arm64: mm: Flip kernel VA space") in
Linux.
i.e. PAGE_OFFSET address has been moved to bottom instead of middle in
kernel virtual address space.

As below changes solves mentioned kexec-tools/vmcore-demsg problem.

diff --git a/kexec/arch/arm64/crashdump-arm64.c
b/kexec/arch/arm64/crashdump-arm64.c
index 4fd7aa8..1c28b06 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -58,6 +58,8 @@ static uint64_t get_kernel_page_offset(void)
 {
        int i;

+       return 0xffff000000000000;  --> PAGE_OFFSET
        if (elf_info.kern_vaddr_start == UINT64_MAX)
                return UINT64_MAX;

Also, I verified by moving one patch below 14c127c957c1 in Linux, no
changes required in kexect-tools. Everything works fine.

The calculation used in makedumpfile (your patches), indirectly takes
care of this.  So we need similar calculation here in kexec also.



--pk

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
