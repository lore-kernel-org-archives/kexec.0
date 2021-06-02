Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loFm9-001UEV-E2
 for kexec@lists.infradead.org; Wed, 02 Jun 2021 01:34:30 +0000
Received: by mail-ed1-x52a.google.com with SMTP id s6so859906edu.10
 for <kexec@lists.infradead.org>; Tue, 01 Jun 2021 18:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
 <20210527150526.271941-5-pasha.tatashin@soleen.com>
 <87pmx52212.wl-maz@kernel.org>
In-Reply-To: <87pmx52212.wl-maz@kernel.org>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 1 Jun 2021 21:33:52 -0400
Message-ID: <CA+CK2bChDqMKGAG8_rEigWcXRaBN=rnuV_WLnU=1TPjJRtpc5A@mail.gmail.com>
Subject: Re: [PATCH 04/18] arm64: kernel: add helper for booted at EL2 and not
 VHE
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
To: Marc Zyngier <maz@kernel.org>
Cc: James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, James Morse <james.morse@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mm <linux-mm@kvack.org>, Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com, rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>, Selin Dag <selindag@gmail.com>, Tyler Hicks <tyhicks@linux.microsoft.com>, Pingfan Liu <kernelfans@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, madvenka@linux.microsoft.com

On Tue, Jun 1, 2021 at 8:38 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 27 May 2021 16:05:12 +0100,
> Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
> >
> > Replace places that contain logic like this:
> >       is_hyp_mode_available() && !is_kernel_in_hyp_mode()
> >
> > With a dedicated boolean function  is_hyp_callable(). This will be needed
> > later in kexec in order to sooner switch back to EL2.
>
> This looks like the very definition of "run in nVHE mode", so I'd
> rather you call it like this, rather than "callable", which is
> extremely ambiguous (if running at EL2, I call it any time I want, for
> free).

Hi Marc,

Naming is hard. Are you proposing  s/is_hyp_callable/run_in_nvhe_mode/
? This is also not a very good name because it does not sound like a
boolean, but instead that we know that there is nvhe mode available
and we can switch to it.

>
> >
> > Suggested-by: James Morse <james.morse@arm.com>
> >
> > [Fixed merging issues]
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  arch/arm64/include/asm/virt.h | 5 +++++
> >  arch/arm64/kernel/cpu-reset.h | 3 +--
> >  arch/arm64/kernel/hibernate.c | 9 +++------
> >  arch/arm64/kernel/sdei.c      | 2 +-
> >  4 files changed, 10 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
> > index 7379f35ae2c6..4216c8623538 100644
> > --- a/arch/arm64/include/asm/virt.h
> > +++ b/arch/arm64/include/asm/virt.h
> > @@ -128,6 +128,11 @@ static __always_inline bool is_protected_kvm_enabled(void)
> >               return cpus_have_final_cap(ARM64_KVM_PROTECTED_MODE);
> >  }
> >
> > +static inline bool is_hyp_callable(void)
> > +{
> > +     return is_hyp_mode_available() && !is_kernel_in_hyp_mode();
> > +}
>
> nit: consider switching the two members of the expression so that you
> don't have extra memory accesses when running at EL2.

Sure, I will do that.


> > -/* Do we need to reset el2? */
> > -#define el2_reset_needed() (is_hyp_mode_available() && !is_kernel_in_hyp_mode())
> > -
>
> Please keep the macro, as it explains *why* we're doing things (we
> need to reset EL2), and replacing it with a generic macro drops the
> documentation aspect.

OK, I will keep the macro, and redefine it to use the common macro.

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
