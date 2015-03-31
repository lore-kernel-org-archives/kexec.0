Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 31 Mar 2015 08:31:59 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [RFC v2 0/5] arm64: kvm: reset hyp context for kexec
Message-ID: <20150331083159.7c3f78d4@arm.com>
In-Reply-To: <551A38FC.1040801@linaro.org>
References: <1427358326-3708-1-git-send-email-takahiro.akashi@linaro.org>
 <20150327153131.GK12400@redacted.bos.redhat.com>
 <55157920.3050003@arm.com>
 <20150327174044.GL12400@redacted.bos.redhat.com>
 <5518A969.3090707@linaro.org> <20150330081613.60ff7dc0@arm.com>
 <55190F45.1070803@linaro.org> <551A38FC.1040801@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "geoff@infradead.org" <geoff@infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "freddy77@gmail.com" <freddy77@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, Kyle McMartin <kmcmarti@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "david.griego@linaro.org" <david.griego@linaro.org>

On Tue, 31 Mar 2015 07:04:44 +0100
AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:

Hi Takahiro,

> Marc,
> 
> On 03/30/2015 05:54 PM, AKASHI Takahiro wrote:
> > On 03/30/2015 04:16 PM, Marc Zyngier wrote:
> >> On Mon, 30 Mar 2015 02:39:53 +0100
> >> AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> >>
> >>> On 03/28/2015 02:40 AM, Kyle McMartin wrote:
> >>>> On Fri, Mar 27, 2015 at 03:37:04PM +0000, Marc Zyngier wrote:
> >>>>>> [  236.260863] Kernel panic - not syncing: HYP panic:
> >>>>>> [  236.260863] PS:600003c9 PC:000003ffffff0830 ESR:0000000096000006
> >>>>>
> >>>>> It would be interesting if you could find out what you have at offset
> >>>>> 0x830 of hyp-init.o (the stack trace is for EL1, and is not going to
> >>>>> help much).
> >>>>>
> >>>>
> >>>> Given the alignment, i'm going to assume i'm looking at the right thing:
> >>>>
> >>>> 0000000000000820 <__kvm_hyp_reset>:
> >>>>        820:       d51c2000        msr     ttbr0_el2, x0
> >>>>        824:       d5033fdf        isb
> >>>>        828:       d50c871f        tlbi    alle2
> >>>>        82c:       d5033f9f        dsb     sy
> >>>>        830:       10000060        adr     x0, 83c <__kvm_hyp_reset+0x1c>
> >>>>        834:       b3403c01        bfxil   x1, x0, #0, #16
> >>>>        838:       d61f0020        br      x1
> >>>>        83c:       d53c1000        mrs     x0, sctlr_el2
> >>>>
> >>>> but it seems fairly implausible to be trapping on ADR x0, 1f...
> >>>
> >>>
> >>> I've never seen this panic on fast model...
> >>>
> >>> ESR shows that
> >>>     - Exception class: Data abort taken without a change in Exception level
> >>>     - Data fault status code: Translation fault at EL2
> >>>
> >>> and FAR seems not to be a proper address.
> >>
> >> ... which is consistent with what we're seeing here (data fault on
> >> something that doesn't generate a load/store). I'm pretty sure the
> >> page tables are screwed.
> >>
> >> Have you tested it with 64k pages?
> >
> > Hmm... It seems that I was able to reproduce the problem if 64k pages enabled.
> 
> The entry address in trampoline code calc'ed by kvm_virt_to_trampoline(__kvm_hyp_reset)
> seems to be wrong due to improper page-alignment in hyp-init.S.
> The following patch fixed this problem, at least, in my environment(fast model).
> (I don't know why it's PAGE_SHIFT - 1, not PAGE_SHIFT.)
> 
>  >diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
>  >index d212990..45b8d98 100644
>  >--- a/arch/arm64/kvm/hyp-init.S
>  >+++ b/arch/arm64/kvm/hyp-init.S
>  >@@ -24,7 +24,7 @@
>  >        .text
>  >        .pushsection    .hyp.idmap.text, "ax"
>  >
>  >-       .align  11
>  >+       .align  (PAGE_SHIFT - 1)

I'm afraid this is wrong. This alignment is for the vectors (which have
to be aligned on a 2kB boundary, hence the ".align 11"), not for the
code. Aligning it on a 32kB boundary doesn't make any sense, and just
hides the bug.

I bet that without this hack, the hyp-init code is spread across two
64kB pages, and the kernel generates a bounce page for this code. By
changing the alignment, you just end up having the code to fit in a
single page, and no bounce page gets generated.

If I'm right above the above, it means that you're computing something
against the wrong base. Can you please verify this scenario?

Now, the good news is that Ard is removing the bounce page from the KVM
code (for unrelated reasons), and this may just be the saving grace.

>  >
>  > ENTRY(__kvm_hyp_init)
>  >        ventry  __invalid               // Synchronous EL2t
> 
> 
> After applying this patch, I got another problem with kexec-tools on 64k page kernel,
> but I've already modified kexec-tools.

The idea that userspace behavior is dependent on the kernel page size
is deeply worrying...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
