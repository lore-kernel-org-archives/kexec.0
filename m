Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 4 Jun 2020 08:19:24 +0100
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v6 2/2] arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo
Message-ID: <20200604071923.GB30155@willie-the-truck>
References: <1589395957-24628-1-git-send-email-bhsharma@redhat.com>
 <1589395957-24628-3-git-send-email-bhsharma@redhat.com>
 <DM6PR18MB24258C2F2B91E4BF407421CDD2880@DM6PR18MB2425.namprd18.prod.outlook.com>
 <CACi5LpOyQ+MAg9rh=cgLprBGTZ3kvtVP1ShNKG-2AV1Tu14EgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACi5LpOyQ+MAg9rh=cgLprBGTZ3kvtVP1ShNKG-2AV1Tu14EgQ@mail.gmail.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Ganapatrao Kulkarni <gkulkarni@marvell.com>, Steve Capper <steve.capper@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Kamlakant Patel <kamlakantp@marvell.com>, James Morse <james.morse@arm.com>, Dave Anderson <anderson@redhat.com>, "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Jun 04, 2020 at 02:04:58AM +0530, Bhupesh Sharma wrote:
> On Wed, Jun 3, 2020 at 4:50 PM Kamlakant Patel <kamlakantp@marvell.com> wrote:
> > > diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
> > > index 1f646b07e3e9..314391a156ee 100644
> > > --- a/arch/arm64/kernel/crash_core.c
> > > +++ b/arch/arm64/kernel/crash_core.c
> > > @@ -7,6 +7,14 @@
> > >  #include <linux/crash_core.h>
> > >  #include <asm/cpufeature.h>
> > >  #include <asm/memory.h>
> > > +#include <asm/pgtable-hwdef.h>
> > > +
> > > +static inline u64 get_tcr_el1_t1sz(void);
> > > +
> > > +static inline u64 get_tcr_el1_t1sz(void) {
> > > +     return (read_sysreg(tcr_el1) & TCR_T1SZ_MASK) >> TCR_T1SZ_OFFSET; }
> > >
> > >  void arch_crash_save_vmcoreinfo(void)
> > >  {
> > > @@ -16,6 +24,8 @@ void arch_crash_save_vmcoreinfo(void)
> > >                                               kimage_voffset);
> > >       vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
> > >                                               PHYS_OFFSET);
> > > +     vmcoreinfo_append_str("NUMBER(TCR_EL1_T1SZ)=0x%llx\n",
> > > +                                             get_tcr_el1_t1sz());
> > I tested this patch on top of upstream kernel v5.7 and I am getting "crash: cannot determine VA_BITS_ACTUAL" error with crash tool.
> > I looked into crash-utility source and it is expecting tcr_el1_t1sz not TCR_EL1_T1SZ.
> > Could you please check.
> 
> Indeed. As per James comments on the v5 (see [1]) where he suggested
> converting ttcr_el1_t1sz into TCR_EL1_T1SZ, I made the change in v6
> accordingly.
> 
> This time I haven't sent out the v6 userspace changes
> (makedumpfile/crash-utility) upstream first, since we are waiting for
> kernel changes to be accepted first, as we have seen in the past that
> while the userspace patches have been accepted, the kernel patches
> required a respin cycle, thus leading to inconsistencies, as you also
> pointed out with crash-utility.

Yes, and that';s the right way to do it. Userspace can't rely on the
stability of a kernel interface if it's no in the upstream kernel!

So doing with the ALL CAPS names is the right thing to do.

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
