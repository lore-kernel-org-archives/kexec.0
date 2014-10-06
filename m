Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 6 Oct 2014 11:10:48 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/7] arm64/kvm: Fix assembler compatibility of macros
Message-ID: <20141006101048.GC24686@leverpostej>
References: <cover.1411604443.git.geoff@infradead.org>
 <490268c9dba3b6d3f5a52c7c1b0dd81686aac6f7.1411604443.git.geoff@infradead.org>
 <20141003102641.GA26643@leverpostej>
 <1412375268.32313.48.camel@smoke>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1412375268.32313.48.camel@smoke>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

On Fri, Oct 03, 2014 at 11:27:48PM +0100, Geoff Levand wrote:
> On Fri, 2014-10-03 at 11:26 +0100, Mark Rutland wrote:
> > Would you be able to fix those up at the same time? It doesn't look like there
> > are too many, and it should be a fairly mechanical change:
> 
> Sure.
> 
> > [mark@leverpostej:~/src/linux]% grep '[0-9][UL]' -- arch/arm64/include/asm/kvm_arm.h    
> > #define VTTBR_BADDR_MASK  (((1LLU << (40 - VTTBR_X)) - 1) << VTTBR_BADDR_SHIFT)
> > #define VTTBR_VMID_SHIFT  (48LLU)
> > #define ESR_EL2_IL              (1U << 25)
> > #define ESR_EL2_ISV             (1U << ESR_EL2_ISV_SHIFT)
> > #define ESR_EL2_SAS             (3U << ESR_EL2_SAS_SHIFT)
> > #define ESR_EL2_CV              (1U << ESR_EL2_CV_SHIFT)
> 
> The list is a bit longer if you look for hex numbers also, but I think
> I got them all.

Ah, yes.

Cheers for fixing the rest!

Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
